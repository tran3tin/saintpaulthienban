const express = require("express");
const communityController = require("../controllers/communityController");
const { authenticateToken, checkPermission } = require("../middlewares/auth");
const { attachDataScope } = require("../middlewares/dataScope");
const { uploadDecision } = require("../middlewares/upload");
const {
  validateCommunityCreate,
  validateCommunityUpdate,
  handleValidationErrors,
} = require("../middlewares/validation");

const router = express.Router();

router.use(authenticateToken);
router.use(attachDataScope);

router.get(
  "/",
  checkPermission("communities.view"),
  communityController.getAllCommunities
);
router.get(
  "/:id",
  checkPermission("communities.view"),
  communityController.getCommunityById
);
router.get(
  "/:id/members",
  checkPermission("communities.view"),
  communityController.getCommunityMembers
);

router.post(
  "/",
  checkPermission("communities.create"),
  validateCommunityCreate,
  handleValidationErrors,
  communityController.createCommunity
);

router.put(
  "/:id",
  checkPermission("communities.update"),
  validateCommunityUpdate,
  handleValidationErrors,
  communityController.updateCommunity
);

router.delete(
  "/:id",
  checkPermission("communities.delete"),
  communityController.deleteCommunity
);

// Member management routes
router.post(
  "/:id/members",
  checkPermission("communities.update"),
  uploadDecision,
  communityController.addMember
);

router.put(
  "/:id/members/:memberId",
  checkPermission("communities.update"),
  uploadDecision,
  communityController.updateMemberRole
);

router.delete(
  "/:id/members/:memberId",
  checkPermission("communities.update"),
  communityController.removeMember
);

module.exports = router;
