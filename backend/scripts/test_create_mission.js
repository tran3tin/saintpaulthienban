const MissionModel = require("../src/models/MissionModel");
const SisterModel = require("../src/models/SisterModel");
const db = require("../src/config/database");

async function testCreateMission() {
  try {
    console.log("Starting Mission Creation Test...");

    // 1. Get a sister
    const sisters = await SisterModel.findAll({}, 1);
    if (sisters.length === 0) {
      console.error("No sisters found to assign mission to.");
      process.exit(1);
    }
    const sisterId = sisters[0].id;
    console.log(`Using Sister ID: ${sisterId}`);

    // 2. Prepare Payload
    const payload = {
      sister_id: sisterId,
      field: "education",
      specific_role: "Teacher",
      organization: "High School A",
      address: "123 Main St",
      start_date: "2023-01-01",
      notes: "Test mission creation",
      documents: JSON.stringify([
        { name: "test.pdf", url: "http://test.com/test.pdf" },
      ]),
    };

    console.log("Payload:", payload);

    // 3. Attempt Create
    const mission = await MissionModel.create(payload);
    console.log("Mission created successfully:", mission);
  } catch (error) {
    console.error("Mission Creation FAILED:");
    console.error(error);
  } finally {
    if (db.end) await db.end(); // Try to close pool
    process.exit();
  }
}

testCreateMission();
