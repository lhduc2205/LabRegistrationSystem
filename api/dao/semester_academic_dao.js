const db = require('../db');

class SemesterAcademicDAO {
    async getAll() {
        return await db('HocKyNienKhoa')
            .join('HocKy', 'HocKy.id', 'HocKyNienKhoa.hoc_ky_id')
            .join('NienKhoa', 'NienKhoa.id', 'HocKyNienKhoa.nien_khoa_id')
            .select(
                'HocKyNienKhoa.*',
                'HocKy.ten_hoc_ky',
                'NienKhoa.nien_khoa',
            );
    }

    async getByDate(date) {
        const hocky_nienkhoa = await db('HocKyNienKhoa')
            .join('HocKy', 'HocKy.id', 'HocKyNienKhoa.hoc_ky_id')
            .join('NienKhoa', 'NienKhoa.id', 'HocKyNienKhoa.nien_khoa_id')
            .where('ngay_bat_dau', '<', date)
            // .where('ngay_ket_thuc', '>', date)
            .select(
                'HocKyNienKhoa.*',
                'HocKy.ten_hoc_ky',
                'NienKhoa.nien_khoa',
            );
        const length = hocky_nienkhoa.length;
        return hocky_nienkhoa[length - 1];
    }

    async update(id, updatedData) {
        return await db('HocKyNienKhoa').where('id', id).update(updatedData);
    }
}

module.exports = new SemesterAcademicDAO();
