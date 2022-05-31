const router = require('express').Router();

const WeekController = require('../controllers/week_controller');

router.get('/', WeekController.getAll);
router.get('/:id', WeekController.getById);

module.exports = router;
