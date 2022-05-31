const db = require('../db');
const TimetablingCloneDAO = require('./timetabling_clone_dao');

class TimetablingDAO {
    async getAll() {
        return await db('LichThucHanh').select('*');
    }

    async getFull() {
        return await db('LichThucHanh')
            .join('NhomThucHanh', 'NhomThucHanh.id', 'LichThucHanh.nhom_th_id')
            .join('LopHocPhan', 'LopHocPhan.id', 'NhomThucHanh.lop_hoc_phan_id')
            .join('MonHoc', 'MonHoc.id', 'LopHocPhan.mon_hoc_id')
            .orderBy('LichThucHanh.tuan_id')
            .select(
                'NhomThucHanh.*',
                'LichThucHanh.*',
                'LopHocPhan.*',
                'MonHoc.ma_mon_hoc',
                'LichThucHanh.id as id',
                'LichThucHanh.tuan_id as tuan_id',
                'LichThucHanh.buoi_hoc_id as buoi_hoc_id',
                'LichThucHanh.thu_id as thu_id',
                'NhomThucHanh.so_luong_sinh_vien as so_luong_sinh_vien',
            );
    }

    async getSingleFull(timetableDto) {
        return await db('LichThucHanh')
            .join('NhomThucHanh', 'NhomThucHanh.id', 'LichThucHanh.nhom_th_id')
            .join('LopHocPhan', 'LopHocPhan.id', 'NhomThucHanh.lop_hoc_phan_id')
            .where('LichThucHanh.tuan_id', timetableDto.tuan_id)
            .where('LichThucHanh.thu_id', timetableDto.thu_id)
            .where('LichThucHanh.buoi_hoc_id', timetableDto.buoi_hoc_id)
            .where('LichThucHanh.phong_id', timetableDto.phong_id)
            .orderBy('LichThucHanh.tuan_id')
            .first()
            .select(
                'NhomThucHanh.*',
                'LichThucHanh.*',
                'LopHocPhan.*',
                'NhomThucHanh.so_luong_sinh_vien as so_luong_sinh_vien',
                'LichThucHanh.id as id',
                'LichThucHanh.tuan_id as tuan_id',
                'LichThucHanh.buoi_hoc_id as buoi_hoc_id',
                'LichThucHanh.thu_id as thu_id',
            );
    }

    async getSingleFullByID(id) {
        return await db('LichThucHanh')
            .join('NhomThucHanh', 'NhomThucHanh.id', 'LichThucHanh.nhom_th_id')
            .join('LopHocPhan', 'LopHocPhan.id', 'NhomThucHanh.lop_hoc_phan_id')
            .join('MonHoc', 'MonHoc.id', 'LopHocPhan.mon_hoc_id')
            .where('LichThucHanh.id', id)
            .orderBy('LichThucHanh.tuan_id')
            .first()
            .select(
                'NhomThucHanh.*',
                'LichThucHanh.*',
                'LopHocPhan.*',
                'MonHoc.ma_mon_hoc',
                'NhomThucHanh.so_luong_sinh_vien as so_luong_sinh_vien',
                'LichThucHanh.id as id',
                'LichThucHanh.tuan_id as tuan_id',
                'LichThucHanh.buoi_hoc_id as buoi_hoc_id',
                'LichThucHanh.thu_id as thu_id',
            );
    }

    async getByCourse(courseID) {
        return await db('NhomThucHanh')
            .join('LichThucHanh', 'NhomThucHanh.id', 'LichThucHanh.nhom_th_id')
            .where('NhomThucHanh.lop_hoc_phan_id', courseID)
            .select('NhomThucHanh.*', 'LichThucHanh.*');
    }

    async getRegistration() {
        return await db('LichDangKy')
            .join('NhomThucHanh', 'NhomThucHanh.id', 'LichDangKy.nhom_th_id')
            .join('LopHocPhan', 'LopHocPhan.id', 'NhomThucHanh.lop_hoc_phan_id')
            .join('GiangVien', 'GiangVien.id', 'LopHocPhan.giang_vien_id')
            .join('MonHoc', 'MonHoc.id', 'LopHocPhan.mon_hoc_id')
            .select(
                'MonHoc.*',
                'LopHocPhan.ma_lop_hoc_phan',
                'NhomThucHanh.*',
                'LichDangKy.*',
                'GiangVien.ho_ten',
                'GiangVien.gioi_tinh',
            );
    }

    async getGroup() {
        return await db('NhomThucHanh')
            .join('LopHocPhan', 'LopHocPhan.id', 'NhomThucHanh.lop_hoc_phan_id')
            .select(
                '*',
                'NhomThucHanh.id as id',
                'NhomThucHanh.so_luong_sinh_vien as so_luong_sinh_vien',
            );
    }

    async getSingleGroup(groupID) {
        return await db('NhomThucHanh')
            .join('LopHocPhan', 'LopHocPhan.id', 'NhomThucHanh.lop_hoc_phan_id')
            .where('NhomThucHanh.id', groupID)
            .first()
            .select(
                '*',
                'NhomThucHanh.id as id',
                'NhomThucHanh.so_luong_sinh_vien as so_luong_sinh_vien',
            );
    }

    async getGroupByLecturer(lecturerID) {
        return await db('NhomThucHanh')
            .join('LopHocPhan', 'LopHocPhan.id', 'NhomThucHanh.lop_hoc_phan_id')
            .join('MonHoc', 'MonHoc.id', 'LopHocPhan.mon_hoc_id')
            .where('LopHocPhan.giang_vien_id', lecturerID)
            .orderBy('NhomThucHanh.id')
            .select(
                'NhomThucHanh.*',
                'LopHocPhan.ma_lop_hoc_phan',
                'MonHoc.ma_mon_hoc',
                'MonHoc.ten_mon_hoc',
            );
    }

