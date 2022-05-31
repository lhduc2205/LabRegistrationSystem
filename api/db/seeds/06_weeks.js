/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.seed = function (knex) {
    // Deletes ALL existing entries
    return knex('Tuan')
        .del()
        .then(function () {
            // Inserts seed entries
            return knex('Tuan').insert([
                { ma_tuan: 1, ten_tuan: 'tuần 1' },
                { ma_tuan: 2, ten_tuan: 'tuần 2' },
                { ma_tuan: 3, ten_tuan: 'tuần 3' },
                { ma_tuan: 4, ten_tuan: 'tuần 4' },
                { ma_tuan: 5, ten_tuan: 'tuần 5' },
                { ma_tuan: 6, ten_tuan: 'tuần 6' },
                { ma_tuan: 7, ten_tuan: 'tuần 7' },
                { ma_tuan: 8, ten_tuan: 'tuần 8' },
                { ma_tuan: 9, ten_tuan: 'tuần 9' },
                { ma_tuan: 10, ten_tuan: 'tuần 10' },
                { ma_tuan: 11, ten_tuan: 'tuần 11' },
                { ma_tuan: 12, ten_tuan: 'tuần 12' },
                { ma_tuan: 13, ten_tuan: 'tuần 13' },
                { ma_tuan: 14, ten_tuan: 'tuần 14' },
                { ma_tuan: 15, ten_tuan: 'tuần 15' },
                { ma_tuan: 16, ten_tuan: 'tuần 16' },
                { ma_tuan: 17, ten_tuan: 'tuần 17' },
                { ma_tuan: 18, ten_tuan: 'tuần 18' },
                { ma_tuan: 19, ten_tuan: 'tuần 19' },
                { ma_tuan: 20, ten_tuan: 'tuần 20' },
                { ma_tuan: 21, ten_tuan: 'tuần 21' },
                { ma_tuan: 22, ten_tuan: 'tuần 22' },
            ]);
        });
};
