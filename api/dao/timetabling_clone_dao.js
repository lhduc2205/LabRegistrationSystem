const db = require('../db');

class TimetablingCloneDAO {
    async getAll() {
        return await db('LichThucHanhClone')
            .join(
                'NhomThucHanh',
                'NhomThucHanh.id',
                'LichThucHanhClone.nhom_th_id',
            )
            .join('LopHocPhan', 'LopHocPhan.id', 'NhomThucHanh.lop_hoc_phan_id')
            .orderBy('LichThucHanhClone.tuan_id')
            .select(
                'NhomThucHanh.*',
                'LichThucHanhClone.*',
                'LopHocPhan.*',
                'LichThucHanhClone.id as id',
                'LichThucHanhClone.tuan_id as tuan_id',
                'LichThucHanhClone.buoi_hoc_id as buoi_hoc_id',
                'LichThucHanhClone.thu_id as thu_id',
            );
    }

    async getAllBasic() {
        return await db('LichThucHanhClone').select('*');
    }

    async getRegistration() {
        return await db('LichDangKy').select('*');
    }

    async getRegistrationFull() {
        return await db('LichDangKy')
            .join('NhomThucHanh', 'NhomThucHanh.id', 'LichDangKy.nhom_th_id')
            .join('LopHocPhan', 'LopHocPhan.id', 'NhomThucHanh.lop_hoc_phan_id')
            .select(
                '*',
                'LichDangKy.id as id',
                'NhomThucHanh.so_luong_sinh_vien as slsv_nhom',
                'LichDangKy.trang_thai as trang_thai',
            );
    }

    async getByWeek(weekID) {
        return await db('LichDangKy')
            .join('NhomThucHanh', 'NhomThucHanh.id', 'LichDangKy.nhom_th_id')
            .join('LopHocPhan', 'LopHocPhan.id', 'NhomThucHanh.lop_hoc_phan_id')
            .where('tuan_id', weekID)
            .select('*');
    }

    async getSingle(groupID) {
        return await db('LichDangKy').where('tuan_id', groupID).select('*');
    }

    async getSingleFull(timetableDto) {
        return await db('LichThucHanhClone')
            .join(
                'NhomThucHanh',
                'NhomThucHanh.id',
                'LichThucHanhClone.nhom_th_id',
            )
            .join('LopHocPhan', 'LopHocPhan.id', 'NhomThucHanh.lop_hoc_phan_id')
            .where('LichThucHanhClone.tuan_id', timetableDto.tuan_id)
            .where('LichThucHanhClone.thu_id', timetableDto.thu_id)
            .where('LichThucHanhClone.buoi_hoc_id', timetableDto.buoi_hoc_id)
            .where('LichThucHanhClone.phong_id', timetableDto.phong_id)
            .orderBy('LichThucHanhClone.tuan_id')
            .first()
            .select(
                'NhomThucHanh.*',
                'LichThucHanhClone.*',
                'LopHocPhan.*',
                'NhomThucHanh.so_luong_sinh_vien as so_luong_sinh_vien',
                'LichThucHanhClone.id as id',
                'LichThucHanhClone.tuan_id as tuan_id',
                'LichThucHanhClone.buoi_hoc_id as buoi_hoc_id',
                'LichThucHanhClone.thu_id as thu_id',
            );
    }

    async create(groupID, weekID) {
        return await db('LichDangKy')
            .insert([
                {
                    tuan_id: weekID,
                    nhom_th_id: groupID,
                },
            ])
            .returning('*');
    }

    async createClone(timetableDto) {
        return await db('LichThucHanhClone')
            .insert(timetableDto)
            .returning('*');
    }

    async update(groupID, weekID) {
        return await db('LichDangKy')
            .update('tuan_id', weekID)
            .where('nhom_th_id', groupID)
            .select('*');
    }

    async updateClone(id, timetableDto) {
        return await db('LichThucHanhClone')
            .update({
                thu_id: timetableDto.thu_id,
                phong_id: timetableDto.phong_id,
            })
            .where('id', id)
            .select('*');
    }

    async deleteByGroupID(groupID) {
        return await db('LichDangKy').where('nhom_th_id', groupID).del();
    }

    async deleteRegistration() {
        return await db('LichDangKy').del();
    }

    async deleteClone() {
        return await db('LichThucHanhClone').del();
    }

    async deleteSingleClone(id) {
        return await db('LichThucHanhClone').where('id', id).del();
    }

    async delete() {
        return await db('LichThucHanhClone').del();
    }
}

module.exports = new TimetablingCloneDAO();
