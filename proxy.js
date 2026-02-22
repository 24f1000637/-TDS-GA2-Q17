const http = require("http");

const TARGET_PORT = 8003;

const proxy = http.createServer((req, res) => {
  const options = {
    hostname: "localhost",
    port: TARGET_PORT,
    path: req.url,
    method: req.method,
    headers: {
      ...req.headers,

      // 🔥 CRITICAL: force browser UA
      "user-agent":
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/120 Safari/537.36",
    },
  };

  const proxyReq = http.request(options, (proxyRes) => {
    res.writeHead(proxyRes.statusCode, proxyRes.headers);
    proxyRes.pipe(res, { end: true });
  });

  req.pipe(proxyReq, { end: true });
});

proxy.listen(8004, () => {
  console.log("Proxy running on 8004");
});
