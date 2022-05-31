/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.seed = function (knex) {
    // Deletes ALL existing entries
    return knex('BoMon')
        .del()
        .then(function () {
            // Inserts seed entries
            return knex('BoMon').insert([
                { ten_bo_mon: 'công nghệ thông tin', viet_tat: 'cntt' },
                { ten_bo_mon: 'kỹ thuật phần mềm', viet_tat: 'ktpm' },
                { ten_bo_mon: 'khoa học máy tính', viet_tat: 'khmt' },
                { ten_bo_mon: 'hệ thống thông tin', viet_tat: 'httt' },
                { ten_bo_mon: 'mạng máy tính', viet_tat: 'mmt' },
            ]);
        });
};
