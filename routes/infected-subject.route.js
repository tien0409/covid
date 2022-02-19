const express = require('express');
const router = express.Router();

const controllers = require('../controllers/infected-subject.controller');

router.get('/', controllers.getVaccines);

module.exports = router;
