const TimetablingService = require('../services/timetabling_service');
const TimetableCloneService = require('../services/timetable_clone_service');
const LabSoftwareService = require('../services/lab_software_service');
const SubjectSoftwareService = require('../services/subject_software_service');
const ClassScheduling = require('../timetabling');
const LecturerService = require('../services/lecturer_service');

class TimetablingController {
    async getAll(req, res) {
        try {
            const result = await TimetablingService.getFull();
            res.status(200).json(result);
        } catch (err) {
            res.status(500).json(err);
        }
    }

    async getCloneFull(req, res) {
        try {
            const result = await TimetableCloneService.getFull();
            res.status(200).json(result);
        } catch (err) {
            res.status(500).json(err);
        }
    }

    async getClone(req, res) {
        try {
            const result = await TimetableCloneService.getAll();
            res.status(200).json(result);
        } catch (err) {
            res.status(500).json(err);
        }
    }

    async getCloneBasic(req, res) {
        try {
            const result = await TimetableCloneService.getAllBasic();
            res.status(200).json(result);
        } catch (err) {
            res.status(500).json(err);
        }
    }

    async getByEmail(req, res) {
        try {
            // const courses = await CourseService.getByEmail(req.params.email);
            // for(let i = 0; i < courses.length; i++) {

            // }
            const result = await TimetablingService.getByEmail(
                req.params.email,
            );
            res.status(200).json(result);
        } catch (err) {
            res.status(500).json(err);
        }
    }

    async getGroup(req, res) {
        try {
            const result = await TimetablingService.getGroup();
            res.status(200).json(result);
        } catch (err) {
            res.status(500).json(err);
        }
    }

    async getGroupByLecturer(req, res) {
        try {
            const lecturer = await LecturerService.getSingle(req.params.email);
            const result = await TimetablingService.getGroupByLecturer(
                lecturer.id,
            );
            res.status(200).json(result);
        } catch (err) {
            res.status(500).json(err);
        }
    }

    async getRegistration(req, res) {
        try {
            let result = await TimetablingService.getRegistration();
            result = TimetablingService._formatResult(result);

            // result = result.map((item) => {
            //     const { trang_thai, tuan_id, ...final } = item;
            //     return final;
            // });

            res.status(200).json(result);
        } catch (err) {
            res.status(500).json(err);
        }
    }

    async getRegistrationNoFormat(req, res) {
        try {
            let result = await TimetablingService.getRegistration();

            res.status(200).json(result);
        } catch (err) {
            res.status(500).json(err);
        }
    }

    async getRegistrationByWeek(req, res) {
        try {
            const result = await TimetablingService.getRegistrationByWeek(
                req.params.week,
            );
            res.status(200).json(result);
        } catch (err) {
            res.status(500).json(err);
        }
    }

    async getRegistrationByEmail(req, res) {
        try {
            let result = await TimetablingService.getRegistrationByEmail(
                req.params.email,
            );
            result = TimetablingService._formatResult(result);

            result = result.map((item) => {
                const { trang_thai, tuan_id, ...final } = item;
                return final;
            });

            res.status(200).json(result);
        } catch (err) {
            res.status(500).json(err);
        }
    }

    async createTimetable(req, res) {
        try {
            // await TimetablingService.create();
            const group = await TimetablingService.getSingleGroup(
                req.body.nhom_th_id,
            );

            const notification = await TimetableCloneService.checkLabMatched(
                group,
                req.body.phong_id,
            );

            if (notification.length == 0) {
                await TimetablingService.create(req.body);
                await TimetablingService.updateStatusRegistration(
                    req.body.nhom_th_id,
                    req.body.tuan_id,
                    true,
                );
            }
            const timetable = await TimetablingService.getSingleFull(req.body);

            res.status(200).json([timetable, notification]);
        } catch (err) {
            res.status(500).json(err);
        }
    }

    uploadSingle() {
        return TimetablingService.upload().single('timetable');
    }

    async readFile(req, res, next) {
        const file = req.file;

        if (!file) {
            const error = new Error('Please upload a file');
            error.httpStatusCode = 400;
            return next(error);
        }

        try {
            const result = await TimetablingService.readFile(file);

            res.status(200).json(result);
        } catch (error) {
            console.error(error);
            res.status(500).json('Lỗi! Không thể đọc file.');
        }
    }

