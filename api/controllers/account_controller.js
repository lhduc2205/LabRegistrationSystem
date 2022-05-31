const accountService = require('../services/account_service');
var jwt = require('jsonwebtoken');

class AccountController {
    async getAll(req, res) {
        try {
            const accounts = await accountService.getAll();
            res.status(200).json(accounts);
        } catch (err) {
            console.error(err);
            res.status(500).json('Lỗi! Không thể kết nối CSDL');
        }
    }

    async create(req, res) {
        try {
            const id = await accountService.create(req.body);
            if (id != null) {
                res.status(201).json(id);
            }
        } catch (err) {
            console.error(err);
            res.status(500).json('Lỗi! Không thể đăng kí');
        }
    }

    async login(req, res) {
        // const email = req.body.email;
        // const user = { name: email };
        // const accessToken = jwt.sign(user, process.env.ACCESS_TOKEN_SECRET, { expiresIn: '15s' });
        // const refreshToken = jwt.sign(user, process.env.REFRESH_TOKEN_SECRET);
        // res.json({ accessToken: accessToken, refreshToken: refreshToken});
        try {
            const result = await accountService.login(req.body);
            result != null
                ? res.status(200).json(result)
                : res.status(400).json('Tài khoản hoặc mật khẩu không hợp lệ');
        } catch (err) {
            console.error(err);
            res.status(500).json('Lỗi! Không thể đăng nhập');
        }
    }

    async delete(req, res) {
        try {
            const result = await accountService.delete(req.params.email);
            result != null
                ? res
                      .status(200)
                      .json({ message: 'successfully', data: result })
                : res.status(400).json('Không tồn tại email');
        } catch (err) {
            console.error(err);
            res.status(500).json('Lỗi! Không thể xóa tài khoản');
        }
    }

    // authenticateToken(req, res, next) {
    //     const authHeader = req.headers['authorization'];
    //     const token = authHeader && authHeader.split(' ')[1];
    //     if(token == null){
    //         return res.sendStatus(401);
    //     }
    //     jwt.verify(token, process.env.ACCESS_TOKEN_SECRET, (err, user) => {
    //         if(err) {
    //             return res.sendStatus(403);
    //         }
    //         req.user = user;
    //         next();
    //     })
    // }

    // generateAccessToken(user) {
    //     return jwt.sign(user, process.env.ACCESS_TOKEN_SECRET, { expiresIn: '15s' });
    // }
}

module.exports = new AccountController();
