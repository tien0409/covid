require('dotenv').config();
const express = require('express');

const app = express();
const PORT = 8080;

// import utils
const conn = require('./utils/db');
conn();

app.listen(PORT, () => console.log(`Server running on PORT ${PORT}`));
