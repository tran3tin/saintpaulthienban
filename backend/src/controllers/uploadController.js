const { getBucket } = require("../config/firebase");
const path = require("path");

// Hàm helper để upload file lên Firebase Storage
const uploadToFirebase = async (file, folder = "osp_uploads") => {
  try {
    const bucket = getBucket();

    if (!bucket) {
      throw new Error(
        "Firebase Storage not initialized. Check FIREBASE_SERVICE_ACCOUNT and FIREBASE_STORAGE_BUCKET environment variables."
      );
    }

    if (!file) {
      throw new Error("No file provided");
    }

    // Tạo tên file mới (giữ nguyên đuôi file gốc)
    const fileExtension = path.extname(file.originalname);
    const fileName = `${Date.now()}-${Math.round(
      Math.random() * 1e9
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
    throw error;
  }
};

// Hàm xử lý upload single file
const uploadFile = async (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).json({ message: "Vui lòng chọn file!" });
    }

    const result = await uploadToFirebase(req.file);

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

    const uploadPromises = req.files.map((file) => uploadToFirebase(file));
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
};
