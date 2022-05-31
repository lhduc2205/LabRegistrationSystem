const departmentService = require('../services/deparment_service');

class DepartmentController {
    async create(req, res) {
        const departmentExists = await departmentService.check(req.body);

        if (departmentExists.length > 0) {
            res.status(400).json(`Bộ môn ${req.body.ten_bo_mon} đã tồn tại`);
        } else {
            try {
                const result = await departmentService.create(req.body);
                res.status(201).json(result[0]);
            } catch (err) {
                console.error(err);
                // res.status(500).json('Lỗi! Không thể thêm bộ môn');
                res.status(500).json(err.detail);
            }
        }
    }

    async getAll(req, res) {
        try {
            const result = await departmentService.getAll();
            // res.status(200).json({
            //     "message": "successfully",
            //     "data": result
            // });
            res.status(200).json(result);
        } catch (err) {
            console.error(err);
            res.status(500).json('Lỗi! Không thể xem các bộ môn');
        }
    }

    async get(req, res) {
        try {
            const result = await departmentService.get(req.params.id);
            res.status(200).json({
                message: 'successfull',
                data: result,
            });
        } catch (err) {
            console.error(err);
            res.status(500).json(
                'Lỗi! Không thể truy xuất dữ liệu từ bảng bộ môn',
            );
        }
    }

    async update(req, res) {
        try {
            const result = await departmentService.update(
                req.params.id,
                req.body,
            );
            res.status(200).json(result[0]);
        } catch (err) {
            console.error(err);
            res.status(500).json(
                'Lỗi! Không thể truy xuất dữ liệu từ bảng bộ môn',
            );
        }
    }

    async delete(req, res) {
        try {
            const result = await departmentService.delete(req.params.id);
            res.status(200).json({
                message: 'successfull',
                data: result,
            });
        } catch (err) {
            console.error(err);
            res.status(500).json(
                'Lỗi! Không thể truy xuất dữ liệu từ bảng bộ môn',
            );
        }
    }
}

module.exports = new DepartmentController();
