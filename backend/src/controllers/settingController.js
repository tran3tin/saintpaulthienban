// src/controllers/settingController.js
const db = require("../config/database");
const mysqldump = require("mysqldump");
const fs = require("fs").promises;
const fsSync = require("fs");
const path = require("path");
const { getBucket } = require("../config/firebase");

/**
 * Get all settings by group or all
 */
const getAllSettings = async (req, res) => {
  try {
    const { group } = req.query;
    let query = "SELECT * FROM system_settings";
    const params = [];

    if (group) {
      query += " WHERE setting_group = ?";
      params.push(group);
    }

    query += " ORDER BY setting_group, setting_key";

    const [rows] = await db.execute(query, params);

    // Convert to object format
    const settings = {};
    rows.forEach((row) => {
      settings[row.setting_key] = row.setting_value;
    });

    res.json({ success: true, data: settings });
  } catch (error) {
    console.error("getAllSettings error:", error);
    res.status(500).json({ success: false, message: "Lỗi khi tải cài đặt" });
  }
};

/**
 * Get general settings
 */
const getGeneralSettings = async (req, res) => {
  try {
    const [rows] = await db.execute(
      "SELECT * FROM system_settings WHERE setting_group = 'general'"
    );

    const settings = {};
    rows.forEach((row) => {
      settings[row.setting_key] = row.setting_value;
    });

    res.json({ success: true, data: settings });
  } catch (error) {
    console.error("getGeneralSettings error:", error);
    res
      .status(500)
      .json({ success: false, message: "Lỗi khi tải cài đặt chung" });
  }
};

/**
 * Update general settings
 */
const updateGeneralSettings = async (req, res) => {
  try {
    const settings = req.body;

    for (const [key, value] of Object.entries(settings)) {
      await db.execute(
        `INSERT INTO system_settings (setting_key, setting_value, setting_group)
         VALUES (?, ?, 'general')
         ON DUPLICATE KEY UPDATE setting_value = ?`,
        [key, value, value]
      );
    }

    res.json({ success: true, message: "Đã cập nhật cài đặt chung" });
  } catch (error) {
    console.error("updateGeneralSettings error:", error);
    res
      .status(500)
      .json({ success: false, message: "Lỗi khi cập nhật cài đặt chung" });
  }
};

/**
 * Get system settings
 */
const getSystemSettings = async (req, res) => {
  try {
    const [rows] = await db.execute(
      "SELECT * FROM system_settings WHERE setting_group = 'system'"
    );

    const settings = {};
    rows.forEach((row) => {
      // Parse boolean strings
      if (row.setting_value === "true") {
        settings[row.setting_key] = true;
      } else if (row.setting_value === "false") {
        settings[row.setting_key] = false;
      } else if (!isNaN(row.setting_value) && row.setting_value !== "") {
        settings[row.setting_key] = Number(row.setting_value);
      } else {
        settings[row.setting_key] = row.setting_value;
      }
    });

    res.json({ success: true, data: settings });
  } catch (error) {
    console.error("getSystemSettings error:", error);
    res
      .status(500)
      .json({ success: false, message: "Lỗi khi tải cài đặt hệ thống" });
  }
};

/**
 * Update system settings
 */
const updateSystemSettings = async (req, res) => {
  try {
    const settings = req.body;

    for (const [key, value] of Object.entries(settings)) {
      const stringValue =
        typeof value === "boolean" ? String(value) : String(value);
      await db.execute(
        `INSERT INTO system_settings (setting_key, setting_value, setting_group)
         VALUES (?, ?, 'system')
         ON DUPLICATE KEY UPDATE setting_value = ?`,
        [key, stringValue, stringValue]
      );
    }

    res.json({ success: true, message: "Đã cập nhật cài đặt hệ thống" });
  } catch (error) {
    console.error("updateSystemSettings error:", error);
    res
      .status(500)
      .json({ success: false, message: "Lỗi khi cập nhật cài đặt hệ thống" });
  }
};

/**
 * Get user preferences
 */
