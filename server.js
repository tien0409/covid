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

// require('./seeder');
// routes
const vaccineRoute = require('./routes/vaccine.route');
const userRoute = require('./routes/user.route');
const infectedSubjectRoute = require('./routes/infected-subject.route');
const provinceRoute = require('./routes/province.route');
const adminRoute = require('./routes/admin.route');

app.use('/api/vaccines', vaccineRoute),
app.use('/api/users', userRoute);
app.use('/api/infected-subject', infectedSubjectRoute);
app.use('/api/provinces', provinceRoute);
app.use('/api/admin', adminRoute);

app.listen(PORT, () => console.log(`Server running on PORT ${PORT}`));
