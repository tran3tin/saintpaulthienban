// controllers/chatbotController.js

const { v4: uuidv4 } = require("uuid");
const ChatConversationModel = require("../models/ChatConversationModel");
const chatbotService = require("../services/chatbotService");
const openaiService = require("../services/openaiService");

// Debug mode - set to false in production
const DEBUG = process.env.NODE_ENV !== "production";
const log = (...args) => DEBUG && console.log(...args);

// ============== Helper Functions ==============

/**
 * Post-process AI response for better formatting
 */
function postProcessResponse(response, analysis) {
  let processed = response;

  // Clean up excessive whitespace
  processed = processed.replace(/\n{3,}/g, "\n\n");

  // Ensure proper Vietnamese formatting
  processed = processed.replace(/(\d+)\/(\d+)\/(\d+)/g, (match, d, m, y) => {
    if (y.length === 4) return match;
    return `${d}/${m}/${y}`;
  });

  // Add helpful follow-up suggestions for certain intents
  if (
    analysis.intent === "statistics" &&
    !processed.includes("Bạn có thể hỏi")
  ) {
    processed +=
      "\n\n💡 *Bạn có thể hỏi thêm về chi tiết của từng cộng đoàn hoặc giai đoạn cụ thể.*";
  }

  return processed.trim();
}

// ============== Controller Class ==============

class ChatbotController {
  /**
   * Handle chat message with AI-first analysis
   * Flow: User Question → ChatGPT Analysis → Database Query → ChatGPT Response
   */
  async chat(req, res) {
    try {
      log("=== CHATBOT REQUEST (AI-First Flow) ===");
      const { message, conversation_id } = req.body;
      log("Message:", message);

      if (!message) {
        return res.status(400).json({
          success: false,
          error: "Message is required",
        });
      }

      // Normalize and clean message
      const cleanedMessage = message.trim();

      // ========== STEP 1: AI Analysis (Primary) ==========
      log("Step 1: AI-powered message analysis...");
      let analysis = await openaiService.analyzeWithAI(cleanedMessage);

      // Fallback to keyword-based analysis if AI fails
      if (!analysis) {
        log("AI analysis failed, falling back to keyword matching...");
        analysis = chatbotService.analyzeMessage(cleanedMessage);
        analysis.source = "keyword";
      }
      log("Analysis result:", JSON.stringify(analysis, null, 2));

      // ========== STEP 2: Extract/Enhance Entities ==========
      log("Step 2: Extracting database entities...");
      const dbEntities = await chatbotService.extractEntities(cleanedMessage);

      // Merge AI entities with DB entities (DB entities have priority for IDs)
      const entities = {
        ...analysis.entities,
        ...dbEntities,
        // Keep AI-detected info that DB might miss
        age_question:
          analysis.entities?.age_question ||
          /tuổi|bao nhiêu tuổi/i.test(cleanedMessage),
        count_question:
          analysis.entities?.count_question ||
          /bao nhiêu|mấy|số lượng/i.test(cleanedMessage),
        list_question:
          analysis.entities?.list_question ||
          /danh sách|liệt kê/i.test(cleanedMessage),
      };

      // If AI found a person name but DB didn't find sister_id, try additional search
      if (analysis.entities?.person_name && !entities.sister_id) {
        log(
          "Trying to find sister by AI-detected name:",
          analysis.entities.person_name,
        );
        const additionalSearch = await chatbotService.searchSisterByName(
          analysis.entities.person_name,
        );
        if (additionalSearch) {
          entities.sister_id = additionalSearch.id;
          entities.sister_name = additionalSearch.birth_name;
          entities.saint_name = additionalSearch.saint_name;
        }
      }

      log("Combined entities:", JSON.stringify(entities, null, 2));

      // ========== STEP 3: Smart Intent Refinement ==========
      // Refine intent based on both AI analysis and extracted entities
      if (entities.sister_id && analysis.intent === "general") {
        analysis.intent = "sister_info";
        log("Intent refined to sister_info (found sister in DB)");
      }
      if (entities.community_id && analysis.intent === "general") {
        analysis.intent = "community_info";
        log("Intent refined to community_info (found community in DB)");
      }
      if (entities.count_question && analysis.intent === "general") {
        analysis.intent = "statistics";
        log("Intent refined to statistics (count question)");
      }

      // ========== STEP 4: Database Context Retrieval ==========
      log("Step 3: Retrieving database context...");
      let context = await chatbotService.retrieveContext(analysis, entities);

      // If no context found but we have entities, try broader search
      if (
        (!context.text || context.text.length < 50) &&
        analysis.intent !== "greeting" &&
        analysis.intent !== "help"
      ) {
        log("Limited context, trying comprehensive search...");
        context = await chatbotService.getComprehensiveContext(
          cleanedMessage,
          entities,
        );
      }

      log("Context retrieved, length:", context.text?.length || 0);

      // ========== STEP 5: Conversation History ==========
      log("Step 4: Getting conversation history...");
      let conversationHistory = [];
      if (conversation_id) {
        try {
          const history = await ChatConversationModel.getByConversationId(
            conversation_id,
            5,
          );
          conversationHistory = history.flatMap((h) => [
            { role: "user", content: h.user_message },
            { role: "assistant", content: h.ai_response },
          ]);
        } catch (historyError) {
          console.warn("Could not load history:", historyError.message);
        }
      }

      // ========== STEP 6: Generate AI Response ==========
      log("Step 5: Generating AI response with context...");
      const aiResponse = await openaiService.chat(
        cleanedMessage,
        context,
        conversationHistory,
      );
      log("AI Response success:", aiResponse.success);

      if (!aiResponse.success) {
        log("AI Error:", aiResponse.error);
        // If AI fails but we have context, return context directly
        if (context.text && context.text.length > 50) {
          return res.json({
            success: true,
            response: `📊 **Thông tin từ hệ thống:**\n\n${context.text}`,
            conversation_id: conversation_id || uuidv4(),
            sources: context.sources || [],
          });
        }
        return res.status(500).json({
          success: false,
          error: aiResponse.error || "Failed to get AI response",
        });
      }

      // ========== STEP 7: Post-process & Return ==========
      const processedResponse = postProcessResponse(
        aiResponse.message,
        analysis,
      );

      // Save conversation
      const newConversationId = conversation_id || uuidv4();
      try {
        await ChatConversationModel.create({
          conversation_id: newConversationId,
          user_id: req.user?.id,
          user_message: cleanedMessage,
          ai_response: processedResponse,
          context_used: context,
          entities_extracted: entities,
          intent: analysis.intent,
          sub_intent: analysis.subIntent,
          confidence: analysis.confidence,
          tokens_used: aiResponse.tokens,
          cost: aiResponse.cost,
        });
      } catch (saveError) {
        console.warn("Could not save conversation:", saveError.message);
      }

      return res.json({
        success: true,
        response: processedResponse,
        conversation_id: newConversationId,
        sources: context.sources || [],
        metadata: {
          intent: analysis.intent,
          confidence: analysis.confidence,
          analysisSource: analysis.source,
        },
      });
    } catch (error) {
      console.error("Chat error:", error);
      return res.status(500).json({
        success: false,
        error: "Xin lỗi, có lỗi xảy ra. Vui lòng thử lại.",
      });
    }
  }

