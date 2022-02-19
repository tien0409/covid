const express = require("express");
const router = express.Router();

const controllers = require("../controllers/vaccine.controller");

router.get("/", controllers.getVaccines);

module.exports = router;
