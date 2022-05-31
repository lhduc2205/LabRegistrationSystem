const TimetableCloneDAO = require('../dao/timetabling_clone_dao');
const SubjectSoftwareService = require('../services/subject_software_service');
const SemesterDetailService = require('../services/semester_detail_service');
const LabSoftwareService = require('../services/lab_software_service');

class TimetableCloneService {
    async getAll() {
        return await TimetableCloneDAO.getAll();
    }

    async getAllBasic() {
        return await TimetableCloneDAO.getAllBasic();
    }

    async getSingleFull(timetableDto) {
        return await TimetableCloneDAO.getSingleFull(timetableDto);
    }

    getRegistration() {
        return TimetableCloneDAO.getRegistration();
    }

    async getFull() {
        const timetable = await TimetableCloneDAO.getRegistrationFull();
        const format = this._formatTimetableClone(timetable);
        for (let i = 0; i < timetable.length; i++) {
            await SubjectSoftwareService.getSingle(
                timetable[i].mon_hoc_id,
            ).then((result) => {
                timetable[i].phan_mem_id = [];
                for (let j = 0; j < result.length; j++) {
                    timetable[i].phan_mem_id.push(result[j].phan_mem_id);
                }
            });
        }
        return timetable;
    }

    async createClone(timetableList) {
        await TimetableCloneDAO.deleteClone();
        timetableList.forEach(async (timetable) => {
            const semesterDetail = await SemesterDetailService.getSingle(
                timetable.course.hoc_ky_nien_khoa_id,
                timetable.course.tuan_id,
            );

            let timetableDto = {};
            timetableDto.phong_id = timetable.room.id;
            timetableDto.tuan_id = timetable.course.tuan_id;
            timetableDto.nhom_th_id = timetable.course.nhom_th_id;
            timetableDto.thu_id = timetable.day.id;
            timetableDto.buoi_hoc_id = timetable.period.id;
            timetableDto.ngay_bat_dau = semesterDetail.ngay_bat_dau;

            await TimetableCloneDAO.createClone(timetableDto);
        });

        // const timetableClone = await TimetableCloneDAO.getAll();
        return await TimetableCloneDAO.getAll();
    }

    createSingleClone(timetableDto) {
        return TimetableCloneDAO.createClone(timetableDto);
    }

    // return err notification if this lab is not suitable
    async checkLabMatched(timetable, labID) {
        let err = [];
        const software = await SubjectSoftwareService.getSingle(
            timetable.mon_hoc_id,
        );

        timetable.phan_mem_id =
            SubjectSoftwareService.formatResult(software)[0].phan_mem_id;

        let labSoftware = await LabSoftwareService.getSingle(labID);
        labSoftware = LabSoftwareService.formatResult(labSoftware)[0];

        if (timetable.so_luong_sinh_vien > labSoftware.so_cho_ngoi) {
            err.push('Số lượng máy không đủ');
        }
        if (
            !SubjectSoftwareService.checkInclude(
                timetable.phan_mem_id,
                labSoftware.phan_mem_id,
            )
        ) {
            err.push('Không có đầy đủ phần mềm hỗ trợ');
        }

        return err;
    }

    updateClone(id, timetableDto) {
        return TimetableCloneDAO.updateClone(id, timetableDto);
    }

    deleteRegistration() {
        return TimetableCloneDAO.deleteRegistration();
    }

    deleteSingleClone(id) {
        return TimetableCloneDAO.deleteSingleClone(id);
    }

    delete() {
        return TimetableCloneDAO.delete();
    }

    _formatTimetableClone(labData) {
        const output = labData.reduce(function (o, cur) {
            var occurs = o.reduce(function (n, item, i) {
                return item.id === cur.id ? i : n;
            }, -1);

            if (occurs >= 0) {
                o[occurs].tuan_id = o[occurs].tuan_id.concat(cur.tuan_id);
            } else {
                var obj = {
                    ...cur,
                    id: cur.id,
                    tuan_id: cur.tuan_id != null ? [cur.tuan_id] : [],
                };
                o = o.concat([obj]);
            }
            return o;
        }, []);

        return output;
    }
}

module.exports = new TimetableCloneService();
