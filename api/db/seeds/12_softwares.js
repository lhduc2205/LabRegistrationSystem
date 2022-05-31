/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.seed = function (knex) {
    // Deletes ALL existing entries
    return knex('PhanMem')
        .del()
        .then(function () {
            // Inserts seed entries
            return knex('PhanMem').insert([
                {
                    ma_phan_mem: 'virtual_box',
                    ten_phan_mem: 'virtualBox',
                    phien_ban: '6.1.32',
                },
                {
                    ma_phan_mem: 'packet_tracer',
                    ten_phan_mem: 'packet tracer',
                    phien_ban: '8.0.0',
                },
                {
                    ma_phan_mem: 'dev_c',
                    ten_phan_mem: 'dev-C++',
                    phien_ban: '6.30',
                },
                {
                    ma_phan_mem: 'mysql',
                    ten_phan_mem: 'MySQL',
                    phien_ban: '8.0.28',
                },
                {
                    ma_phan_mem: 'eclipse',
                    ten_phan_mem: 'Eclipse',
                    phien_ban: '4.23',
                },
            ]);
        });
};