  /**
   * Get conversation history
   */
  async getHistory(req, res) {
    try {
      const { conversationId } = req.params;

      const history =
        await ChatConversationModel.getByConversationId(conversationId);

      const messages = [];
      history.forEach((record) => {
        messages.push({
          role: "user",
          content: record.user_message,
          timestamp: record.created_at,
        });
        messages.push({
          role: "assistant",
          content: record.ai_response,
          timestamp: record.created_at,
          sources: record.context_used?.sources || [],
        });
      });

      return res.json({
        success: true,
        data: messages,
      });
    } catch (error) {
      console.error("Get history error:", error);
      return res.status(500).json({
        success: false,
        error: "Internal server error",
      });
    }
  }

  /**
   * Clear conversation
   */
  async clearConversation(req, res) {
    try {
      const { conversationId } = req.params;

      await ChatConversationModel.deleteByConversationId(conversationId);

      return res.json({
        success: true,
        message: "Conversation cleared successfully",
      });
    } catch (error) {
      console.error("Clear conversation error:", error);
      return res.status(500).json({
        success: false,
        error: "Internal server error",
      });
    }
  }

  /**
   * Submit feedback
   */
  async submitFeedback(req, res) {
    try {
      const { message_id, is_helpful, feedback } = req.body;

      await ChatConversationModel.updateFeedback(
        message_id,
        is_helpful,
        feedback,
      );

      return res.json({
        success: true,
        message: "Feedback submitted successfully",
      });
    } catch (error) {
      console.error("Submit feedback error:", error);
      return res.status(500).json({
        success: false,
        error: "Internal server error",
      });
    }
  }
}

module.exports = new ChatbotController();
