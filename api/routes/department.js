const router = require('express').Router();
// var jwt = require('jsonwebtoken');

const departmentController = require('../controllers/department_controller');

router.get('/', departmentController.getAll);
router.get('/:id', departmentController.get);
router.post('/', departmentController.create);
router.put('/:id', departmentController.update);
router.delete('/:id', departmentController.delete);

// router.get('/:id', departmentController.);

module.exports = router;
