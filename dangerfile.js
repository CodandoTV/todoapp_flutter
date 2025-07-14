// dangerfile.js
const { danger, fail, warn, message } = require("danger");

// Check for changes in test files
const testFilesChanged = danger.git.modified_files
  .concat(danger.git.created_files)
  .some(file => file.includes("test"));

if (!testFilesChanged) {
  warn("This PR doesn’t appear to include any test changes. Please consider adding or updating tests.");
} else {
  message("Thanks for adding unit tests")
}