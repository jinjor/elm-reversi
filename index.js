const express = require('express');
const ws = require('ws');

const app = express();

app.use(express.static('docs'));

app.listen(3000, () => {
  console.log('Reversi server listening on port 3000!');
});

const WebSocketServer = ws.Server;
const wss = new WebSocketServer({ port: 3001 });
wss.on('connection', ws => {
  ws.on('message', (data, flags) => {
    wss.clients.forEach(client => {
      client.send(data);
    });
  });
});
