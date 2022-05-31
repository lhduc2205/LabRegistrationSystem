const db = require('../db');

class SubjectDAO {
    async getAll() {
        return await db('MonHoc').select('*');
    }

    async getById2(ma_mon_hoc) {
        return await db('MonHoc')
            .where('ma_mon_hoc', ma_mon_hoc)
            .select('*')
            .first();
    }
}

module.exports = new SubjectDAO();
