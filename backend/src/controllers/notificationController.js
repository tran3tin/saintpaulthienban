// src/controllers/notificationController.js
const db = require("../config/database");

/**
 * Get notifications for current user
 */
const getNotifications = async (req, res) => {
  try {
    const userId = req.user.id;

    // 1. Lấy dữ liệu thô từ query (đang là String hoặc undefined)
    const { limit } = req.query;

    // 2. ÉP KIỂU SANG SỐ NGUYÊN (QUAN TRỌNG NHẤT)
    // Nếu không có limit hoặc ép kiểu lỗi, mặc định lấy 10
    const limitNumber = Number(limit) || 10;

    // Log ra để kiểm tra (trên server log số sẽ có màu vàng/xanh, chuỗi màu trắng)
    console.log(
      `[Debug] UserID: ${userId}, Limit (Number): ${limitNumber}, Type: ${typeof limitNumber}`
    );

    const [notifications] = await db.execute(
      `SELECT * FROM notifications 
       WHERE user_id = ? 
       ORDER BY created_at DESC LIMIT ?`,
      [userId, limitNumber]
    );

    // Get unread count
    const [countResult] = await db.execute(
      "SELECT COUNT(*)::int as count FROM notifications WHERE user_id = ? AND is_read = FALSE",
      [userId]
    );

    res.json({
      success: true,
      data: notifications,
      unreadCount: countResult[0].count,
    });
  } catch (error) {
    console.error("getNotifications error:", error);
    res.status(500).json({ success: false, message: "Lỗi khi tải thông báo" });
  }
};

/**
 * Get unread count
 */
const getUnreadCount = async (req, res) => {
  try {
    const userId = req.user.id;

    const [rows] = await db.execute(
      "SELECT COUNT(*)::int as count FROM notifications WHERE user_id = ? AND is_read = FALSE",
      [userId]
    );

    res.json({
      success: true,
      count: rows[0].count,
    });
  } catch (error) {
    console.error("getUnreadCount error:", error);
    res.status(500).json({ success: false, message: "Lỗi khi đếm thông báo" });
  }
};

/**
 * Mark notification as read
 */
const markAsRead = async (req, res) => {
  try {
    const userId = req.user.id;
    const { id } = req.params;

    const [rows] = await db.execute(
      "UPDATE notifications SET is_read = TRUE, read_at = CURRENT_TIMESTAMP WHERE id = ? AND user_id = ? RETURNING id",
      [id, userId]
    );

    if (!rows || rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: "Không tìm thấy thông báo",
      });
    }

    res.json({ success: true, message: "Đã đánh dấu đã đọc" });
  } catch (error) {
    console.error("markAsRead error:", error);
    res
      .status(500)
      .json({ success: false, message: "Lỗi khi cập nhật thông báo" });
  }
};

/**
 * Mark all notifications as read
 */
const markAllAsRead = async (req, res) => {
  try {
    const userId = req.user.id;

    await db.execute(
      "UPDATE notifications SET is_read = TRUE, read_at = CURRENT_TIMESTAMP WHERE user_id = ? AND is_read = FALSE",
      [userId]
    );

    res.json({ success: true, message: "Đã đánh dấu tất cả đã đọc" });
  } catch (error) {
    console.error("markAllAsRead error:", error);
    res
      .status(500)
      .json({ success: false, message: "Lỗi khi cập nhật thông báo" });
  }
};

/**
 * Delete a notification
 */
const deleteNotification = async (req, res) => {
  try {
    const userId = req.user.id;
    const { id } = req.params;

    const [rows] = await db.execute(
      "DELETE FROM notifications WHERE id = ? AND user_id = ? RETURNING id",
      [id, userId]
    );

    if (!rows || rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: "Không tìm thấy thông báo",
      });
    }

    res.json({ success: true, message: "Đã xóa thông báo" });
  } catch (error) {
    console.error("deleteNotification error:", error);
    res.status(500).json({ success: false, message: "Lỗi khi xóa thông báo" });
  }
};

/**
 * Delete all notifications
 */
const deleteAllNotifications = async (req, res) => {
  try {
    const userId = req.user.id;

    await db.execute("DELETE FROM notifications WHERE user_id = ?", [userId]);

    res.json({ success: true, message: "Đã xóa tất cả thông báo" });
  } catch (error) {
    console.error("deleteAllNotifications error:", error);
    res.status(500).json({ success: false, message: "Lỗi khi xóa thông báo" });
  }
};

/**
 * Create a notification (internal use or admin)
 */
const createNotification = async (req, res) => {
  try {
    const { user_id, type = "info", title, message, link } = req.body;

    if (!user_id || !title) {
      return res.status(400).json({
        success: false,
        message: "user_id và title là bắt buộc",
      });
    }

    const [rows] = await db.execute(
      `INSERT INTO notifications (user_id, type, title, message, link)
       VALUES (?, ?, ?, ?, ?) RETURNING id`,
      [user_id, type, title, message || null, link || null]
    );

    res.json({
      success: true,
      data: { id: rows?.[0]?.id },
      message: "Đã tạo thông báo",
    });
  } catch (error) {
    console.error("createNotification error:", error);
    res.status(500).json({ success: false, message: "Lỗi khi tạo thông báo" });
  }
};

/**
 * Create notification for multiple users (broadcast)
 */
const broadcastNotification = async (req, res) => {
  try {
    const { user_ids, type = "info", title, message, link } = req.body;

    if (!user_ids || !Array.isArray(user_ids) || user_ids.length === 0) {
      return res.status(400).json({
        success: false,
        message: "user_ids phải là mảng không rỗng",
      });
    }

    if (!title) {
      return res.status(400).json({
        success: false,
        message: "title là bắt buộc",
      });
    }

    // Use UNNEST to insert for multiple users efficiently
    await db.execute(
      `INSERT INTO notifications (user_id, type, title, message, link)
       SELECT uid, ?, ?, ?, ?
       FROM UNNEST(?::int[]) AS uid`,
      [type, title, message || null, link || null, user_ids]
    );

    res.json({
      success: true,
      message: `Đã gửi thông báo đến ${user_ids.length} người dùng`,
    });
  } catch (error) {
    console.error("broadcastNotification error:", error);
    res.status(500).json({ success: false, message: "Lỗi khi gửi thông báo" });
  }
};

module.exports = {
  getNotifications,
  getUnreadCount,
  markAsRead,
  markAllAsRead,
  deleteNotification,
  deleteAllNotifications,
  createNotification,
  broadcastNotification,
};
