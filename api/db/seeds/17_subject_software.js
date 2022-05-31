/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.seed = function (knex) {
    // Deletes ALL existing entries
    return knex('MonHocPhanMem')
        .del()
        .then(function () {
            // Inserts seed entries
            return knex('MonHocPhanMem')
                .del()
                .then(function () {
                    // Inserts seed entries
                    return knex('MonHocPhanMem').insert([
                        { mon_hoc_id: 2, phan_mem_id: 1 },
                        { mon_hoc_id: 4, phan_mem_id: 1 },
                        { mon_hoc_id: 4, phan_mem_id: 2 },
                        { mon_hoc_id: 6, phan_mem_id: 4 },
                    ]);
                });
        });
};
