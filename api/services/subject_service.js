const subjectDAO = require('../dao/subject_dao');

class SubjectService {
    getAll() {
        return subjectDAO.getAll();
    }
}

module.exports = new SubjectService();
