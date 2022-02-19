require('dotenv').config();
const express = require('express');
const morgan = require('morgan');
const cors = require('cors');
const mssql = require('mssql');

const app = express();
const PORT = 8080;

// import utils
const conn = require('./utils/db');
conn(mssql);

// middlewares
app.use(morgan('dev'));
app.use(cors());

// routes
const vaccineRoute = require('./routes/vaccine.route');
const userRoute = require('./routes/user.route');

app.use('/api/vaccines', vaccineRoute),
app.use('/api/users', userRoute);

app.listen(PORT, () => console.log(`Server running on PORT ${PORT}`));
