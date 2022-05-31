const db = require('../db');
const AccountDAO = require('./account_dao');
const departmentDAO = require('./department_dao');

class LecturerDAO {
    async getAll() {
        const result = await db('GiangVien')
            .join('BoMon', 'GiangVien.bo_mon_id', '=', 'BoMon.id')
            .join('TaiKhoan', 'TaiKhoan.email', 'GiangVien.email_gv')
            .join('VaiTro', 'VaiTro.id', 'TaiKhoan.vai_tro_id')
            .where('TaiKhoan.vai_tro_id', 2)
            .orderBy('GiangVien.id')
            .select(
                'GiangVien.*',
                'VaiTro.ten_vai_tro',
                'VaiTro.ma_vai_tro',
                'BoMon.ten_bo_mon',
            );

        return result;
    }

    async getById2(ma_gv) {
        const giang_vien = await db('GiangVien')
            .where('ma_gv', ma_gv)
            .select('*')
            .first();

        return giang_vien;
    }

    async getSingle(email) {
        const result = await db('GiangVien')
            .where('email_gv', email)
            .first()
            .select('*');

        return result;
    }

    async getFullInfo(email) {
        const userInfo = await db('GiangVien')
            .join('BoMon', 'BoMon.id', 'GiangVien.bo_mon_id')
            .join('TaiKhoan', 'TaiKhoan.email', 'GiangVien.email_gv')
            .join('VaiTro', 'VaiTro.id', 'TaiKhoan.vai_tro_id')
            .where('email_gv', email)
            .first()
            .select(
                'GiangVien.*',
                'VaiTro.ten_vai_tro',
                'VaiTro.ma_vai_tro',
                'BoMon.ten_bo_mon',
            );
        return userInfo;
    }

    async createLecturer(accountData, lecturerData) {
        const { email, mat_khau } = accountData;
        delete lecturerData.email_gv;
        delete lecturerData.ten_vai_tro;
        delete lecturerData.ma_vai_tro;

        await AccountDAO.create(email, mat_khau);
        // await this.getFullInfo(email);
        const departmentName = await departmentDAO.get(lecturerData.bo_mon_id);

        lecturerData.email_gv = email;
        console.log(lecturerData);

        const lecturerInfo = await db('GiangVien')
            .insert(lecturerData)
            .returning('*');

        lecturerInfo[0].ten_bo_mon = departmentName.ten_bo_mon;

        return lecturerInfo[0];
    }

    async update(id, lecturerData) {
        console.log(lecturerData.ngay_sinh);

        const lecturerInfo = await db('GiangVien')
            .where('id', id)
            .update(lecturerData)
            .returning('*');

        lecturerInfo[0].ten_bo_mon = null;
        console.log(lecturerInfo[0]);

        return lecturerInfo[0];
    }

    async delete(id, email) {
        await db('GiangVien').where('id', id).del();

        const result = await db('TaiKhoan').where('email', email).del();

        return result;
    }
}

module.exports = new LecturerDAO();
