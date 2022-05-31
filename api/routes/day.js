const router = require('express').Router();

const dayController = require('../controllers/day_controller');

router.get('/', dayController.getAll);

module.exports = router;
