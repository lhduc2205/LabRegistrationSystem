/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.seed = function (knex) {
    // Deletes ALL existing entries
    return knex('BuoiHoc')
        .del()
        .then(function () {
            // Inserts seed entries
            return knex('BuoiHoc').insert([
                { ma_buoi_hoc: 'sang', ten_buoi_hoc: 'sáng' },
                { ma_buoi_hoc: 'chieu', ten_buoi_hoc: 'chiều' },
                // { ma_buoi_hoc: 'toi', ten_buoi_hoc: 'tối' },
            ]);
        });
};
