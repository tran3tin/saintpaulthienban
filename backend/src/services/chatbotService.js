// services/chatbotService.js

const db = require("../config/database");
const NodeCache = require("node-cache");

// Cache for 30 minutes
const cache = new NodeCache({ stdTTL: 1800 });

// Vietnamese text normalization helpers
const vietnameseNormalize = {
  // Remove Vietnamese diacritics for fuzzy matching
  removeDiacritics: (str) => {
    return str
      .normalize("NFD")
      .replace(/[\u0300-\u036f]/g, "")
      .replace(/đ/g, "d")
      .replace(/Đ/g, "D");
  },

  // Normalize text for comparison
  normalize: (str) => {
    return str.toLowerCase().trim().replace(/\s+/g, " ");
  },

  // Calculate similarity between two strings (0-1)
  similarity: (str1, str2) => {
    const s1 = vietnameseNormalize.normalize(str1);
    const s2 = vietnameseNormalize.normalize(str2);
    if (s1 === s2) return 1;
    if (s1.includes(s2) || s2.includes(s1)) return 0.8;

    // Levenshtein-based similarity for typo tolerance
    const longer = s1.length > s2.length ? s1 : s2;
    const shorter = s1.length > s2.length ? s2 : s1;
    if (longer.length === 0) return 1;

    const editDistance = vietnameseNormalize.levenshtein(s1, s2);
    return (longer.length - editDistance) / longer.length;
  },

  // Levenshtein distance
  levenshtein: (a, b) => {
    const matrix = [];
    for (let i = 0; i <= b.length; i++) matrix[i] = [i];
    for (let j = 0; j <= a.length; j++) matrix[0][j] = j;
    for (let i = 1; i <= b.length; i++) {
      for (let j = 1; j <= a.length; j++) {
        matrix[i][j] =
          b.charAt(i - 1) === a.charAt(j - 1)
            ? matrix[i - 1][j - 1]
            : Math.min(
                matrix[i - 1][j - 1] + 1,
                matrix[i][j - 1] + 1,
                matrix[i - 1][j] + 1
              );
      }
    }
    return matrix[b.length][a.length];
  },
};

