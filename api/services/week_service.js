const weekDAO = require('../dao/week_dao');

class WeekService {
    getAll() {
        return weekDAO.getAll();
    }

    getById(id) {
        return weekDAO.getById(id);
    }
}

module.exports = new WeekService();