    async scheduling(req, res) {
        try {
            let schedule = await ClassScheduling.scheduling();

            for (let i = 0; i < schedule.conflict.length; i++) {
                schedule.result = schedule.result.filter(
                    (res) =>
                        res.course.nhom_th_id !=
                            schedule.conflict[i].nhom_th_id ||
                        res.course.tuan_id != schedule.conflict[i].tuan_id,
                );
            }

            // schedule.result.map((e) => {
            //     console.log(
            //         `nhom: ${e.course.nhom_th_id} - tuan: ${e.course.tuan_id}`,
            //     );
            // });

            await TimetableCloneService.createClone(schedule.result);
            const result = await TimetableCloneService.getAll();
            const data = { timetable: result, conflict: schedule.conflict };
            res.status('200').json(data);
        } catch (error) {
            res.status('500').json(error);
        }
    }

    async saveToOfficial(req, res) {
        try {
            const clone = await TimetableCloneService.getAllBasic();
            const group = await TimetablingService.getGroup();

            await TimetablingService.delete();
            await TimetablingService.updateAllStatusRegistration(false);

            for (let i = 0; i < clone.length; i++) {
                const { id, ...data } = clone[i];
                await TimetablingService.create(data);
                await TimetablingService.updateStatusRegistration(
                    clone[i].nhom_th_id,
                    clone[i].tuan_id,
                    true,
                );
            }

            // for (let i = 0; i < group.length; i++) {
            //     const updatedData = { trang_thai: true };
            //     await TimetablingService.updateGroup(updatedData);
            // }

            await TimetableCloneService.delete();
            const timetable = await TimetablingService.getFull();

            res.status('200').json(timetable);
        } catch (error) {
            res.status('500').json();
        }
    }

    async register(req, res) {
        try {
            await TimetablingService.register(
                req.body.ma_nhom,
                req.body.tuan_th,
            );
            await TimetablingService.updateSingleGroup(req.body.ma_nhom, {
                trang_thai: true,
            });
            const result = await TimetablingService.getSingleGroup(
                req.body.ma_nhom,
            );
            console.log(result);
            res.status(200).json(result);
        } catch (error) {
            console.error(error);
            res.status(500).json('Lỗi! Không thể đọc file.');
        }
    }

    async updateClone(req, res) {
        try {
            const timetable = await TimetableCloneService.getSingleFull(
                req.body.source,
            );

            let notification = await TimetableCloneService.checkLabMatched(
                timetable,
                req.body.des.phong_id,
            );

            if (notification.length == 0) {
                timetable.thu_id = req.body.des.thu_id;
                timetable.phong_id = req.body.des.phong_id;

                const { id, ...updatedData } = timetable;
                await TimetableCloneService.updateClone(id, updatedData);
            }

            res.status('200').json(notification);
        } catch (error) {
            res.status('500');
        }
    }

    async updateTimetable(req, res) {
        try {
            await TimetablingService.updateTimetable(req.body.id, req.body);
            const timetable = await TimetablingService.getSingleFullByID(
                req.body.id,
            );
            console.log(timetable);
            res.status('200').json(timetable);
        } catch (error) {
            res.status('500');
        }
    }

    async updateTimetableWithDraggable(req, res) {
        try {
            const timetable = await TimetablingService.getSingleFull(
                req.body.source,
            );

            let notification = await TimetableCloneService.checkLabMatched(
                timetable,
                req.body.des.phong_id,
            );

            if (notification.length == 0) {
                timetable.thu_id = req.body.des.thu_id;
                timetable.phong_id = req.body.des.phong_id;

                // const { id, ...updatedData } = timetable;
                await TimetablingService.updateTimetable(
                    timetable.id,
                    timetable,
                );
            }

            res.status('200').json(notification);
        } catch (error) {
            res.status('500');
        }
    }

    async updateGroup(req, res) {
        try {
            const result = await TimetablingService.updateGroup(req.body);
            res.status(200).json(result);
        } catch (error) {
            console.error(error);
            res.status(500).json('Lỗi! Không thể đọc file.');
        }
    }

    async checkAvailableRoom(req, res) {
        try {
            console.log(req.body);
            const result = await TimetablingService.checkAvailableRoom(
                req.body,
            );
            let obj = {
                is_unoccupied: result[0] === undefined ? true : false,
                notification: result[1],
            };
            // console.log(obj);
            res.status(200).json(obj);
        } catch (error) {
            console.error(error);
            res.status(500).json('Lỗi! Không thể kiểm tra phòng hợp lệ.');
        }
    }

    async deleteRegistration(req, res) {
        try {
            const result = await TimetableCloneService.deleteRegistration();
            res.status(200).json(result);
        } catch (err) {
            res.status(500).json(err);
        }
    }
}

module.exports = new TimetablingController();
