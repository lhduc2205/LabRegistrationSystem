const TimetablingDAO = require('../dao/timetabling_dao');
const TimetablingCloneDAO = require('../dao/timetabling_clone_dao');
const TimetablingCloneService = require('../services/timetable_clone_service');
const WeekDAO = require('../dao/week_dao');
const SubjectDAO = require('../dao/subject_dao');
const CourseDAO = require('../dao/course_dao');
const XLSX = require('xlsx');
const Excel = require('exceljs');
const multer = require('multer');

class TimetablingService {
    getAll() {
        return TimetablingDAO.getAll();
    }

    getFull() {
        return TimetablingDAO.getFull();
    }

    async getSingleFull(timetableDto) {
        return await TimetablingDAO.getSingleFull(timetableDto);
    }

    async getSingleFullByID(id) {
        return await TimetablingDAO.getSingleFullByID(id);
    }

    async getByEmail(email) {
        const courses = await CourseDAO.getByEmail(email);
        let timetable = [];

        for (let i = 0; i < courses.length; i++) {
            const result = await TimetablingDAO.getByCourse(courses[i].id);
            timetable.push(...result);
        }

        return timetable;
    }

    getRegistration() {
        // const courses = await CourseDAO.getAll();
        // var timetablingResgistration = [];
        // for (let i = 0; i < courses.length; i++) {
        //     await TimetablingDAO.findTimetablingRegistration(
        //         courses[i].id,
        //     ).then((registration) => {
        //         const result = this._formatResult(registration);
        //         timetablingResgistration.push(...result);
        //     });
        // }
        // return timetablingResgistration;
        return TimetablingDAO.getRegistration();
    }

    getGroup() {
        return TimetablingDAO.getGroup();
    }

    getSingleGroup(groupID) {
        return TimetablingDAO.getSingleGroup(groupID);
    }

    getGroupByLecturer(lecturerID) {
        return TimetablingDAO.getGroupByLecturer(lecturerID);
    }

    getRegistrationByEmail(email) {
        // const courses = await CourseDAO.getByEmail(email);
        // var timetablingResgistration = [];
        // for (let i = 0; i < courses.length; i++) {
        //     await TimetablingDAO.findTimetablingRegistration(
        //         courses[i].id,
        //     ).then((registration) => {
        //         const result = this._formatResult(registration);
        //         timetablingResgistration.push(...result);
        //     });
        // }
        // // console.log(timetabling);
        // return timetablingResgistration;
        return TimetablingDAO.getRegistrationByEmail(email);
    }

    async getRegistrationByWeek(weekID) {
        return TimetablingDAO.getRegistrationByWeek(weekID);
    }

    _formatResult(registrationData) {
        // registrationData.map(e => console.log(e.trang_thai));
        const output = registrationData.reduce(function (o, cur) {
            var occurs = o.reduce(function (n, item, i) {
                return item.ma_nhom === cur.ma_nhom &&
                    item.lop_hoc_phan_id === cur.lop_hoc_phan_id &&
                    item.nhom_th_id === cur.nhom_th_id
                    ? i
                    : n;
            }, -1);

            if (occurs >= 0) {
                if (cur.trang_thai) {
                    o[occurs].da_xep.push(cur.tuan_id);
                } else {
                    o[occurs].chua_xep.push(cur.tuan_id);
                }
                o[occurs].da_xep.sort();
                o[occurs].chua_xep.sort();
            } else {
                var obj = {
                    ...cur,
                    id: cur.id,
                    da_xep: cur.trang_thai ? [cur.tuan_id] : [],
                    chua_xep: cur.trang_thai ? [] : [cur.tuan_id],
                };
                o = o.concat([obj]);
            }

            return o;
        }, []);

        return output;
    }

    create(timetablingDto) {
        return TimetablingDAO.createTimetabling(timetablingDto);
    }

    async register(groupID, weekList) {
        for (let i = 0; i < weekList.length; i++) {
            await TimetablingDAO.createRegistration(groupID, weekList[i]);
        }
        return true;
    }

    async checkAvailableRoom(data) {
        let timetableDto = {
            tuan_id: data.tuan_id,
            thu_id: data.thu_id,
            buoi_hoc_id: data.buoi_hoc_id,
            phong_id: data.phong_id,
        };
        let timetable = await TimetablingDAO.getSingleFull(timetableDto);
        let err = await TimetablingCloneService.checkLabMatched(
            data.cur_timetable,
            data.phong_id,
        );
        return [timetable, err];
    }

