const softwareService = require('../services/software_service');

class SoftwareController {
    async getAll(req, res) {
        try {
            const result = await softwareService.getAll();
            res.status(200).json(result);
        } catch (err) {
            console.error(err);
            res.status(500).json('Lỗi! Không thể xem dữ liệu phòng thực hành');
        }
    }
}

module.exports = new SoftwareController();