class ChatbotService {
  /**
   * Analyze message to detect intent and extract entities
   * Enhanced with better Vietnamese NLP patterns
   */
  analyzeMessage(message) {
    const lowerMessage = message.toLowerCase();
    const normalizedMessage = vietnameseNormalize.normalize(message);

    const analysis = {
      intent: "general",
      subIntent: null,
      entities: {},
      keywords: [],
      confidence: 0,
      questionType: this.detectQuestionType(message),
    };

    // Enhanced intent patterns with priority and confidence scoring
    const intentPatterns = [
      {
        intent: "journey_info",
        priority: 10,
        patterns: [
          { regex: /hành trình\s*(ơn gọi)?/i, weight: 1.0 },
          { regex: /ơn gọi/i, weight: 0.9 },
          { regex: /giai đoạn\s*(nào|gì|hiện tại)?/i, weight: 0.9 },
          { regex: /đang\s*(ở\s*)?(giai đoạn|bước)/i, weight: 0.85 },
          { regex: /khấn\s*(tạm|trọn|lần đầu|vĩnh viễn)?/i, weight: 0.95 },
          { regex: /nhà tập/i, weight: 0.9 },
          { regex: /tập viện/i, weight: 0.9 },
          { regex: /tiền tập/i, weight: 0.9 },
          { regex: /tìm hiểu\s*(ơn gọi)?/i, weight: 0.85 },
          { regex: /novitiate|postulancy|vows/i, weight: 0.9 },
          { regex: /ai\s+(đang|đã)\s+(khấn|ở)/i, weight: 0.8 },
        ],
      },
      {
        intent: "sister_info",
        priority: 9,
        patterns: [
          { regex: /thông tin\s+(về\s+)?(chị|sơ|nữ tu)/i, weight: 1.0 },
          { regex: /(chị|sơ)\s+[A-Za-zÀ-ỹ]+/i, weight: 0.95 },
          { regex: /nữ tu\s+[A-Za-zÀ-ỹ]+/i, weight: 0.95 },
          { regex: /hồ sơ\s+(của\s+)?/i, weight: 0.9 },
          { regex: /cho\s+(tôi\s+)?biết\s+về/i, weight: 0.85 },
          { regex: /tìm\s+(thông tin\s+)?về/i, weight: 0.85 },
          { regex: /ai\s+là/i, weight: 0.7 },
          { regex: /profile|info/i, weight: 0.8 },
          { regex: /tên\s+(thánh|thật|họ)/i, weight: 0.85 },
          { regex: /sinh\s+(ngày|năm|nơi|quê)/i, weight: 0.8 },
          { regex: /liên\s*(hệ|lạc)/i, weight: 0.75 },
        ],
      },
      {
        intent: "community_info",
        priority: 8,
        patterns: [
          { regex: /cộng\s*đoàn\s+[A-Za-zÀ-ỹ]+/i, weight: 1.0 },
          { regex: /danh\s*sách\s*(các\s+)?cộng\s*đoàn/i, weight: 0.95 },
          { regex: /cộng\s*đoàn\s*(nào|gì)/i, weight: 0.9 },
          { regex: /nhà dòng/i, weight: 0.85 },
          { regex: /địa chỉ\s+(cộng đoàn|nhà dòng)?/i, weight: 0.85 },
          { regex: /ở\s+(cộng đoàn|đâu)/i, weight: 0.8 },
          { regex: /thuộc\s+cộng\s*đoàn/i, weight: 0.9 },
          { regex: /thành viên\s+(của\s+)?cộng đoàn/i, weight: 0.9 },
          { regex: /ai\s+(đang\s+)?ở\s+(cộng đoàn)?/i, weight: 0.75 },
          { regex: /community/i, weight: 0.8 },
        ],
      },
      {
        intent: "statistics",
        priority: 7,
        patterns: [
          { regex: /thống kê\s*(tổng\s*quan|chung)?/i, weight: 1.0 },
          { regex: /báo cáo\s*(tổng\s*quan)?/i, weight: 0.95 },
          { regex: /tổng\s*(số|cộng)/i, weight: 0.9 },
          { regex: /bao nhiêu\s*(nữ tu|chị|người|cộng đoàn)?/i, weight: 0.95 },
          { regex: /số\s*lượng/i, weight: 0.9 },
          { regex: /có\s+mấy/i, weight: 0.85 },
          { regex: /đếm\s*(số)?/i, weight: 0.85 },
          { regex: /report|stats|count/i, weight: 0.8 },
          { regex: /phân\s*bổ/i, weight: 0.85 },
          { regex: /tỷ\s*lệ/i, weight: 0.85 },
          { regex: /trung\s*bình/i, weight: 0.8 },
        ],
      },
      {
        intent: "education_info",
        priority: 6,
        patterns: [
          { regex: /học\s*vấn/i, weight: 1.0 },
          { regex: /bằng\s*cấp/i, weight: 0.95 },
          { regex: /trình\s*độ\s*(học vấn)?/i, weight: 0.9 },
          { regex: /tốt nghiệp/i, weight: 0.9 },
          { regex: /học\s+(ở\s+)?trường/i, weight: 0.85 },
          { regex: /chuyên\s*ngành/i, weight: 0.9 },
          { regex: /cử\s*nhân|thạc\s*sĩ|tiến\s*sĩ/i, weight: 0.95 },
          { regex: /đại học|cao đẳng/i, weight: 0.85 },
          { regex: /education|degree/i, weight: 0.8 },
        ],
      },
      {
        intent: "health_info",
        priority: 5,
        patterns: [
          { regex: /sức\s*khỏe/i, weight: 1.0 },
          { regex: /bệnh\s*(tình|án|sử)?/i, weight: 0.9 },
          { regex: /khám\s*(bệnh|sức khỏe)?/i, weight: 0.9 },
          { regex: /điều\s*trị/i, weight: 0.9 },
          { regex: /thuốc/i, weight: 0.85 },
          { regex: /health/i, weight: 0.8 },
        ],
      },
      {
        intent: "mission_info",
        priority: 5,
        patterns: [
          { regex: /sứ\s*vụ/i, weight: 1.0 },
          { regex: /công\s*tác\s*(tông đồ)?/i, weight: 0.9 },
          { regex: /mission/i, weight: 0.8 },
          { regex: /hoạt\s*động\s*(tông đồ)?/i, weight: 0.85 },
          { regex: /bổ\s*nhiệm/i, weight: 0.85 },
        ],
      },
      {
        intent: "help",
        priority: 1,
        patterns: [
          { regex: /giúp\s*(đỡ|tôi)?/i, weight: 1.0 },
          { regex: /hướng\s*dẫn\s*(sử dụng)?/i, weight: 0.95 },
          { regex: /làm\s*sao\s*(để)?/i, weight: 0.9 },
          { regex: /cách\s*(nào|để)?/i, weight: 0.85 },
          { regex: /có thể\s*(hỏi|làm)\s*gì/i, weight: 0.9 },
          { regex: /bạn\s+là\s+ai/i, weight: 0.95 },
          { regex: /help|how to/i, weight: 0.8 },
        ],
      },
      {
        intent: "greeting",
        priority: 0,
        patterns: [
          { regex: /^(xin\s*)?chào/i, weight: 1.0 },
          { regex: /^hello|hi|hey/i, weight: 1.0 },
          { regex: /khỏe không/i, weight: 0.9 },
        ],
      },
    ];

    // Score each intent
    let bestMatch = { intent: "general", score: 0, priority: -1 };

    for (const { intent, priority, patterns } of intentPatterns) {
      let maxScore = 0;
      for (const { regex, weight } of patterns) {
        if (regex.test(message)) {
          const score = weight;
          if (score > maxScore) maxScore = score;
        }
      }

      // Use priority as tiebreaker
      if (
        maxScore > bestMatch.score ||
        (maxScore === bestMatch.score && priority > bestMatch.priority)
      ) {
        bestMatch = { intent, score: maxScore, priority };
      }
    }

    analysis.intent = bestMatch.intent;
    analysis.confidence = bestMatch.score;

    // Detect sub-intent for more specific handling
    analysis.subIntent = this.detectSubIntent(message, analysis.intent);

    // Extract keywords (excluding common Vietnamese stop words)
    const stopWords = [
      "này",
      "của",
      "các",
      "những",
      "được",
      "trong",
      "không",
      "cho",
      "tôi",
      "biết",
      "về",
      "với",
      "là",
      "và",
      "hay",
      "hoặc",
      "như",
      "thế",
      "nào",
      "gì",
      "đó",
      "đây",
      "kia",
      "một",
      "hai",
      "ba",
      "có",
      "xin",
      "vui",
      "lòng",
      "hãy",
      "bạn",
      "ơi",
    ];
    const keywords =
      message
        .match(/[A-Za-zÀ-ỹ]{2,}/g)
        ?.filter((word) => !stopWords.includes(word.toLowerCase())) || [];
    analysis.keywords = [...new Set(keywords)];

    return analysis;
  }

  /**
   * Detect question type for better response formatting
   */
  detectQuestionType(message) {
    const lowerMessage = message.toLowerCase();

    if (/bao nhiêu|mấy|số lượng|tổng số|đếm/.test(lowerMessage)) {
      return "count";
    }
    if (/danh sách|liệt kê|những ai|có ai/.test(lowerMessage)) {
      return "list";
    }
    if (/là gì|nghĩa là|định nghĩa/.test(lowerMessage)) {
      return "definition";
    }
    if (/như thế nào|làm sao|cách nào/.test(lowerMessage)) {
      return "howto";
    }
    if (/tại sao|vì sao|lý do/.test(lowerMessage)) {
      return "why";
    }
    if (/ở đâu|địa chỉ|nơi nào/.test(lowerMessage)) {
      return "location";
    }
    if (/khi nào|lúc nào|ngày nào|năm nào/.test(lowerMessage)) {
      return "time";
    }
    if (/ai là|người nào|chị nào/.test(lowerMessage)) {
      return "who";
    }
    if (/so sánh|khác nhau|giống nhau/.test(lowerMessage)) {
      return "comparison";
    }

    return "general";
  }

