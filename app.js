const http = require('http');
const os = require('os');

const hostname = '0.0.0.0';
const port = 3000;

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('DevOps Project Running on ' + os.hostname());
});

server.listen(port, hostname, () => {
  console.log(`Server running`);
});
