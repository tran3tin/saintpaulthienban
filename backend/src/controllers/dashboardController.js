// backend/src/controllers/dashboardController.js

const SisterModel = require("../models/SisterModel");
const CommunityModel = require("../models/CommunityModel");
const PostModel = require("../models/PostModel");
const AuditLogModel = require("../models/AuditLogModel");
const auditLogFormatter = require("../services/auditLogFormatter");

/**
 * Get dashboard overview statistics
 */
const getDashboardStats = async (req, res) => {
  try {
    // Total sisters
    const [totalSistersResult] = await SisterModel.executeQuery(
      "SELECT COUNT(*) as total FROM sisters"
    );
    const totalSisters = totalSistersResult?.total || 0;

    // Active sisters
    const [activeSistersResult] = await SisterModel.executeQuery(
      "SELECT COUNT(*) as total FROM sisters WHERE status = 'active'"
    );
    const activeSisters = activeSistersResult?.total || 0;

    // Total communities
    const [totalCommunitiesResult] = await CommunityModel.executeQuery(
      "SELECT COUNT(*) as total FROM communities"
    );
    const totalCommunities = totalCommunitiesResult?.total || 0;

    // Average age of active sisters
    const [avgAgeResult] = await SisterModel.executeQuery(
      `SELECT ROUND(AVG(EXTRACT(YEAR FROM AGE(CURRENT_DATE, date_of_birth))::INT)) as avg_age 
       FROM sisters 
       WHERE status = 'active' AND date_of_birth IS NOT NULL`
    );
    const averageAge = avgAgeResult?.avg_age || 0;

    // New sisters this month
    const [newSistersResult] = await SisterModel.executeQuery(
      `SELECT COUNT(*) as total FROM sisters 
       WHERE EXTRACT(MONTH FROM created_at) = EXTRACT(MONTH FROM CURRENT_DATE) 
       AND EXTRACT(YEAR FROM created_at) = EXTRACT(YEAR FROM CURRENT_DATE)`
    );
    const newSistersThisMonth = newSistersResult?.total || 0;

    // Sisters by status
    const sistersByStatus = await SisterModel.executeQuery(
      `SELECT status, COUNT(*) as count 
       FROM sisters 
       GROUP BY status`
    );

    // Sisters by vocation stage (latest stage only)
    const sistersByStage = await SisterModel.executeQuery(
      `SELECT v.stage, COUNT(DISTINCT v.sister_id) as count
       FROM vocation_journey v
       INNER JOIN (
         SELECT sister_id, MAX(start_date) AS max_start
         FROM vocation_journey
         GROUP BY sister_id
       ) latest ON latest.sister_id = v.sister_id AND latest.max_start = v.start_date
       INNER JOIN sisters s ON s.id = v.sister_id
       GROUP BY v.stage
       ORDER BY count DESC`
    );

    return res.status(200).json({
      success: true,
      data: {
        totalSisters,
        activeSisters,
        totalCommunities,
        averageAge,
        newSistersThisMonth,
        sistersByStatus,
        sistersByStage,
      },
    });
  } catch (error) {
    console.error("getDashboardStats error:", error.message);
    return res.status(500).json({
      success: false,
      message: "Lỗi khi tải thống kê dashboard",
    });
  }
};

/**
 * Get recent activities from audit log
 */
const getRecentActivities = async (req, res) => {
  try {
    const { limit = 10, useAI = false } = req.query;

    const activities = await AuditLogModel.executeQuery(
      `SELECT 
        al.id,
        al.action,
        al.table_name,
        al.record_id,
        al.old_value,
        al.new_value,
        al.ip_address,
        al.created_at,
        u.full_name as user_name,
        u.email as user_email
       FROM audit_logs al
       LEFT JOIN users u ON u.id = al.user_id
       ORDER BY al.created_at DESC
       LIMIT ?`,
      [parseInt(limit)]
    );

    // Format activities using auditLogFormatter
    const formattedActivities = await auditLogFormatter.formatActivities(
      activities,
      useAI === "true" || useAI === true
    );

    return res.status(200).json({
      success: true,
      data: formattedActivities,
    });
  } catch (error) {
    console.error("getRecentActivities error:", error.message);
    return res.status(500).json({
      success: false,
      message: "Lỗi khi tải hoạt động gần đây",
    });
  }
};

