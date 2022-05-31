const accountDAO = require('../dao/account_dao');
const LecturerService = require('./lecturer_service');

class AccountService {
    getAll() {
        return accountDAO.getAll();
    }

    create(accountDto) {
        const { email, mat_khau } = accountDto;
        return accountDAO.create(email, mat_khau);
    }

    async login(accountDto) {
        const { email, mat_khau } = accountDto;
        const result = await accountDAO.login(email, mat_khau);
        if (result != null) {
            return LecturerService.getFullInfo(email);
        }
        return null;
    }

    delete(email) {
        return accountDAO.delete(email);
    }
}

module.exports = new AccountService();
