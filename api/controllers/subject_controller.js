const subjectService = require('../services/subject_service');

class SubjectController {
    async getAll(req, res) {
        try {
            const result = await subjectService.getAll();
            res.status(200).json(result);
        } catch (err) {
            res.status(500).json(err);
        }
    }
}

module.exports = new SubjectController();
