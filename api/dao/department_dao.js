const db = require('../db');

class DepartmentDAO {
    async getAll() {
        const result = await db('BoMon').select('*').orderBy('id');

        return result;
    }

    async get(id) {
        const result = await db('BoMon').select('*').where('id', id);

        return result[0];
    }

    async create(ten_bo_mon, viet_tat) {
        const result = await db('BoMon')
            .insert({
                ten_bo_mon: ten_bo_mon,
                viet_tat: viet_tat,
            })
            .returning('*');

        return result;
    }

    async check(ten_bo_mon, viet_tat) {
        const result = await db('BoMon')
            .select('*')
            .where('ten_bo_mon', ten_bo_mon)
            .where('viet_tat', viet_tat);

        return result;
    }

    async update(id, ten_bo_mon, viet_tat) {
        const result = await db('BoMon')
            .where('id', id)
            .update({
                ten_bo_mon: ten_bo_mon,
                viet_tat: viet_tat,
            })
            .returning('*');

        return result;
    }

    async delete(id) {
        const result = await db('BoMon').where('id', id).del();

        return result;
    }
}

module.exports = new DepartmentDAO();
