const dayService = require('../services/day_service');

class DayController {
    async getAll(req, res) {
        try {
            const result = await dayService.getAll();
            res.status(200).json(result);
        } catch (err) {
            res.status(500).json(err);
        }
    }
}

module.exports = new DayController();
