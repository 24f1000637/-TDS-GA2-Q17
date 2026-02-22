const http = require("http");
http
  .createServer((req, res) => {
    res.writeHead(200, { "Content-Type": "text/plain" });
    res.end("24f1000637@ds.study.iitm.ac.in");
  })
  .listen(8003);
