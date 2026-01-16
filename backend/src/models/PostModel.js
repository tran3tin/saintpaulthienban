// backend/src/models/PostModel.js

const BaseModel = require("./BaseModel");

class PostModel extends BaseModel {
  constructor() {
    super({ tableName: "posts", softDeleteColumn: "deleted_at" });
  }

  /**
   * Get all posts with pagination and filters
   */
  async getPosts(options = {}) {
    const {
      page = 1,
      limit = 10,
      search = "",
      category = "",
      status = "",
      sortBy = "newest",
      exclude = null,
    } = options;

    const offset = (page - 1) * limit;

    let whereConditions = ["p.deleted_at IS NULL"];
    let params = [];

    if (search) {
      whereConditions.push(
        "(p.title ILIKE ? OR p.content ILIKE ? OR p.summary ILIKE ?)"
      );
      params.push(`%${search}%`, `%${search}%`, `%${search}%`);
    }

    if (category) {
      whereConditions.push("p.category = ?");
      params.push(category);
    }

    if (status === "pinned") {
      whereConditions.push("p.is_pinned = TRUE");
    } else if (status === "important") {
      whereConditions.push("p.is_important = TRUE");
    }

    if (exclude) {
      whereConditions.push("p.id != ?");
      params.push(exclude);
    }

    // Exclude pinned posts from regular list
    whereConditions.push("p.is_pinned = FALSE");

    let orderBy = "p.created_at DESC";
    if (sortBy === "oldest") {
      orderBy = "p.created_at ASC";
    } else if (sortBy === "views") {
      orderBy = "p.view_count DESC";
    }

    const whereClause = whereConditions.join(" AND ");

    // Get total count
    const countQuery = `
      SELECT COUNT(*) as total
      FROM posts p
      WHERE ${whereClause}
    `;
    const countResult = await this.executeQuery(countQuery, params);
    const total = countResult[0]?.total || 0;

    // Get posts
    const query = `
      SELECT 
        p.*,
        u.username as author_name,
        u.email as author_email
      FROM posts p
      LEFT JOIN users u ON p.author_id = u.id
      WHERE ${whereClause}
      ORDER BY ${orderBy}
      LIMIT ? OFFSET ?
    `;

    const posts = await this.executeQuery(query, [...params, limit, offset]);

    // Parse tags/attachments for legacy string payloads (JSONB will already be objects)
    posts.forEach((post) => {
      if (post.tags) {
        try {
          post.tags =
            typeof post.tags === "string" ? JSON.parse(post.tags) : post.tags;
        } catch (e) {
          post.tags = [];
        }
      } else {
        post.tags = [];
      }
      if (post.attachments) {
        try {
          post.attachments =
            typeof post.attachments === "string"
              ? JSON.parse(post.attachments)
              : post.attachments;
        } catch (e) {
          post.attachments = [];
        }
      } else {
        post.attachments = [];
      }
    });

    return {
      posts,
      total,
      totalPages: Math.ceil(total / limit),
      currentPage: page,
    };
  }

  /**
   * Get pinned posts
   */
  async getPinnedPosts() {
    const query = `
      SELECT 
        p.*,
        u.username as author_name,
        u.email as author_email
      FROM posts p
      LEFT JOIN users u ON p.author_id = u.id
      WHERE p.is_pinned = TRUE AND p.deleted_at IS NULL
      ORDER BY p.updated_at DESC
    `;

    const posts = await this.executeQuery(query);

    posts.forEach((post) => {
      if (post.tags) {
        try {
          post.tags =
            typeof post.tags === "string" ? JSON.parse(post.tags) : post.tags;
        } catch (e) {
          post.tags = [];
        }
      } else {
        post.tags = [];
      }
      if (post.attachments) {
        try {
          post.attachments =
            typeof post.attachments === "string"
              ? JSON.parse(post.attachments)
              : post.attachments;
        } catch (e) {
          post.attachments = [];
        }
      } else {
        post.attachments = [];
      }
    });

    return posts;
  }

  /**
   * Get post by ID with author info
   */
  async getPostById(id) {
    const query = `
      SELECT 
        p.*,
        u.username as author_name,
        u.email as author_email
      FROM posts p
      LEFT JOIN users u ON p.author_id = u.id
      WHERE p.id = ? AND p.deleted_at IS NULL
    `;

    const result = await this.executeQuery(query, [id]);
    const post = result[0];

    if (post) {
      if (post.tags) {
        try {
          post.tags =
            typeof post.tags === "string" ? JSON.parse(post.tags) : post.tags;
        } catch (e) {
          post.tags = [];
        }
      } else {
        post.tags = [];
      }
      if (post.attachments) {
        try {
          post.attachments =
            typeof post.attachments === "string"
              ? JSON.parse(post.attachments)
              : post.attachments;
        } catch (e) {
          post.attachments = [];
        }
      } else {
        post.attachments = [];
      }
    }

    return post;
  }

  /**
   * Increment view count
   */
  async incrementViewCount(id) {
    const query = `
      UPDATE posts 
      SET view_count = view_count + 1 
      WHERE id = ?
    `;
    return this.executeQuery(query, [id]);
  }

  /**
   * Toggle pin status
   */
  async togglePin(id) {
    const query = `
      UPDATE posts 
      SET is_pinned = NOT is_pinned, updated_at = NOW() 
      WHERE id = ?
    `;
    return this.executeQuery(query, [id]);
  }

  /**
   * Soft delete
   */
  async softDelete(id) {
    const query = `
      UPDATE posts 
      SET deleted_at = NOW() 
      WHERE id = ?
    `;
    return this.executeQuery(query, [id]);
  }
}

module.exports = new PostModel();