const getPreferences = async (req, res) => {
  try {
    const userId = req.user.id;

    const [rows] = await db.execute(
      "SELECT * FROM user_preferences WHERE user_id = ?",
      [userId]
    );

    // Default preferences
    const defaultPreferences = {
      theme: "light",
      sidebarCollapsed: false,
      itemsPerPage: 10,
      showWelcomeMessage: true,
      emailNotifications: true,
      systemNotifications: true,
      birthdayReminder: true,
      anniversaryReminder: true,
      evaluationReminder: true,
      showStatistics: true,
      showRecentActivities: true,
      showUpcomingEvents: true,
      showBirthdayWidget: true,
    };

    // Merge with user preferences
    rows.forEach((row) => {
      if (row.preference_value === "true") {
        defaultPreferences[row.preference_key] = true;
      } else if (row.preference_value === "false") {
        defaultPreferences[row.preference_key] = false;
      } else if (!isNaN(row.preference_value) && row.preference_value !== "") {
        defaultPreferences[row.preference_key] = Number(row.preference_value);
      } else {
        defaultPreferences[row.preference_key] = row.preference_value;
      }
    });

    res.json({ success: true, data: defaultPreferences });
  } catch (error) {
    console.error("getPreferences error:", error);
    res.status(500).json({ success: false, message: "Lỗi khi tải tùy chọn" });
  }
};

/**
 * Update user preferences
 */
const updatePreferences = async (req, res) => {
  try {
    const userId = req.user.id;
    const preferences = req.body;

    for (const [key, value] of Object.entries(preferences)) {
      const stringValue =
        typeof value === "boolean" ? String(value) : String(value);
      await db.execute(
        `INSERT INTO user_preferences (user_id, preference_key, preference_value)
         VALUES (?, ?, ?)
         ON DUPLICATE KEY UPDATE preference_value = ?`,
        [userId, key, stringValue, stringValue]
      );
    }

    res.json({ success: true, message: "Đã cập nhật tùy chọn" });
  } catch (error) {
    console.error("updatePreferences error:", error);
    res
      .status(500)
      .json({ success: false, message: "Lỗi khi cập nhật tùy chọn" });
  }
};

/**
 * Reset preferences to default
 */
const resetPreferences = async (req, res) => {
  try {
    const userId = req.user.id;

    await db.execute("DELETE FROM user_preferences WHERE user_id = ?", [
      userId,
    ]);

    res.json({ success: true, message: "Đã khôi phục tùy chọn mặc định" });
  } catch (error) {
    console.error("resetPreferences error:", error);
    res
      .status(500)
      .json({ success: false, message: "Lỗi khi khôi phục tùy chọn" });
  }
};

/**
 * Test email configuration
 */
const testEmail = async (req, res) => {
  try {
    // Get email settings
    const [rows] = await db.execute(
      "SELECT * FROM system_settings WHERE setting_group = 'system' AND setting_key LIKE 'smtp%' OR setting_key LIKE 'email%'"
    );

    if (rows.length === 0) {
      return res.status(400).json({
        success: false,
        message: "Chưa cấu hình email",
      });
    }

    // TODO: Implement actual email sending logic
    // For now, just return success
    res.json({
      success: true,
      message: "Email test đã được gửi (giả lập)",
    });
  } catch (error) {
    console.error("testEmail error:", error);
    res.status(500).json({ success: false, message: "Lỗi khi test email" });
  }
};

/**
 * Clear cache
 */
const clearCache = async (req, res) => {
  try {
    // TODO: Implement actual cache clearing logic
    res.json({ success: true, message: "Đã xóa cache thành công" });
  } catch (error) {
    console.error("clearCache error:", error);
    res.status(500).json({ success: false, message: "Lỗi khi xóa cache" });
  }
};

/**
 * Get backups list
 */
const getBackups = async (req, res) => {
  try {
    const [rows] = await db.execute(
      `SELECT b.*, u.username as created_by_name
       FROM backups b
       LEFT JOIN users u ON b.created_by = u.id
       ORDER BY b.created_at DESC`
    );

    res.json({ success: true, data: rows });
  } catch (error) {
    console.error("getBackups error:", error);
    res
      .status(500)
      .json({ success: false, message: "Lỗi khi tải danh sách backup" });
  }
};

/**
 * Create new backup using mysqldump npm package and upload to Firebase
 */
