const express = require('express');
const router = express.Router();

const controllers = require('../controllers/user.controller');

router.post('/national', controllers.createNationalForm);
router.get('/national', controllers.getAllNationalForm);
router.get('/national/:id', controllers.getNationalForm);

router.post('/domestic', controllers.createDomesticForm);
router.get('/domestic', controllers.getALlDomestic);

router.post('/entry', controllers.createEntryForm);
router.get('/entry', controllers.getAllEntry);

router.post('/history', controllers.getHistory);
module.exports = router;
