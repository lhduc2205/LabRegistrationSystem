const labService = require('../services/lab_service.js');

class LabController {
    async getAll(req, res) {
        try {
            const result = await labService.getAll();
            res.status(200).json(result);
        } catch (err) {
            console.error(err);
            res.status(500).json('Lỗi! Không thể xem dữ liệu phòng thực hành');
        }
    }
}

module.exports = new LabController();
