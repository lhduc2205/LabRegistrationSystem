const router = require('express').Router();

const courseController = require('../controllers/course_controller');

router.get('/', courseController.getAll);
router.get('/lecturer/:email', courseController.getByEmail);

router.get('/download/:email', courseController.getSample);

router.post(
    '/upload',
    courseController.uploadSingle(),
    courseController.readFile,
    // function(req, res) {console.log(req.file);}
);

router.post('/', courseController.create);

// const upload = require('../services/upload_service').upload();
// const upload = ;

// const array1 = [1, 2, 3, 4, 1, 2, 5, 1];
// const newArray = [...new Set(array1)];
// let result = [];

// for(let i = 0; i < newArray.length; i++) {
// 	const filter = array1.filter((e) => e == newArray[i]);
//   	result.push(filter)
// }

// result.map((e) => {
//   	console.log(e.length);
// });

module.exports = router;
