// Price History of Any ASIN – Node.js example (Node 18+, ES module)
// Usage: ASIN_API_KEY=your-key node asin_history.mjs

const headers = { Authorization: `Bearer ${process.env.ASIN_API_KEY}`, "Content-Type": "application/json" };

const params = new URLSearchParams({
  "asin": "B09DFCB66S",
  "marketplace": "com",
  "days": "90",
});
const response = await fetch(`https://www.asin.dev/api/v1/history?${params}`, { headers });
if (!response.ok) {
  console.error(`HTTP ${response.status}: ${await response.text()}`);
  process.exit(1);
}

console.log(JSON.stringify(await response.json(), null, 2));
