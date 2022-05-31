const CourseService = require('../services/course_service');
const LecturerService = require('../services/lecturer_service');
const SemesterService = require('../services/semester_academic_service');
const format = require('date-format');

class CourseController {
    async getAll(req, res) {
        try {
            const result = await CourseService.getAll();
            res.status(200).json(result);
        } catch (err) {
            console.error(err);
            res.status(500).json('Lỗi! Không thể xem dữ liệu giảng dạy');
        }
    }

    async getByEmail(req, res) {
        try {
            const result = await CourseService.getByEmail(req.params.email);
            res.status(200).json(result);
        } catch (err) {
            console.error(err);
            res.status(500).json('Lỗi! Không thể xem dữ liệu giảng dạy');
        }
    }

    async create(req, res) {
        try {
            const result = await CourseService.create(req.body);
            res.status(201).json(result);
        } catch (err) {
            console.error(err);
            res.status(500).json('Lỗi! Không thể xem dữ liệu giảng dạy');
        }
    }

    uploadSingle() {
        return CourseService.upload().single('course');
    }

    async readFile(req, res, next) {
        const file = req.file;

        if (!file) {
            const error = new Error('Please upload a file');
            error.httpStatusCode = 400;
            return next(error);
        }

        try {
            const result = await CourseService.readFile(file);

            res.status(200).json(result);
        } catch (error) {
            console.error(error);
            res.status(500).json('Lỗi! Không thể đọc file.');
        }
    }

    async getSample(req, res) {
        try {
            const dateFormat = format.asString('MM-dd-yyyy', new Date());
            const course = await CourseService.getJoinByEmail(req.params.email);
            const lecturer = await LecturerService.getFullInfo(
                req.params.email,
            );
            const semester = await SemesterService.getByDate(dateFormat);
            const fileName = await CourseService.getSample(
                course,
                lecturer,
                semester,
            );
            res.status(200).download(fileName);
        } catch (error) {
            console.error(error);
            res.status(500).json('Lỗi! Không thể đọc file.');
        }
    }
}

module.exports = new CourseController();
