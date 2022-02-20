const express = require('express');
const router = express.Router();

const controllers = require('../controllers/vaccine.controller');

router.get('/', controllers.getVaccines);
router.post('/', controllers.createVaccine);
router.get('/:id', controllers.getVaccine);
router.put('/:id', controllers.updateVaccine);
router.delete('/:id', controllers.deleteVaccine);

module.exports = router;
