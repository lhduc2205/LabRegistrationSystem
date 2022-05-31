const ClassModel = require('./class_model');
const Helpers = require('../helpers');

class Schedule {
    constructor(data) {
        this.data = data;
        this.classes = [];
        this.numbOfConflicts = 0;
        this.conflict = [];
        this.fitness = -1;
        this.classNumb = 0;
        this.isFitnessChanged = true;
    }

    initialize() {
        for (let i = 0; i < this.data.course.length; i++) {
            let newClass = new ClassModel(this.classNumb, this.data.course[i]);
            this.classNumb++;

            newClass.room =
                this.data.room[
                    Helpers.getRandomInt(0, this.data.room.length - 1)
                ];
            // newClass.day =
            //     this.data.day[
            //     Helpers.getRandomInt(0, this.data.day.length - 1)
            //     ];
            // newClass.period =
            //     this.data.period[
            //     Helpers.getRandomInt(0, this.data.period.length - 1)
            //     ];

            newClass.day = this.data.day[this.data.course[i].thu_id - 1];
            newClass.period =
                this.data.period[this.data.course[i].buoi_hoc_id - 1];

            this.classes.push(newClass);
        }

        return this;
    }

    getFitness() {
        if (this.isFitnessChanged == true) {
            this.fitness = this.calculate_fitness();
            this.isFitnessChanged = false;
        }
        return this.fitness;
    }

    getClasses() {
        this.isFitnessChanged = true;
        return this.classes;
    }

    calculate_fitness() {
        this.numbOfConflicts = 0;
        this.conflict = [];
        // this.conflict.software = [];
        // this.conflict.course = [];
        // this.conflict.slot = [];
        let classes = this.getClasses();
        // console.log(classes[0].course);

        for (let i = 0; i < classes.length; i++) {
            if (classes[i].room.so_cho_ngoi < classes[i].course.slsv_nhom) {
                this.numbOfConflicts++;
                this.conflict.push(classes[i].course);
            }

            const isContain = classes[i].course.phan_mem_id.every((software) =>
                classes[i].room.phan_mem_id.includes(software),
            );
            if (!isContain) {
                this.numbOfConflicts++;
                this.conflict.push(classes[i].course);
            }

            var isExisted = false;

            for (let j = 0; j < classes.length; j++) {
                if (j > i) {
                    if (
                        classes[i].day.id == classes[j].day.id &&
                        classes[i].period.id == classes[j].period.id &&
                        classes[i].id != classes[j].id
                    ) {
                        if (
                            classes[i].room.id == classes[j].room.id

                            // classes[i].day.id == classes[j].day.id &&
                            // classes[i].period.id == classes[j].period.id
                        ) {
                            this.numbOfConflicts++;
                            this.conflict.push(classes[j].course);
                        }
                    }
                }
            }
        }

        return 1 / (1.0 * this.numbOfConflicts + 1);
    }

    checkAvailableRoom(curClasses, nextClasses) {
        if (
            curClasses.course.buoi_hoc_id != curClasses.period.id &&
            curClasses.course.thu_id != curClasses.day.id
        ) {
            if (
                curClasses.course.buoi_hoc_id != nextClasses.period.id &&
                curClasses.course.thu_id != nextClasses.day.id &&
                curClasses.room.id != nextClasses.room.id
            ) {
                return true;
            } else {
                return false;
            }
        }
    }
}

module.exports = Schedule;
