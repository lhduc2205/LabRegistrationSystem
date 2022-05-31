const SubjectSoftwareDAO = require('../dao/subject_software_dao');

class SubjectSoftwareService {
    getAll() {
        return SubjectSoftwareDAO.getAll();
    }

    getSingle(subjectID) {
        return SubjectSoftwareDAO.getSingle(subjectID);
    }

    create(reqData) {
        const { id, phan_mem_id, ...subjectData } = reqData;
        return SubjectSoftwareDAO.create(phan_mem_id, subjectData);
    }

    checkInclude(subjectSoftware, labSoftware) {
        return subjectSoftware.every((software) =>
            labSoftware.includes(software),
        );
    }

    update(subjectID, reqData) {
        const { id, phan_mem_id, ...subjectData } = reqData;
        return SubjectSoftwareDAO.update(subjectID, phan_mem_id, subjectData);
    }

    delete(subjectID) {
        return SubjectSoftwareDAO.delete(subjectID);
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

module.exports = new SubjectSoftwareService();
