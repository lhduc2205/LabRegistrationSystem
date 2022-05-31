const labDAO = require('../dao/lab_dao');
class LabService {
    getAll() {
        return labDAO.getAll();
    }

    async getFull() {
        const data = await labDAO.getFull();
        const result = this._formatResult(data);
        return result;
    }

    _formatResult(labData) {
        const output = labData.reduce(function (o, cur) {
            var occurs = o.reduce(function (n, item, i) {
                return item.id === cur.id ? i : n;
            }, -1);

            if (occurs >= 0) {
                o[occurs].phan_mem_id = o[occurs].phan_mem_id.concat(
                    cur.phan_mem_id,
                );
                o[occurs].ma_phan_mem = o[occurs].ma_phan_mem.concat(
                    cur.ma_phan_mem,
                );
                o[occurs].ten_phan_mem = o[occurs].ten_phan_mem.concat(
                    cur.ten_phan_mem,
                );
                o[occurs].phien_ban = o[occurs].phien_ban.concat(cur.phien_ban);
                // o[occurs].phan_mem_id.sort();
            } else {
                var obj = {
                    ...cur,
                    id: cur.id,
                    phan_mem_id:
                        cur.phan_mem_id != null ? [cur.phan_mem_id] : [],
                    ma_phan_mem:
                        cur.ma_phan_mem != null ? [cur.ma_phan_mem] : [],
                    ten_phan_mem:
                        cur.ten_phan_mem != null ? [cur.ten_phan_mem] : [],
                    phien_ban: cur.phien_ban != null ? [cur.phien_ban] : [],
                };
                o = o.concat([obj]);
            }

            return o;
        }, []);

        return output;
    }
}

module.exports = new LabService();
