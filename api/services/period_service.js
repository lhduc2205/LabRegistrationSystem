const periodDAO = require('../dao/period_dao');

class PeriodService {
    getAll() {
        return periodDAO.getAll();
    }

    deleteSingle(id) {
        return periodDAO.deleteSingle(id);
    }
}

module.exports = new PeriodService();
