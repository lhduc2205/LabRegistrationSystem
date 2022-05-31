const SubjectSofwareService = require('../services/subject_software_service');

class SubjectSoftwareController {
    async getAll(req, res) {
        try {
            const labData = await SubjectSofwareService.getAll(req.body);
            const result = SubjectSofwareService.formatResult(labData);

            res.status(200).json(result);
        } catch (err) {
            console.error(err);
            res.status(500).json('Lỗi! Không thể xem dữ liệu phòng - phần mềm');
        }
    }

    async getSingle(req, res) {
        try {
            const labData = await SubjectSofwareService.getSingle(
                req.params.id,
            );
            const result = SubjectSofwareService.formatResult(labData);

            res.status(200).json(result[0]);
        } catch (err) {
            console.error(err);
            res.status(500).json('Lỗi! Không thể xem dữ liệu phòng - phần mềm');
        }
    }

    async create(req, res) {
        try {
            const labData = await SubjectSofwareService.create(req.body);
            const result = SubjectSofwareService.formatResult(labData);

            res.status(201).json(result[0]);
        } catch (err) {
            console.error(err);
            res.status(500).json('Lỗi! Không thể xem dữ liệu phòng - phần mềm');
        }
    }

    async update(req, res) {
        try {
            const labData = await SubjectSofwareService.update(
                req.params.id,
                req.body,
            );
            const result = SubjectSofwareService.formatResult(labData);
            res.status(201).json(result[0]);
        } catch (err) {
            console.error(err);
            res.status(500).json('Lỗi! Không thể xem dữ liệu phòng - phần mềm');
        }
    }

    async delete(req, res) {
        try {
            const result = await SubjectSofwareService.delete(req.params.id);
            res.status(200).json(result);
        } catch (err) {
            console.error(err);
            res.status(500).json(err.detail);
        }
    }
}

module.exports = new SubjectSoftwareController();
