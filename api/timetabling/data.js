const TimetableCloneService = require('../services/timetable_clone_service');
const LabService = require('../services/lab_service');
const DayService = require('../services/day_service');
const PeriodService = require('../services/period_service');

class Data {
    constructor() {
        this.course;
        this.room;
        this.day;
        this.period;
        this.numberOfClasses = 0;
    }

    async getData() {
        this.course = await TimetableCloneService.getFull();
        this.room = await LabService.getFull();
        this.day = await DayService.getAll();
        this.period = await PeriodService.getAll();
        this.numberOfClasses = this.course.length;
    }
}

module.exports = Data;