const createBackup = async (req, res) => {
  let tempFilePath = null;

  try {
    const userId = req.user.id;
    const timestamp = new Date()
      .toISOString()
      .replace(/[:-]/g, "")
      .slice(0, 15);
    const filename = `backup_${timestamp}.sql`;

    // Use /tmp directory for temporary file (Railway-compatible)
    tempFilePath = path.join("/tmp", filename);

    // Get database config - support both URL and individual params
    let dbConfig;

    if (process.env.MYSQL_URL || process.env.DATABASE_URL) {
      // Parse connection URL (Railway format: mysql://user:pass@host:port/database)
      const connectionUrl = process.env.MYSQL_URL || process.env.DATABASE_URL;
      const urlPattern =
        /mysql:\/\/([^:]+):([^@]+)@([^:]+):(\d+)\/(.+?)(\?.*)?$/;
      const match = connectionUrl.match(urlPattern);

      if (!match) {
        throw new Error("Invalid MYSQL_URL format");
      }

      dbConfig = {
        host: match[3],
        port: parseInt(match[4]),
        user: match[1],
        password: match[2],
        database: match[5],
      };
    } else {
      // Use individual environment variables (Railway or manual config)
      dbConfig = {
        host: process.env.MYSQLHOST || process.env.DB_HOST || "localhost",
        port: parseInt(process.env.MYSQLPORT || process.env.DB_PORT || "3306"),
        user: process.env.MYSQLUSER || process.env.DB_USER || "root",
        password: process.env.MYSQLPASSWORD || process.env.DB_PASSWORD || "",
        database: process.env.MYSQLDATABASE || process.env.DB_NAME || "osp_db",
      };
    }

    console.log("Creating backup with mysqldump library...");
    console.log("Database config:", {
      host: dbConfig.host,
      port: dbConfig.port,
      database: dbConfig.database,
      user: dbConfig.user,
    });

    // Use mysqldump library to create SQL dump
    await mysqldump({
      connection: {
        host: dbConfig.host,
        port: dbConfig.port,
        user: dbConfig.user,
        password: dbConfig.password,
        database: dbConfig.database,
      },
      dumpToFile: tempFilePath,
      dump: {
        schema: {
          table: {
            dropIfExist: true,
          },
        },
      },
    });

    console.log("Backup file created:", tempFilePath);

    // Get file size
    const stats = await fs.stat(tempFilePath);
    const fileSize = stats.size;

    console.log("Backup file size:", fileSize);

    // Try to upload to Firebase Storage
    const bucket = getBucket();
    let downloadUrl = null;
    let storagePath = null;

    if (bucket) {
      try {
        const firebaseDestination = `backups/${filename}`;

        await bucket.upload(tempFilePath, {
          destination: firebaseDestination,
          metadata: {
            contentType: "application/sql",
            metadata: {
              createdBy: userId.toString(),
              createdAt: new Date().toISOString(),
            },
          },
        });

        console.log("Uploaded to Firebase:", firebaseDestination);

        // Get signed URL for download (expires in 7 days)
        const file = bucket.file(firebaseDestination);
        const [url] = await file.getSignedUrl({
          action: "read",
          expires: Date.now() + 7 * 24 * 60 * 60 * 1000, // 7 days
        });

        downloadUrl = url;
        storagePath = firebaseDestination;

        console.log("Firebase download URL generated");
      } catch (uploadError) {
        console.warn(
          "Firebase upload failed, falling back to local storage:",
          uploadError.message
        );
      }
    } else {
      console.warn("Firebase not configured, storing locally only");
    }

    // If Firebase upload failed, store locally
    if (!storagePath) {
      const backupDir = path.join(__dirname, "../../backups");
      await fs.mkdir(backupDir, { recursive: true });

      const localPath = path.join(backupDir, filename);
      await fs.copyFile(tempFilePath, localPath);

      storagePath = `backups/${filename}`;
      console.log("Backup saved locally:", localPath);
    }

    // Clean up temp file
    try {
      if (tempFilePath && fsSync.existsSync(tempFilePath)) {
        fsSync.unlinkSync(tempFilePath);
        console.log("Temp file cleaned up");
      }
    } catch (cleanupError) {
      console.warn("Failed to cleanup temp file:", cleanupError.message);
    }

    // Insert backup record
    const [result] = await db.execute(
      `INSERT INTO backups (filename, file_path, file_size, backup_type, status, created_by, download_url)
       VALUES (?, ?, ?, 'manual', 'completed', ?, ?)`,
      [filename, storagePath, fileSize, userId, downloadUrl]
    );

    res.json({
      success: true,
      data: {
        id: result.insertId,
        filename,
        file_path: storagePath,
        file_size: fileSize,
        download_url: downloadUrl,
      },
      message: "Đã tạo backup thành công",
    });
  } catch (error) {
    console.error("createBackup error:", error);

    // Clean up temp file on error
    try {
      if (tempFilePath && fsSync.existsSync(tempFilePath)) {
        fsSync.unlinkSync(tempFilePath);
      }
    } catch (cleanupError) {
      // Ignore cleanup errors
    }

    res.status(500).json({
      success: false,
      message: "Lỗi khi tạo backup: " + error.message,
    });
  }
};

/**
 * Restore backup
 */
