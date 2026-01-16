// src/models/UserCommunityModel.js

const BaseModel = require("./BaseModel");

class UserCommunityModel extends BaseModel {
  constructor() {
    super({ tableName: "user_communities", primaryKey: "id" });
  }

  /**
   * Get all communities assigned to user
   */
  async getUserCommunities(userId) {
    const query = `
      SELECT c.* 
      FROM communities c
      INNER JOIN user_communities uc ON uc.community_id = c.id
      WHERE uc.user_id = ?
      ORDER BY c.name
    `;
    return this.executeQuery(query, [userId]);
  }

  /**
   * Get community IDs assigned to user
   */
  async getUserCommunityIds(userId) {
    const query = `
      SELECT community_id 
      FROM ${this.tableName}
      WHERE user_id = ?
    `;
    const results = await this.executeQuery(query, [userId]);
    return results.map((r) => r.community_id);
  }

  /**
   * Grant communities to user
   */
  async grantCommunities(userId, communityIds, grantedBy) {
    if (!communityIds || communityIds.length === 0) return;

    // Use individual inserts for PostgreSQL compatibility
    const results = [];
    for (const commId of communityIds) {
      const query = `
        INSERT INTO ${this.tableName} (user_id, community_id, granted_by)
        VALUES ($1, $2, $3)
        ON CONFLICT (user_id, community_id) DO UPDATE SET 
          granted_at = CURRENT_TIMESTAMP, 
          granted_by = EXCLUDED.granted_by
      `;
      const result = await this.executeQuery(query, [
        userId,
        commId,
        grantedBy,
      ]);
      results.push(result);
    }
    return results;
  }

  /**
   * Revoke specific communities from user
   */
  async revokeCommunities(userId, communityIds) {
    if (!communityIds || communityIds.length === 0) return;

    const placeholders = communityIds.map((_, i) => `$${i + 2}`).join(",");
    const query = `
      DELETE FROM ${this.tableName} 
      WHERE user_id = $1 AND community_id IN (${placeholders})
    `;

    return this.executeQuery(query, [userId, ...communityIds]);
  }

  /**
   * Revoke all communities from user
   */
  async revokeAllCommunities(userId) {
    return this.delete({ user_id: userId });
  }

  /**
   * Sync user communities (replace all)
   */
  async syncCommunities(userId, communityIds, grantedBy) {
    const connection = await this.pool.getConnection();
    try {
      await connection.beginTransaction();

      // Delete all existing communities
      await connection.query(
        `DELETE FROM ${this.tableName} WHERE user_id = ?`,
        [userId]
      );

      // Add new communities
      if (communityIds && communityIds.length > 0) {
        const values = communityIds.map((commId) => [
          userId,
          commId,
          grantedBy,
        ]);
        await connection.query(
          `INSERT INTO ${this.tableName} (user_id, community_id, granted_by) VALUES ?`,
          [values]
        );
      }

      await connection.commit();
    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  }

  /**
   * Check if user has access to community
   */
  async hasCommunityAccess(userId, communityId) {
    const query = `
      SELECT COUNT(*) as count
      FROM ${this.tableName}
      WHERE user_id = ? AND community_id = ?
    `;
    const [result] = await this.executeQuery(query, [userId, communityId]);
    return result.count > 0;
  }

  /**
   * Get users assigned to a community
   */
  async getCommunityUsers(communityId) {
    const query = `
      SELECT u.* 
      FROM users u
      INNER JOIN user_communities uc ON uc.user_id = u.id
      WHERE uc.community_id = ?
      ORDER BY u.full_name
    `;
    return this.executeQuery(query, [communityId]);
  }
}

module.exports = new UserCommunityModel();
