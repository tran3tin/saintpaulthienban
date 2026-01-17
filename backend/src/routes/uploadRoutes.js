const express = require("express");
const router = express.Router();
const { uploadDocuments } = require("../middlewares/upload");
const { authenticateToken } = require("../middlewares/auth");
const { processFileUpload } = require("../controllers/uploadController");

// Upload multiple documents
router.post(
  "/documents",
  authenticateToken,
  uploadDocuments,
  async (req, res) => {
    try {
      console.log("📤 Upload request received");
      console.log(`📂 Files count: ${req.files ? req.files.length : 0}`);

      if (!req.files || req.files.length === 0) {
        return res.status(400).json({ message: "No files uploaded" });
      }

      // Log file details
      req.files.forEach((file, i) => {
        console.log(
          `📄 File ${i + 1}: ${file.originalname} (${file.mimetype}, ${
            file.size
          } bytes)`,
        );
      });

      // Upload tất cả files (Firebase -> Local Fallback)
      const uploadPromises = req.files.map((file) => processFileUpload(file));
      const results = await Promise.all(uploadPromises);

      const uploadedFiles = results.map((result, index) => ({
        id: Date.now() + index,
        name: result.originalName,
        size: req.files[index].size,
        type: req.files[index].mimetype,
        url: result.url,
        uploadedAt: new Date().toISOString(),
      }));

      console.log(`✅ Successfully uploaded ${uploadedFiles.length} files`);

      return res.status(200).json({
        success: true,
        files: uploadedFiles,
      });
    } catch (error) {
      console.error("❌ Upload error:", error.message);
      console.error("❌ Stack trace:", error.stack);
      return res.status(500).json({
        message: "Failed to upload files",
        error: error.message,
      });
    }
  },
);

module.exports = router;
