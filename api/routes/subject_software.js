const router = require('express').Router();

const SubjectSoftwareController = require('../controllers/subject_software_controller');

router.get('/', SubjectSoftwareController.getAll);
router.get('/:id', SubjectSoftwareController.getSingle);
router.post('/', SubjectSoftwareController.create);
router.put('/:id', SubjectSoftwareController.update);
router.delete('/:id', SubjectSoftwareController.delete);

module.exports = router;