  /**
   * Detect sub-intent for more specific handling
   */
  detectSubIntent(message, mainIntent) {
    const lowerMessage = message.toLowerCase();

    const subIntentMap = {
      journey_info: {
        current_stage: /đang ở|hiện tại|bây giờ/i,
        stage_list: /danh sách|các giai đoạn/i,
        stage_count: /bao nhiêu|mấy người|số lượng/i,
        specific_stage:
          /khấn tạm|khấn trọn|nhà tập|tập viện|tiền tập|tìm hiểu/i,
      },
      sister_info: {
        basic_info: /thông tin|hồ sơ|profile/i,
        contact: /liên hệ|điện thoại|email|số điện thoại/i,
        search: /tìm|tìm kiếm|search/i,
        list: /danh sách|liệt kê/i,
      },
      community_info: {
        list: /danh sách|tất cả|các cộng đoàn/i,
        members: /thành viên|ai ở|có ai/i,
        details: /thông tin|chi tiết|địa chỉ/i,
      },
      statistics: {
        overview: /tổng quan|chung|overview/i,
        by_stage: /theo giai đoạn|phân bổ/i,
        by_community: /theo cộng đoàn/i,
        trends: /xu hướng|biến động|thay đổi/i,
      },
    };

    const intentSubMap = subIntentMap[mainIntent];
    if (!intentSubMap) return null;

    for (const [subIntent, pattern] of Object.entries(intentSubMap)) {
      if (pattern.test(message)) {
        return subIntent;
      }
    }

    return null;
  }

  /**
   * Extract entities from message with improved accuracy
   */
  async extractEntities(message) {
    const entities = {};
    const lowerMessage = message.toLowerCase();
    const normalizedMessage = vietnameseNormalize.normalize(message);

    try {
      // Extract sister names from database with fuzzy matching
      const [sisters] = await db.execute(
        "SELECT id, birth_name, saint_name, code FROM sisters"
      );

      // Sort sisters by name length (longest first) for better matching
      const sortedSisters = sisters.sort((a, b) => {
        const aLen = Math.max(
          (a.birth_name || "").length,
          (a.saint_name || "").length
        );
        const bLen = Math.max(
          (b.birth_name || "").length,
          (b.saint_name || "").length
        );
        return bLen - aLen;
      });

      let bestSisterMatch = { id: null, score: 0, name: null };

      for (const sister of sortedSisters) {
        const birthName = (sister.birth_name || "").toLowerCase().trim();
        const saintName = (sister.saint_name || "").toLowerCase().trim();
        const code = (sister.code || "").toLowerCase().trim();

        // Direct match
        if (
          (birthName && lowerMessage.includes(birthName)) ||
          (saintName && lowerMessage.includes(saintName)) ||
          (code && lowerMessage.includes(code))
        ) {
          bestSisterMatch = {
            id: sister.id,
            score: 1,
            name: sister.birth_name,
            saint_name: sister.saint_name,
          };
          break;
        }

        // Fuzzy matching for typos
        if (birthName) {
          const similarity = vietnameseNormalize.similarity(
            lowerMessage,
            birthName
          );
          if (similarity > 0.7 && similarity > bestSisterMatch.score) {
            bestSisterMatch = {
              id: sister.id,
              score: similarity,
              name: sister.birth_name,
              saint_name: sister.saint_name,
            };
          }
        }

        // Check for partial name mentions (e.g., "chị Maria" or "sơ Tín")
        const sisterPatterns = [
          new RegExp(`(chị|sơ|nữ tu)\\s+${saintName}`, "i"),
          new RegExp(`(chị|sơ|nữ tu)\\s+${birthName.split(" ").pop()}`, "i"),
        ];

        for (const pattern of sisterPatterns) {
          if (pattern.test(message) && bestSisterMatch.score < 0.9) {
            bestSisterMatch = {
              id: sister.id,
              score: 0.9,
              name: sister.birth_name,
              saint_name: sister.saint_name,
            };
            break;
          }
        }
      }

      if (bestSisterMatch.id) {
        entities.sister_id = bestSisterMatch.id;
        entities.sister_name = bestSisterMatch.name;
        entities.saint_name = bestSisterMatch.saint_name;
        entities.match_confidence = bestSisterMatch.score;
      }

      // Extract community names with fuzzy matching
      const [communities] = await db.execute(
        "SELECT id, name, code FROM communities"
      );

      let bestCommunityMatch = { id: null, score: 0, name: null };

      for (const community of communities) {
        const name = (community.name || "").toLowerCase();
        const code = (community.code || "").toLowerCase();

        // Direct match
        if (
          (name && lowerMessage.includes(name)) ||
          (code && lowerMessage.includes(code))
        ) {
          bestCommunityMatch = {
            id: community.id,
            score: 1,
            name: community.name,
          };
          break;
        }

        // Check for partial community name
        const communityPattern = new RegExp(
          `cộng\\s*đoàn\\s+${name.replace(/cộng đoàn\\s*/i, "")}`,
          "i"
        );
        if (communityPattern.test(message) && bestCommunityMatch.score < 0.9) {
          bestCommunityMatch = {
            id: community.id,
            score: 0.9,
            name: community.name,
          };
        }

        // Fuzzy matching
        const similarity = vietnameseNormalize.similarity(lowerMessage, name);
        if (similarity > 0.7 && similarity > bestCommunityMatch.score) {
          bestCommunityMatch = {
            id: community.id,
            score: similarity,
            name: community.name,
          };
        }
      }

      if (bestCommunityMatch.id) {
        entities.community_id = bestCommunityMatch.id;
        entities.community_name = bestCommunityMatch.name;
      }

      // Extract dates (multiple formats)
      const datePatterns = [
        /(\d{1,2})[\/\-\.](\d{1,2})[\/\-\.](\d{4})/, // DD/MM/YYYY
        /(\d{4})[\/\-\.](\d{1,2})[\/\-\.](\d{1,2})/, // YYYY/MM/DD
        /ngày\s+(\d{1,2})\s+(tháng\s+)?(\d{1,2})(\s+năm\s+(\d{4}))?/i, // Vietnamese format
      ];

      for (const pattern of datePatterns) {
        const dateMatch = message.match(pattern);
        if (dateMatch) {
          entities.date = dateMatch[0];
          break;
        }
      }

      // Extract year
      const yearPatterns = [
        /năm\s+(\d{4})/i,
        /(\d{4})\s*(-|đến|tới)\s*(\d{4}|nay)/i,
        /từ\s+(\d{4})/i,
      ];

      for (const pattern of yearPatterns) {
        const yearMatch = message.match(pattern);
        if (yearMatch) {
          entities.year = parseInt(yearMatch[1]);
          if (yearMatch[3]) {
            entities.endYear =
              yearMatch[3] === "nay"
                ? new Date().getFullYear()
                : parseInt(yearMatch[3]);
          }
          break;
        }
      }

      // Extract stage keywords with Vietnamese variations
      const stagePatterns = {
        inquiry: /tìm hiểu|giai đoạn đầu|inquiry/i,
        pre_postulancy: /tiền\s*tập|pre.?postulancy/i,
        postulancy: /tập viện|postulancy/i,
        novitiate: /nhà tập|novitiate|tập sinh/i,
        temporary_vows: /khấn tạm|khấn lần đầu|temporary/i,
        perpetual_vows: /khấn trọn|khấn vĩnh viễn|perpetual|vĩnh khấn/i,
      };

      for (const [stage, pattern] of Object.entries(stagePatterns)) {
        if (pattern.test(message)) {
          entities.stage = stage;
          entities.stage_vietnamese = this.getStageVietnameseName(stage);
          break;
        }
      }

      // Extract numbers for quantity queries
      const numberMatch = message.match(
        /(\d+)\s*(người|nữ tu|chị|thành viên)/i
      );
      if (numberMatch) {
        entities.quantity = parseInt(numberMatch[1]);
      }

      // Extract age/age range
      const ageMatch = message.match(
        /(\d+)\s*tuổi|tuổi\s*(\d+)|từ\s*(\d+)\s*đến\s*(\d+)\s*tuổi/i
      );
      if (ageMatch) {
        entities.age = parseInt(ageMatch[1] || ageMatch[2] || ageMatch[3]);
        if (ageMatch[4]) {
          entities.maxAge = parseInt(ageMatch[4]);
        }
      }
    } catch (error) {
      console.error("Error extracting entities:", error);
    }

    return entities;
  }

