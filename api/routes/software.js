const router = require('express').Router();

const softwareController = require('../controllers/software_controller');

router.get('/', softwareController.getAll);

module.exports = router;
