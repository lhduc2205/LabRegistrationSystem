/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> } 
 */
exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('NienKhoa').del()
    .then(function () {
      // Inserts seed entries
      return knex('NienKhoa').insert([
        {nien_khoa: '2021-2022'},
        {nien_khoa: '2022-2023'},
        {nien_khoa: '2023-2024'},
      ]);
    });
};
