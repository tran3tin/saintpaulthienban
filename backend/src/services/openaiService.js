// services/openaiService.js

const OpenAI = require("openai");

class OpenAIService {
  constructor() {
    this.client = null;
    this.model = process.env.OPENAI_MODEL || "gpt-3.5-turbo";
    this.maxTokens = parseInt(process.env.OPENAI_MAX_TOKENS) || 1000;
    this.pricing = {
      "gpt-3.5-turbo": { input: 0.0005, output: 0.0015 },
      "gpt-4": { input: 0.03, output: 0.06 },
      "gpt-4-turbo": { input: 0.01, output: 0.03 },
      "gpt-4o": { input: 0.005, output: 0.015 },
      "gpt-4o-mini": { input: 0.00015, output: 0.0006 },
    };
  }

  /**
   * Initialize OpenAI client
   */
  initialize() {
    if (!this.client && process.env.OPENAI_API_KEY) {
      this.client = new OpenAI({
        apiKey: process.env.OPENAI_API_KEY,
      });
    }
    return this.client;
  }

  /**
   * Check if service is configured
   */
  isConfigured() {
    return !!process.env.OPENAI_API_KEY;
  }

  /**
   * Get system prompt - Enhanced for better understanding and responses
   */
  getSystemPrompt() {
    return `Bạn là trợ lý AI thông minh của hệ thống quản lý Hội Dòng Thánh Phaolô Thiện Bản.

## VAI TRÒ VÀ NHIỆM VỤ
1. Trả lời các câu hỏi về nữ tu, hành trình ơn gọi, cộng đoàn một cách CHÍNH XÁC dựa trên dữ liệu được cung cấp
2. Giải thích thông tin rõ ràng, dễ hiểu, có cấu trúc
3. Sử dụng ngôn ngữ tôn trọng, lịch sự, phù hợp với môi trường tôn giáo
4. Nếu không có đủ thông tin, hãy thành thật nói rằng bạn không có dữ liệu và đề xuất cách khác
5. Trả lời bằng tiếng Việt tự nhiên

## CÁC GIAI ĐOẠN ƠN GỌI (theo thứ tự)
1. **Tìm hiểu (Inquiry)**: Giai đoạn đầu tiên khi tìm hiểu về đời tu
2. **Tiền tập viện (Pre-postulancy)**: Chuẩn bị trước khi vào tập viện  
3. **Tập viện (Postulancy)**: Giai đoạn tập viện, học hỏi căn bản
4. **Nhà tập (Novitiate)**: Giai đoạn nhà tập, học hỏi sâu hơn về đời tu
5. **Khấn tạm (Temporary Vows)**: Đã khấn lần đầu, cam kết tạm thời (thường 3-6 năm)
6. **Khấn trọn (Perpetual Vows)**: Khấn vĩnh viễn, cam kết trọn đời

## CÁCH TRẢ LỜI
- **Câu hỏi về số lượng**: Trả lời số liệu cụ thể trước, sau đó giải thích thêm nếu cần
- **Câu hỏi về thông tin cá nhân**: Trình bày có cấu trúc với các mục rõ ràng
- **Câu hỏi về danh sách**: Sử dụng bullet points hoặc đánh số
- **Câu hỏi so sánh**: Sử dụng bảng hoặc so sánh song song
- **Câu hỏi không rõ ràng**: Hỏi lại để làm rõ thay vì đoán

## QUY TẮC QUAN TRỌNG
1. KHÔNG bịa đặt thông tin - chỉ dựa trên dữ liệu được cung cấp
2. Nếu dữ liệu là "N/A" hoặc trống, nói rõ "Chưa có thông tin" thay vì bỏ qua
3. Sử dụng emoji phù hợp để làm câu trả lời sinh động (👤 📍 📊 🏠 📚 ✅ ❌)
4. Khi đề cập đến người, dùng "Chị" hoặc tên thánh đi kèm tên
5. Format ngày tháng theo kiểu Việt Nam (DD/MM/YYYY)
6. Với số liệu, làm tròn và thêm đơn vị rõ ràng

## XỬ LÝ CÂU HỎI PHỨC TẠP
- Nếu câu hỏi có nhiều phần, trả lời từng phần một cách rõ ràng
- Nếu câu hỏi mơ hồ, xác nhận lại ý người dùng
- Nếu không tìm thấy chính xác, gợi ý kết quả tương tự`;
  }

