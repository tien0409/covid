const express = require('express');
const router = express.Router();

const controllers = require('../controllers/user.controller');

router.post('/national', controllers.createNationalForm);

module.exports = router;
