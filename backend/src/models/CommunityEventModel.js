const BaseModel = require("./BaseModel");

class CommunityEventModel extends BaseModel {
  constructor() {
    super({ tableName: "community_events", primaryKey: "id" });
    this.allowedFields = [
      "community_id",
      "title",
      "description",
      "event_date",
      "created_at",
    ];
    this.requiredFields = ["community_id", "title", "event_date"];
  }

  validateData(data = {}, { partial = false } = {}) {
    const sanitized = {};

    Object.entries(data).forEach(([key, value]) => {
      if (!this.allowedFields.includes(key)) {
        throw new Error(`Field ${key} is not allowed in CommunityEvent model.`);
      }
      sanitized[key] = value;
    });

    if (!partial) {
      this.requiredFields.forEach((field) => {
        if (sanitized[field] === undefined || sanitized[field] === null) {
          throw new Error(
            `Field ${field} is required for CommunityEvent model.`,
          );
        }
      });
    }

    return sanitized;
  }

  async create(data = {}) {
    const sanitized = this.validateData(data);
    return super.create(sanitized);
  }
}

module.exports = CommunityEventModel;
