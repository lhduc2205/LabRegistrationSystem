/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.seed = function (knex) {
    // Deletes ALL existing entries
    return knex('PhongPhanMem')
        .del()
        .then(function () {
            // Inserts seed entries
            return knex('PhongPhanMem').insert([
                { phong_id: 1, phan_mem_id: 1 },
                { phong_id: 1, phan_mem_id: 2 },
                { phong_id: 1, phan_mem_id: 3 },
                { phong_id: 1, phan_mem_id: 4 },
                { phong_id: 2, phan_mem_id: 2 },
                { phong_id: 3, phan_mem_id: 1 },
                { phong_id: 3, phan_mem_id: 3 },
            ]);
        });
};
