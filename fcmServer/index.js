const { HttpError } = require('http-errors');
const app = require('./app');
const http = require('http');

http.createServer(app).listen(8080, () => {
    console.log('this server running on 8080');
});