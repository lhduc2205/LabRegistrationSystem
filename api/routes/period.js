const router = require('express').Router();

const periodController = require('../controllers/period_controller');

router.get('/', periodController.getAll);
router.delete('/:id', periodController.deleteSingle);

module.exports = router;