const restoreBackup = async (req, res) => {
  try {
    const { id } = req.params;

    const [backups] = await db.execute("SELECT * FROM backups WHERE id = ?", [
      id,
    ]);

    if (backups.length === 0) {
      return res.status(404).json({
        success: false,
        message: "Không tìm thấy backup",
      });
    }

    const backup = backups[0];
    const fullPath = path.join(__dirname, "../../", backup.file_path);

    // Check if file exists
    try {
      await fs.access(fullPath);
    } catch (err) {
      return res.status(404).json({
        success: false,
        message: "Không tìm thấy file backup",
      });
    }

    // Read SQL file
    const sqlContent = await fs.readFile(fullPath, "utf-8");

    // Get database config
    const dbConfig = {
      host: process.env.DB_HOST || "localhost",
      user: process.env.DB_USER || "root",
      password: process.env.DB_PASSWORD || "",
      database: process.env.DB_NAME || "osp_db",
    };

    // Build mysql restore command
    const mysqlCmd = `mysql -h ${dbConfig.host} -u ${dbConfig.user} ${
      dbConfig.password ? `-p${dbConfig.password}` : ""
    } ${dbConfig.database} < "${fullPath}"`;

    // Execute restore
    await execPromise(mysqlCmd);

    // Log the restore action
    const userId = req.user?.id;
    if (userId) {
      await db.execute(
        `INSERT INTO audit_logs (user_id, action, table_name, description)
         VALUES (?, 'restore', 'database', ?)`,
        [userId, `Restored from backup: ${backup.filename}`]
      );
    }

    res.json({
      success: true,
      message: "Đã khôi phục dữ liệu thành công",
    });
  } catch (error) {
    console.error("restoreBackup error:", error);
    res.status(500).json({
      success: false,
      message: "Lỗi khi khôi phục backup: " + error.message,
    });
  }
};

/**
 * Download backup - supports both Firebase and local storage
 */
const downloadBackup = async (req, res) => {
  try {
    const { id } = req.params;

    const [backups] = await db.execute("SELECT * FROM backups WHERE id = ?", [
      id,
    ]);

    if (backups.length === 0) {
      return res.status(404).json({
        success: false,
        message: "Không tìm thấy backup",
      });
    }

    const backup = backups[0];

    // If backup has download_url (Firebase), redirect to it
    if (backup.download_url) {
      return res.json({
        success: true,
        download_url: backup.download_url,
        message: "Use download_url to download the file",
      });
    }

    // Otherwise, try local file
    const fullPath = path.join(__dirname, "../../", backup.file_path);

    // Check if file exists locally
    try {
      await fs.access(fullPath);
    } catch (err) {
      return res.status(404).json({
        success: false,
        message: "Không tìm thấy file backup",
      });
    }

    // Send file
    res.download(fullPath, backup.filename, (err) => {
      if (err) {
        console.error("Download error:", err);
        if (!res.headersSent) {
          res.status(500).json({ success: false, message: "Lỗi khi tải file" });
        }
      }
    });
  } catch (error) {
    console.error("downloadBackup error:", error);
    res.status(500).json({ success: false, message: "Lỗi khi tải backup" });
  }
};

/**
 * Delete backup
 */
const deleteBackup = async (req, res) => {
  try {
    const { id } = req.params;

    // Get backup info first
    const [backups] = await db.execute("SELECT * FROM backups WHERE id = ?", [
      id,
    ]);

    if (backups.length === 0) {
      return res.status(404).json({
        success: false,
        message: "Không tìm thấy backup",
      });
    }

    const backup = backups[0];
    const fullPath = path.join(__dirname, "../../", backup.file_path);

    // Delete file if exists
    try {
      await fs.unlink(fullPath);
    } catch (err) {
      console.warn("File not found or already deleted:", fullPath);
    }

    // Delete database record
    const [result] = await db.execute("DELETE FROM backups WHERE id = ?", [id]);

    res.json({ success: true, message: "Đã xóa backup" });
  } catch (error) {
    console.error("deleteBackup error:", error);
    res.status(500).json({ success: false, message: "Lỗi khi xóa backup" });
  }
};

/**
 * Restore from uploaded SQL file
 */
