const SemesterDetailDAO = require('../dao/semester_detail_dao');

class SemesterDetailService {
    getFull() {
        return SemesterDetailDAO.getFull();
    }

    getSingle(semesterID, weekID) {
        return SemesterDetailDAO.getSingle(semesterID, weekID);
    }

    // getByDate(date) {
    //     return SemesterDetailDAO.getByDate(date);
    // }

    // update(id, updatedData) {
    //     return SemesterDetailDAO.update(id, updatedData);
    // }
}

module.exports = new SemesterDetailService();
