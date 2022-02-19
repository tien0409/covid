require('dotenv').config();
const express = require('express');
const morgan = require('morgan');
const cors = require('cors');

const app = express();
const PORT = 8080;

// middlewares
app.use(morgan('dev'));
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({extended: true}));

// routes
const vaccineRoute = require('./routes/vaccine.route');
const userRoute = require('./routes/user.route');

app.use('/api/vaccines', vaccineRoute),
app.use('/api/users', userRoute);

app.listen(PORT, () => console.log(`Server running on PORT ${PORT}`));
