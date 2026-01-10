/**
 * Script to sync sisters.current_community_id from community_assignments
 *
 * Logic:
 * - Lấy community_id từ community_assignments với end_date IS NULL hoặc end_date >= CURRENT_DATE
 * - Nếu có nhiều assignments, lấy cái có start_date mới nhất
 * - Cập nhật vào sisters.current_community_id
 */

const db = require("../src/config/database");

async function syncCurrentCommunityIds() {
  let connection;
  try {
    console.log("🔄 Starting sync of sisters.current_community_id...");

    connection = await db.getConnection();

    // Get all current community assignments
    const { rows: assignments } = await connection.query(`
      SELECT 
        ca.sister_id,
        ca.community_id,
        ca.start_date,
        ROW_NUMBER() OVER (PARTITION BY ca.sister_id ORDER BY ca.start_date DESC) as rn
      FROM community_assignments ca
      WHERE ca.end_date IS NULL OR ca.end_date >= CURRENT_DATE
    `);

    console.log(`📊 Found ${assignments.length} current community assignments`);

    // Filter to get only the latest assignment per sister
    const latestAssignments = assignments.filter((a) => a.rn === 1);
    console.log(
      `📊 ${latestAssignments.length} sisters have current community`
    );

    // Update each sister
    let updated = 0;
    for (const assignment of latestAssignments) {
      const result = await connection.query(
        `
        UPDATE sisters
        SET current_community_id = $1
        WHERE id = $2 AND (current_community_id IS NULL OR current_community_id <> $1)
      `,
        [assignment.community_id, assignment.sister_id]
      );

      if (result.rowCount > 0) {
        updated++;
        console.log(
          `   ✅ Sister ${assignment.sister_id} -> Community ${assignment.community_id}`
        );
      }
    }

    // Set NULL for sisters without current assignment
    const { rows: sistersWithoutAssignment } = await connection.query(`
      SELECT s.id, s.religious_name, s.birth_name
      FROM sisters s
      WHERE s.current_community_id IS NOT NULL
      AND s.id NOT IN (
        SELECT DISTINCT sister_id FROM community_assignments 
        WHERE end_date IS NULL OR end_date >= CURRENT_DATE
      )
    `);

    for (const sister of sistersWithoutAssignment) {
      await connection.query(
        `
        UPDATE sisters SET current_community_id = NULL WHERE id = $1
      `,
        [sister.id]
      );
      console.log(
        `   ⚠️ Sister ${sister.id} (${sister.religious_name} ${sister.birth_name}) - cleared community (no current assignment)`
      );
    }

    console.log(`\n✅ Sync complete:`);
    console.log(`   - Updated: ${updated} sisters`);
    console.log(`   - Cleared: ${sistersWithoutAssignment.length} sisters`);

    // Verify
    const { rows: verifyResult } = await connection.query(`
      SELECT 
        s.id, 
        s.religious_name, 
        s.birth_name, 
        s.current_community_id,
        c.name as community_name
      FROM sisters s
      LEFT JOIN communities c ON s.current_community_id = c.id
      ORDER BY s.id
      LIMIT 20
    `);

    console.log(`\n📋 Current state (first 20 sisters):`);
    verifyResult.forEach((s) => {
      console.log(
        `   ID ${s.id}: ${s.religious_name} ${s.birth_name} -> ${
          s.community_name || "No community"
        }`
      );
    });
  } catch (error) {
    console.error("❌ Error:", error.message);
    console.error(error.stack);
  } finally {
    if (connection) {
      connection.release();
    }
    process.exit(0);
  }
}

syncCurrentCommunityIds();
