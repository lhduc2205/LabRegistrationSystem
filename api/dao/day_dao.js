const db = require('../db');

class DayDAO {
    async getAll() {
        return await db('Thu').orderBy('id').select('*');
    }

    async getById2(dayID) {
        return await db('Thu').where('ma_thu', dayID).first().select('*');
    }
}

module.exports = new DayDAO();
