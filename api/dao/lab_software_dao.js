const db = require('../db');

class LabSoftwareDAO {
    async getAll() {
        // return await db('PhongThucHanh').select('*');

        const result = await db('PhongPhanMem')
            .select('PhongThucHanh.*', 'PhanMem.id as phan_mem_id')
            .join('PhanMem', 'PhongPhanMem.phan_mem_id', 'PhanMem.id')
            .rightJoin(
                'PhongThucHanh',
                'PhongPhanMem.phong_id',
                'PhongThucHanh.id',
            )
            .orderBy('PhongThucHanh.id');

        return result;
    }

    async getSingle(labId) {
        const result = await db('PhongPhanMem')
            .select('PhongThucHanh.*', 'PhanMem.id as phan_mem_id')
            .where('PhongThucHanh.id', labId)
            .join('PhanMem', 'PhongPhanMem.phan_mem_id', 'PhanMem.id')
            .rightJoin(
                'PhongThucHanh',
                'PhongPhanMem.phong_id',
                'PhongThucHanh.id',
            );

        return result;
    }

    // async getSingle(labId) {
    //     const result = await db('PhongThucHanh')
    //         .join('PhongPhanMem', 'PhongPhanMem.phong_id', 'PhongThucHanh.id')
    //         .join(
    //             'PhanMem',
    //             'PhanMem.id',
    //             'PhongPhanMem.phan_mem_id',
    //         )
    //         .where('PhongThucHanh.id', labId)
    //         .first()
    //         .select('*', 'PhongPhanMem.id as phan_mem_id', 'PhongThucHanh.id as id');

    //     return result;
    // }

    async create(softwareId, labData) {
        const labResult = await db('PhongThucHanh')
            .insert(labData)
            .returning('id');

        const { id } = labResult[0];

        for (var i = 0; i < softwareId.length; i++) {
            await db('PhongPhanMem').insert({
                phong_id: id,
                phan_mem_id: softwareId[i],
            });
        }
        const labInfo = this.getSingle(labResult[0].id);

        return labInfo;
    }

    async update(labId, softwareId, labData) {
        await db('PhongPhanMem').where('phong_id', labId).del();
        await db('PhongThucHanh').update(labData).where('id', labId);

        for (var i = 0; i < softwareId.length; i++) {
            await db('PhongPhanMem').insert({
                phong_id: labId,
                phan_mem_id: softwareId[i],
            });
        }

        return this.getSingle(labId);
    }

    async delete(labId) {
        await db('PhongPhanMem').where('phong_id', labId).del();
        const result = await db('PhongThucHanh').where('id', labId).del();
        return result;
    }
}

module.exports = new LabSoftwareDAO();