  /**
   * Chat with OpenAI
   */
  async chat(userMessage, context = null, conversationHistory = []) {
    try {
      // Initialize client if not already
      if (!this.initialize()) {
        return {
          success: false,
          message:
            "Dịch vụ AI chưa được cấu hình. Vui lòng liên hệ quản trị viên.",
          error: "OpenAI API key not configured",
        };
      }

      // Build messages array
      const messages = [
        {
          role: "system",
          content: this.getSystemPrompt(),
        },
      ];

      // Add conversation history (last 10 messages for context)
      if (conversationHistory.length > 0) {
        const recentHistory = conversationHistory.slice(-10);
        recentHistory.forEach((msg) => {
          messages.push({
            role: msg.role === "user" ? "user" : "assistant",
            content: msg.content,
          });
        });
      }

      // Add context from database with clear formatting
      if (context && context.text) {
        messages.push({
          role: "system",
          content: `## DỮ LIỆU TỪ HỆ THỐNG\nĐây là dữ liệu thực tế từ cơ sở dữ liệu. Hãy dựa vào dữ liệu này để trả lời:\n\n${context.text}`,
        });
      }

      // Add user message
      messages.push({
        role: "user",
        content: userMessage,
      });

      // Call OpenAI API with optimized settings
      const completion = await this.client.chat.completions.create({
        model: this.model,
        messages: messages,
        max_tokens: this.maxTokens,
        temperature: 0.7,
        top_p: 0.95,
        frequency_penalty: 0.1,
        presence_penalty: 0.1,
      });

      const response = completion.choices[0].message.content;
      const usage = completion.usage;

      // Calculate cost
      const cost = this.calculateCost(usage);

      return {
        success: true,
        message: response,
        tokens: usage.total_tokens,
        promptTokens: usage.prompt_tokens,
        completionTokens: usage.completion_tokens,
        cost: cost,
        model: this.model,
        context: context,
      };
    } catch (error) {
      console.error("OpenAI API Error:", error.message);

      // Handle quota exceeded - return context-based response
      if (error.status === 429 || error.code === "insufficient_quota") {
        // Fallback: return context data directly
        if (context && context.text) {
          return {
            success: true,
            message: `⚠️ *Chế độ offline - Dữ liệu từ hệ thống:*\n\n${context.text}\n\n_Lưu ý: AI đang tạm ngưng, đây là dữ liệu trực tiếp từ database._`,
            tokens: 0,
            cost: 0,
            model: "offline-fallback",
          };
        }
        return {
          success: false,
          message:
            "⚠️ Hệ thống AI đã hết quota. Vui lòng liên hệ quản trị viên để nạp thêm credit OpenAI.",
          error: error.message,
        };
      }

      if (error.code === "rate_limit_exceeded") {
        return {
          success: false,
          message: "Hệ thống đang bận, vui lòng thử lại sau vài giây.",
          error: error.message,
        };
      }

      return {
        success: false,
        message:
          "Xin lỗi, tôi không thể xử lý yêu cầu của bạn lúc này. Vui lòng thử lại sau.",
        error: error.message,
      };
    }
  }

  /**
   * Calculate cost based on token usage
   */
  calculateCost(usage) {
    const pricing = this.pricing[this.model];

    if (!pricing) {
      return 0;
    }

    const inputCost = (usage.prompt_tokens / 1000) * pricing.input;
    const outputCost = (usage.completion_tokens / 1000) * pricing.output;

    return parseFloat((inputCost + outputCost).toFixed(6));
  }

  /**
   * Get model info
   */
  getModelInfo() {
    return {
      model: this.model,
      maxTokens: this.maxTokens,
      pricing: this.pricing[this.model] || null,
      isConfigured: this.isConfigured(),
    };
  }

  /**
   * Analyze user message using AI to extract intent and entities
   * This is the FIRST step - let AI understand the question before database queries
   */
  async analyzeWithAI(userMessage) {
    try {
      if (!this.initialize()) {
        console.log("OpenAI not configured, falling back to keyword analysis");
        return null;
      }

      const analysisPrompt = `Phân tích câu hỏi của người dùng và trả về JSON với các trường sau:

INTENT (chọn 1):
- "sister_info": Hỏi về thông tin nữ tu
- "community_info": Hỏi về cộng đoàn
- "statistics": Hỏi về số lượng, thống kê
- "journey_info": Hỏi về hành trình ơn gọi
- "education_info": Hỏi về học vấn
- "health_info": Hỏi về sức khỏe
- "mission_info": Hỏi về sứ vụ
- "help": Hướng dẫn
- "greeting": Chào hỏi
- "general": Chung chung

ENTITIES (trích xuất):
- person_name: Tên người (VD: "Lan", "Maria Tín")
- community_name: Tên cộng đoàn
- stage: Giai đoạn ơn gọi
- age_question: true/false
- count_question: true/false
- list_question: true/false

SEARCH_KEYS (mảng các từ khóa quan trọng để tìm trong DB):
- Trích xuất danh từ riêng, tên, địa danh, mã số... để query database.
- VD: "chị Lan ở đâu?" -> ["Lan"]
- VD: "cộng đoàn Thủ Đức có ai?" -> ["Thủ Đức"]

Câu hỏi: "${userMessage}"

Trả về JSON:
{"intent":"...", "entities":{...}, "search_keys":["..."], "keywords":["..."]}`;

      const completion = await this.client.chat.completions.create({
        model: this.model,
        messages: [
          {
            role: "system",
            content:
              "Bạn là AI phân tích câu hỏi. Chỉ trả về JSON, không giải thích.",
          },
          {
            role: "user",
            content: analysisPrompt,
          },
        ],
        max_tokens: 300,
        temperature: 0.1, // Low temperature for consistent parsing
      });

      const responseText = completion.choices[0].message.content.trim();
      console.log("AI Analysis raw response:", responseText);

      // Parse JSON from response (handle potential markdown wrapper)
      let jsonStr = responseText;
      if (responseText.includes("```json")) {
        jsonStr =
          responseText.match(/```json\s*([\s\S]*?)\s*```/)?.[1] || responseText;
      } else if (responseText.includes("```")) {
        jsonStr =
          responseText.match(/```\s*([\s\S]*?)\s*```/)?.[1] || responseText;
      }

      const analysis = JSON.parse(jsonStr);
      console.log("AI Analysis parsed:", analysis);

      return {
        success: true,
        intent: analysis.intent || "general",
        entities: analysis.entities || {},
        search_keys: analysis.search_keys || [],
        keywords: analysis.keywords || [],
        confidence: 0.9,
        source: "ai",
      };
    } catch (error) {
      console.error("AI Analysis error:", error.message);
      return null; // Return null to fall back to keyword analysis
    }
  }
}

module.exports = new OpenAIService();