/**
 * Get single activity detail with AI description
 */
const getActivityDetail = async (req, res) => {
  try {
    const { id } = req.params;
    const { useAI = true } = req.query;

    const [activity] = await AuditLogModel.executeQuery(
      `SELECT 
        al.id,
        al.action,
        al.table_name,
        al.record_id,
        al.old_value,
        al.new_value,
        al.ip_address,
        al.created_at,
        u.full_name as user_name,
        u.email as user_email
       FROM audit_logs al
       LEFT JOIN users u ON u.id = al.user_id
       WHERE al.id = ?`,
      [id]
    );

    if (!activity) {
      return res.status(404).json({
        success: false,
        message: "Không tìm thấy hoạt động",
      });
    }

    // Format activity with AI (if requested)
    const formatted = await auditLogFormatter.formatActivity(
      activity,
      useAI === "true" || useAI === true
    );

    return res.status(200).json({
      success: true,
      data: formatted,
    });
  } catch (error) {
    console.error("getActivityDetail error:", error.message);
    return res.status(500).json({
      success: false,
      message: "Lỗi khi tải chi tiết hoạt động",
    });
  }
};

/**
 * Get recent posts for dashboard
 */
const getRecentPosts = async (req, res) => {
  try {
    const { limit = 5 } = req.query;

    const posts = await PostModel.executeQuery(
      `SELECT 
        p.id,
        p.title,
        p.category,
        p.summary,
        p.is_pinned,
        p.is_important,
        p.view_count,
        p.created_at,
        u.full_name as author_name
       FROM posts p
       LEFT JOIN users u ON u.id = p.author_id
       WHERE p.status = 'published' AND p.deleted_at IS NULL
       ORDER BY p.is_pinned DESC, p.created_at DESC
       LIMIT ?`,
      [parseInt(limit)]
    );

    return res.status(200).json({
      success: true,
      data: posts,
    });
  } catch (error) {
    console.error("getRecentPosts error:", error.message);
    return res.status(500).json({
      success: false,
      message: "Lỗi khi tải bài đăng gần đây",
    });
  }
};

/**
 * Get quick stats for dashboard cards
 */
const getQuickStats = async (req, res) => {
  try {
    // Pending evaluations
    const [pendingEvaluations] = await SisterModel.executeQuery(
      `SELECT COUNT(*) as total FROM evaluations WHERE status = 'pending'`
    );

    // Upcoming events (posts with su-kien category created in last 7 days)
    const [upcomingEvents] = await PostModel.executeQuery(
      `SELECT COUNT(*) as total FROM posts 
       WHERE category = 'su-kien' 
       AND status = 'published' 
       AND deleted_at IS NULL
       AND created_at >= CURRENT_DATE - INTERVAL '7 days'`
    );

    // Important announcements
    const [importantAnnouncements] = await PostModel.executeQuery(
      `SELECT COUNT(*) as total FROM posts 
       WHERE is_important = 1 
       AND status = 'published' 
       AND deleted_at IS NULL`
    );

    // Active missions
    const [activeMissions] = await SisterModel.executeQuery(
      `SELECT COUNT(*) as total FROM missions 
       WHERE (end_date IS NULL OR end_date >= CURRENT_DATE)`
    );

    return res.status(200).json({
      success: true,
      data: {
        pendingEvaluations: pendingEvaluations?.total || 0,
        upcomingEvents: upcomingEvents?.total || 0,
        importantAnnouncements: importantAnnouncements?.total || 0,
        activeMissions: activeMissions?.total || 0,
      },
    });
  } catch (error) {
    console.error("getQuickStats error:", error.message);
    return res.status(500).json({
      success: false,
      message: "Lỗi khi tải thống kê nhanh",
    });
  }
};

module.exports = {
  getDashboardStats,
  getRecentActivities,
  getActivityDetail,
  getRecentPosts,
  getQuickStats,
};
