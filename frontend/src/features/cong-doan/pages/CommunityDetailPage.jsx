// src/features/cong-doan/pages/CommunityDetailPage.jsx

import React, { useState, useEffect } from "react";
import {
  Container,
  Row,
  Col,
  Card,
  Button,
  Badge,
  Tab,
  Nav,
  Table,
  Modal,
  Form,
} from "react-bootstrap";
import { useParams, useNavigate } from "react-router-dom";
import ReactQuill from "react-quill";
import "react-quill/dist/quill.snow.css";
import {
  Document,
  Page,
  Text,
  View,
  StyleSheet,
  Font,
  pdf,
} from "@react-pdf/renderer";
import { communityService } from "@services";
import { formatDate } from "@utils";
import DatePicker from "@components/forms/DatePicker";
import LoadingSpinner from "@components/common/Loading/LoadingSpinner";
import Breadcrumb from "@components/common/Breadcrumb";
import "./CommunityDetailPage.css";

// Đăng ký Font Roboto hỗ trợ tiếng Việt
Font.register({
  family: "Roboto",
  fonts: [
    {
      src: "https://cdnjs.cloudflare.com/ajax/libs/ink/3.1.10/fonts/Roboto/roboto-regular-webfont.ttf",
      fontWeight: "normal",
    },
    {
      src: "https://cdnjs.cloudflare.com/ajax/libs/ink/3.1.10/fonts/Roboto/roboto-bold-webfont.ttf",
      fontWeight: "bold",
    },
  ],
});

// Styles cho PDF
const pdfStyles = StyleSheet.create({
  page: {
    flexDirection: "column",
    padding: 30,
    fontFamily: "Roboto",
    fontSize: 10,
  },
  header: {
    backgroundColor: "#34495e",
    padding: 15,
    marginBottom: 15,
    marginHorizontal: -30,
    marginTop: -30,
  },
  headerTitle: {
    color: "#ffffff",
    fontSize: 18,
    fontWeight: "bold",
    textAlign: "center",
    marginBottom: 5,
  },
  headerSubtitle: {
    color: "#ffffff",
    fontSize: 12,
    textAlign: "center",
    marginBottom: 3,
  },
  headerDate: {
    color: "#ffffff",
    fontSize: 9,
    textAlign: "center",
  },
  basicInfoBox: {
    backgroundColor: "#ecf0f1",
    padding: 10,
    marginBottom: 15,
  },
  basicInfoName: {
    fontSize: 14,
    fontWeight: "bold",
    marginBottom: 3,
  },
  basicInfoText: {
    fontSize: 10,
    marginBottom: 2,
  },
  sectionTitle: {
    backgroundColor: "#2980b9",
    color: "#ffffff",
    padding: 6,
    fontSize: 11,
    fontWeight: "bold",
    marginBottom: 8,
    marginTop: 10,
  },
  row: {
    flexDirection: "row",
    marginBottom: 4,
  },
  label: {
    fontWeight: "bold",
    width: "35%",
    fontSize: 9,
  },
  value: {
    width: "65%",
    fontSize: 9,
  },
  twoColumnRow: {
    flexDirection: "row",
    marginBottom: 4,
  },
  column: {
    width: "50%",
    flexDirection: "row",
  },
  columnLabel: {
    fontWeight: "bold",
    width: "40%",
    fontSize: 9,
  },
  columnValue: {
    width: "60%",
    fontSize: 9,
  },
  table: {
    marginTop: 5,
  },
  tableHeader: {
    flexDirection: "row",
    backgroundColor: "#2980b9",
    padding: 5,
  },
  tableHeaderCell: {
    color: "#ffffff",
    fontSize: 8,
    fontWeight: "bold",
    textAlign: "center",
  },
  tableRow: {
    flexDirection: "row",
    borderBottomWidth: 1,
    borderBottomColor: "#ecf0f1",
    padding: 4,
  },
  tableRowAlt: {
    flexDirection: "row",
    borderBottomWidth: 1,
    borderBottomColor: "#ecf0f1",
    padding: 4,
    backgroundColor: "#f9f9f9",
  },
  tableCell: {
    fontSize: 8,
    textAlign: "center",
  },
  emptyText: {
    fontSize: 9,
    color: "#7f8c8d",
  },
  footer: {
    position: "absolute",
    bottom: 20,
    left: 30,
    right: 30,
    flexDirection: "row",
    justifyContent: "space-between",
    fontSize: 8,
    color: "#7f8c8d",
  },
  pageNumber: {
    textAlign: "center",
  },
});

const getRoleLabel = (role) => {
  const roles = {
    superior: "Bề trên",
    assistant: "Phó bề trên",
    treasurer: "Thủ quỹ",
    secretary: "Thư ký",
    member: "Thành viên",
  };
  return roles[role] || "Thành viên";
};

const InfoItem = ({ label, value }) => (
  <div className="info-item">
    <label>{label}</label>
    <div className={`value ${!value || value === "-" ? "empty" : ""}`}>
      {value || "Chưa cập nhật"}
    </div>
  </div>
);

