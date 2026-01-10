// src/features/hoc-van/pages/EducationListAllPage.jsx

import React, { useState, useEffect, useMemo } from "react";
import {
  Container,
  Row,
  Col,
  Card,
  Table,
  Button,
  Form,
  Pagination,
  Badge,
} from "react-bootstrap";
import { Link } from "react-router-dom";
import { FaGraduationCap, FaEye, FaEdit, FaTrash } from "react-icons/fa";
import { toast } from "react-toastify";
import { educationService, lookupService } from "@services";
import LoadingSpinner from "@components/common/Loading/LoadingSpinner";
import Breadcrumb from "@components/common/Breadcrumb";

const EducationListAllPage = () => {
  const [loading, setLoading] = useState(true);
  const [educations, setEducations] = useState([]);
  const [levels, setLevels] = useState([]);
  const [searchTerm, setSearchTerm] = useState("");
  const [debouncedSearch, setDebouncedSearch] = useState("");
  const [currentPage, setCurrentPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [filter, setFilter] = useState({
    level: "",
    status: "",
  });
  const [sortBy, setSortBy] = useState("sister_name");
  const [sortOrder, setSortOrder] = useState("asc");

  // Fetch education levels on mount and when window gets focus
  useEffect(() => {
    const fetchLevels = async () => {
      try {
        const response = await lookupService.getEducationLevels();
        if (response && response.data) {
          setLevels(response.data);
          console.log("Education levels loaded:", response.data.length);
        }
      } catch (error) {
        console.error("Error fetching education levels:", error);
      }
    };
    fetchLevels();

    // Refresh levels when window gets focus
    const handleFocus = () => {
      fetchLevels();
    };
    window.addEventListener("focus", handleFocus);
    return () => window.removeEventListener("focus", handleFocus);
  }, []);

  // Debounce search - chờ 500ms sau khi ngừng gõ
  useEffect(() => {
    const timer = setTimeout(() => {
      setDebouncedSearch(searchTerm);
    }, 500);
    return () => clearTimeout(timer);
  }, [searchTerm]);

  // Fetch khi thay đổi page, filter hoặc debouncedSearch
  useEffect(() => {
    fetchEducations();
  }, [currentPage, filter.level, filter.status, debouncedSearch]);

  // Reset về trang 1 khi search thay đổi
  useEffect(() => {
    setCurrentPage(1);
  }, [debouncedSearch]);

  // Refresh data khi quay lại trang (window focus)
  useEffect(() => {
    const handleFocus = () => {
      fetchEducations();
    };
    window.addEventListener("focus", handleFocus);
    return () => window.removeEventListener("focus", handleFocus);
  }, [currentPage, filter.level, filter.status, debouncedSearch]);

  const fetchEducations = async () => {
    try {
      setLoading(true);
      const params = {
        page: currentPage,
        limit: 10,
      };
      // Chỉ gửi search nếu có giá trị
      if (debouncedSearch.trim()) {
        params.search = debouncedSearch.trim();
      }
      // Chỉ gửi filter nếu có giá trị
      if (filter.level) {
        params.level = filter.level;
      }
      if (filter.status) {
        params.status = filter.status;
      }

      const response = await educationService.getList(params);
      if (response.success) {
        setEducations(response.data.items || response.data || []);
        setTotalPages(
          response.data.totalPages || Math.ceil((response.data.total || 0) / 10)
        );
      }
    } catch (error) {
      console.error("Error fetching educations:", error);
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = async (id) => {
    if (window.confirm("Bạn có chắc chắn muốn xóa học vấn này?")) {
      try {
        const result = await educationService.delete(id);
        if (result.success) {
          toast.success("Xóa học vấn thành công!");
          fetchEducations();
        } else {
          toast.error(result.error || "Không thể xóa học vấn");
        }
      } catch (error) {
        console.error("Error deleting education:", error);
        toast.error("Lỗi khi xóa học vấn");
      }
    }
  };

  const getLevelBadge = (levelCode) => {
    // Fallback mapping tiếng Việt cho các level
    const levelTranslations = {
      primary: "Tiểu học",
      secondary: "Trung học cơ sở",
      high_school: "Trung học phổ thông",
      vocational: "Trung cấp",
      associate: "Cao đẳng",
      bachelor: "Đại học",
      master: "Thạc sĩ",
      doctorate: "Tiến sĩ",
      other: "Khác",
    };

    const levelItem = levels.find((l) => l.code === levelCode);
    if (levelItem) {
      return (
        <Badge
          style={{
            backgroundColor: levelItem.color || "#6c757d",
            color: "#fff",
          }}
        >
          {levelItem.name}
        </Badge>
      );
    }

    // Fallback to translations if level not found in levels array
    const vietnameseName = levelTranslations[levelCode] || levelCode || "Khác";
    return <Badge bg="secondary">{vietnameseName}</Badge>;
  };

  const getStatusBadge = (status) => {
    const statuses = {
      dang_hoc: { label: "Đang học", variant: "primary" },
      da_tot_nghiep: { label: "Đã tốt nghiệp", variant: "success" },
      tam_nghi: { label: "Tạm nghỉ", variant: "warning" },
      da_nghi: { label: "Đã nghỉ", variant: "secondary" },
    };
    const statusInfo = statuses[status] || {
      label: status,
      variant: "secondary",
    };
    return <Badge bg={statusInfo.variant}>{statusInfo.label}</Badge>;
  };

  const handleSort = (key) => {
    setSortOrder((prevOrder) =>
      sortBy === key && prevOrder === "asc" ? "desc" : "asc"
    );
    setSortBy(key);
  };

  const renderSortIcon = (key) => {
    if (sortBy !== key) return <i className="fas fa-sort text-muted ms-1"></i>;
    return sortOrder === "asc" ? (
      <i className="fas fa-sort-up ms-1"></i>
    ) : (
      <i className="fas fa-sort-down ms-1"></i>
    );
  };

  const sortedEducations = useMemo(() => {
    const items = [...educations];
    const getValue = (item) => {
      if (sortBy === "sister_name")
        return item.sister_name || item.religious_name || "";
      if (sortBy === "institution") return item.institution || "";
      if (sortBy === "major") return item.major || "";
      if (sortBy === "level") return item.level || "";
      if (sortBy === "graduation_year") return item.graduation_year || 0;
      if (sortBy === "status") return item.status || "";
      return "";
    };

    items.sort((a, b) => {
      const aValue = getValue(a);
      const bValue = getValue(b);

      if (typeof aValue === "number" && typeof bValue === "number") {
        return sortOrder === "asc" ? aValue - bValue : bValue - aValue;
      }

      return sortOrder === "asc"
        ? String(aValue).localeCompare(String(bValue))
        : String(bValue).localeCompare(String(aValue));
    });

    return items;
  }, [educations, sortBy, sortOrder]);

  if (loading && educations.length === 0) {
    return (
      <div
        className="d-flex justify-content-center align-items-center"
        style={{ minHeight: "60vh" }}
      >
        <LoadingSpinner size="large" />
      </div>
    );
  }

  return (
    <Container fluid className="py-4">
      <Breadcrumb title="Quản lý Học vấn" items={[{ label: "Học vấn" }]} />

      {/* Statistics Cards */}
      <Row className="g-3 mb-4">
        <Col xs={6} md={3}>
          <Card className="stat-card shadow-sm border-0 rounded-3">
            <Card.Body>
              <div className="d-flex justify-content-between align-items-center">
                <div>
                  <small className="text-muted">Tổng số</small>
                  <h4 className="mb-0">{educations.length}</h4>
                </div>
                <div className="stat-icon bg-primary">
                  <i className="fas fa-graduation-cap"></i>
                </div>
              </div>
            </Card.Body>
          </Card>
        </Col>
        <Col xs={6} md={3}>
          <Card className="stat-card shadow-sm border-0 rounded-3">
            <Card.Body>
              <div className="d-flex justify-content-between align-items-center">
                <div>
                  <small className="text-muted">Đang học</small>
                  <h4 className="mb-0">
                    {educations.filter((e) => e.status === "dang_hoc").length}
                  </h4>
                </div>
                <div className="stat-icon bg-success">
                  <i className="fas fa-book-open"></i>
                </div>
              </div>
            </Card.Body>
          </Card>
        </Col>
        <Col xs={6} md={3}>
          <Card className="stat-card shadow-sm border-0 rounded-3">
            <Card.Body>
              <div className="d-flex justify-content-between align-items-center">
                <div>
                  <small className="text-muted">Đã tốt nghiệp</small>
                  <h4 className="mb-0">
                    {
                      educations.filter((e) => e.status === "da_tot_nghiep")
                        .length
                    }
                  </h4>
                </div>
                <div className="stat-icon bg-info">
                  <i className="fas fa-check"></i>
                </div>
              </div>
            </Card.Body>
          </Card>
        </Col>
        <Col xs={6} md={3}>
          <Card className="stat-card shadow-sm border-0 rounded-3">
            <Card.Body>
              <div className="d-flex justify-content-between align-items-center">
                <div>
                  <small className="text-muted">Số trình độ</small>
                  <h4 className="mb-0">
                    {
                      new Set(educations.map((e) => e.level).filter(Boolean))
                        .size
                    }
                  </h4>
                </div>
                <div className="stat-icon bg-warning">
                  <i className="fas fa-layer-group"></i>
                </div>
              </div>
            </Card.Body>
          </Card>
        </Col>
      </Row>

      {/* Filters */}
      <Card className="mb-4 shadow-sm border-0 rounded-3">
        <Card.Body>
          <Row className="align-items-end">
            <Col md={4}>
              <Form.Group>
                <Form.Label>Tìm kiếm</Form.Label>
                <Form.Control
                  type="text"
                  placeholder="Tên nữ tu, trường học, ngành học..."
                  value={searchTerm}
                  onChange={(e) => setSearchTerm(e.target.value)}
                  size="lg"
                />
              </Form.Group>
            </Col>
            <Col md={3}>
              <Form.Group>
                <Form.Label>Trình độ</Form.Label>
                <Form.Select
                  value={filter.level}
                  onChange={(e) => {
                    setFilter({ ...filter, level: e.target.value });
                    setCurrentPage(1);
                  }}
                  size="lg"
                >
                  <option value="">Tất cả</option>
                  {levels.map((level) => (
                    <option key={level.code} value={level.code}>
                      {level.name}
                    </option>
                  ))}
                </Form.Select>
              </Form.Group>
            </Col>
            <Col md={3}>
              <Form.Group>
                <Form.Label>Trạng thái</Form.Label>
                <Form.Select
                  value={filter.status}
                  onChange={(e) => {
                    setFilter({ ...filter, status: e.target.value });
                    setCurrentPage(1);
                  }}
                  size="lg"
                >
                  <option value="">Tất cả</option>
                  <option value="dang_hoc">Đang học</option>
                  <option value="da_tot_nghiep">Đã tốt nghiệp</option>
                  <option value="tam_nghi">Tạm nghỉ</option>
                  <option value="da_nghi">Đã nghỉ</option>
                </Form.Select>
              </Form.Group>
            </Col>
            <Col md={2}>
              <Button
                variant="outline-secondary"
                className="w-100"
                size="lg"
                onClick={() => {
                  setSearchTerm("");
                  setDebouncedSearch("");
                  setFilter({ level: "", status: "" });
                  setCurrentPage(1);
                }}
              >
                Xóa bộ lọc
              </Button>
            </Col>
          </Row>
        </Card.Body>
      </Card>

      {/* Table */}
      <Card
        className="shadow-sm border-0 rounded-3"
        style={{ borderRadius: "12px", overflow: "hidden" }}
      >
        <Card.Body className="p-0">
          {educations.length === 0 ? (
            <div className="text-center py-5">
              <FaGraduationCap size={48} className="text-muted mb-3" />
              <h5>Chưa có thông tin học vấn</h5>
              <p className="text-muted">
                Vui lòng thêm học vấn từ trang thông tin nữ tu
              </p>
            </div>
          ) : (
            <>
              <div className="table-responsive">
                <Table hover className="mb-0 align-middle">
                  <thead className="bg-light">
                    <tr>
                      <th className="text-nowrap">#</th>
                      <th
                        role="button"
                        onClick={() => handleSort("sister_name")}
                        className="text-nowrap"
                      >
                        Nữ tu {renderSortIcon("sister_name")}
                      </th>
                      <th
                        role="button"
                        onClick={() => handleSort("institution")}
                        className="text-nowrap"
                      >
                        Trường học {renderSortIcon("institution")}
                      </th>
                      <th
                        role="button"
                        onClick={() => handleSort("major")}
                        className="text-nowrap"
                      >
                        Ngành học {renderSortIcon("major")}
                      </th>
                      <th
                        role="button"
                        onClick={() => handleSort("level")}
                        className="text-nowrap"
                      >
                        Trình độ {renderSortIcon("level")}
                      </th>
                      <th
                        role="button"
                        onClick={() => handleSort("graduation_year")}
                        className="text-nowrap"
                      >
                        Năm tốt nghiệp {renderSortIcon("graduation_year")}
                      </th>
                      <th
                        role="button"
                        onClick={() => handleSort("status")}
                        className="text-nowrap"
                      >
                        Trạng thái {renderSortIcon("status")}
                      </th>
                      <th className="text-end text-nowrap">Thao tác</th>
                    </tr>
                  </thead>
                  <tbody>
                    {sortedEducations.map((edu, index) => (
                      <tr key={edu.id}>
                        <td>{(currentPage - 1) * 10 + index + 1}</td>
                        <td>
                          <Link
                            to={`/nu-tu/${edu.sister_id}`}
                            className="text-primary fw-semibold"
                          >
                            {[
                              edu.religious_name,
                              edu.birth_name || edu.sister_name,
                            ]
                              .filter(Boolean)
                              .join(" ") || "N/A"}
                          </Link>
                        </td>
                        <td>{edu.institution || "N/A"}</td>
                        <td>{edu.major || "N/A"}</td>
                        <td>{getLevelBadge(edu.level)}</td>
                        <td>{edu.graduation_year || "—"}</td>
                        <td>{getStatusBadge(edu.status)}</td>
                        <td className="text-end">
                          <Link
                            to={`/hoc-van/${edu.id}`}
                            state={{ education: edu }}
                            className="btn btn-sm btn-outline-info me-1"
                            title="Xem chi tiết"
                          >
                            <FaEye />
                          </Link>
                          <Link
                            to={`/hoc-van/${edu.id}/edit`}
                            className="btn btn-sm btn-outline-primary me-1"
                            title="Chỉnh sửa"
                          >
                            <FaEdit />
                          </Link>
                          <Button
                            variant="outline-danger"
                            size="sm"
                            onClick={() => handleDelete(edu.id)}
                            title="Xóa"
                          >
                            <FaTrash />
                          </Button>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </Table>
              </div>

              {/* Pagination */}
              {totalPages > 1 && (
                <div className="d-flex justify-content-between align-items-center py-3 px-3">
                  <small className="text-muted">
                    Trang {currentPage} / {totalPages}
                  </small>
                  <Pagination className="mb-0">
                    <Pagination.First
                      onClick={() => setCurrentPage(1)}
                      disabled={currentPage === 1}
                    />
                    <Pagination.Prev
                      onClick={() => setCurrentPage((p) => p - 1)}
                      disabled={currentPage === 1}
                    />
                    {(() => {
                      const pages = [];
                      const maxVisible = 5;
                      let startPage = Math.max(
                        1,
                        currentPage - Math.floor(maxVisible / 2)
                      );
                      let endPage = Math.min(
                        totalPages,
                        startPage + maxVisible - 1
                      );

                      if (endPage - startPage + 1 < maxVisible) {
                        startPage = Math.max(1, endPage - maxVisible + 1);
                      }

                      for (let i = startPage; i <= endPage; i++) {
                        pages.push(
                          <Pagination.Item
                            key={i}
                            active={i === currentPage}
                            onClick={() => setCurrentPage(i)}
                          >
                            {i}
                          </Pagination.Item>
                        );
                      }
                      return pages;
                    })()}
                    <Pagination.Next
                      onClick={() => setCurrentPage((p) => p + 1)}
                      disabled={currentPage === totalPages}
                    />
                    <Pagination.Last
                      onClick={() => setCurrentPage(totalPages)}
                      disabled={currentPage === totalPages}
                    />
                  </Pagination>
                  <div style={{ width: "100px" }}></div>
                </div>
              )}
            </>
          )}
        </Card.Body>
      </Card>
    </Container>
  );
};

export default EducationListAllPage;
