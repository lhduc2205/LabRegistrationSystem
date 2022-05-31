const SemesterDetailService = require('../services/semester_detail_service');

class SemesterDetailController {
    async getFull(req, res) {
        try {
            const result = await SemesterDetailService.getFull();
            res.status(200).json(result);
        } catch (err) {
            console.error(err);
            res.status(500).json('Lỗi! Không thể xem dữ liệu học kì niên khóa');
        }
    }

    async getSingle(req, res) {
        try {
            const result = await SemesterDetailService.getSingle(
                req.params.semester,
                req.params.week,
            );
            res.status(200).json(result);
        } catch (err) {
            console.error(err);
            res.status(500).json('Lỗi! Không thể xem dữ liệu học kì niên khóa');
        }
    }

    // async getByDate(req, res) {
    //     try {
    //         const result = await SemesterDetailService.getByDate(
    //             req.params.date,
    //         );
    //         res.status(200).json(result);
    //     } catch (err) {
    //         console.error(err);
    //         res.status(500).json('Lỗi! Không thể xem dữ liệu học kì niên khóa');
    //     }
    // }

    // async update(req, res) {
    //     try {
    //         const result = await SemesterDetailService.update(
    //             req.params.id,
    //             req.body,
    //         );
    //         res.status(200).json(result);
    //     } catch (err) {
    //         console.error(err);
    //         res.status(500).json('Lỗi! Không thể xem dữ liệu học kì niên khóa');
    //     }
    // }
}

module.exports = new SemesterDetailController();
