// Load the http module to create an http server.
var http = require('http');

function init(request, response) {
  response.setHeader('Access-Control-Allow-Origin', 'http://localhost:8000');
  if (request.url == "/dinosaur") {
    response.writeHead(200, {"Content-Type": "application/json"});
    response.end("{\"name\":\"Rexik\",\"armLength\":1,\"wayToKill\":\"Devouring\"}");
  } else {
      response.writeHead(200, {"Content-Type": "application/json"});
      response.end("{\"teethCount\":15623266,\"wayToKill\":\"Chewing\"}");
  }
}

// Configure our HTTP server to respond with Hello World to all requests.
var server = http.createServer(function (request, response) {
  setTimeout(function() {init(request, response);}, 3000);
});

// Listen on port 8000, IP defaults to 127.0.0.1
server.listen(8200);

// Put a friendly message on the terminal
console.log("Server running at http://127.0.0.1:8200/");
