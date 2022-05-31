/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.seed = function (knex) {
    // Deletes ALL existing entries
    return knex('Thu')
        .del()
        .then(function () {
            // Inserts seed entries
            return knex('Thu').insert([
                { ma_thu: '2', ten_thu: '2' },
                { ma_thu: '3', ten_thu: '3' },
                { ma_thu: '4', ten_thu: '4' },
                { ma_thu: '5', ten_thu: '5' },
                { ma_thu: '6', ten_thu: '6' },
                { ma_thu: '7', ten_thu: '7' },
                { ma_thu: '8', ten_thu: 'chủ nhật' },
            ]);
        });
};
