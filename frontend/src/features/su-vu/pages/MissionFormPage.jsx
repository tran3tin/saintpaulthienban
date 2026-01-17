// src/features/su-vu/pages/MissionFormPage.jsx

import React, { useState, useEffect } from "react";
import {
  Container,
  Card,
  Form,
  Button,
  Row,
  Col,
  Alert,
} from "react-bootstrap";
import { useParams, useNavigate } from "react-router-dom";
import { toast } from "react-toastify";
import { missionService, sisterService, uploadService } from "@services";
import { useForm } from "@hooks";
import Input from "@components/forms/Input";
import Select from "@components/forms/Select";
import DatePicker from "@components/forms/DatePicker";
import TextArea from "@components/forms/TextArea";
import SearchableSelect from "@components/forms/SearchableSelect";
import FileUpload from "@components/forms/FileUpload";
import LoadingSpinner from "@components/common/Loading/LoadingSpinner";
import Breadcrumb from "@components/common/Breadcrumb";
import "./MissionDetailPage.css";

const MissionFormPage = () => {
  const { id, sisterId } = useParams();
  const navigate = useNavigate();
  const isEditMode = !!id;

  const [loading, setLoading] = useState(false);
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState("");
  const [sisters, setSisters] = useState([]);

  const {
    values,
    errors,
    touched,
    handleChange,
    handleBlur,
    setFieldValue,
    setValues,
  } = useForm({
    sister_id: sisterId || "",
    field: "",
    specific_role: "",
    organization: "",
    address: "",
    start_date: "",
    end_date: "",
    notes: "",
    documents: [],
  });

  useEffect(() => {
    fetchSisters();
    if (isEditMode) {
      fetchMission();
    }
  }, [id]);

  const fetchSisters = async () => {
    try {
      const response = await sisterService.getList({
        limit: 1000,
        status: "all",
      });
      if (response.success) {
        const items = response.data?.items || response.data || [];
        setSisters(items);
      }
    } catch (error) {
      console.error("Error fetching sisters:", error);
    }
  };

  const fetchMission = async () => {
    try {
      setLoading(true);
      const response = await missionService.getById(id);
      if (response.success && response.data) {
        const mission = response.data.data || response.data;
        setValues({
          sister_id: mission.sister_id || "",
          field: mission.field || "",
          specific_role: mission.specific_role || "",
          organization: mission.organization || "",
          address: mission.address || "",
          start_date: mission.start_date
            ? mission.start_date.split("T")[0]
            : "",
          // Ignore invalid end_date (before 1900)
          end_date:
            mission.end_date && new Date(mission.end_date).getFullYear() >= 1900
              ? mission.end_date.split("T")[0]
              : "",
          notes: mission.notes || "",
          documents: mission.documents || [],
        });
      } else {
        toast.error("Không tìm thấy sứ vụ");
        navigate("/su-vu");
      }
    } catch (error) {
      console.error("Error fetching mission:", error);
      toast.error("Lỗi khi tải thông tin sứ vụ");
      navigate("/su-vu");
    } finally {
      setLoading(false);
    }
  };

  const validate = () => {
    const newErrors = {};
    if (!values.sister_id && !sisterId)
      newErrors.sister_id = "Nữ tu là bắt buộc";
    if (!values.field) newErrors.field = "Lĩnh vực sứ vụ là bắt buộc";
    if (!values.start_date) newErrors.start_date = "Ngày bắt đầu là bắt buộc";

    // Validate end_date > start_date
    if (values.end_date && values.start_date) {
      const start = new Date(values.start_date);
      const end = new Date(values.end_date);
      if (end <= start) {
        newErrors.end_date = "Ngày kết thúc phải lớn hơn ngày bắt đầu";
        toast.error("Ngày kết thúc phải lớn hơn ngày bắt đầu");
      }
    }

    // Validate end_date <= today
    if (values.end_date) {
      const end = new Date(values.end_date);
      const today = new Date();
      today.setHours(0, 0, 0, 0); // Reset time to start of day
      end.setHours(0, 0, 0, 0);

      if (end > today) {
        newErrors.end_date = "Ngày kết thúc không được lớn hơn ngày hôm nay";
        toast.error("Ngày kết thúc không được lớn hơn ngày hôm nay");
      }
    }

    return newErrors;
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    const validationErrors = validate();
    if (Object.keys(validationErrors).length > 0) {
      Object.values(validationErrors).forEach((err) => toast.error(err));
      return;
    }

    try {
      setSubmitting(true);
      const payload = {
        ...values,
        sister_id: sisterId || values.sister_id,
        // Send null for empty end_date to allow clearing the date
        end_date: values.end_date || null,
      };

      let result;
      if (isEditMode) {
        result = await missionService.update(id, payload);
      } else {
        result = await missionService.create(payload);
      }

      if (result.success) {
        toast.success(
          isEditMode ? "Cập nhật sứ vụ thành công!" : "Thêm sứ vụ thành công!",
        );
        if (sisterId) {
          navigate(`/nu-tu/${sisterId}/su-vu`);
        } else {
          navigate("/su-vu");
        }
      } else {
        toast.error(result.error || "Đã xảy ra lỗi");
      }
    } catch (error) {
      console.error("Error saving mission:", error);
      toast.error("Đã xảy ra lỗi khi lưu sứ vụ");
    } finally {
      setSubmitting(false);
    }
  };

  const handleCancel = () => {
    if (sisterId) {
      navigate(`/nu-tu/${sisterId}/su-vu`);
    } else {
      navigate("/su-vu");
    }
  };

  const handleAddDocument = async (event) => {
    const files = event.target?.value;
    if (!files || files.length === 0) return;

    try {
      // Upload files to server
      const result = await uploadService.uploadDocuments(files);
      if (result.success && result.files) {
        // Convert uploaded files to document objects
        const newDocs = result.files.map((file) => ({
          url: file.url,
          name: file.originalName || file.name,
          size: file.size,
          uploaded_at: new Date().toISOString(),
        }));

        setFieldValue("documents", [...values.documents, ...newDocs]);
        toast.success(`Đã tải lên ${newDocs.length} tệp thành công`);
      } else {
        toast.error(result.error || "Không thể tải tệp lên");
      }
    } catch (error) {
      console.error("Error uploading documents:", error);
      toast.error("Có lỗi xảy ra khi tải tệp lên");
    }
  };

  const handleRemoveDocument = (index) => {
    const newDocuments = values.documents.filter((_, i) => i !== index);
    setFieldValue("documents", newDocuments);
  };

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

  return (
    <Container fluid className="py-4">
      <Breadcrumb
        title={isEditMode ? "Chỉnh sửa Sứ vụ" : "Thêm Sứ vụ Mới"}
        items={[
          { label: "Quản lý Sứ vụ", link: "/su-vu" },
          { label: isEditMode ? "Chỉnh sửa" : "Thêm mới" },
        ]}
      />

      {/* Error Alert */}
      {error && (
        <Alert variant="danger" dismissible onClose={() => setError("")}>
          <i className="fas fa-exclamation-circle me-2"></i>
          {error}
        </Alert>
      )}

      <Form onSubmit={handleSubmit}>
        <Row className="g-4">
          <Col lg={8}>
            <Card className="health-info-card">
              <Card.Header>
                <i className="fas fa-info-circle"></i>
                <span>Thông tin sứ vụ</span>
              </Card.Header>
              <Card.Body>
                <Row className="g-3">
                  {/* Sister selector - only show if sisterId not provided */}
                  {!sisterId && (
                    <Col md={12}>
                      <SearchableSelect
                        label="Nữ tu"
                        name="sister_id"
                        value={values.sister_id}
                        onChange={handleChange}
                        onBlur={handleBlur}
                        error={errors.sister_id}
                        touched={touched.sister_id}
                        required
                        disabled={isEditMode}
                        placeholder="Nhập tên để tìm nữ tu..."
                        maxDisplayItems={5}
                        options={(sisters || []).map((sister) => ({
                          value: sister.id,
                          label: `${
                            sister.saint_name ? `${sister.saint_name} ` : ""
                          }${sister.birth_name}`,
                        }))}
                      />
                    </Col>
                  )}

                  <Col md={6}>
                    <Input
                      label="Lĩnh vực sứ vụ"
                      name="field"
                      value={values.field}
                      onChange={handleChange}
                      onBlur={handleBlur}
                      error={errors.field}
                      touched={touched.field}
                      required
                      placeholder="Nhập lĩnh vực sứ vụ..."
                    />
                  </Col>

                  <Col md={6}>
                    <Input
                      label="Vai trò cụ thể"
                      name="specific_role"
                      value={values.specific_role}
                      onChange={handleChange}
                      onBlur={handleBlur}
                      placeholder="VD: Giáo viên, Y tá, Quản lý..."
                    />
                  </Col>

                  <Col md={6}>
                    <Input
                      label="Tổ chức"
                      name="organization"
                      value={values.organization}
                      onChange={handleChange}
                      onBlur={handleBlur}
                      placeholder="VD: Trường THPT, Bệnh viện..."
                    />
                  </Col>

                  <Col md={6}>
                    <Input
                      label="Địa chỉ"
                      name="address"
                      value={values.address}
                      onChange={handleChange}
                      onBlur={handleBlur}
                      placeholder="Địa chỉ nơi làm việc..."
                    />
                  </Col>

                  <Col md={6}>
                    <DatePicker
                      label="Ngày bắt đầu"
                      name="start_date"
                      value={values.start_date}
                      onChange={(date) => setFieldValue("start_date", date)}
                      onBlur={handleBlur}
                      error={errors.start_date}
                      touched={touched.start_date}
                      required
                    />
                  </Col>

                  <Col md={6}>
                    <DatePicker
                      label="Ngày kết thúc"
                      name="end_date"
                      value={values.end_date}
                      onChange={(date) => setFieldValue("end_date", date)}
                      onBlur={handleBlur}
                      error={errors.end_date}
                      touched={touched.end_date}
                      hint="Để trống nếu đang làm"
                    />
                  </Col>

                  <Col md={12}>
                    <TextArea
                      label="Ghi chú"
                      name="notes"
                      value={values.notes}
                      onChange={handleChange}
                      onBlur={handleBlur}
                      rows={4}
                      placeholder="Ghi chú thêm về sứ vụ..."
                    />
                  </Col>
                </Row>
              </Card.Body>
            </Card>
          </Col>

          {/* Documents */}
          <Col lg={4}>
            <Card className="health-info-card">
              <Card.Header className="documents-header">
                <i className="fas fa-file-alt"></i>
                <span>Tài liệu đính kèm</span>
              </Card.Header>
              <Card.Body>
                <FileUpload
                  label="Tải lên tài liệu"
                  accept=".pdf,.doc,.docx,.jpg,.jpeg,.png"
                  maxSize={10 * 1024 * 1024}
                  onChange={handleAddDocument}
                  multiple
                />

                {values.documents && values.documents.length > 0 && (
                  <div className="mt-3">
                    <h6 className="mb-2">
                      Danh sách tài liệu ({values.documents.length}):
                    </h6>
                    <div className="document-list">
                      {values.documents.map((doc, index) => (
                        <div
                          key={index}
                          className="document-item d-flex align-items-center justify-content-between p-2 border rounded mb-2"
                        >
                          <div className="d-flex align-items-center flex-grow-1 me-2">
                            <i className="fas fa-file-pdf text-danger me-2"></i>
                            <div className="text-truncate">
                              <div
                                className="fw-medium text-truncate"
                                style={{ maxWidth: "180px" }}
                              >
                                {doc.name}
                              </div>
                              {doc.size && (
                                <small className="text-muted">
                                  {(doc.size / 1024).toFixed(2)} KB
                                </small>
                              )}
                            </div>
                          </div>
                          <div className="d-flex gap-1">
                            {doc.url && (
                              <>
                                <Button
                                  variant="outline-success"
                                  size="sm"
                                  href={doc.url}
                                  download={doc.name}
                                  title="Tải xuống"
                                >
                                  <i className="fas fa-download"></i>
                                </Button>
                              </>
                            )}
                            <Button
                              variant="outline-danger"
                              size="sm"
                              onClick={() => handleRemoveDocument(index)}
                              title="Xóa"
                            >
                              <i className="fas fa-times"></i>
                            </Button>
                          </div>
                        </div>
                      ))}
                    </div>
                  </div>
                )}
              </Card.Body>
            </Card>

            {/* Action Buttons */}
            <Card className="health-info-card mt-4">
              <Card.Header className="system-header">
                <i className="fas fa-check-circle"></i>
                <span>Thao tác</span>
              </Card.Header>
              <Card.Body>
                <div className="d-grid gap-2">
                  <Button
                    type="submit"
                    variant="primary"
                    size="lg"
                    disabled={submitting}
                  >
                    {submitting ? (
                      <>
                        <span className="spinner-border spinner-border-sm me-2"></span>
                        Đang lưu...
                      </>
                    ) : (
                      <>
                        <i className="fas fa-save me-2"></i>
                        {isEditMode ? "Cập nhật" : "Tạo mới"}
                      </>
                    )}
                  </Button>
                  <Button
                    type="button"
                    variant="secondary"
                    size="lg"
                    onClick={handleCancel}
                    disabled={submitting}
                  >
                    <i className="fas fa-times me-2"></i>
                    Hủy
                  </Button>
                </div>
              </Card.Body>
            </Card>
          </Col>
        </Row>
      </Form>
    </Container>
  );
};

export default MissionFormPage;