  /**
   * Get Vietnamese name for journey stage
   */
  getStageVietnameseName(stageCode) {
    const stageNames = {
      inquiry: "Tìm hiểu",
      pre_postulancy: "Tiền tập viện",
      postulancy: "Tập viện",
      novitiate: "Nhà tập",
      temporary_vows: "Khấn tạm",
      perpetual_vows: "Khấn trọn",
    };
    return stageNames[stageCode] || stageCode;
  }

  /**
   * Retrieve context from database based on intent and entities
   */
  async retrieveContext(analysis, entities) {
    const cacheKey = `context_${analysis.intent}_${JSON.stringify(entities)}`;

    // Check cache first
    const cached = cache.get(cacheKey);
    if (cached) {
      return cached;
    }

    let context = {
      text: "",
      data: {},
      sources: [],
    };

    try {
      // If we have a specific sister_id, always get full sister info first
      if (entities.sister_id) {
        context = await this.getFullSisterContext(entities);
      } else {
        switch (analysis.intent) {
          case "journey_info":
            context = await this.getJourneyContext(entities);
            break;
          case "sister_info":
            context = await this.getSisterContext(entities);
            break;
          case "community_info":
            context = await this.getCommunityContext(entities);
            break;
          case "statistics":
            context = await this.getStatisticsContext(entities);
            break;
          case "education_info":
            context = await this.getEducationContext(entities);
            break;
          case "help":
            context = this.getHelpContext();
            break;
          default:
            context = await this.getGeneralContext();
        }
      }

      // Cache the result
      if (context.text) {
        cache.set(cacheKey, context);
      }
    } catch (error) {
      console.error("Error retrieving context:", error);
      context.text = "Không thể truy xuất dữ liệu từ hệ thống.";
    }

    return context;
  }

  /**
   * Get journey context
   */
  async getJourneyContext(entities) {
    let contextText = "";
    let data = {};
    const sources = [];

    if (entities.sister_id) {
      // Get specific sister journey
      const [sisters] = await db.execute(
        `SELECT s.*, c.name as community_name
         FROM sisters s
         LEFT JOIN communities c ON s.current_community_id = c.id
         WHERE s.id = ?`,
        [entities.sister_id]
      );

      if (sisters.length > 0) {
        const sister = sisters[0];

        // Get journey records
        const [journeys] = await db.execute(
          `SELECT vj.*, js.name as stage_name, js.color as stage_color
           FROM vocation_journey vj
           LEFT JOIN journey_stages js ON vj.stage = js.code
           WHERE vj.sister_id = ?
           ORDER BY vj.start_date ASC`,
          [entities.sister_id]
        );

        contextText = `📋 Hành trình ơn gọi của ${sister.saint_name || ""} ${
          sister.birth_name
        }:\n\n`;
        contextText += `👤 Thông tin cơ bản:\n`;
        contextText += `- Tên thánh: ${sister.saint_name || "N/A"}\n`;
        contextText += `- Họ tên: ${sister.birth_name}\n`;
        contextText += `- Mã số: ${sister.code}\n`;
        contextText += `- Cộng đoàn hiện tại: ${
          sister.community_name || "N/A"
        }\n\n`;

        if (journeys.length > 0) {
          contextText += `📍 Các giai đoạn đã trải qua:\n`;
          journeys.forEach((journey, index) => {
            const startDate = new Date(journey.start_date).toLocaleDateString(
              "vi-VN"
            );
            const endDate = journey.end_date
              ? new Date(journey.end_date).toLocaleDateString("vi-VN")
              : "Hiện tại";
            contextText += `${index + 1}. ${
              journey.stage_name || journey.stage
            }\n`;
            contextText += `   - Thời gian: ${startDate} → ${endDate}\n`;
            if (journey.location) {
              contextText += `   - Địa điểm: ${journey.location}\n`;
            }
            if (journey.notes) {
              contextText += `   - Ghi chú: ${journey.notes}\n`;
            }
          });
        } else {
          contextText += "Chưa có thông tin hành trình ơn gọi.\n";
        }

        data = { sister, journeys };
        sources.push({
          type: "sister",
          id: sister.id,
          name: sister.birth_name,
        });
      }
    } else {
      // General journey statistics
      const [stageStats] = await db.execute(
        `SELECT js.name as stage_name, js.code, COUNT(DISTINCT vj.sister_id) as count
         FROM journey_stages js
         LEFT JOIN vocation_journey vj ON js.code = vj.stage AND vj.end_date IS NULL
         WHERE js.is_active = true
         GROUP BY js.id, js.name, js.code
         ORDER BY js.display_order`
      );

      contextText = `📊 Thống kê hành trình ơn gọi hiện tại:\n\n`;
      stageStats.forEach((stage) => {
        contextText += `- ${stage.stage_name}: ${stage.count || 0} nữ tu\n`;
      });

      data = { stageStats };
    }

    return { text: contextText, data, sources };
  }

