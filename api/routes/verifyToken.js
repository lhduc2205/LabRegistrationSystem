const jwt = require('jsonwebtoken');

function auth(req, res, next) {
    const token = req.header('auth-token');
    if (!token) {
        return res.status(400).send('Access Denied');
    }

    try {
        const verifield = jwt.verify(token, process.env.TOKEN_SECRET);
        req.user = verifield;
    } catch (error) {
        res.status(400).send('Invalid Token');
    }
}
