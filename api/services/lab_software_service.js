const labSoftwareDAO = require('../dao/lab_software_dao');

class LabSoftwareService {
    getAll() {
        return labSoftwareDAO.getAll();
    }

    getSingle(labId) {
        return labSoftwareDAO.getSingle(labId);
    }

    create(reqData) {
        const { id, phan_mem_id, ...labData } = reqData;
        return labSoftwareDAO.create(phan_mem_id, labData);
    }

    update(labId, reqData) {
        const { id, phan_mem_id, ...labData } = reqData;
        return labSoftwareDAO.update(labId, phan_mem_id, labData);
    }

    delete(labId) {
        return labSoftwareDAO.delete(labId);
    }

    formatResult(labData) {
        const output = labData.reduce(function (o, cur) {
            var occurs = o.reduce(function (n, item, i) {
                return item.id === cur.id ? i : n;
            }, -1);

            if (occurs >= 0) {
                o[occurs].phan_mem_id = o[occurs].phan_mem_id.concat(
                    cur.phan_mem_id,
                );
                o[occurs].phan_mem_id.sort();
            } else {
                var obj = {
                    ...cur,
                    id: cur.id,
                    phan_mem_id:
                        cur.phan_mem_id != null ? [cur.phan_mem_id] : [],
                };
                o = o.concat([obj]);
            }

            return o;
        }, []);

        return output;
    }
}

module.exports = new LabSoftwareService();
