const router = require('express').Router();

const labController = require('../controllers/lab_controller');

router.get('/', labController.getAll);
// router.get('/:id', labController.get);
// router.post('/', labController.create);
// router.put('/:id', labController.update);x`

module.exports = router;
