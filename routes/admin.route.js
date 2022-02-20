const express = require('express');
const router = express.Router();

const controllers = require('../controllers/admin.controller');

router.post('/login', controllers.login);
router.get('/currentUser', controllers.currentUser);

module.exports = router;
