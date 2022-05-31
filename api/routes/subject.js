const router = require('express').Router();

const subjectController = require('../controllers/subject_controller');

router.get('/', subjectController.getAll);

module.exports = router;
