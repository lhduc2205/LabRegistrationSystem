const db = require('../db');

class SemesterDetailDAO {
    async getFull() {
        return await db('ChiTietHocKyNienKhoa')
            .join('Tuan', 'Tuan.id', 'ChiTietHocKyNienKhoa.tuan_id')
            .join(
                'HocKyNienKhoa',
                'HocKyNienKhoa.id',
                'ChiTietHocKyNienKhoa.hoc_ky_nien_khoa_id',
            )
            .join('HocKy', 'HocKy.id', 'HocKyNienKhoa.hoc_ky_id')
            .join('NienKhoa', 'NienKhoa.id', 'HocKyNienKhoa.nien_khoa_id')
            .select(
                '*',
                'ChiTietHocKyNienKhoa.id as id',
                'ChiTietHocKyNienKhoa.ngay_bat_dau as ngay_bat_dau',
            );
    }

    async getFullByDate(date) {
        console.log(date);
        return await db('HocKyNienKhoa')
            .join('HocKy', 'HocKy.id', 'HocKyNienKhoa.hoc_ky_id')
            .join('NienKhoa', 'NienKhoa.id', 'HocKyNienKhoa.nien_khoa_id')
            .join(
                'ChiTietHocKyNienKhoa',
                'ChiTietHocKyNienKhoa.hoc_ky_nien_khoa_id',
                'HocKyNienKhoa.id',
            )
            .join('Tuan', 'Tuan.id', 'ChiTietHocKyNienKhoa.tuan_id')
            .where('HocKyNienKhoa.ngay_bat_dau', '<', date)
            .orderBy('HocKyNienKhoa.id', 'desc')
            .select('*');
    }

    async getSingle(semesterID, weekID) {
        return await db('ChiTietHocKyNienKhoa')
            .join('Tuan', 'Tuan.id', 'ChiTietHocKyNienKhoa.tuan_id')
            .join(
                'HocKyNienKhoa',
                'HocKyNienKhoa.id',
                'ChiTietHocKyNienKhoa.hoc_ky_nien_khoa_id',
            )
            .join('HocKy', 'HocKy.id', 'HocKyNienKhoa.hoc_ky_id')
            .join('NienKhoa', 'NienKhoa.id', 'HocKyNienKhoa.nien_khoa_id')
            .where('ChiTietHocKyNienKhoa.hoc_ky_nien_khoa_id', semesterID)
            .where('ChiTietHocKyNienKhoa.tuan_id', weekID)
            .first()
            .select(
                '*',
                'ChiTietHocKyNienKhoa.id as id',
                'ChiTietHocKyNienKhoa.ngay_bat_dau as ngay_bat_dau',
            );
    }
}

module.exports = new SemesterDetailDAO();
