const dayDAO = require('../dao/day_dao');

class DayService {
    getAll() {
        return dayDAO.getAll();
    }
}

module.exports = new DayService();
