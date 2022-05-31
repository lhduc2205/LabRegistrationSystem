const router = require('express').Router();

const accountController = require('../controllers/account_controller');
const lecturerController = require('../controllers/lecturer_controller');

router.get('/account/', accountController.getAll);
router.post('/account/login', accountController.login);
router.post('/account/register', accountController.create);
router.delete('/account/:email', accountController.delete);

router.get('/', lecturerController.getAll);
router.get('/:email', lecturerController.getSingle);
router.get('/:email/full-info', lecturerController.getFullInfo);
router.post('/', lecturerController.create);
router.put('/:id', lecturerController.update);
router.delete('/:id', lecturerController.delete);

// router.post('/login', );

module.exports = router;
