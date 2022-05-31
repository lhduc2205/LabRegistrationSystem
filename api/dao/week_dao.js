const db = require('../db');

class WeekDAO {
    async getAll() {
        return await db('Tuan').select('*');
    }

    async getById(weekID) {
        return await db('Tuan').where('ma_tuan', weekID).first().select('*');
    }
}

module.exports = new WeekDAO();
