const { HttpError } = require('http-errors');
const app = require('./app');
const http = require('http');
const scheduler = require("./routes/scheduler");

const { PORT } = process.env;

scheduler.schedulerfun;

http.createServer(app).listen(PORT || 8080, () => {
    console.log('this server running on 8080');
});