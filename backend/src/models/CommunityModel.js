const BaseModel = require("./BaseModel");

class CommunityModel extends BaseModel {
  constructor() {
    super({ tableName: "communities", primaryKey: "id" });
    this.allowedFields = [
      "code",
      "name",
      "address",
      "phone",
      "email",
      "established_date",
      "status",
      "description",
      "history",
      "created_at",
      "updated_at",
    ];
    this.requiredFields = ["name"];
  }

  validateData(data = {}, { partial = false } = {}) {
    const sanitized = {};

    Object.entries(data).forEach(([key, value]) => {
      if (!this.allowedFields.includes(key)) {
        throw new Error(`Field ${key} is not allowed in Communities model.`);
      }
      sanitized[key] = value;
    });

    if (!partial) {
      this.requiredFields.forEach((field) => {
        if (sanitized[field] === undefined || sanitized[field] === null) {
          throw new Error(`Field ${field} is required for Communities model.`);
        }
      });
    }

    return sanitized;
  }

  async create(data = {}) {
    const sanitized = this.validateData(data);
    return super.create(sanitized);
  }

  async update(id, data = {}) {
    const sanitized = this.validateData(data, { partial: true });
    return super.update(id, sanitized);
  }

  async getMembersList(communityId) {
    if (!communityId) {
      throw new Error("getMembersList requires a community id.");
    }

    // Check if journey_stages table exists
    let hasJourneyStagesTable = false;
    try {
      await this.executeQuery("SELECT 1 FROM journey_stages LIMIT 1");
      hasJourneyStagesTable = true;
    } catch (e) {
      // Table doesn't exist
    }

    // Get members from vocation_journey (current stage at this community)
    let sql;
    if (hasJourneyStagesTable) {
      sql = `
        SELECT vj.id, vj.sister_id, vj.stage, vj.start_date, vj.end_date,
               s.birth_name, s.saint_name, s.code AS sister_code,
               js.name as stage_name, js.color as stage_color
        FROM vocation_journey vj
        INNER JOIN sisters s ON s.id = vj.sister_id
        LEFT JOIN journey_stages js ON vj.stage = js.code
        WHERE vj.community_id = ?
          AND (vj.end_date IS NULL OR vj.end_date >= CURRENT_DATE)
        ORDER BY vj.start_date DESC
      `;
    } else {
      sql = `
        SELECT vj.id, vj.sister_id, vj.stage, vj.start_date, vj.end_date,
               s.birth_name, s.saint_name, s.code AS sister_code,
               vj.stage as stage_name, '#6c757d' as stage_color
        FROM vocation_journey vj
        INNER JOIN sisters s ON s.id = vj.sister_id
        WHERE vj.community_id = ?
          AND (vj.end_date IS NULL OR vj.end_date >= CURRENT_DATE)
        ORDER BY vj.start_date DESC
      `;
    }

    return this.executeQuery(sql, [communityId]);
  }
}

module.exports = new CommunityModel();
