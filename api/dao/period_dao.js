const db = require('../db');

class PeriodDAO {
    async getAll() {
        return await db('BuoiHoc').select('*');
    }

    async deleteSingle(id) {
        return await db('BuoiHoc').where('id', id).del();
    }
}

module.exports = new PeriodDAO();