  /**
   * Get full sister context with all related information
   * This is the main function to get comprehensive sister information
   */
  async getFullSisterContext(entities) {
    let contextText = "";
    let data = {};
    const sources = [];

    try {
      // 1. Get basic sister info with community
      const [sisters] = await db.execute(
        `SELECT s.*, c.name as community_name, c.address as community_address
         FROM sisters s
         LEFT JOIN communities c ON s.current_community_id = c.id
         WHERE s.id = ?`,
        [entities.sister_id]
      );

      if (sisters.length === 0) {
        return {
          text: "Không tìm thấy thông tin nữ tu trong hệ thống.",
          data: {},
          sources: [],
        };
      }

      const sister = sisters[0];

      // Build comprehensive context
      contextText = `👤 **THÔNG TIN CHI TIẾT VỀ ${(
        sister.saint_name || ""
      ).toUpperCase()} ${sister.birth_name.toUpperCase()}**\n\n`;

      // Basic Information
      contextText += `📋 **Thông tin cơ bản:**\n`;
      contextText += `- Mã số: ${sister.code || "N/A"}\n`;
      contextText += `- Tên thánh: ${sister.saint_name || "N/A"}\n`;
      contextText += `- Họ tên: ${sister.birth_name}\n`;
      contextText += `- Ngày sinh: ${
        sister.date_of_birth
          ? new Date(sister.date_of_birth).toLocaleDateString("vi-VN")
          : "N/A"
      }\n`;
      contextText += `- Nơi sinh: ${
        sister.place_of_birth || sister.birth_place || "N/A"
      }\n`;
      contextText += `- Quốc tịch: ${sister.nationality || "Việt Nam"}\n`;
      contextText += `- Email: ${sister.email || "N/A"}\n`;
      contextText += `- Điện thoại: ${sister.phone || "N/A"}\n`;

      // Family Information
      if (sister.father_name || sister.mother_name) {
        contextText += `\n👨‍👩‍👧 **Thông tin gia đình:**\n`;
        contextText += `- Tên cha: ${sister.father_name || "N/A"}\n`;
        contextText += `- Tên mẹ: ${sister.mother_name || "N/A"}\n`;
      }

      // Current Community
      contextText += `\n🏠 **Cộng đoàn hiện tại:**\n`;
      contextText += `- Tên: ${sister.community_name || "Chưa phân bổ"}\n`;
      if (sister.community_address) {
        contextText += `- Địa chỉ: ${sister.community_address}\n`;
      }

      // 2. Get vocation journey
      try {
        const [journeys] = await db.execute(
          `SELECT vj.*, js.name as stage_name
           FROM vocation_journey vj
           LEFT JOIN journey_stages js ON vj.stage = js.code
           WHERE vj.sister_id = ?
           ORDER BY vj.start_date DESC`,
          [entities.sister_id]
        );

        if (journeys.length > 0) {
          contextText += `\n📍 **Hành trình ơn gọi:**\n`;
          journeys.forEach((journey, index) => {
            const startDate = journey.start_date
              ? new Date(journey.start_date).toLocaleDateString("vi-VN")
              : "N/A";
            const endDate = journey.end_date
              ? new Date(journey.end_date).toLocaleDateString("vi-VN")
              : "Hiện tại";
            const stageName =
              journey.stage_name ||
              this.getStageVietnameseName(journey.stage) ||
              journey.stage;
            contextText += `${
              index + 1
            }. ${stageName}: ${startDate} → ${endDate}\n`;
            if (journey.location) {
              contextText += `   📍 Địa điểm: ${journey.location}\n`;
            }
            if (journey.notes) {
              contextText += `   📝 Ghi chú: ${journey.notes}\n`;
            }
          });

          // Current stage
          const currentJourney = journeys.find((j) => !j.end_date);
          if (currentJourney) {
            contextText += `\n✅ **Giai đoạn hiện tại:** ${
              currentJourney.stage_name ||
              this.getStageVietnameseName(currentJourney.stage) ||
              currentJourney.stage
            }\n`;
          }
        }
      } catch (journeyError) {
        console.warn("Could not fetch journey data:", journeyError.message);
      }

      // 3. Get education records
      try {
        const [educations] = await db.execute(
          `SELECT * FROM education WHERE sister_id = ? ORDER BY end_date DESC, start_date DESC`,
          [entities.sister_id]
        );

        if (educations.length > 0) {
          contextText += `\n📚 **Học vấn:**\n`;
          educations.forEach((edu, index) => {
            contextText += `${index + 1}. ${
              edu.degree || edu.level || "Bằng cấp"
            }: ${edu.major || edu.field || "N/A"}\n`;
            contextText += `   🏫 Trường: ${edu.institution || "N/A"}\n`;
            if (edu.start_date || edu.end_date) {
              const startYear = edu.start_date
                ? new Date(edu.start_date).getFullYear()
                : "?";
              const endYear = edu.end_date
                ? new Date(edu.end_date).getFullYear()
                : "Đang học";
              contextText += `   📅 Thời gian: ${startYear} - ${endYear}\n`;
            }
          });
        }
      } catch (eduError) {
        console.warn("Could not fetch education data:", eduError.message);
      }

      // 4. Get mission/assignment records
      try {
        const [missions] = await db.execute(
          `SELECT m.*, c.name as community_name 
           FROM missions m
           LEFT JOIN communities c ON m.community_id = c.id
           WHERE m.sister_id = ? 
           ORDER BY m.start_date DESC
           LIMIT 5`,
          [entities.sister_id]
        );

        if (missions.length > 0) {
          contextText += `\n⛪ **Sứ vụ/Công tác:**\n`;
          missions.forEach((mission, index) => {
            contextText += `${index + 1}. ${
              mission.position || mission.role || "Sứ vụ"
            }\n`;
            if (mission.community_name) {
              contextText += `   🏠 Tại: ${mission.community_name}\n`;
            }
            if (mission.start_date) {
              const startDate = new Date(mission.start_date).toLocaleDateString(
                "vi-VN"
              );
              const endDate = mission.end_date
                ? new Date(mission.end_date).toLocaleDateString("vi-VN")
                : "Hiện tại";
              contextText += `   📅 Thời gian: ${startDate} - ${endDate}\n`;
            }
          });
        }
      } catch (missionError) {
        console.warn("Could not fetch mission data:", missionError.message);
      }

      // 5. Get health records summary (if available)
      try {
        const [[healthSummary]] = await db.execute(
          `SELECT COUNT(*) as record_count FROM health_records WHERE sister_id = ?`,
          [entities.sister_id]
        );

        if (healthSummary && healthSummary.record_count > 0) {
          contextText += `\n🏥 **Hồ sơ sức khỏe:** Có ${healthSummary.record_count} bản ghi\n`;
        }
      } catch (healthError) {
        // Health table might not exist, ignore
      }

      // 6. Get community assignment history
      try {
        const [assignments] = await db.execute(
          `SELECT ca.*, c.name as community_name
           FROM community_assignments ca
           LEFT JOIN communities c ON ca.community_id = c.id
           WHERE ca.sister_id = ?
           ORDER BY ca.start_date DESC
           LIMIT 5`,
          [entities.sister_id]
        );

        if (assignments.length > 0) {
          contextText += `\n🔄 **Lịch sử phân bổ cộng đoàn:**\n`;
          assignments.forEach((assign, index) => {
            const startDate = assign.start_date
              ? new Date(assign.start_date).toLocaleDateString("vi-VN")
              : "N/A";
            const endDate = assign.end_date
              ? new Date(assign.end_date).toLocaleDateString("vi-VN")
              : "Hiện tại";
            contextText += `${index + 1}. ${
              assign.community_name
            }: ${startDate} → ${endDate}\n`;
          });
        }
      } catch (assignError) {
        console.warn("Could not fetch assignment data:", assignError.message);
      }

      data = { sister };
      sources.push({
        type: "sister",
        id: sister.id,
        name: `${sister.saint_name || ""} ${sister.birth_name}`.trim(),
      });
    } catch (error) {
      console.error("Error in getFullSisterContext:", error);
      contextText = "Có lỗi khi truy xuất thông tin nữ tu.";
    }

    return { text: contextText, data, sources };
  }