    async register(timetablingDto) {
        const { lop_hoc_phan_id, ma_nhom, tuan_id, so_luong_sinh_vien } =
            timetablingDto;
        var checkGroup = await this.findGroupByCourse(lop_hoc_phan_id, ma_nhom);

        if (checkGroup == undefined) {
            const { tuan_id, ...groupDto } = timetablingDto;

            const group = await this.createGroup(groupDto);

            await this.createMultiRegistration(tuan_id, group[0].id);
            return null;
        }

        const groupID = await this.updateStudentQuantity(
            lop_hoc_phan_id,
            ma_nhom,
            so_luong_sinh_vien,
        );

        await TimetablingCloneDAO.deleteByGroupID(groupID[0].id);
        await this.createMultiRegistration(tuan_id, groupID[0].id);
        return null;
    }

    async createRegistration(groupID, weekID) {
        return await db('LichDangKy').insert({
            nhom_th_id: groupID,
            tuan_id: weekID,
        });
    }

    async createMultiRegistration(weekList, groupID) {
        for (let i = 0; i < weekList.length; i++) {
            await TimetablingCloneDAO.create(groupID, weekList[i]);
        }
        return null;
    }

    async getByGroupAndWeek(groupID, weekID) {
        return await db('LichThucHanh')
            .where('nhom_th_id', groupID)
            .where('tuan_id', weekID)
            .first()
            .select('*');
    }

    async getRegistrationByWeek(weekID) {
        return await db('LichDangKy')
            .join('NhomThucHanh', 'NhomThucHanh.id', 'LichDangKy.nhom_th_id')
            .where('LichDangKy.tuan_id', weekID)
            .select('*');
    }

    async getRegistrationByEmail(email) {
        return await db('LichDangKy')
            .join('NhomThucHanh', 'NhomThucHanh.id', 'LichDangKy.nhom_th_id')
            .join('LopHocPhan', 'LopHocPhan.id', 'NhomThucHanh.lop_hoc_phan_id')
            .join('MonHoc', 'MonHoc.id', 'LopHocPhan.mon_hoc_id')
            .join('GiangVien', 'GiangVien.id', 'LopHocPhan.giang_vien_id')
            .where('GiangVien.email_gv', email)
            .select(
                'NhomThucHanh.*',
                'LichDangKy.*',
                'MonHoc.ma_mon_hoc',
                'MonHoc.ten_mon_hoc',
            );
    }

    async findGroupByCourse(courseID, GroupID) {
        return await db('NhomThucHanh')
            .where('lop_hoc_phan_id', courseID)
            .where('ma_nhom', GroupID)
            .first()
            .select('*');
    }

    async createGroup(groupDto) {
        return await db('NhomThucHanh').insert(groupDto).returning('*');
    }

    async createTimetabling(timetablingDto) {
        return await db('LichThucHanh').insert(timetablingDto).returning('*');
    }

    async updateTimetablingByGroupID(groupID, updateData) {
        return await db('LichThucHanh')
            .update(updateData)
            .where('nhom_th_id', groupID)
            .returning('*');
    }

    async updateStudentQuantity(courseID, groupID, studentQuantity) {
        return await db('NhomThucHanh')
            .update({
                so_luong_sinh_vien: studentQuantity,
                trang_thai: true,
            })
            .where('lop_hoc_phan_id', courseID)
            .where('ma_nhom', groupID)
            .returning('id');
    }

    async delRegistration() {
        return await db('LichDangKy').del();
    }

    async findTimetablingRegistration(courseID) {
        return await db('NhomThucHanh')
            .join('LichDangKy', 'NhomThucHanh.id', 'LichDangKy.nhom_th_id')
            .where('lop_hoc_phan_id', courseID)
            .select('NhomThucHanh.*', 'LichDangKy.id', 'LichDangKy.tuan_id');
    }

    async updateTimetable(id, timetableDto) {
        return await db('LichThucHanh')
            .update({
                thu_id: timetableDto.thu_id,
                phong_id: timetableDto.phong_id,
                tuan_id: timetableDto.tuan_id,
                buoi_hoc_id: timetableDto.buoi_hoc_id,
            })
            .where('id', id)
            .select('*');
    }

    async updateGroup(groupDto) {
        return await db('NhomThucHanh').update(groupDto).select('*');
    }

    async updateSingleGroup(groupID, groupDto) {
        return await db('NhomThucHanh')
            .update(groupDto)
            .where('id', groupID)
            .select('*');
    }

    async updateAllStatusRegistration(status) {
        return await db('LichDangKy')
            .update({ trang_thai: status })
            .select('*');
    }

    async updateStatusRegistration(groupID, weekID, status) {
        return await db('LichDangKy')
            .update({
                trang_thai: status,
            })
            .where('nhom_th_id', groupID)
            .where('tuan_id', weekID)
            .select('*');
    }

    async deleteAllGroup() {
        return await db('NhomThucHanh').del();
    }

    async deleteGroupByCourse(courseID) {
        return await db('NhomThucHanh')
            .where('lop_hoc_phan_id', courseID)
            .del();
    }

    async delete() {
        return await db('LichThucHanh').del();
    }
}

module.exports = new TimetablingDAO();
