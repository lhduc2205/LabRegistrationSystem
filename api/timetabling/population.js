const Schedule = require('./schedule');

class Population {
    constructor(size, data) {
        this.size = size;
        this.data = data;
        this.schedules = [];

        for (let i = 0; i < size; i++) {
            this.schedules.push(new Schedule(data).initialize());
        }
    }

    get_schedules() {
        return this.schedules;
    }
}

module.exports = Population;
