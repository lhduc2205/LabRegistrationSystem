const db = require('../db');

class SoftwareDAO {
    async getAll() {
        return await db('PhanMem').select('*');
    }
}

module.exports = new SoftwareDAO();
