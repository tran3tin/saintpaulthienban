const CommunityController = require("../src/controllers/communityController");
const pool = require("../src/config/database");

// Mock request and response
const req = {
  params: { id: 16 }, // The ID from the user report
  userScope: { /* minimal mock of user scope */ role: "admin" },
  user: { id: 1, role: "admin" },
};

const res = {
  status: function (code) {
    console.log(`Status: ${code}`);
    return this;
  },
  json: function (data) {
    console.log("JSON response:", JSON.stringify(data, null, 2));
    return this;
  },
};

async function run() {
  try {
    console.log("Testing getCommunityEvents...");
    await CommunityController.getCommunityEvents(req, res);
  } catch (err) {
    console.error("Caught error:", err);
  } finally {
    pool.end();
  }
}

run();
