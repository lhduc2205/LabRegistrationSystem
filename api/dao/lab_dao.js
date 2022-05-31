const db = require('../db');

class LabDao {
    async getAll() {
        return await db('PhongThucHanh').select('*');
    }

    async getFull() {
        const result = await db('PhongThucHanh')
            .leftJoin(
                'PhongPhanMem',
                'PhongPhanMem.phong_id',
                'PhongThucHanh.id',
            )
            .leftJoin('PhanMem', 'PhanMem.id', 'PhongPhanMem.phan_mem_id')
            .orderBy('PhongThucHanh.id')
            .select('*', 'PhongThucHanh.id as id');

        return result;
    }
}

module.exports = new LabDao();
