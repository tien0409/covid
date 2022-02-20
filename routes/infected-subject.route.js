const express = require('express');
const router = express.Router();

const controllers = require('../controllers/infected-subject.controller');

router.get('/', controllers.getInfectedSubjects);
router.get('/symptoms', controllers.getSymptoms);
router.get('/cscl', controllers.getCSCL);

module.exports = router;
