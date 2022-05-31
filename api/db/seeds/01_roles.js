/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.seed = function (knex) {
    // Deletes ALL existing entries
    return knex('VaiTro')
        .del()
        .then(function () {
            // Inserts seed entries
            return knex('VaiTro').insert([
                { ma_vai_tro: 'admin', ten_vai_tro: 'quản trị viên' },
                { ma_vai_tro: 'user', ten_vai_tro: 'người dùng' },
            ]);
        });
};
