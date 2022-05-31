const softwareDAO = require('../dao/software_dao');

class SoftwareService {
    getAll() {
        return softwareDAO.getAll();
    }
}

module.exports = new SoftwareService();
