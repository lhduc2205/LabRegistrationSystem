const periodService = require('../services/period_service');

class PeriodController {
    async getAll(req, res) {
        try {
            const result = await periodService.getAll();
            res.status(200).json(result);
        } catch (err) {
            res.status(500).json(err);
        }
    }

    async deleteSingle(req, res) {
        try {
            const result = await periodService.deleteSingle(req.params.id);
            res.status(200).json(result);
        } catch (err) {
            res.status(500).json(err);
        }
    }
}

module.exports = new PeriodController();
