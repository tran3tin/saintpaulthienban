/**
 * Script to generate properly formatted FIREBASE_SERVICE_ACCOUNT env var for Render/Cloud platforms
 * Run: node backend/scripts/generate_firebase_env.js
 */

const fs = require('fs');
const path = require('path');

// Read the .env file
const envPath = path.join(__dirname, '../.env');
const envContent = fs.readFileSync(envPath, 'utf8');

// Extract FIREBASE_SERVICE_ACCOUNT value
const match = envContent.match(/FIREBASE_SERVICE_ACCOUNT=(.+)/);

if (!match) {
  console.error('❌ FIREBASE_SERVICE_ACCOUNT not found in .env file');
  process.exit(1);
}

const firebaseConfig = match[1].trim();

// Validate it's valid JSON
try {
  const parsed = JSON.parse(firebaseConfig);
  console.log('✅ Valid Firebase configuration found\n');
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  console.log('📋 COPY THIS VALUE TO RENDER ENVIRONMENT VARIABLE:');
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');
  console.log('Variable Name: FIREBASE_SERVICE_ACCOUNT');
  console.log('\nVariable Value:\n');
  console.log(firebaseConfig);
  console.log('\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');
  console.log('🔍 Preview (first 200 chars):');
  console.log(firebaseConfig.substring(0, 200) + '...\n');
  console.log('📦 Project ID:', parsed.project_id);
  console.log('📧 Client Email:', parsed.client_email);
  console.log('\n✅ Configuration is ready to use!');
} catch (error) {
  console.error('❌ Invalid JSON format:', error.message);
  console.error('\nRaw value:', firebaseConfig.substring(0, 200) + '...');
  process.exit(1);
}
