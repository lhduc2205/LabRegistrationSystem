/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.seed = function (knex) {
    // Deletes ALL existing entries
    return knex('MonHoc')
        .del()
        .then(function () {
            // Inserts seed entries
            return knex('MonHoc').insert([
                {
                    ma_mon_hoc: 'CT101',
                    ten_mon_hoc: 'Lập trình căn bản',
                    viet_tat: 'LTCB',
                    so_tin_chi: 4,
                },
                {
                    ma_mon_hoc: 'CT178',
                    ten_mon_hoc: 'Nguyên lý hệ điều hành',
                    viet_tat: 'NL HĐH',
                    so_tin_chi: 3,
                },
                {
                    ma_mon_hoc: 'CT179',
                    ten_mon_hoc: 'Quản trị hệ thống',
                    viet_tat: 'QTHT',
                    so_tin_chi: 3,
                },
                {
                    ma_mon_hoc: 'CT112',
                    ten_mon_hoc: 'Mạng máy tính',
                    viet_tat: 'MMT',
                    so_tin_chi: 3,
                },
                {
                    ma_mon_hoc: 'CT175',
                    ten_mon_hoc: 'Lý thuyết đồ thị',
                    viet_tat: 'LTĐT',
                    so_tin_chi: 3,
                },
                {
                    ma_mon_hoc: 'CT237',
                    ten_mon_hoc: 'Hệ quản trị cơ sở dữ liệu',
                    viet_tat: 'HQT CSDL',
                    so_tin_chi: 3,
                },
            ]);
        });
};
