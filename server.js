require('dotenv').config();
const express = require('express');
const morgan = require('morgan');

const app = express();
const PORT = 8080;

// import utils
const conn = require('./utils/db');
conn();

// middlewares
app.use(morgan('dev'));

app.listen(PORT, () => console.log(`Server running on PORT ${PORT}`));
