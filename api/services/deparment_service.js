const departmentDAO = require('../dao/department_dao');

class DepartmentService {
    create(departmentDto) {
        const { ten_bo_mon, viet_tat } = departmentDto;
        return departmentDAO.create(ten_bo_mon, viet_tat);
    }

    getAll() {
        return departmentDAO.getAll();
    }

    get(id) {
        return departmentDAO.get(id);
    }

    check(departmentDto) {
        const { ten_bo_mon, viet_tat } = departmentDto;
        return departmentDAO.check(ten_bo_mon, viet_tat);
    }

    update(id, departmentDto) {
        const { ten_bo_mon, viet_tat } = departmentDto;
        return departmentDAO.update(id, ten_bo_mon, viet_tat);
    }

    delete(id) {
        return departmentDAO.delete(id);
    }
}

module.exports = new DepartmentService();
