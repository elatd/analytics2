/* eslint-disable no-console */
require('dotenv').config();
const { execSync } = require('child_process');

try {
  console.log('Copying database files...');
  execSync('npm run copy-db-files', { stdio: 'inherit' });
  console.log('Applying database migrations...');
  execSync('npm run update-db', { stdio: 'inherit' });
  console.log('Database setup complete.');
} catch (err) {
  console.error('Database setup failed:', err.message);
  process.exit(1);
}