    upload() {
        let storage = multer.diskStorage({
            destination: function (req, file, cb) {
                cb(null, './uploads');
            },
            filename: function (req, file, cb) {
                cb(null, 'Dang-Ky-Thuc-Hanh' + '.xlsx');
            },
        });

        return multer({ storage: storage });
    }

    updateTimetable(id, timetableDto) {
        return TimetablingDAO.updateTimetable(id, timetableDto);
    }

    updateGroup(groupDto) {
        return TimetablingDAO.updateGroup(groupDto);
    }

    updateSingleGroup(groupID, groupDto) {
        return TimetablingDAO.updateSingleGroup(groupID, groupDto);
    }

    updateStatusRegistration(groupID, weekID, status) {
        return TimetablingDAO.updateStatusRegistration(groupID, weekID, status);
    }

    updateAllStatusRegistration(status) {
        return TimetablingDAO.updateAllStatusRegistration(status);
    }

    async readFile(file) {
        const workbook = new Excel.Workbook();
        const newWorkbook = new Excel.Workbook();
        const path = file.path;
        const newPath = 'uploads\\Quan-Ly-Thuc-Hanh.xlsx';
        const sheetString = 'Mau-Quan-Ly-Thuc-Hanh';
        const sheetName = file.originalname.slice(0, -5);
        const options = {
            useSharedStrings: true,
            useStyles: true,
        };
        let breakIndex = 9;

        await workbook.xlsx.readFile(path);
        await newWorkbook.xlsx.readFile(newPath);

        const worksheet = workbook.getWorksheet(sheetString);
        var newWorksheet = newWorkbook.getWorksheet(sheetName);

        if (newWorksheet != undefined) {
            newWorkbook.removeWorksheet(newWorksheet.id);
        }
        newWorksheet = newWorkbook.addWorksheet(sheetName);

        for (const property in worksheet._merges) {
            newWorksheet.mergeCells(`${worksheet._merges[property]}`);
        }

        let groupCount = worksheet.getCell(`G${breakIndex}`).value;
        while (groupCount != null) {
            groupCount = worksheet.getCell(`G${breakIndex}`).value;

            if (groupCount != null) {
                for (let i = 0; i < groupCount; i++) {
                    const timeTablingDto = {};
                    const subjectName = worksheet.getCell(
                        `B${breakIndex}`,
                    ).value;
                    const subjectGroup = worksheet.getCell(
                        `D${breakIndex}`,
                    ).value;
                    const studentQuantity = worksheet.getCell(
                        `I${breakIndex}`,
                    ).value;
                    const groupID = worksheet.getCell(`H${breakIndex}`).value;
                    const subject = await SubjectDAO.getById2(subjectName);
                    const course = await CourseDAO.getByGroupAndSubject(
                        subjectGroup.slice(1),
                        subject.id,
                    );
                    const weekID = [];
                    // console.log(subjectName + `(${subjectGroup})` + ": " + studentQuantity);

                    timeTablingDto.lop_hoc_phan_id = course.id;
                    timeTablingDto.so_luong_sinh_vien = studentQuantity;
                    timeTablingDto.ma_nhom = groupID;
                    timeTablingDto.trang_thai = true;

                    for (let j = 0; j <= 5; j++) {
                        const _weekCell = worksheet.getCell(
                            `J${breakIndex + j}`,
                        ).value;

                        if (_weekCell != null) {
                            const week = await WeekDAO.getById(_weekCell);
                            weekID.push(week.id);
                            // console.log(timeTablingDto);
                        }
                    }

                    timeTablingDto.tuan_id = weekID;

                    await TimetablingDAO.register(timeTablingDto);

                    if (groupCount > 1) {
                        breakIndex += 6;
                    }
                }

                if (groupCount < 2) {
                    breakIndex += 6;
                }
            }
        }

        worksheet.eachRow((row, rowNumber) => {
            row.eachCell({ includeEmpty: true }, (cell, rowNumber) => {
                newWorksheet.getCell(cell.$col$row).value = cell.value;
                newWorksheet.getCell(cell.$col$row).style = cell.style;
            });
        });

        await newWorkbook.xlsx.writeFile(newPath, options);

        return await TimetablingDAO.getAll();

        // return TimetablingDAO.getAll();
    }

    async delete() {
        await TimetablingDAO.delete();
    }
}

module.exports = new TimetablingService();