  /**
   * Get sister context
   */
  async getSisterContext(entities) {
    let contextText = "";
    let data = {};
    const sources = [];

    if (entities.sister_id) {
      // Get specific sister info
      const [sisters] = await db.execute(
        `SELECT s.*, c.name as community_name
         FROM sisters s
         LEFT JOIN communities c ON s.current_community_id = c.id
         WHERE s.id = ?`,
        [entities.sister_id]
      );

      if (sisters.length > 0) {
        const sister = sisters[0];

        // Get education
        const [educations] = await db.execute(
          "SELECT * FROM education WHERE sister_id = ? ORDER BY start_date DESC",
          [sister.id]
        );

        contextText = `👤 Thông tin chi tiết về ${sister.saint_name || ""} ${
          sister.birth_name
        }:\n\n`;
        contextText += `📋 Thông tin cơ bản:\n`;
        contextText += `- Tên thánh: ${sister.saint_name || "N/A"}\n`;
        contextText += `- Họ tên: ${sister.birth_name}\n`;
        contextText += `- Mã số: ${sister.code}\n`;
        contextText += `- Ngày sinh: ${
          sister.date_of_birth
            ? new Date(sister.date_of_birth).toLocaleDateString("vi-VN")
            : "N/A"
        }\n`;
        contextText += `- Nơi sinh: ${sister.birth_place || "N/A"}\n`;
        contextText += `- Cộng đoàn: ${sister.community_name || "N/A"}\n`;
        contextText += `- Email: ${sister.email || "N/A"}\n`;
        contextText += `- Điện thoại: ${sister.phone || "N/A"}\n`;

        if (educations.length > 0) {
          contextText += `\n📚 Học vấn:\n`;
          educations.forEach((edu) => {
            contextText += `- ${edu.degree || edu.level}: ${
              edu.major || edu.field
            } tại ${edu.institution}\n`;
          });
        }

        data = { sister, educations };
        sources.push({
          type: "sister",
          id: sister.id,
          name: sister.birth_name,
        });
      }
    } else {
      // General sister statistics
      const [[totalResult]] = await db.execute(
        "SELECT COUNT(*) as total FROM sisters"
      );

      const [byCommunity] = await db.execute(
        `SELECT c.name, COUNT(s.id) as count
         FROM communities c
         LEFT JOIN sisters s ON c.id = s.current_community_id
         GROUP BY c.id, c.name
         ORDER BY count DESC`
      );

      contextText = `👥 Thông tin chung về các nữ tu:\n\n`;
      contextText += `Tổng số nữ tu đang hoạt động: ${totalResult.total}\n\n`;
      contextText += `Phân bổ theo cộng đoàn:\n`;
      byCommunity.forEach((item) => {
        contextText += `- ${item.name}: ${item.count} nữ tu\n`;
      });

      data = { total: totalResult.total, byCommunity };
    }

    return { text: contextText, data, sources };
  }

  /**
   * Get community context
   */
  async getCommunityContext(entities) {
    let contextText = "";
    let data = {};

    if (entities.community_id) {
      // Get specific community
      const [communities] = await db.execute(
        `SELECT c.*, 
                (SELECT COUNT(*) FROM sisters s WHERE s.current_community_id = c.id) as member_count
         FROM communities c
         WHERE c.id = ?`,
        [entities.community_id]
      );

      if (communities.length > 0) {
        const community = communities[0];

        // Get members
        const [members] = await db.execute(
          `SELECT id, birth_name, saint_name, code
           FROM sisters
           WHERE current_community_id = ?
           ORDER BY birth_name`,
          [community.id]
        );

        contextText = `🏠 Thông tin cộng đoàn ${community.name}:\n\n`;
        contextText += `- Mã: ${community.code}\n`;
        contextText += `- Địa chỉ: ${community.address || "N/A"}\n`;
        contextText += `- Điện thoại: ${community.phone || "N/A"}\n`;
        contextText += `- Email: ${community.email || "N/A"}\n`;
        contextText += `- Số thành viên: ${community.member_count}\n`;

        if (members.length > 0) {
          contextText += `\n👥 Danh sách thành viên:\n`;
          members.forEach((member, index) => {
            contextText += `${index + 1}. ${member.saint_name || ""} ${
              member.birth_name
            } (${member.code})\n`;
          });
        }

        data = { community, members };
      }
    } else {
      // Get all communities
      const [communities] = await db.execute(
        `SELECT c.*, 
                (SELECT COUNT(*) FROM sisters s WHERE s.current_community_id = c.id) as member_count
         FROM communities c
         ORDER BY c.name`
      );

      contextText = `🏠 Danh sách các cộng đoàn:\n\n`;
      contextText += `Tổng số: ${communities.length} cộng đoàn\n\n`;

      communities.forEach((community) => {
        contextText += `📍 ${community.name}\n`;
        contextText += `   - Mã: ${community.code}\n`;
        contextText += `   - Địa chỉ: ${community.address || "N/A"}\n`;
        contextText += `   - Số thành viên: ${community.member_count}\n\n`;
      });

      data = { communities };
    }

    return { text: contextText, data, sources: [] };
  }

