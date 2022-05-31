/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.seed = function (knex) {
    // Deletes ALL existing entries
    return knex('GiangVien')
        .del()
        .then(function () {
            // Inserts seed entries
            return knex('GiangVien').insert([
                {
                    ho_ten: 'Admin',
                    ma_gv: '0001',
                    gioi_tinh: 0,
                    ngay_sinh: '05-22-2000',
                    sdt: '0834987648',
                    bo_mon_id: 1,
                    email_gv: 'admin',
                },
                {
                    ho_ten: 'Trần Công Án',
                    ma_gv: '0002',
                    gioi_tinh: 0,
                    ngay_sinh: '05-22-2000',
                    sdt: '0834987648',
                    bo_mon_id: 1,
                    email_gv: 'tca@cit.ctu.edu.vn',
                },
                {
                    ho_ten: 'Lâm Nhựt Khang',
                    ma_gv: '0003',
                    gioi_tinh: 1,
                    ngay_sinh: '05-22-2000',
                    sdt: '0834987648',
                    bo_mon_id: 5,
                    email_gv: 'lnk@cit.ctu.edu.vn',
                },
            ]);
        });
};
