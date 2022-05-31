const router = require('express').Router();

const GaController = require('../controllers/ga_controller');

// router.get('/', gaController.timetabling);
router.get('/', GaController.scheduling);

module.exports = router;
