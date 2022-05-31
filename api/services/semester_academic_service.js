const semesterAcademicDAO = require('../dao/semester_academic_dao');
const SemesterDetailDAO = require('../dao/semester_detail_dao');

class SemesterAcademicService {
    getAll() {
        return semesterAcademicDAO.getAll();
    }

    getByDate(date) {
        return semesterAcademicDAO.getByDate(date);
    }

    getFullByDate(date) {
        return SemesterDetailDAO.getFullByDate(date);
    }

    getCurrent() {
        var format = require('date-format');
        const date = format('MM-dd-yyyy', new Date());
        const semester = this.getByDate(date);
        return semester;
    }

    update(id, updatedData) {
        return semesterAcademicDAO.update(id, updatedData);
    }
}

module.exports = new SemesterAcademicService();
