const db = require('../db');

class SubjectSoftwareDAO {
    async getAll() {
        const result = await db('MonHocPhanMem')
            .join('PhanMem', 'MonHocPhanMem.phan_mem_id', 'PhanMem.id')
            .rightJoin('MonHoc', 'MonHocPhanMem.mon_hoc_id', 'MonHoc.id')
            .orderBy('MonHoc.id')
            .select('MonHoc.*', 'PhanMem.id as phan_mem_id');

        return result;
    }

    async getSingle(subjectID) {
        const result = await db('MonHocPhanMem')
            .where('MonHoc.id', subjectID)
            .join('PhanMem', 'MonHocPhanMem.phan_mem_id', 'PhanMem.id')
            .rightJoin('MonHoc', 'MonHocPhanMem.mon_hoc_id', 'MonHoc.id')
            .select('MonHoc.*', 'PhanMem.id as phan_mem_id');

        return result;
    }

    async create(softwareId, subjectData) {
        const subjectResult = await db('MonHoc')
            .insert(subjectData)
            .returning('id');

        const { id } = subjectResult[0];

        for (var i = 0; i < softwareId.length; i++) {
            await db('MonHocPhanMem').insert({
                mon_hoc_id: id,
                phan_mem_id: softwareId[i],
            });
        }
        const subjectInfo = this.getSingle(subjectResult[0].id);

        return subjectInfo;
    }

    async update(subjectID, softwareId, subjectData) {
        await db('MonHocPhanMem').where('mon_hoc_id', subjectID).del();
        await db('MonHoc').update(subjectData).where('id', subjectID);

        for (var i = 0; i < softwareId.length; i++) {
            await db('MonHocPhanMem').insert({
                mon_hoc_id: subjectID,
                phan_mem_id: softwareId[i],
            });
        }

        return this.getSingle(subjectID);
    }

    async delete(subjectID) {
        await db('MonHocPhanMem').where('mon_hoc_id', subjectID).del();
        const result = await db('MonHoc').where('id', subjectID).del();
        return result;
    }
}

module.exports = new SubjectSoftwareDAO();
