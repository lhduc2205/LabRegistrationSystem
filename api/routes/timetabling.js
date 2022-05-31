const router = require('express').Router();

const TimetablingController = require('../controllers/timetabling_controller');

// Timetable
router.get('/', TimetablingController.getAll);
router.get('/scheduling', TimetablingController.scheduling);
router.post('/check-available-room', TimetablingController.checkAvailableRoom);
router.post('/create', TimetablingController.createTimetable);
router.post(
    '/upload',
    TimetablingController.uploadSingle(),
    TimetablingController.readFile,
    // function(req, res) {console.log(req.file);}
);

// Timetable clone
router.get('/clone', TimetablingController.getClone);
router.get('/clone/basic', TimetablingController.getCloneBasic);
router.get('/clone/full', TimetablingController.getCloneFull);
router.get('/clone/save', TimetablingController.saveToOfficial);
router.put('/clone/update', TimetablingController.updateClone);
router.put(
    '/update/draggable',
    TimetablingController.updateTimetableWithDraggable,
);

// Registration
router.get('/registration', TimetablingController.getRegistration);
router.get(
    '/registration/no-format',
    TimetablingController.getRegistrationNoFormat,
);
router.post('/registration', TimetablingController.register);
router.put('/update', TimetablingController.updateTimetable);
router.delete('/registration', TimetablingController.deleteRegistration);

// Group
router.get('/group', TimetablingController.getGroup);
router.put('/group', TimetablingController.updateGroup);

// With Params
router.get('/:email', TimetablingController.getByEmail);
router.get(
    '/registration/week/:week',
    TimetablingController.getRegistrationByWeek,
);
router.get('/lecturer/:email', TimetablingController.getByEmail);
router.get(
    '/registration/:email',
    TimetablingController.getRegistrationByEmail,
);
router.get('/group/lecturer/:email', TimetablingController.getGroupByLecturer);
router.get(
    '/registration/:email',
    TimetablingController.getRegistrationByEmail,
);

module.exports = router;
