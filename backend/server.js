const path = require("path");
const express = require("express");
const dotenv = require("dotenv");

// Load environment variables from .env file (for local development)
dotenv.config({ path: path.resolve(__dirname, ".env") });

const registerRoutes = require("./src/routes");
const { notFound, errorHandler } = require("./src/middlewares/errorHandler");
const { applySecurityMiddlewares } = require("./src/middlewares/security");
const db = require("./src/config/database");
const { initDatabase } = require("./src/config/initDatabase");
const { initializeFirebase } = require("./src/config/firebase");

const app = express();

// ✅ Tin tưởng proxy khi chạy trên Railway/Heroku/Cloud
// Bắt buộc phải có để express-rate-limit hoạt động đúng với X-Forwarded-For header
app.set("trust proxy", 1);

// Security middlewares (helmet, CORS, sanitizers, rate limiters)
applySecurityMiddlewares(app);

// Core middlewares for parsing and static assets
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Serve uploads with CORS headers
app.use(
  "/uploads",
  (req, res, next) => {
    res.setHeader("Cross-Origin-Resource-Policy", "cross-origin");
    res.setHeader("Access-Control-Allow-Origin", "*");
    next();
  },
  express.static(path.join(__dirname, "src", "uploads")),
);

// ✅ Endpoint cho UptimeRobot (Keep-Alive)
// Trả về response siêu nhẹ để giữ Render không ngủ đông
app.get("/ping", (req, res) => {
  res.status(200).send("pong");
});

app.use(express.static(path.join(__dirname, "frontend")));

// Attach all API routes
// Basic health checks for platform probes
app.get("/", (req, res) => {
  res.send("OK");
});

// Readiness gate
let isReady = false;
let initError = null;

app.get("/healthz", (req, res) => {
  res.json({ 
    status: "ok", 
    env: process.env.NODE_ENV || "development",
    ready: isReady,
    initError: initError ? initError.message : null
  });
});

registerRoutes(app);

// Fallback handlers for unmatched routes and errors
app.use(notFound);
app.use(errorHandler);

// Middleware to return 503 if not ready
app.use((req, res, next) => {
  if (!isReady && !req.path.startsWith('/healthz')) {
    return res.status(503).json({ 
      error: 'Service temporarily unavailable', 
      code: 'SERVER_WARMING_UP',
      message: 'Database initialization in progress. Please retry in a few seconds.'
    });
  }
  next();
});

// Start server immediately to satisfy Render port binding requirement
const PORT = process.env.PORT || 8080;

const server = app.listen(PORT, "0.0.0.0", () => {
  console.log(
    `🚀 Server listening on port ${PORT} (env: ${
      process.env.NODE_ENV || "development"
    })`,
  );
  console.log("⏳ Initializing database and services in background...");
});

// Initialize database and services in background
(async () => {
  try {
    // Wait for DB connection with retries
    await db.waitForConnection();
    
    // Run database migrations/initialization
    await initDatabase();
    
    // Initialize Firebase Storage
    initializeFirebase();
    
    isReady = true;
    console.log("✅ Server is fully ready to accept requests.");
  } catch (error) {
    console.error("❌ Initialization failed:", error.message);
    initError = error;
    // Don't exit - let server run in degraded mode for debugging
  }
})();
