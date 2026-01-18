const admin = require("firebase-admin");
const dotenv = require("dotenv");

dotenv.config();

let bucket = null;
let initialized = false;

const initializeFirebase = () => {
  if (initialized && bucket) {
    return bucket;
  }

  // 1. Check for the full JSON env var (preferred for Render/Cloud)
  let serviceAccount = null;

  if (process.env.FIREBASE_SERVICE_ACCOUNT) {
    try {
      // Remove potential whitespace or quotes wrapping the JSON
      const rawEnv = process.env.FIREBASE_SERVICE_ACCOUNT.trim();
      serviceAccount = JSON.parse(rawEnv);

      // Fix for Private Key newlines (common issue with .env and JSON)
      if (serviceAccount.private_key) {
        serviceAccount.private_key = serviceAccount.private_key.replace(
          /\\n/g,
          "\n",
        );
      }
    } catch (e) {
      console.error(
        "❌ Error parsing FIREBASE_SERVICE_ACCOUNT JSON:",
        e.message,
      );
    }
  }

  if (!serviceAccount) {
    console.warn(
      "⚠️ FIREBASE_SERVICE_ACCOUNT environment variable is missing or invalid. Firebase storage will be disabled.",
    );
    return null;
  }

  // 2. Determine Bucket Name
  // Priority: Env Var > Derived from Project ID
  let storageBucket = process.env.FIREBASE_STORAGE_BUCKET;

  if (!storageBucket && serviceAccount.project_id) {
    // Default to standard firebase bucket URL: project-id.appspot.com
    storageBucket = `${serviceAccount.project_id}.appspot.com`;
    console.log(`ℹ️ Auto-configured storage bucket: ${storageBucket}`);
  }

  if (!storageBucket) {
    console.warn(
      "⚠️ FIREBASE_STORAGE_BUCKET is missing and could not be derived. Firebase storage disabled.",
    );
    return null;
  }

  try {
    if (!admin.apps.length) {
      admin.initializeApp({
        credential: admin.credential.cert(serviceAccount),
        storageBucket: storageBucket,
      });
    }

    bucket = admin.storage().bucket();
    initialized = true;

    console.log("✅ Firebase Admin initialized successfully");
    console.log(`📦 Active Bucket: ${storageBucket}`);

    return bucket;
  } catch (error) {
    console.error("❌ Firebase initialization error:", error.message);
    return null;
  }
};

const getBucket = () => {
  if (!bucket) {
    bucket = initializeFirebase();
  }
  return bucket;
};

module.exports = { getBucket, initializeFirebase };
