// src/services/api.js

import axios from "axios";
import { toast } from "react-toastify";

// Backend URLs - Fallback values if VITE_API_URL is not set
const LOCALHOST_API = "http://localhost:5000/api";
const PRODUCTION_API = "https://saintpaulthienban-backend.onrender.com/api"; // Update this with your Render backend URL

// Priority 1: Use VITE_API_URL from environment variable (RECOMMENDED)
let baseURL = import.meta.env.VITE_API_URL;

// Priority 2: Fallback to localhost (dev) or production URL
if (!baseURL) {
  baseURL = import.meta.env.DEV ? LOCALHOST_API : PRODUCTION_API;
  console.warn(
    `⚠️ VITE_API_URL not set. Using fallback: ${baseURL}. Please set VITE_API_URL in .env file.`,
  );
}

// Create axios instance
const api = axios.create({
  baseURL,
  timeout: 30000,
  headers: {
    "Content-Type": "application/json",
  },
});

// Request interceptor
api.interceptors.request.use(
  (config) => {
    // Get token from localStorage
    const token = localStorage.getItem("token");

    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }

    return config;
  },
  (error) => {
    return Promise.reject(error);
  },
);

// Response interceptor
api.interceptors.response.use(
  (response) => {
    return response.data;
  },
  (error) => {
    // Handle errors
    if (error.response) {
      const { status, data } = error.response;
      const requestUrl = error.config?.url || "";
      const isAuthLoginRequest = requestUrl.includes("/auth/login");

      switch (status) {
        case 400:
          // Skip toast for login validation errors - let UI handle it
          if (!isAuthLoginRequest) {
            toast.error(data.message || "Dữ liệu không hợp lệ");
          }
          break;

        case 401:
          // Skip global handling for direct login attempts so UI can show inline errors
          if (isAuthLoginRequest) {
            break;
          }

          // Unauthorized - only redirect if not on login page
          if (!window.location.pathname.includes("/login")) {
            localStorage.removeItem("token");
            localStorage.removeItem("user");
            window.location.href = "/login";
            toast.error("Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.");
          }
          break;

        case 403:
          // Check if account is locked
          if (data.code === "ACCOUNT_LOCKED") {
            localStorage.removeItem("token");
            localStorage.removeItem("user");
            toast.error(data.message || "Tài khoản của bạn đã bị khóa.");
            if (!window.location.pathname.includes("/login")) {
              window.location.href = "/login";
            }
          } else {
            toast.error("Bạn không có quyền thực hiện thao tác này.");
          }
          break;

        case 404:
          toast.error("Không tìm thấy dữ liệu.");
          break;

        case 409:
          toast.error(data.message || "Dữ liệu đã tồn tại.");
          break;

        case 422:
          // Validation errors
          if (data.errors) {
            Object.values(data.errors).forEach((err) => {
              toast.error(err);
            });
          } else {
            toast.error(data.message || "Dữ liệu không hợp lệ.");
          }
          break;

        case 500:
          toast.error("Lỗi server. Vui lòng thử lại sau.");
          break;

        default:
          toast.error(data.message || "Có lỗi xảy ra. Vui lòng thử lại.");
      }
    } else if (error.request) {
      // Network error - try fallback to localhost if currently using Railway
      if (api.defaults.baseURL === RAILWAY_API) {
        console.warn(
          "⚠️ Railway backend unreachable, switching to localhost...",
        );
        api.defaults.baseURL = LOCALHOST_API;
        toast.info("Chuyển sang server local...");

        // Retry the request with localhost
        return api.request(error.config);
      } else {
        toast.error(
          "Không thể kết nối đến server. Vui lòng kiểm tra kết nối mạng.",
        );
      }
    } else {
      toast.error("Có lỗi xảy ra. Vui lòng thử lại.");
    }

    return Promise.reject(error);
  },
);

export default api;
