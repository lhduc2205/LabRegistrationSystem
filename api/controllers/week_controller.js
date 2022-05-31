const WeekService = require('../services/week_service');

class WeekController {
    async getAll(req, res) {
        try {
            const result = await WeekService.getAll();
            res.status(200).json(result);
        } catch (err) {
            console.error(err);
            res.status(500).json('Lỗi! Không thể xem dữ liệu tuần');
        }
    }

    async getById(req, res) {
        try {
            console.log(req.params.id);
            const result = await WeekService.getById(req.params.id);
            res.status(200).json(result);
        } catch (err) {
            console.error(err);
            res.status(500).json('Lỗi! Không thể xem dữ liệu tuần');
        }
    }
}

module.exports = new WeekController();
