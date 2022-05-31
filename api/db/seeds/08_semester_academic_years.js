/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.seed = function (knex) {
    // Deletes ALL existing entries
    return knex('HocKyNienKhoa')
        .del()
        .then(function () {
            // Inserts seed entries
            return knex('HocKyNienKhoa').insert([
                {
                    ngay_bat_dau: '01-03-2022',
                    so_tuan: 20,
                    hoc_ky_id: 2,
                    nien_khoa_id: 1,
                },
            ]);
        });
};
