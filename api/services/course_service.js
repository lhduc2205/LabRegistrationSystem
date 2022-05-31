const XLSX = require('xlsx');
const multer = require('multer');
const CourseDAO = require('../dao/course_dao');
const Excel = require('exceljs');
const StringHelpers = require('../helpers/string_helpers');
const ExcelHelpers = require('../helpers/excel_helpers');

class CourseService {
    getAll() {
        return CourseDAO.getAll();
    }

    getByEmail(lecturerEmail) {
        return CourseDAO.getByEmail(lecturerEmail);
    }

    getJoinByEmail(lecturerEmail) {
        return CourseDAO.getJoinByEmail(lecturerEmail);
    }

    getByGroupAndSubject(groupName, subjectID) {
        return CourseDAO.getByGroupAndSubject(groupName, subjectID);
    }

    create(classData) {
        return CourseDAO.create(classData);
    }

    upload() {
        var storage = multer.diskStorage({
            destination: function (req, file, cb) {
                cb(null, './uploads');
            },
            filename: function (req, file, cb) {
                cb(null, file.fieldname + '.xlsx');
            },
        });

        return multer({ storage: storage });
    }

    readFile(file) {
        const fileLocation = file.path;

        console.log(fileLocation);

        var workbook = XLSX.readFile(fileLocation);
        var sheet_name_list = workbook.SheetNames;

        workbook.Sheets[sheet_name_list[0]].A1.w = 'stt';
        workbook.Sheets[sheet_name_list[0]].B1.w = 'ma_gv';
        workbook.Sheets[sheet_name_list[0]].C1.w = 'ho_ten';
        workbook.Sheets[sheet_name_list[0]].D1.w = 'ma_mon_hoc';
        workbook.Sheets[sheet_name_list[0]].E1.w = 'so_tin_chi';
        workbook.Sheets[sheet_name_list[0]].F1.w = 'ma_lop_hoc_phan';
        workbook.Sheets[sheet_name_list[0]].G1.w = 'so_luong_sinh_vien';
        workbook.Sheets[sheet_name_list[0]].H1.w = 'ten_mon_hoc';
        workbook.Sheets[sheet_name_list[0]].I1.w = 'ma_thu';
        workbook.Sheets[sheet_name_list[0]].J1.w = 'tiet_hoc';

        let classJson = XLSX.utils.sheet_to_json(
            workbook.Sheets[sheet_name_list[0]],
        );

        classJson.map(
            (e) => (e.tiet_hoc = parseInt(e.tiet_hoc.split(', ')[0])),
        );

        return CourseDAO.createClassByExcel(classJson);
    }

    async getSample(courseDto, lecturerInfo, semester) {
        const workbook = new Excel.Workbook();
        const fileName = 'samples\\Mau-Quan-Ly-Thuc-Hanh.xlsx';
        const newFileName = `samples\\${lecturerInfo.email_gv}.xlsx`;
        const bgColorList = ['FFFCE4D6', 'FFFFFF00'];
        const eachTotalRow = 6;

        await workbook.xlsx.readFile(fileName);

        const worksheet = workbook.getWorksheet('Mau-Quan-Ly-Thuc-Hanh');
        var curRow = 9;
        var startRow = curRow + 1;
        var endRow = curRow;
        var breakPoint = [];
        var color = 0;

        this.fillInfo(worksheet, lecturerInfo, semester);

        for (let i = 0; i < courseDto.length; i++) {
            let groupCount = this.calGroupCount(
                courseDto[i].so_luong_sinh_vien,
            );

            worksheet.insertRow(curRow, [
                i + 1,
                courseDto[i].ma_mon_hoc,
                courseDto[i].so_tin_chi,
                "'" + courseDto[i].ma_lop_hoc_phan,
                courseDto[i].so_luong_sinh_vien,
                StringHelpers.capitalizeFirstLetter(courseDto[i].ten_mon_hoc),
                groupCount,
            ]);

            breakPoint.push(curRow);
            for (let group = 1; group <= groupCount; group++) {
                let bgColor = bgColorList[0];
                let soLuong = Math.round(
                    courseDto[i].so_luong_sinh_vien / groupCount,
                );
                if (group == 2) {
                    soLuong--;
                }

                if (color % 2 != 0) {
                    bgColor = bgColorList[1];
                }

                ExcelHelpers.setBackground(worksheet, curRow, bgColor);
                for (let i = 1; i <= 5; i++) {
                    worksheet.insertRow(curRow + i, []);
                    ExcelHelpers.setBackground(worksheet, curRow + i, bgColor);
                    endRow++;
                }
                color++;
                endRow++;
                ExcelHelpers.mergeEachGroup(
                    worksheet,
                    startRow - 1,
                    endRow - 1,
                    group,
                    soLuong,
                );
                startRow += eachTotalRow;
                curRow += eachTotalRow;
            }
            startRow = endRow + 1;
        }

        for (let i = 0; i < breakPoint.length; i++) {
            if (i == breakPoint.length - 1) {
                ExcelHelpers.mergeCells(worksheet, breakPoint[i], endRow - 1);
            } else {
                ExcelHelpers.mergeCells(
                    worksheet,
                    breakPoint[i],
                    breakPoint[i + 1] - 1,
                );
            }
        }

        worksheet.insertRow(endRow, []);
        for (let i = 9; i < endRow; i++) {
            ExcelHelpers.drawBorder(worksheet, i);
        }

        await workbook.xlsx.writeFile(`${newFileName}`);

        return newFileName;
    }

    fillInfo(worksheet, lecturerInfo, semester) {
        const hocKy = semester.ten_hoc_ky.toUpperCase();
        const nienKhoa = semester.nien_khoa.toUpperCase();

        worksheet.getCell(
            'A3',
        ).value = `Bộ môn: ${StringHelpers.capitalizeFirstLetter(
            lecturerInfo.ten_bo_mon,
        )}`;

        worksheet.getCell(
            'A4',
        ).value = `KẾ HOẠCH GIẢNG DẠY THỰC HÀNH ${hocKy} NĂM HỌC ${nienKhoa}`;

        worksheet.getCell('A5').value = `${hocKy} - NĂM HỌC ${nienKhoa}`;

        worksheet.getCell('B6').value =
            `Họ và tên CBGD: ${StringHelpers.capitalizeFirstEachLetter(
                lecturerInfo.ho_ten,
            )}` +
            ' - ' +
            `MACB: ${lecturerInfo.ma_gv}`;
    }

    calGroupCount(studentQuantity) {
        if (studentQuantity <= 60) {
            return 1;
        }
        return 2;
    }
}

module.exports = new CourseService();
