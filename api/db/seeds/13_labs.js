/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.seed = function (knex) {
    // Deletes ALL existing entries
    return knex('PhongThucHanh')
        .del()
        .then(function () {
            // Inserts seed entries
            return knex('PhongThucHanh').insert([
                {
                    ten_phong: 'P01/DI',
                    so_cho_ngoi: 40,
                    dung_luong_ram: 4096,
                    dung_luong_o_cung: 524288,
                    cpu: 'intel core i3',
                    gpu: '',
                    bo_mon_id: 1,
                },
                {
                    ten_phong: 'P02/DI',
                    so_cho_ngoi: 40,
                    dung_luong_ram: 4096,
                    dung_luong_o_cung: 524288,
                    cpu: 'intel core i3',
                    gpu: '',
                    bo_mon_id: 2,
                },
                {
                    ten_phong: 'P03/DI',
                    so_cho_ngoi: 60,
                    dung_luong_ram: 4096,
                    dung_luong_o_cung: 524288,
                    cpu: 'intel core i3',
                    gpu: '',
                    bo_mon_id: 3,
                },
                // {
                //     ten_phong: 'P04/DI',
                //     so_cho_ngoi: 60,
                //     dung_luong_ram: 8192,
                //     dung_luong_o_cung: 1024000,
                //     cpu: 'intel core i5',
                //     gpu: '',
                //     bo_mon_id: 1,
                // },
            ]);
        });
};
