const { getBucket } = require("../config/firebase");
const path = require("path");
const fs = require("fs");

// Helper to save file locally
const uploadToLocal = async (file, folder = "documents", req = null) => {
  try {
    // Generate unique filename
    const fileExtension = path.extname(file.originalname);
    const fileName = `${Date.now()}-${Math.round(
      Math.random() * 1e9,
    )}${fileExtension}`;

    // Target directory (src/uploads/{folder})
    // Note: __dirname is src/controllers, so ../uploads is src/uploads
    const uploadDir = path.join(__dirname, "../uploads", folder);

    // Create directory if not exists
    if (!fs.existsSync(uploadDir)) {
      fs.mkdirSync(uploadDir, { recursive: true });
    }

    const filePath = path.join(uploadDir, fileName);

    // Write file buffer to disk
    await fs.promises.writeFile(filePath, file.buffer);

    // Return URL relative to server root
    let baseUrl = "http://localhost:5000";
    if (req) {
      const protocol = req.headers["x-forwarded-proto"] || req.protocol;
      const host = req.get("host");
      baseUrl = `${protocol}://${host}`;
    }

    const fullUrl = `${baseUrl}/uploads/${folder}/${fileName}`;

    console.log("✅ File saved locally:", fullUrl);

    return {
      url: fullUrl,
      originalName: file.originalname,
      fileName,
    };
  } catch (error) {
    console.error("❌ Local upload error:", error);
    throw error;
  }
};

// Hàm helper để upload file lên Firebase Storage
const uploadToFirebase = async (file, folder = "osp_uploads") => {
  try {
    const bucket = getBucket();

    if (!bucket) {
      throw new Error("Firebase Storage not initialized");
    }

    if (!file) {
      throw new Error("No file provided");
    }

    // Tạo tên file mới (giữ nguyên đuôi file gốc)
    const fileExtension = path.extname(file.originalname);
    const fileName = `${Date.now()}-${Math.round(
      Math.random() * 1e9,
    )}${fileExtension}`;

    // Tạo reference trên Firebase
    const blob = bucket.file(`${folder}/${fileName}`);

    const blobStream = blob.createWriteStream({
      metadata: {
        contentType: file.mimetype,
      },
    });

    return new Promise((resolve, reject) => {
      blobStream.on("error", (err) => {
        reject(err);
      });

      blobStream.on("finish", async () => {
        try {
          // Lấy đường dẫn tải file (Signed URL)
          const [url] = await blob.getSignedUrl({
            action: "read",
            expires: "01-01-2100",
          });

          resolve({
            url,
            originalName: file.originalname,
            fileName,
          });
        } catch (error) {
          reject(error);
        }
      });

      blobStream.end(file.buffer);
    });
  } catch (error) {
    // console.warn("Firebase upload failed, trying local fallback...");
    // If firebase fails, throw to let the caller handle fallback
    throw error;
  }
};

// Wrapper to handle upload strategy (Firebase -> Local Fallback)
const processFileUpload = async (file, req = null) => {
  try {
    // Try Firebase first
    return await uploadToFirebase(file);
  } catch (error) {
    const errorMsg = error.message || "Unknown error";
    // Check for specific firebase errors to warn user
    if (errorMsg.includes("bucket does not exist")) {
      console.error(
        "❌ CRITICAL FIREBASE ERROR: The Storage Bucket does not exist. Check your FIREBASE_STORAGE_BUCKET env var or create the bucket in Firebase Console.",
      );
    }

    console.warn(
      `⚠️ Firebase upload failed (${errorMsg}). Falling back to local storage.`,
    );
    // Fallback to local
    return await uploadToLocal(file, "documents", req);
  }
};

// Hàm xử lý upload single file
const uploadFile = async (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).json({ message: "Vui lòng chọn file!" });
    }

    const result = await processFileUpload(req.file, req);

    res.status(200).json({
      message: "Upload thành công",
      url: result.url,
      originalName: result.originalName,
    });
  } catch (error) {
    console.error("Upload error:", error);
    res.status(500).json({ message: "Lỗi server khi upload" });
  }
};

// Hàm xử lý upload multiple files
const uploadMultipleFiles = async (req, res) => {
  try {
    if (!req.files || req.files.length === 0) {
      return res.status(400).json({ message: "Vui lòng chọn file!" });
    }

    const uploadPromises = req.files.map((file) =>
      processFileUpload(file, req),
    );
    const results = await Promise.all(uploadPromises);

    res.status(200).json({
      message: "Upload thành công",
      files: results,
    });
  } catch (error) {
    console.error("Upload error:", error);
    res.status(500).json({ message: "Lỗi server khi upload" });
  }
};

module.exports = {
  uploadFile,
  uploadMultipleFiles,
  uploadToFirebase,
  processFileUpload,
  uploadToLocal,
};
