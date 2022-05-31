const db = require('../db');
const bcrypt = require('bcrypt');

class AccountDAO {
    async getAll() {
        const result = await db('TaiKhoan').select('email', 'vai_tro_id');
        // .join('VaiTro', 'VaiTro.id', 'TaiKhoan.vai_tro_id')
        // .select('email', 'ten_vai_tro');

        return result;
    }

    // async getUserInfo(lecturerEmail) {
    //     const userInfo = await db('GiangVien')
    //         .join('BoMon', 'BoMon.id', 'GiangVien.bo_mon_id')
    //         .join('TaiKhoan', 'TaiKhoan.email', 'GiangVien.email_gv')
    //         .join('VaiTro', 'VaiTro.id', 'TaiKhoan.vai_tro_id')
    //         .where('email_gv', lecturerEmail)
    //         .first()
    //         .select(
    //             'GiangVien.*',
    //             'VaiTro.ten_vai_tro',
    //             'VaiTro.ma_vai_tro',
    //             'BoMon.ten_bo_mon'
    //         );
    //     return userInfo;
    // }

    async create(email, mat_khau) {
        const hash = bcrypt.hashSync(mat_khau, 10);

        const result = await db('TaiKhoan')
            .insert({
                email: email,
                mat_khau: hash,
            })
            .returning('email');

        return result[0];
    }

    async login(email, mat_khau) {
        const account = await db('TaiKhoan')
            .where('email', email)
            .first()
            .select('*');
        const result = bcrypt.compareSync(mat_khau, account.mat_khau);

        if (!result) {
            return null;
        }

        // const userInfo = await db('GiangVien')
        //     .select('*')
        //     .join('')
        //     .where('email_gv', email)
        //     // .where('mat_khau', hash)
        //     .first();
        // const userInfo = await this.getUserInfo(email);
        return email;
    }

    async delete(email) {
        const result = await db('TaiKhoan').where('email', email).del();

        return result;
    }
}

module.exports = new AccountDAO();
