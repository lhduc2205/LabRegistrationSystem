const router = require('express').Router();

const semesterAcademicController = require('../controllers/semester_academic_controller');
const SemesterDetailController = require('../controllers/semester_detail_controller');

router.get('/', semesterAcademicController.getAll);
router.get('/current', semesterAcademicController.getCurrent);
router.get('/detail', SemesterDetailController.getFull);
router.get('/detail/:semester/:week', SemesterDetailController.getSingle);
router.get('/date/:date', semesterAcademicController.getByDate);
router.get('/date/:date/full', semesterAcademicController.getFullByDate);
router.put('/:id', semesterAcademicController.update);

module.exports = router;
