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
  express.static(path.join(__dirname, "src", "uploads"))
);

app.use(express.static(path.join(__dirname, "frontend")));

// Attach all API routes
// Basic health checks for platform probes
app.get("/", (req, res) => {
  res.send("OK");
});

app.get("/healthz", (req, res) => {
  res.json({ status: "ok", env: process.env.NODE_ENV || "development" });
});

registerRoutes(app);

// Fallback handlers for unmatched routes and errors
app.use(notFound);
app.use(errorHandler);

// Verify DB connectivity before accepting requests
const startServer = async () => {
  try {
    const connection = await db.getConnection();
    connection.release();
    console.log("Database connection verified successfully.");

    // Run database migrations/initialization
    await initDatabase();

    // Initialize Firebase Storage (will log warnings if not configured)
    initializeFirebase();

    // Get PORT right before starting server to ensure env vars are ready
    const PORT = process.env.PORT || 8080;

    app.listen(PORT, "0.0.0.0", () => {
      console.log(
        `HR Records Management API listening on port ${PORT} (env: ${
          process.env.NODE_ENV || "development"
        })`
      );
    });
  } catch (error) {
    console.error("Failed to start server:", error.message);
    process.exit(1);
  }
};

startServer();
