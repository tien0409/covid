const express = require('express');
const router = express.Router();

const controllers = require('../controllers/province.controller');

router.get('/', controllers.getProvinces);

module.exports = router;
