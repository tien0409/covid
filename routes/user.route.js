const express = require('express');
const router = express.Router();

const controllers = require('../controllers/user.controller');

router.post('/national', controllers.createNationalForm);
router.post('/domestic', controllers.createDomesticForm);
router.post('/entry', controllers.createEntryForm);

module.exports = router;