const CommunityDetailPage = () => {
  const { id } = useParams();
  const navigate = useNavigate();
  const [loading, setLoading] = useState(true);
  const [community, setCommunity] = useState(null);
  const [members, setMembers] = useState([]);

  // Event states
  const [events, setEvents] = useState([]);
  const [showEventModal, setShowEventModal] = useState(false);
  const [newEvent, setNewEvent] = useState({
    title: "",
    description: "",
    event_date: new Date().toISOString().split("T")[0],
  });
  const [addingEvent, setAddingEvent] = useState(false);
  const [eventSearch, setEventSearch] = useState("");

  // History states
  const [showHistoryModal, setShowHistoryModal] = useState(false);
  const [historyContent, setHistoryContent] = useState("");
  const [editingHistory, setEditingHistory] = useState(false);
  const [savingHistory, setSavingHistory] = useState(false);

  // Quill editor configuration
  const quillModules = {
    toolbar: [
      [{ header: [1, 2, 3, 4, 5, 6, false] }],
      [{ font: [] }],
      [{ size: ["small", false, "large", "huge"] }],
      ["bold", "italic", "underline", "strike"],
      [{ color: [] }, { background: [] }],
      [{ script: "sub" }, { script: "super" }],
      [{ list: "ordered" }, { list: "bullet" }],
      [{ indent: "-1" }, { indent: "+1" }],
      [{ direction: "rtl" }],
      [{ align: [] }],
      ["blockquote", "code-block"],
      ["link", "image", "video"],
      ["clean"],
    ],
  };

  const quillFormats = [
    "header",
    "font",
    "size",
    "bold",
    "italic",
    "underline",
    "strike",
    "color",
    "background",
    "script",
    "list",
    "bullet",
    "indent",
    "direction",
    "align",
    "blockquote",
    "code-block",
    "link",
    "image",
    "video",
  ];

  useEffect(() => {
    fetchCommunityDetail();
    fetchMembers();
    fetchEvents();
  }, [id]);

  const fetchEvents = async () => {
    try {
      const response = await communityService.getEvents(id);
      if (response && response.success) {
        setEvents(response.data);
      }
    } catch (error) {
      console.error("Error fetching events:", error);
    }
  };

  useEffect(() => {
    // Load history content when community data is loaded
    if (community?.history) {
      setHistoryContent(community.history);
    }
  }, [community]);

  const fetchCommunityDetail = async () => {
    try {
      setLoading(true);
      const response = await communityService.getDetail(id);
      if (response && response.community) {
        setCommunity(response.community);
        // Nếu API trả về members cùng lúc
        if (response.members) {
          setMembers(response.members);
        }
      }
    } catch (error) {
      console.error("Error fetching community detail:", error);
    } finally {
      setLoading(false);
    }
  };

  const fetchMembers = async () => {
    try {
      const response = await communityService.getMembers(id);
      if (response && response.members) {
        setMembers(response.members);
      }
    } catch (error) {
      console.error("Error fetching members:", error);
    }
  };

  const handleEdit = () => {
    navigate(`/cong-doan/${id}/edit`);
  };

  const handleDelete = async () => {
    if (window.confirm("Bạn có chắc chắn muốn xóa cộng đoàn này?")) {
      try {
        await communityService.delete(id);
        navigate("/cong-doan");
      } catch (error) {
        console.error("Error deleting community:", error);
      }
    }
  };

  const handleAssignMembers = () => {
    navigate(`/cong-doan/${id}/assign`);
  };

  // Event handlers
  const handleOpenEventModal = () => {
    setNewEvent({
      title: "",
      description: "",
      event_date: new Date().toISOString().split("T")[0],
    });
    setShowEventModal(true);
  };

  const handleCloseEventModal = () => {
    setShowEventModal(false);
  };

  const handleAddEvent = async () => {
    if (!newEvent.title || !newEvent.event_date) {
      alert("Vui lòng nhập tên sự kiện và ngày diễn ra");
      return;
    }

    try {
      setAddingEvent(true);
      const response = await communityService.addEvent(id, newEvent);
      if (response && response.success) {
        await fetchEvents();
        setShowEventModal(false);
      } else {
        alert("Không thể thêm sự kiện");
      }
    } catch (error) {
      console.error("Error adding event:", error);
      alert("Lỗi khi thêm sự kiện");
    } finally {
      setAddingEvent(false);
    }
  };

  const [viewEvent, setViewEvent] = useState(null);
  const [showViewEventModal, setShowViewEventModal] = useState(false);

  const handleViewEvent = (event) => {
    // Nếu là sự kiện thủ công (manual), hiển thị modal xem chi tiết
    if (event.type === "manual") {
      setViewEvent(event);
      setShowViewEventModal(true);
      return;
    }

    // Nếu là sự kiện tự động (auto), điều hướng đến trang chi tiết tương ứng
    if (event.type === "auto" && event.id) {
      const idParts = event.id.toString().split("-");
      // Lấy ID thực thể (phần tử cuối cùng)
      const entityId = idParts[idParts.length - 1];

      // Kiểm tra loại sự kiện dựa trên prefix
      // Assignments (arrival/departure)
      if (
        event.id.startsWith("arrival-") ||
        event.id.startsWith("departure-")
      ) {
        navigate(`/cong-doan/assignments/${entityId}`);
        return;
      }

      // Sứ vụ (mission)
      if (
        event.id.startsWith("miss-start-") ||
        event.id.startsWith("miss-end-")
      ) {
        navigate(`/su-vu/${entityId}`);
        return;
      }

      // Học vấn (education)
      if (
        event.id.startsWith("edu-start-") ||
        event.id.startsWith("edu-end-")
      ) {
        navigate(`/hoc-van/${entityId}`);
        return;
      }

      // Sức khỏe (health)
      if (event.id.startsWith("health-")) {
        navigate(`/suc-khoe/${entityId}`);
        return;
      }

      // Giai đoạn ơn gọi (stage)
      if (event.id.startsWith("stage-") || event.id.startsWith("stage-end-")) {
        navigate(`/hanh-trinh/${entityId}`);
        return;
      }

      // Khóa thường huấn (course) - Nếu chưa có trang chi tiết, có thể hiển thị modal hoặc điều hướng về danh sách
      // Hiện tại fallback về hiển thị modal vì chưa có /training-courses/:id
    }

    // Fallback cho các trường hợp còn lại
    setViewEvent(event);
    setShowViewEventModal(true);
  };

  const handleCloseViewEventModal = () => {
    setShowViewEventModal(false);
    setViewEvent(null);
  };

  const handleDeleteEvent = async (eventId) => {
    if (!eventId) return;
    if (window.confirm("Bạn có chắc chắn muốn xóa sự kiện này?")) {
      try {
        const response = await communityService.deleteEvent(id, eventId);
        if (response && response.success) {
          await fetchEvents();
        } else {
          alert(
            "Không thể xóa sự kiện: " +
              (response?.message || "Lỗi không xác định"),
          );
        }
      } catch (error) {
        console.error("Error deleting event:", error);
        alert("Lỗi khi xóa sự kiện");
      }
    }
  };

  // History handlers
  const handleOpenHistoryEditor = () => {
    setEditingHistory(true);
    setShowHistoryModal(true);
  };

  const handleCloseHistoryModal = () => {
    setShowHistoryModal(false);
    setEditingHistory(false);
    // Reset to saved content
    if (community?.history) {
      setHistoryContent(community.history);
    }
  };

  const handleSaveHistory = async () => {
    try {
      setSavingHistory(true);
      await communityService.update(id, { history: historyContent });
      setCommunity((prev) => ({ ...prev, history: historyContent }));
      setShowHistoryModal(false);
      setEditingHistory(false);
    } catch (error) {
      console.error("Error saving history:", error);
      alert("Không thể lưu lịch sử. Vui lòng thử lại.");
    } finally {
      setSavingHistory(false);
    }
  };

  const handleDeleteHistory = async () => {
    if (window.confirm("Bạn có chắc chắn muốn xóa lịch sử hình thành?")) {
      try {
        await communityService.update(id, { history: null });
        setCommunity((prev) => ({ ...prev, history: null }));
        setHistoryContent("");
      } catch (error) {
        console.error("Error deleting history:", error);
        alert("Không thể xóa lịch sử. Vui lòng thử lại.");
      }
    }
  };

  const handleViewMember = (memberId) => {
    navigate(`/nu-tu/${memberId}`);
  };

  const handleExportExcel = () => {
    if (!filteredEvents || filteredEvents.length === 0) {
      alert("Không có dữ liệu để xuất");
      return;
    }

    // 1. Define Headers
    const headers = ["Ngày", "Sự kiện", "Chi tiết"];

    // 2. Format Data
    const csvContent = [
      headers.join(","),
      ...filteredEvents.map((event) => {
        const date = new Date(event.event_date).toLocaleDateString("vi-VN");
        // Escape quotes and wrap in quotes for CSV safety
        const title = `"${(event.title || "").replace(/"/g, '""')}"`;
        const desc = `"${(event.description || "").replace(/"/g, '""')}"`;
        return [date, title, desc].join(",");
      }),
    ].join("\n");

    // 3. Create Blob with BOM for UTF-8 (Critical for Vietnamese)
    const blob = new Blob(["\uFEFF" + csvContent], {
      type: "text/csv;charset=utf-8;",
    });

    // 4. Download
    const url = URL.createObjectURL(blob);
    const link = document.createElement("a");
    link.href = url;
    link.download = `SuKien_${community?.code || "CongDoan"}_${new Date().toISOString().slice(0, 10)}.csv`;
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
    URL.revokeObjectURL(url);
  };

  // PDF Document Component
  const CommunityPDFDocument = ({ community, members }) => {
    const InfoRow = ({ label, value }) => (
      <View style={pdfStyles.row}>
        <Text style={pdfStyles.label}>{label}:</Text>
        <Text style={pdfStyles.value}>{value || "Chưa cập nhật"}</Text>
      </View>
    );

    const TwoColumnRow = ({ label1, value1, label2, value2 }) => (
      <View style={pdfStyles.twoColumnRow}>
        <View style={pdfStyles.column}>
          <Text style={pdfStyles.columnLabel}>{label1}:</Text>
          <Text style={pdfStyles.columnValue}>{value1 || "Chưa cập nhật"}</Text>
        </View>
        <View style={pdfStyles.column}>
          <Text style={pdfStyles.columnLabel}>{label2}:</Text>
          <Text style={pdfStyles.columnValue}>{value2 || "Chưa cập nhật"}</Text>
        </View>
      </View>
    );

    return (
      <Document>
        <Page size="A4" style={pdfStyles.page}>
          {/* Header */}
          <View style={pdfStyles.header}>
            <Text style={pdfStyles.headerTitle}>THÔNG TIN CỘNG ĐOÀN</Text>
            <Text style={pdfStyles.headerSubtitle}>
              Hội Dòng Thánh Phaolô Thiện Bản
            </Text>
            <Text style={pdfStyles.headerDate}>
              Ngày xuất: {formatDate(new Date())}
            </Text>
          </View>

          {/* Basic Info Box */}
          <View style={pdfStyles.basicInfoBox}>
            <Text style={pdfStyles.basicInfoName}>
              {community.name || "N/A"}
            </Text>
            <Text style={pdfStyles.basicInfoText}>
              Mã số: {community.code || "N/A"}
            </Text>
            <Text style={pdfStyles.basicInfoText}>
              Trạng thái:{" "}
              {community.status === "active"
                ? "Đang hoạt động"
                : "Không hoạt động"}
            </Text>
          </View>

          {/* Section 1: Thông tin cơ bản */}
          <Text style={pdfStyles.sectionTitle}>I. THÔNG TIN CƠ BẢN</Text>
          <TwoColumnRow
            label1="Tên cộng đoàn"
            value1={community.name}
            label2="Mã số"
            value2={community.code}
          />
          <TwoColumnRow
            label1="Ngày thành lập"
            value1={formatDate(community.established_date)}
            label2="Trạng thái"
            value2={
              community.status === "active"
                ? "Đang hoạt động"
                : "Không hoạt động"
            }
          />
          <InfoRow label="Địa chỉ" value={community.address} />
          <TwoColumnRow
            label1="Điện thoại"
            value1={community.phone}
            label2="Email"
            value2={community.email}
          />
          <InfoRow label="Mô tả" value={community.description} />

          {/* Section 2: Thống kê */}
          <Text style={pdfStyles.sectionTitle}>II. THỐNG KÊ</Text>
          <TwoColumnRow
            label1="Tổng số thành viên"
            value1={members.length.toString()}
            label2="Bề trên"
            value2={
              members.find((m) => m.role === "superior")?.birth_name ||
              "Chưa có"
            }
          />
          <TwoColumnRow
            label1="Phó bề trên"
            value1={
              members.find((m) => m.role === "assistant")?.birth_name ||
              "Chưa có"
            }
            label2="Thủ quỹ"
            value2={
              members.find((m) => m.role === "treasurer")?.birth_name ||
              "Chưa có"
            }
          />

          {/* Section 3: Danh sách thành viên */}
          <Text style={pdfStyles.sectionTitle}>
            III. DANH SÁCH THÀNH VIÊN ({members.length})
          </Text>
          {members && members.length > 0 ? (
            <View style={pdfStyles.table}>
              <View style={pdfStyles.tableHeader}>
                <Text style={[pdfStyles.tableHeaderCell, { width: "8%" }]}>
                  STT
                </Text>
                <Text style={[pdfStyles.tableHeaderCell, { width: "15%" }]}>
                  Mã số
                </Text>
                <Text style={[pdfStyles.tableHeaderCell, { width: "25%" }]}>
                  Họ tên
                </Text>
                <Text style={[pdfStyles.tableHeaderCell, { width: "17%" }]}>
                  Tên thánh
                </Text>
                <Text style={[pdfStyles.tableHeaderCell, { width: "18%" }]}>
                  Vai trò
                </Text>
                <Text style={[pdfStyles.tableHeaderCell, { width: "17%" }]}>
                  Ngày tham gia
                </Text>
              </View>
              {members.map((member, index) => (
                <View
                  key={member.id || index}
                  style={
                    index % 2 === 0 ? pdfStyles.tableRow : pdfStyles.tableRowAlt
                  }
                >
                  <Text style={[pdfStyles.tableCell, { width: "8%" }]}>
                    {index + 1}
                  </Text>
                  <Text style={[pdfStyles.tableCell, { width: "15%" }]}>
                    {member.sister_code || ""}
                  </Text>
                  <Text style={[pdfStyles.tableCell, { width: "25%" }]}>
                    {member.birth_name || ""}
                  </Text>
                  <Text style={[pdfStyles.tableCell, { width: "17%" }]}>
                    {member.saint_name || ""}
                  </Text>
                  <Text style={[pdfStyles.tableCell, { width: "18%" }]}>
                    {getRoleLabel(member.role)}
                  </Text>
                  <Text style={[pdfStyles.tableCell, { width: "17%" }]}>
                    {formatDate(member.start_date) || ""}
                  </Text>
                </View>
              ))}
            </View>
          ) : (
            <Text style={pdfStyles.emptyText}>Chưa có thành viên nào</Text>
          )}

          {/* Footer */}
          <View style={pdfStyles.footer} fixed>
            <Text>Thông tin Cộng Đoàn - {community.name || "N/A"}</Text>
            <Text
              render={({ pageNumber, totalPages }) =>
                `Trang ${pageNumber}/${totalPages}`
              }
            />
          </View>
        </Page>
      </Document>
    );
  };

  // Export PDF function
  const handleExportPDF = async () => {
    try {
      const blob = await pdf(
        <CommunityPDFDocument community={community} members={members} />,
      ).toBlob();
      const url = URL.createObjectURL(blob);
      const link = document.createElement("a");
      link.href = url;
      const fileName = `ThongTinCongDoan_${
        community.name?.replace(/\s+/g, "_") || "CongDoan"
      }_${new Date().toISOString().slice(0, 10)}.pdf`;
      link.download = fileName;
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
      URL.revokeObjectURL(url);
    } catch (error) {
      console.error("Error exporting PDF:", error);
      alert("Có lỗi khi xuất PDF. Vui lòng thử lại.");
    }
  };

  // Filter events based on search
  const filteredEvents = events.filter((event) => {
    const searchLower = eventSearch.toLowerCase();
    return (
      event.title?.toLowerCase().includes(searchLower) ||
      event.description?.toLowerCase().includes(searchLower) ||
      formatDate(event.event_date).includes(searchLower)
    );
  });

  if (loading) {
    return (
      <div
        className="d-flex justify-content-center align-items-center"
        style={{ minHeight: "60vh" }}
      >
        <LoadingSpinner size="large" />
      </div>
    );
  }

  if (!community) {
    return (
      <Container className="py-4">
        <div className="text-center">
          <h3>Không tìm thấy thông tin cộng đoàn</h3>
          <Button variant="primary" onClick={() => navigate("/cong-doan")}>
            Quay lại danh sách
          </Button>
        </div>
      </Container>
    );
  }

  return (
    <Container fluid className="py-4">
      <Breadcrumb
        title="Thông tin Cộng Đoàn"
        items={[
          { label: "Quản lý Cộng Đoàn", link: "/cong-doan" },
          { label: community.name },
        ]}
      />

      {/* Action Buttons */}
      <div className="d-flex justify-content-end align-items-center mb-4">
        <div className="action-buttons">
          <Button variant="primary" onClick={handleExportPDF}>
            <i className="fas fa-file-pdf me-2"></i>Xuất PDF
          </Button>
          <Button variant="success" onClick={handleEdit}>
            <i className="fas fa-edit me-2"></i>Chỉnh sửa
          </Button>
          <Button variant="danger" onClick={handleDelete}>
            <i className="fas fa-trash me-2"></i>Xóa
          </Button>
          <Button variant="secondary" onClick={() => navigate("/cong-doan")}>
            <i className="fas fa-arrow-left me-2"></i>Quay lại
          </Button>
        </div>
      </div>

      <Tab.Container defaultActiveKey="info">
        <Row className="g-4">
          {/* Left Column - Icon & Quick Info */}
          <Col lg={3}>
            {/* Community Icon Card */}
            <Card className="health-info-card">
              <Card.Header className="documents-header">
                <i className="fas fa-home"></i>
                <span>Cộng Đoàn</span>
              </Card.Header>
              <Card.Body className="text-center">
                <div className="community-icon-section">
                  <div className="community-icon-large">
                    <span style={{ fontSize: "3rem" }}>🏠</span>
                  </div>
                  <div className="name-display">
                    <h3 className="community-name">{community.name}</h3>
                    <div className="code">
                      <i className="fas fa-id-card me-2"></i>
                      {community.code}
                    </div>
                  </div>
                  <div className="mt-3">
                    <Badge
                      bg={
                        community.status === "active" ? "success" : "secondary"
                      }
                    >
                      {community.status === "active"
                        ? "Đang hoạt động"
                        : "Không hoạt động"}
                    </Badge>
                  </div>
                </div>
              </Card.Body>
            </Card>

            {/* Quick Info Card */}
            <Card className="health-info-card">
              <Card.Header className="system-header">
                <i className="fas fa-info-circle"></i>
                <span>Thông tin nhanh</span>
              </Card.Header>
              <Card.Body className="p-2">
                <div className="quick-info">
                  <div className="quick-info-item">
                    <i className="fas fa-users text-primary"></i>
                    <div className="info-content">
                      <small className="text-muted">Số thành viên</small>
                      <div className="fw-semibold">{members.length}</div>
                    </div>
                  </div>

                  <div className="quick-info-item">
                    <i className="fas fa-calendar-alt text-success"></i>
                    <div className="info-content">
                      <small className="text-muted">Ngày thành lập</small>
                      <div className="fw-semibold">
                        {formatDate(community.established_date)}
                      </div>
                    </div>
                  </div>

                  <div className="quick-info-item">
                    <i className="fas fa-map-marker-alt text-info"></i>
                    <div className="info-content">
                      <small className="text-muted">Địa chỉ</small>
                      <div className="fw-semibold">
                        {community.address || "-"}
                      </div>
                    </div>
                  </div>

                  <div className="quick-info-item">
                    <i className="fas fa-phone text-warning"></i>
                    <div className="info-content">
                      <small className="text-muted">Điện thoại</small>
                      <div className="fw-semibold">
                        {community.phone || "-"}
                      </div>
                    </div>
                  </div>
                </div>
              </Card.Body>
            </Card>

            {/* Action Card */}
            <Card className="health-info-card">
              <Card.Body>
                <Button
                  variant="primary"
                  className="w-100"
                  onClick={handleAssignMembers}
                >
                  <i className="fas fa-user-plus me-2"></i>Phân công thành viên
                </Button>
              </Card.Body>
            </Card>
          </Col>

          {/* Right Column - Content */}
          <Col lg={9}>
            {/* Navigation Tabs */}
            <Card className="health-info-card mb-3">
              <Card.Body className="p-2">
                <Nav variant="pills" className="nav-horizontal-tabs">
                  <Nav.Link eventKey="info">
                    <i className="fas fa-info-circle"></i>
                    Thông tin
                  </Nav.Link>
                  <Nav.Link eventKey="members">
                    <i className="fas fa-users"></i>
                    Thành viên ({members.length})
                  </Nav.Link>
                  <Nav.Link eventKey="community_events">
                    <i className="fas fa-calendar-check"></i>
                    Sự kiện
                  </Nav.Link>
                  <Nav.Link eventKey="history">
                    <i className="fas fa-book"></i>
                    Lịch sử hình thành
                  </Nav.Link>
                </Nav>
              </Card.Body>
            </Card>

            {/* Content Card */}
            <Card className="health-info-card">
              <Card.Header>
                <i className="fas fa-info-circle"></i>
                <span>Chi tiết thông tin</span>
              </Card.Header>
              <Card.Body>
                <Tab.Content>
                  <Tab.Pane eventKey="info">
                    <div className="info-section">
                      <h5>
                        <i className="fas fa-home"></i>
                        Thông tin cơ bản
                      </h5>
                      <Row className="g-3">
                        <Col md={6}>
                          <InfoItem
                            label="Tên cộng đoàn"
                            value={community.name}
                          />
                        </Col>
                        <Col md={6}>
                          <InfoItem label="Mã số" value={community.code} />
                        </Col>
                        <Col md={6}>
                          <InfoItem
                            label="Ngày thành lập"
                            value={formatDate(community.established_date)}
                          />
                        </Col>
                        <Col md={6}>
                          <InfoItem
                            label="Trạng thái"
                            value={
                              community.status === "active"
                                ? "Đang hoạt động"
                                : "Không hoạt động"
                            }
                          />
                        </Col>
                        <Col md={12}>
                          <InfoItem label="Địa chỉ" value={community.address} />
                        </Col>
                        <Col md={6}>
                          <InfoItem
                            label="Điện thoại"
                            value={community.phone}
                          />
                        </Col>
                        <Col md={6}>
                          <InfoItem label="Email" value={community.email} />
                        </Col>
                        <Col md={12}>
                          <InfoItem
                            label="Mô tả"
                            value={community.description}
                          />
                        </Col>
                      </Row>
                    </div>
                  </Tab.Pane>

                  <Tab.Pane eventKey="members">
                    <div className="mb-3">
                      <h5 className="mb-0">Danh sách thành viên</h5>
                    </div>

                    {members.length > 0 ? (
                      <Table hover responsive>
                        <thead>
                          <tr>
                            <th>STT</th>
                            <th>Mã số</th>
                            <th>Họ tên</th>
                            <th>Tên thánh</th>
                            <th>Vai trò</th>
                            <th>Ngày tham gia</th>
                            <th>Thao tác</th>
                          </tr>
                        </thead>
                        <tbody>
                          {members.map((member, index) => (
                            <tr key={member.id}>
                              <td>{index + 1}</td>
                              <td>{member.sister_code}</td>
                              <td>{member.birth_name}</td>
                              <td>{member.saint_name || "-"}</td>
                              <td>
                                <Badge
                                  bg={
                                    member.role === "superior"
                                      ? "danger"
                                      : member.role === "assistant"
                                        ? "warning"
                                        : "secondary"
                                  }
                                >
                                  {getRoleLabel(member.role)}
                                </Badge>
                              </td>
                              <td>{formatDate(member.start_date)}</td>
                              <td>
                                <Button
                                  variant="outline-primary"
                                  size="sm"
                                  onClick={() =>
                                    handleViewMember(member.sister_id)
                                  }
                                >
                                  <i className="fas fa-eye"></i>
                                </Button>
                              </td>
                            </tr>
                          ))}
                        </tbody>
                      </Table>
                    ) : (
                      <div className="text-center py-5">
                        <p className="text-muted">Chưa có thành viên nào</p>
                      </div>
                    )}
                  </Tab.Pane>

                  <Tab.Pane eventKey="community_events">
                    <div className="d-flex justify-content-between align-items-center mb-3">
                      <h5 className="mb-0">
                        <i className="fas fa-calendar-check me-2"></i>
                        Sự kiện cộng đoàn
                      </h5>
                      <Button
                        variant="primary"
                        size="sm"
                        onClick={handleOpenEventModal}
                      >
                        <i className="fas fa-plus me-2"></i>
                        Thêm sự kiện
                      </Button>
                    </div>

                    <div className="mb-3">
                      <div className="d-flex justify-content-between align-items-center mb-0 gap-2">
                        <div className="input-group flex-grow-1">
                          <span className="input-group-text bg-white">
                            <i className="fas fa-search text-muted"></i>
                          </span>
                          <Form.Control
                            type="text"
                            placeholder="Tìm kiếm sự kiện theo tên, mô tả hoặc ngày..."
                            value={eventSearch}
                            onChange={(e) => setEventSearch(e.target.value)}
                          />
                          {eventSearch && (
                            <Button
                              variant="outline-secondary"
                              onClick={() => setEventSearch("")}
                            >
                              <i className="fas fa-times"></i>
                            </Button>
                          )}
                        </div>
                        <Button
                          variant="success"
                          onClick={handleExportExcel}
                          disabled={!filteredEvents.length}
                          title="Xuất file Excel"
                          className="text-nowrap"
                        >
                          <i className="fas fa-file-excel me-2"></i>
                          Xuất Excel
                        </Button>
                      </div>
                    </div>

                    {filteredEvents.length > 0 ? (
                      <div className="table-responsive">
                        <Table
                          bordered
                          hover
                          striped
                          size="sm"
                          className="mb-0"
                        >
                          <thead className="table-light">
                            <tr>
                              <th
                                className="text-center align-middle"
                                style={{ width: "120px" }}
                              >
                                Ngày
                              </th>
                              <th
                                className="align-middle"
                                style={{ width: "30%" }}
                              >
                                Sự kiện
                              </th>
                              <th className="align-middle">Chi tiết</th>
                              <th
                                className="align-middle text-center"
                                style={{ width: "100px" }}
                              >
                                Thao tác
                              </th>
                            </tr>
                          </thead>
                          <tbody>
                            {filteredEvents.map((event, index) => {
                              let titleClass = "text-dark";
                              let icon = "";

                              switch (event.category) {
                                case "arrival":
                                  titleClass = "text-success";
                                  icon = "fa-sign-in-alt";
                                  break;
                                case "departure":
                                  titleClass = "text-danger";
                                  icon = "fa-sign-out-alt";
                                  break;
                                case "education":
                                  titleClass = "text-info";
                                  icon = "fa-graduation-cap";
                                  break;
                                case "mission":
                                  titleClass = "text-primary";
                                  icon = "fa-cross";
                                  break;
                                case "health":
                                  titleClass = "text-warning";
                                  icon = "fa-heartbeat";
                                  break;
                                default:
                                  icon = "fa-calendar-day";
                              }

                              return (
                                <tr key={index}>
                                  <td className="text-center align-middle">
                                    {formatDate(event.event_date)}
                                  </td>
                                  <td className="align-middle">
                                    <span
                                      className={`fw-semibold ${titleClass}`}
                                    >
                                      {icon && (
                                        <i className={`fas ${icon} me-2`}></i>
                                      )}
                                      {event.title}
                                    </span>
                                  </td>
                                  <td className="align-middle text-secondary">
                                    {event.description}
                                  </td>
                                  <td className="align-middle">
                                    <div className="d-flex justify-content-center gap-2">
                                      <Button
                                        variant="outline-primary"
                                        size="sm"
                                        onClick={() => handleViewEvent(event)}
                                        title="Xem chi tiết"
                                      >
                                        <i className="fas fa-eye"></i>
                                      </Button>
                                      <Button
                                        variant="outline-danger"
                                        size="sm"
                                        onClick={() =>
                                          handleDeleteEvent(event.id)
                                        }
                                        title="Xóa sự kiện"
                                      >
                                        <i className="fas fa-trash"></i>
                                      </Button>
                                    </div>
                                  </td>
                                </tr>
                              );
                            })}
                          </tbody>
                        </Table>
                      </div>
                    ) : (
                      <div className="text-center py-5">
                        {eventSearch ? (
                          <>
                            <p className="text-muted mb-2">
                              Không tìm thấy sự kiện nào phù hợp với "
                              {eventSearch}"
                            </p>
                            <Button
                              variant="link"
                              onClick={() => setEventSearch("")}
                            >
                              Xóa bộ lọc
                            </Button>
                          </>
                        ) : (
                          <p className="text-muted">Chưa có sự kiện nào</p>
                        )}
                      </div>
                    )}
                  </Tab.Pane>

                  <Tab.Pane eventKey="history">
                    <div className="d-flex justify-content-between align-items-center mb-3">
                      <h5 className="mb-0">
                        <i className="fas fa-book me-2"></i>
                        Lịch sử hình thành
                      </h5>
                      <div className="d-flex gap-2">
                        <Button
                          variant="primary"
                          size="sm"
                          onClick={handleOpenHistoryEditor}
                        >
                          <i className="fas fa-edit me-2"></i>
                          {community?.history ? "Sửa" : "Soạn thảo"}
                        </Button>
                        {community?.history && (
                          <Button
                            variant="danger"
                            size="sm"
                            onClick={handleDeleteHistory}
                          >
                            <i className="fas fa-trash me-2"></i>
                            Xóa
                          </Button>
                        )}
                      </div>
                    </div>

                    {community?.history ? (
                      <div className="history-content">
                        <div
                          className="ql-editor"
                          dangerouslySetInnerHTML={{
                            __html: community.history,
                          }}
                          style={{
                            padding: "15px",
                            border: "1px solid #e0e0e0",
                            borderRadius: "8px",
                            minHeight: "200px",
                            backgroundColor: "#fafafa",
                          }}
                        />
                      </div>
                    ) : (
                      <div className="text-center py-5">
                        <i
                          className="fas fa-book text-muted mb-3"
                          style={{ fontSize: "3rem" }}
                        ></i>
                        <p className="text-muted">
                          Chưa có thông tin lịch sử hình thành
                        </p>
                        <Button
                          variant="primary"
                          onClick={handleOpenHistoryEditor}
                        >
                          <i className="fas fa-edit me-2"></i>Soạn thảo lịch sử
                        </Button>
                      </div>
                    )}
                  </Tab.Pane>
                </Tab.Content>
              </Card.Body>
            </Card>
          </Col>
        </Row>
      </Tab.Container>

      {/* History Editor Modal */}
      <Modal
        show={showHistoryModal}
        onHide={handleCloseHistoryModal}
        size="xl"
        centered
        className="history-editor-modal"
      >
        <Modal.Header closeButton>
          <Modal.Title>
            <i className="fas fa-edit me-2"></i>
            Soạn thảo lịch sử hình thành - {community?.name}
          </Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <Form.Group className="mb-3">
            <Form.Label>
              Nội dung chi tiết <span className="text-danger">*</span>
            </Form.Label>
            <div className="quill-container" style={{ minHeight: "400px" }}>
              <ReactQuill
                theme="snow"
                value={historyContent}
                onChange={setHistoryContent}
                modules={quillModules}
                formats={quillFormats}
                style={{ height: "350px" }}
                placeholder="Nhập nội dung lịch sử hình thành cộng đoàn..."
              />
            </div>
            <small className="text-muted mt-5 d-block">
              <i className="fas fa-info-circle me-1"></i>
              Sử dụng thanh công cụ để định dạng văn bản, thêm hình ảnh, liên
              kết...
            </small>
          </Form.Group>
        </Modal.Body>
        <Modal.Footer>
          <Button
            variant="secondary"
            onClick={handleCloseHistoryModal}
            disabled={savingHistory}
          >
            <i className="fas fa-times me-2"></i>Hủy
          </Button>
          <Button
            variant="primary"
            onClick={handleSaveHistory}
            disabled={savingHistory}
          >
            {savingHistory ? (
              <>
                <span
                  className="spinner-border spinner-border-sm me-2"
                  role="status"
                  aria-hidden="true"
                ></span>
                Đang lưu...
              </>
            ) : (
              <>
                <i className="fas fa-save me-2"></i>Lưu
              </>
            )}
          </Button>
        </Modal.Footer>
      </Modal>

      {/* View Event Modal */}
      <Modal
        show={showViewEventModal}
        onHide={handleCloseViewEventModal}
        centered
      >
        <Modal.Header closeButton>
          <Modal.Title>Chi tiết sự kiện</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          {viewEvent && (
            <div>
              <div className="mb-3">
                <label className="fw-bold text-muted small">Tên sự kiện</label>
                <div className="fs-5">{viewEvent.title}</div>
              </div>
              <div className="mb-3">
                <label className="fw-bold text-muted small">Ngày diễn ra</label>
                <div>{formatDate(viewEvent.event_date)}</div>
              </div>
              <div className="mb-3">
                <label className="fw-bold text-muted small">
                  Mô tả chi tiết
                </label>
                <div className="p-2 bg-light rounded border">
                  {viewEvent.description || (
                    <span className="text-muted fst-italic">
                      Không có mô tả
                    </span>
                  )}
                </div>
              </div>
              {viewEvent.created_at && (
                <div className="text-end text-muted small mt-4">
                  Được tạo lúc:{" "}
                  {new Date(viewEvent.created_at).toLocaleString("vi-VN")}
                </div>
              )}
            </div>
          )}
        </Modal.Body>
        <Modal.Footer>
          <Button variant="secondary" onClick={handleCloseViewEventModal}>
            Đóng
          </Button>
        </Modal.Footer>
      </Modal>

      {/* Add Event Modal */}
      <Modal show={showEventModal} onHide={handleCloseEventModal} centered>
        <Modal.Header closeButton>
          <Modal.Title>Thêm sự kiện mới</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <Form>
            <Form.Group className="mb-3">
              <Form.Label>
                Tên sự kiện <span className="text-danger">*</span>
              </Form.Label>
              <Form.Control
                type="text"
                value={newEvent.title}
                onChange={(e) =>
                  setNewEvent({ ...newEvent, title: e.target.value })
                }
                placeholder="Ví dụ: Lễ bổn mạng cộng đoàn"
              />
            </Form.Group>
            <Form.Group className="mb-3">
              <Form.Label>
                Ngày diễn ra <span className="text-danger">*</span>
              </Form.Label>
              <Form.Control
                type="date"
                value={newEvent.event_date}
                onChange={(e) =>
                  setNewEvent({ ...newEvent, event_date: e.target.value })
                }
              />
            </Form.Group>
            <Form.Group className="mb-3">
              <Form.Label>Mô tả chi tiết</Form.Label>
              <Form.Control
                as="textarea"
                rows={3}
                value={newEvent.description}
                onChange={(e) =>
                  setNewEvent({ ...newEvent, description: e.target.value })
                }
                placeholder="Nhập mô tả chi tiết về sự kiện..."
              />
            </Form.Group>
          </Form>
        </Modal.Body>
        <Modal.Footer>
          <Button
            variant="secondary"
            onClick={handleCloseEventModal}
            disabled={addingEvent}
          >
            Hủy
          </Button>
          <Button
            variant="primary"
            onClick={handleAddEvent}
            disabled={addingEvent}
          >
            {addingEvent ? (
              <>
                <span className="spinner-border spinner-border-sm me-2"></span>
                Đang lưu...
              </>
            ) : (
              "Thêm sự kiện"
            )}
          </Button>
        </Modal.Footer>
      </Modal>
    </Container>
  );
};

export default CommunityDetailPage;
