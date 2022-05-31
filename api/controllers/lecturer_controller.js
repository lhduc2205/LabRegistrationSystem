const lecturerService = require('../services/lecturer_service');

class LecturerController {
    async getAll(req, res) {
        try {
            const result = await lecturerService.getAll();
            res.status(200).json(result);
        } catch (err) {
            console.error(err);
            res.status(500).json(err.detail);
        }
    }

    async getSingle(req, res) {
        try {
            const result = await lecturerService.getSingle(req.params.email);
            res.status(200).json(result);
        } catch (err) {
            console.error(err);
            res.status(500).json(err.detail);
        }
    }

    async getFullInfo(req, res) {
        try {
            const result = await lecturerService.getFullInfo(req.params.email);
            res.status(200).json(result);
        } catch (err) {
            console.error(err);
            res.status(500).json(err.detail);
        }
    }

    async create(req, res) {
        try {
            const result = await lecturerService.create(req.body);
            res.status(201).json(result);
        } catch (err) {
            console.error(err);
            res.status(500).json(err.detail);
        }
    }

    async update(req, res) {
        try {
            const result = await lecturerService.update(
                req.params.id,
                req.body,
            );
            res.status(200).json(result);
        } catch (err) {
            console.error(err);
            res.status(500).json(err.detail);
        }
    }

    async delete(req, res) {
        try {
            const result = await lecturerService.delete(
                req.params.id,
                req.body,
            );
            res.status(200).json(result);
        } catch (err) {
            console.error(err);
            res.status(500).json(err.detail);
        }
    }
}

module.exports = new LecturerController();
