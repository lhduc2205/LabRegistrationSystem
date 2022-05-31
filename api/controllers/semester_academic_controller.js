const semesterAcademicService = require('../services/semester_academic_service');

class SemesterAcademicController {
    async getAll(req, res) {
        try {
            const result = await semesterAcademicService.getAll();
            res.status(200).json(result);
        } catch (err) {
            console.error(err);
            res.status(500).json('Lỗi! Không thể xem dữ liệu học kì niên khóa');
        }
    }

    async getCurrent(req, res) {
        try {
            const result = await semesterAcademicService.getCurrent();
            res.status(200).json(result);
        } catch (err) {
            console.error(err);
            res.status(500).json('Lỗi! Không thể xem dữ liệu học kì niên khóa');
        }
    }

    async getByDate(req, res) {
        try {
            const result = await semesterAcademicService.getByDate(
                req.params.date,
            );
            res.status(200).json(result);
        } catch (err) {
            console.error(err);
            res.status(500).json('Lỗi! Không thể xem dữ liệu học kì niên khóa');
        }
    }

    async getFullByDate(req, res) {
        try {
            const result = await semesterAcademicService.getFullByDate(
                req.params.date,
            );
            res.status(200).json(result);
        } catch (err) {
            console.error(err);
            res.status(500).json('Lỗi! Không thể xem dữ liệu học kì niên khóa');
        }
    }

    async update(req, res) {
        try {
            const result = await semesterAcademicService.update(
                req.params.id,
                req.body,
            );
            res.status(200).json(result);
        } catch (err) {
            console.error(err);
            res.status(500).json('Lỗi! Không thể xem dữ liệu học kì niên khóa');
        }
    }
}

module.exports = new SemesterAcademicController();
