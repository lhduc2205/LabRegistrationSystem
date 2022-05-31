const db = require('../db');
const subjectDAO = require('./subject_dao');
const lecturerDAO = require('./lecturer_dao');
const TimetablingDAO = require('./timetabling_dao');
const DayDAO = require('./day_dao');
const SemesterService = require('../services/semester_academic_service');
const format = require('date-format');

class CourseDAO {
    async getAll() {
        return await db('LopHocPhan')
            .join('GiangVien', 'GiangVien.id', 'LopHocPhan.giang_vien_id')
            .join('MonHoc', 'MonHoc.id', 'LopHocPhan.mon_hoc_id')
            .select(
                'LopHocPhan.*',
                'GiangVien.ho_ten',
                'GiangVien.ma_gv',
                'MonHoc.ma_mon_hoc',
            );
    }

    async getByEmail(lecturerEmail) {
        const { id } = await db('GiangVien')
            .where('email_gv', lecturerEmail)
            .first()
            .select('id');

        return await db('LopHocPhan').where('giang_vien_id', id).select('*');
    }

    async getJoinByEmail(lecturerEmail) {
        const { id } = await db('GiangVien')
            .where('email_gv', lecturerEmail)
            .first()
            .select('id');

        return await db('LopHocPhan')
            .join('MonHoc', 'MonHoc.id', 'LopHocPhan.mon_hoc_id')
            .where('giang_vien_id', id)
            .select(
                'LopHocPhan.*',
                'MonHoc.ma_mon_hoc',
                'MonHoc.so_tin_chi',
                'MonHoc.ten_mon_hoc',
            );
    }

    async getByGroupAndSubject(groupName, subjectID) {
        return await db('LopHocPhan')
            .where('ma_lop_hoc_phan', groupName)
            .where('mon_hoc_id', subjectID)
            .first()
            .select('*');
    }

    async create(courseDto) {
        const result = await db('LopHocPhan').insert(courseDto).returning('*');
        return result[0];
    }

    async createClassByExcel(courseDto) {
        const semester = await SemesterService.getCurrent();
        await TimetablingDAO.deleteAllGroup();
        await this.deleteBySemester(semester.id);

        for (let i = 0; i < courseDto.length; i++) {
            // await TimetablingDAO.deleteGroupByCourse(
            //     courseDto[i].ma_lop_hoc_phan,
            // );

            const courseData = await this.getCourseDto(courseDto[i], semester);
            const course = await this.create(courseData);
            let groupLength = 1;
            if (courseData.so_luong_sinh_vien > 60) {
                groupLength = 2;
            }
            for (let group = 1; group <= groupLength; group++) {
                let studentQuantity = Math.round(
                    courseDto[i].so_luong_sinh_vien / groupLength,
                );
                if (group == 2) {
                    studentQuantity--;
                }
                const groupCourseData = this.getGroupCourseDto(
                    group,
                    course.id,
                    studentQuantity,
                );
                await TimetablingDAO.createGroup(groupCourseData);
            }
        }

        return await this.getAll();
    }

    async deleteBySemester(semesterID) {
        return db('LopHocPhan')
            .where('hoc_ky_nien_khoa_id', semesterID)
            .del()
            .select('*');
    }

    async getCourseDto(courseDto, semester) {
        const subject = await subjectDAO.getById2(courseDto.ma_mon_hoc);
        const lecturer = await lecturerDAO.getById2(courseDto.ma_gv);
        const day = await DayDAO.getById2(courseDto.ma_thu);

        let sessionID = 1;
        if (courseDto.tiet_hoc > 5) {
            sessionID = 2;
        }

        const courseData = {
            mon_hoc_id: subject.id,
            ma_lop_hoc_phan: courseDto.ma_lop_hoc_phan,
            giang_vien_id: lecturer.ma_gv,
            so_luong_sinh_vien: courseDto.so_luong_sinh_vien,
            thu_id: day.id,
            buoi_hoc_id: sessionID,
            hoc_ky_nien_khoa_id: semester.id,
        };
        return courseData;
    }

    getGroupCourseDto(groupID, courseID, studentQuantity) {
        const groupCourseDto = {
            ma_nhom: groupID,
            lop_hoc_phan_id: courseID,
            so_luong_sinh_vien: studentQuantity,
        };
        return groupCourseDto;
    }
}

module.exports = new CourseDAO();
