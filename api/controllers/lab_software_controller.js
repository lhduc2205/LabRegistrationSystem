const labSoftwareService = require('../services/lab_software_service');

class LabSoftwareController {
    async getAll(req, res) {
        try {
            const labData = await labSoftwareService.getAll(req.body);
            const result = labSoftwareService.formatResult(labData);

            res.status(200).json(result);
        } catch (err) {
            console.error(err);
            res.status(500).json('Lỗi! Không thể xem dữ liệu phòng thực hành');
        }
    }

    async getSingle(req, res) {
        try {
            const labData = await labSoftwareService.getSingle(req.params.id);
            const result = labSoftwareService.formatResult(labData);

            res.status(200).json(result[0]);
        } catch (err) {
            console.error(err);
            res.status(500).json('Lỗi! Không thể xem dữ liệu phòng thực hành');
        }
    }

    async create(req, res) {
        try {
            const labData = await labSoftwareService.create(req.body);
            const result = labSoftwareService.formatResult(labData);

            res.status(201).json(result[0]);
        } catch (err) {
            console.error(err);
            res.status(500).json('Lỗi! Không thể xem dữ liệu phòng thực hành');
        }
    }

    async update(req, res) {
        try {
            const labData = await labSoftwareService.update(
                req.params.id,
                req.body,
            );
            const result = labSoftwareService.formatResult(labData);
            res.status(201).json(result[0]);
        } catch (err) {
            console.error(err);
            res.status(500).json('Lỗi! Không thể xem dữ liệu phòng thực hành');
        }
    }

    async delete(req, res) {
        try {
            const result = await labSoftwareService.delete(req.params.id);
            res.status(200).json(result);
        } catch (err) {
            console.error(err);
            res.status(500).json(err.detail);
        }
    }
}

module.exports = new LabSoftwareController();
