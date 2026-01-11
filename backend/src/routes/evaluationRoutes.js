const express = require("express");
const evaluationController = require("../controllers/evaluationController");
const { authenticateToken, checkPermission } = require("../middlewares/auth");
const { attachDataScope } = require("../middlewares/dataScope");

const router = express.Router();

router.use(authenticateToken);
router.use(attachDataScope);

router.get(
  "/",
  checkPermission("evaluations.view"),
  evaluationController.getEvaluations
);

router.get(
  "/sister/:sisterId",
  checkPermission("evaluations.view"),
  evaluationController.getEvaluationsBySister
);

router.get(
  "/:id",
  checkPermission("evaluations.view"),
  evaluationController.getEvaluationById
);

router.post(
  "/",
  checkPermission("evaluations.create"),
  evaluationController.createEvaluation
);

router.put(
  "/:id",
  checkPermission("evaluations.update"),
  evaluationController.updateEvaluation
);

router.delete(
  "/:id",
  checkPermission("evaluations.delete"),
  evaluationController.deleteEvaluation
);

router.get(
  "/:id/export",
  checkPermission("evaluations.view"),
  evaluationController.exportEvaluationPDF
);

module.exports = router;
