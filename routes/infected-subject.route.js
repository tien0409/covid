const express = require('express');
const router = express.Router();

const controllers = require('../controllers/infected-subject.controller');

router.get('/', controllers.getInfectedSubjects);

router.get('/symptoms', controllers.getSymptoms);
router.get('/symptoms/:id', controllers.getSymptom);
router.put('/symptoms/:id', controllers.updateSymptom);
router.post('/symptoms', controllers.createSymptom);
router.delete('/symptoms/:id', controllers.removeSymptom);

router.get('/cscl', controllers.getCSCL);

module.exports = router;