const restoreFromFile = async (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).json({
        success: false,
        message: "Vui lòng upload file SQL",
      });
    }

    const sqlContent = req.file.buffer.toString("utf-8");

    // Validate SQL content
    if (!sqlContent.trim()) {
      return res.status(400).json({
        success: false,
        message: "File SQL trống",
      });
    }

    // Split SQL statements by semicolon (basic split)
    // This handles most common SQL dump formats
    const statements = sqlContent
      .split(/;\s*$/gm)
      .map((s) => s.trim())
      .filter(
        (s) => s.length > 0 && !s.startsWith("--") && !s.startsWith("/*")
      );

    if (statements.length === 0) {
      return res.status(400).json({
        success: false,
        message: "Không tìm thấy câu lệnh SQL hợp lệ trong file",
      });
    }

    // Get a connection for transaction
    const connection = await db.getConnection();

    try {
      // Disable foreign key checks during restore
      await connection.query("SET FOREIGN_KEY_CHECKS = 0");

      let successCount = 0;
      let errorCount = 0;
      const errors = [];

      for (const statement of statements) {
        try {
          if (statement.trim()) {
            await connection.query(statement);
            successCount++;
          }
        } catch (stmtError) {
          errorCount++;
          // Log but continue with other statements
          console.error("SQL statement error:", stmtError.message);
          errors.push(stmtError.message);
          // Stop on critical errors
          if (stmtError.code === "ER_PARSE_ERROR") {
            throw new Error(`Lỗi cú pháp SQL: ${stmtError.message}`);
          }
        }
      }

      // Re-enable foreign key checks
      await connection.query("SET FOREIGN_KEY_CHECKS = 1");

      // Log the restore action
      const userId = req.user?.id;
      if (userId) {
        await connection.query(
          `INSERT INTO audit_logs (user_id, action, table_name, description)
           VALUES (?, 'restore', 'database', ?)`,
          [
            userId,
            `Khôi phục database từ file ${req.file.originalname}. Thành công: ${successCount}, Lỗi: ${errorCount}`,
          ]
        );
      }

      connection.release();

      res.json({
        success: true,
        message: `Đã khôi phục dữ liệu thành công! Thực thi ${successCount} câu lệnh${
          errorCount > 0 ? `, ${errorCount} lỗi` : ""
        }`,
        data: {
          executed: successCount,
          errors: errorCount,
          errorMessages: errors.slice(0, 5), // Return first 5 errors
        },
      });
    } catch (txError) {
      // Re-enable foreign key checks even on error
      await connection.query("SET FOREIGN_KEY_CHECKS = 1");
      connection.release();
      throw txError;
    }
  } catch (error) {
    console.error("restoreFromFile error:", error);
    res.status(500).json({
      success: false,
      message: error.message || "Lỗi khi khôi phục dữ liệu từ file SQL",
    });
  }
};

/**
 * Get storage info
 */
const getStorageInfo = async (req, res) => {
  try {
    // Get database size
    const [dbSize] = await db.execute(`
      SELECT 
        SUM(data_length + index_length) AS total_size
      FROM information_schema.tables 
      WHERE table_schema = DATABASE()
    `);

    // Get backups size
    const [backupsSize] = await db.execute(
      "SELECT SUM(file_size) AS total_backup_size FROM backups"
    );

    const totalUsed =
      (dbSize[0]?.total_size || 0) + (backupsSize[0]?.total_backup_size || 0);
    const totalLimit = 10 * 1024 * 1024 * 1024; // 10GB limit (example)

    res.json({
      success: true,
      data: {
        used: totalUsed,
        total: totalLimit,
        percentage: Math.round((totalUsed / totalLimit) * 100),
        database_size: dbSize[0]?.total_size || 0,
        backups_size: backupsSize[0]?.total_backup_size || 0,
      },
    });
  } catch (error) {
    console.error("getStorageInfo error:", error);
    res
      .status(500)
      .json({ success: false, message: "Lỗi khi tải thông tin lưu trữ" });
  }
};

/**
 * Update setting by key
 */
const updateSettingByKey = async (req, res) => {
  try {
    const { key } = req.params;
    const { value } = req.body;

    await db.execute(
      "UPDATE system_settings SET setting_value = ? WHERE setting_key = ?",
      [value, key]
    );

    res.json({ success: true, message: "Đã cập nhật cài đặt" });
  } catch (error) {
    console.error("updateSettingByKey error:", error);
    res
      .status(500)
      .json({ success: false, message: "Lỗi khi cập nhật cài đặt" });
  }
};

module.exports = {
  getAllSettings,
  getGeneralSettings,
  updateGeneralSettings,
  getSystemSettings,
  updateSystemSettings,
  getPreferences,
  updatePreferences,
  resetPreferences,
  testEmail,
  clearCache,
  getBackups,
  createBackup,
  restoreBackup,
  restoreFromFile,
  downloadBackup,
  deleteBackup,
  getStorageInfo,
  updateSettingByKey,
};
