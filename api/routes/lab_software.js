const router = require('express').Router();

const labSoftwareController = require('../controllers/lab_software_controller');

router.get('/', labSoftwareController.getAll);
router.get('/:id', labSoftwareController.getSingle);
router.post('/', labSoftwareController.create);
router.put('/:id', labSoftwareController.update);
router.delete('/:id', labSoftwareController.delete);

module.exports = router;
