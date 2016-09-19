var express = require('express');
var ws = require('ws');

var app = express();

app.use(express.static('docs'));

app.listen(3000, function () {
  console.log('Reversi server listening on port 3000!');
});

var WebSocketServer = ws.Server;
var wss = new WebSocketServer({ port: 3001 });
wss.on('connection', (ws) => {
  ws.on('message', (data, flags) => {
    wss.clients.forEach((client) => {
      client.send(data);
    });
  });
});