  /**
   * Get statistics context
   */
  async getStatisticsContext(entities) {
    const [[totalSisters]] = await db.execute(
      "SELECT COUNT(*) as count FROM sisters"
    );

    const [[totalCommunities]] = await db.execute(
      "SELECT COUNT(*) as count FROM communities"
    );

    const [byStage] = await db.execute(
      `SELECT js.name as stage_name, COUNT(DISTINCT vj.sister_id) as count
       FROM journey_stages js
       LEFT JOIN vocation_journey vj ON js.code = vj.stage AND vj.end_date IS NULL
       GROUP BY js.id, js.name
       ORDER BY js.display_order`
    );

    const [recentJourneys] = await db.execute(
      `SELECT vj.*, s.birth_name, s.saint_name, js.name as stage_name
       FROM vocation_journey vj
       JOIN sisters s ON vj.sister_id = s.id
       LEFT JOIN journey_stages js ON vj.stage = js.code
       ORDER BY vj.created_at DESC
       LIMIT 5`
    );

    let contextText = `📊 Thống kê tổng quan hệ thống:\n\n`;
    contextText += `👥 Tổng số nữ tu: ${totalSisters.count}\n`;
    contextText += `🏠 Tổng số cộng đoàn: ${totalCommunities.count}\n\n`;

    contextText += `📍 Phân bổ theo giai đoạn ơn gọi:\n`;
    byStage.forEach((stage) => {
      contextText += `- ${stage.stage_name}: ${stage.count || 0} nữ tu\n`;
    });

    if (recentJourneys.length > 0) {
      contextText += `\n📝 Cập nhật hành trình gần đây:\n`;
      recentJourneys.forEach((journey) => {
        const date = new Date(journey.created_at).toLocaleDateString("vi-VN");
        contextText += `- ${date}: ${journey.saint_name || ""} ${
          journey.birth_name
        } → ${journey.stage_name || journey.stage}\n`;
      });
    }

    return {
      text: contextText,
      data: {
        totalSisters: totalSisters.count,
        totalCommunities: totalCommunities.count,
        byStage,
        recentJourneys,
      },
      sources: [],
    };
  }

  /**
   * Get education context
   */
  async getEducationContext(entities) {
    let contextText = "";
    let data = {};

    if (entities.sister_id) {
      const [educations] = await db.execute(
        `SELECT e.*, s.birth_name, s.saint_name
         FROM education e
         JOIN sisters s ON e.sister_id = s.id
         WHERE e.sister_id = ?
         ORDER BY e.start_date DESC`,
        [entities.sister_id]
      );

      if (educations.length > 0) {
        contextText = `📚 Học vấn của ${educations[0].saint_name || ""} ${
          educations[0].birth_name
        }:\n\n`;
        educations.forEach((edu, index) => {
          contextText += `${index + 1}. ${edu.degree || edu.level}\n`;
          contextText += `   - Chuyên ngành: ${
            edu.major || edu.field || "N/A"
          }\n`;
          contextText += `   - Trường: ${edu.institution}\n`;
          contextText += `   - Thời gian: ${
            edu.start_date
              ? new Date(edu.start_date).toLocaleDateString("vi-VN")
              : "N/A"
          } - ${
            edu.end_date
              ? new Date(edu.end_date).toLocaleDateString("vi-VN")
              : "N/A"
          }\n`;
        });
      } else {
        contextText = "Chưa có thông tin học vấn.";
      }

      data = { educations };
    } else {
      // General education statistics
      const [stats] = await db.execute(
        `SELECT degree, COUNT(*) as count
         FROM education
         GROUP BY degree
         ORDER BY count DESC`
      );

      contextText = `📚 Thống kê học vấn:\n\n`;
      stats.forEach((stat) => {
        contextText += `- ${stat.degree || "Khác"}: ${stat.count} người\n`;
      });

      data = { stats };
    }

    return { text: contextText, data, sources: [] };
  }

  /**
   * Get help context
   */
  getHelpContext() {
    const contextText = `🤖 Hướng dẫn sử dụng trợ lý AI:

Bạn có thể hỏi tôi về:

1. 👤 Thông tin nữ tu:
   - "Cho tôi thông tin về chị Maria"
   - "Hồ sơ của nữ tu có mã NT001"

2. 📍 Hành trình ơn gọi:
   - "Hành trình ơn gọi của chị Maria"
   - "Ai đang ở giai đoạn nhà tập?"
   - "Thống kê các giai đoạn ơn gọi"

3. 🏠 Cộng đoàn:
   - "Danh sách các cộng đoàn"
   - "Thông tin cộng đoàn Thiện Bản"
   - "Ai đang ở cộng đoàn nào?"

4. 📊 Thống kê:
   - "Tổng số nữ tu"
   - "Thống kê chung"
   - "Báo cáo tổng quan"

5. 📚 Học vấn:
   - "Học vấn của chị Maria"
   - "Thống kê trình độ học vấn"

💡 Mẹo: Bạn có thể đặt câu hỏi bằng ngôn ngữ tự nhiên!`;

    return {
      text: contextText,
      data: {},
      sources: [],
    };
  }

  /**
   * Get general context
   */
  async getGeneralContext() {
    const [[totalSisters]] = await db.execute(
      "SELECT COUNT(*) as count FROM sisters"
    );

    const [[totalCommunities]] = await db.execute(
      "SELECT COUNT(*) as count FROM communities"
    );

    const contextText = `📋 Thông tin hệ thống:
- Tổng số nữ tu: ${totalSisters.count}
- Tổng số cộng đoàn: ${totalCommunities.count}

Bạn có thể hỏi tôi về thông tin nữ tu, hành trình ơn gọi, cộng đoàn, thống kê, và nhiều nội dung khác.`;

    return {
      text: contextText,
      data: {
        totalSisters: totalSisters.count,
        totalCommunities: totalCommunities.count,
      },
      sources: [],
    };
  }

