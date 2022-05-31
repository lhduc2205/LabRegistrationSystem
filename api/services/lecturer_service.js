const lecturerDAO = require('../dao/lecturer_dao');

class LecturerService {
    getAll() {
        return lecturerDAO.getAll();
    }

    getSingle(email) {
        return lecturerDAO.getSingle(email);
    }

    getFullInfo(email) {
        return lecturerDAO.getFullInfo(email);
    }

    create(reqBody) {
        delete reqBody.data.ten_bo_mon;
        delete reqBody.data.id;

        const lecturerData = reqBody.data;
        const accountData = {
            email: lecturerData.email_gv,
            mat_khau: reqBody.mat_khau,
        };

        lecturerData.email_gv = null;

        return lecturerDAO.createLecturer(accountData, lecturerData);
    }

    update(id, reqBody) {
        const lecturerInfo = reqBody.data;

        if (!reqBody.is_changed_ma_gv) {
            delete lecturerInfo.ma_gv;
        }
        delete lecturerInfo.id;
        delete lecturerInfo.email_gv;
        delete lecturerInfo.ten_bo_mon;
        delete lecturerInfo.ten_vai_tro;
        delete lecturerInfo.ma_vai_tro;

        return lecturerDAO.update(id, lecturerInfo);
    }

    delete(id, reqBody) {
        const { email } = reqBody;
        return lecturerDAO.delete(id, email);
    }
}

module.exports = new LecturerService();
