/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.seed = function (knex) {
    // Deletes ALL existing entries
    return knex('HocKy')
        .del()
        .then(function () {
            // Inserts seed entries
            return knex('HocKy').insert([
                { ma_hoc_ky: 'hk1', ten_hoc_ky: 'học kỳ 1' },
                { ma_hoc_ky: 'hk2', ten_hoc_ky: 'học kỳ 2' },
                { ma_hoc_ky: 'hk3', ten_hoc_ky: 'học kỳ 3' },
            ]);
        });
};