  /**
   * Search sister by name with fuzzy matching
   * Used when AI detects a person name but extractEntities didn't find them
   */
  async searchSisterByName(name) {
    try {
      const searchName = name.toLowerCase().trim();
      const normalizedName = vietnameseNormalize.removeDiacritics(searchName);

      // Try different search strategies
      const [sisters] = await db.execute(
        `SELECT id, birth_name, saint_name, code, date_of_birth 
         FROM sisters 
         WHERE LOWER(birth_name) LIKE ? 
            OR LOWER(saint_name) LIKE ?
            OR LOWER(birth_name) LIKE ?
            OR LOWER(saint_name) LIKE ?
         LIMIT 5`,
        [
          `%${searchName}%`,
          `%${searchName}%`,
          `%${normalizedName}%`,
          `%${normalizedName}%`,
        ]
      );

      if (sisters.length === 0) {
        // Try searching by last name only
        const nameParts = searchName.split(" ");
        const lastName = nameParts[nameParts.length - 1];

        const [byLastName] = await db.execute(
          `SELECT id, birth_name, saint_name, code, date_of_birth 
           FROM sisters 
           WHERE LOWER(birth_name) LIKE ?
           LIMIT 5`,
          [`%${lastName}`]
        );

        if (byLastName.length > 0) {
          // Find best match using similarity
          let bestMatch = null;
          let bestScore = 0;

          for (const sister of byLastName) {
            const similarity = vietnameseNormalize.similarity(
              searchName,
              sister.birth_name
            );
            if (similarity > bestScore && similarity > 0.5) {
              bestScore = similarity;
              bestMatch = sister;
            }
          }

          return bestMatch;
        }

        return null;
      }

      // Find best match from results
      let bestMatch = sisters[0];
      let bestScore = 0;

      for (const sister of sisters) {
        const birthNameSimilarity = vietnameseNormalize.similarity(
          searchName,
          sister.birth_name || ""
        );
        const saintNameSimilarity = vietnameseNormalize.similarity(
          searchName,
          sister.saint_name || ""
        );
        const score = Math.max(birthNameSimilarity, saintNameSimilarity);

        if (score > bestScore) {
          bestScore = score;
          bestMatch = sister;
        }
      }

      return bestMatch;
    } catch (error) {
      console.error("Error searching sister by name:", error);
      return null;
    }
  }

  /**
   * Get comprehensive context for any question
   * This is used as fallback when specific context is not enough
   */
  async getComprehensiveContext(message, entities) {
    let contextText = "";
    const sources = [];

    try {
      // 1. Always include basic statistics
      const [[totalSisters]] = await db.execute(
        "SELECT COUNT(*) as count FROM sisters"
      );
      const [[totalCommunities]] = await db.execute(
        "SELECT COUNT(*) as count FROM communities"
      );

      contextText = `📊 **Thông tin hệ thống:**\n`;
      contextText += `- Tổng số nữ tu: ${totalSisters.count}\n`;
      contextText += `- Tổng số cộng đoàn: ${totalCommunities.count}\n\n`;

      // 2. If asking about communities (mấy cộng đoàn, bao nhiêu cộng đoàn)
      if (/cộng\s*đoàn|community/i.test(message)) {
        const [communities] = await db.execute(
          `SELECT c.*, 
                  (SELECT COUNT(*) FROM sisters s WHERE s.current_community_id = c.id) as member_count
           FROM communities c
           ORDER BY c.name`
        );

        contextText += `🏠 **Danh sách ${communities.length} cộng đoàn:**\n\n`;
        communities.forEach((c, index) => {
          contextText += `${index + 1}. **${c.name}** (Mã: ${c.code})\n`;
          contextText += `   - Địa chỉ: ${c.address || "N/A"}\n`;
          contextText += `   - Số thành viên: ${c.member_count} nữ tu\n\n`;
        });

        sources.push({ type: "communities", count: communities.length });
      }

      // 3. If asking about sisters/nữ tu count or list
      if (
        /nữ\s*tu|chị|sơ|người/i.test(message) &&
        /bao nhiêu|mấy|số lượng|danh sách/i.test(message)
      ) {
        // Get distribution by community
        const [byCommunity] = await db.execute(
          `SELECT c.name, COUNT(s.id) as count
           FROM communities c
           LEFT JOIN sisters s ON c.id = s.current_community_id
           GROUP BY c.id, c.name
           HAVING count > 0
           ORDER BY count DESC`
        );

        contextText += `👥 **Phân bổ nữ tu theo cộng đoàn:**\n`;
        byCommunity.forEach((item) => {
          contextText += `- ${item.name}: ${item.count} nữ tu\n`;
        });
        contextText += "\n";
      }

      // 4. If asking about stages/giai đoạn
      if (/giai\s*đoạn|khấn|ơn gọi|stage/i.test(message)) {
        const [byStage] = await db.execute(
          `SELECT js.name as stage_name, COUNT(DISTINCT vj.sister_id) as count
           FROM journey_stages js
           LEFT JOIN vocation_journey vj ON js.code = vj.stage AND vj.end_date IS NULL
           WHERE js.is_active = true
           GROUP BY js.id, js.name
           ORDER BY js.display_order`
        );

        contextText += `📍 **Phân bổ theo giai đoạn ơn gọi:**\n`;
        byStage.forEach((stage) => {
          contextText += `- ${stage.stage_name}: ${stage.count || 0} nữ tu\n`;
        });
        contextText += "\n";
      }

      // 5. If there's a specific sister mentioned
      if (entities.sister_id) {
        const sisterContext = await this.getFullSisterContext(entities);
        contextText += sisterContext.text;
        sources.push(...(sisterContext.sources || []));
      }

      // 6. If asking about age and have a sister name
      if (/tuổi|age|năm sinh|sinh năm/i.test(message) && entities.sister_id) {
        const [sisters] = await db.execute(
          `SELECT birth_name, saint_name, date_of_birth FROM sisters WHERE id = ?`,
          [entities.sister_id]
        );

        if (sisters.length > 0 && sisters[0].date_of_birth) {
          const birthDate = new Date(sisters[0].date_of_birth);
          const today = new Date();
          let age = today.getFullYear() - birthDate.getFullYear();
          const monthDiff = today.getMonth() - birthDate.getMonth();
          if (
            monthDiff < 0 ||
            (monthDiff === 0 && today.getDate() < birthDate.getDate())
          ) {
            age--;
          }

          contextText += `\n🎂 **Thông tin tuổi:**\n`;
          contextText += `- ${sisters[0].saint_name || ""} ${
            sisters[0].birth_name
          } sinh ngày ${birthDate.toLocaleDateString("vi-VN")}\n`;
          contextText += `- Hiện tại ${age} tuổi\n`;
        }
      }
    } catch (error) {
      console.error("Error getting comprehensive context:", error);
      contextText += "\n⚠️ Có một số thông tin không thể truy xuất.\n";
    }

    return { text: contextText, data: {}, sources };
  }

  /**
   * Clear cache
   */
  clearCache() {
    cache.flushAll();
  }
}

module.exports = new ChatbotService();
