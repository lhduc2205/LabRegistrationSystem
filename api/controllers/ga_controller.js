const ClassScheduling = require('../timetabling');

class GAController {
    async scheduling(req, res) {
        try {
            const result = await ClassScheduling.scheduling();
            res.status('200').json(result);
        } catch (error) {
            res.status('500').json();
        }
    }
}

module.exports = new GAController();
