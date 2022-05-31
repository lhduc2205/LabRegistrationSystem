/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> } 
 */
exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('ChiTietHocKyNienKhoa').del()
    .then(function () {
      // Inserts seed entries
      return knex('ChiTietHocKyNienKhoa').insert([
        {
          ngay_bat_dau: '01-03-2022',
          ngay_ket_thuc: '01-09-2022',
          tuan_id: 1,
          hoc_ky_nien_khoa_id: 1
        },
        {
          ngay_bat_dau: '01-10-2022',
          ngay_ket_thuc: '01-16-2022',
          tuan_id: 2,
          hoc_ky_nien_khoa_id: 1
        },
        {
          ngay_bat_dau: '01-17-2022',
          ngay_ket_thuc: '01-23-2022',
          tuan_id: 3,
          hoc_ky_nien_khoa_id: 1
        },
        {
          ngay_bat_dau: '01-24-2022',
          ngay_ket_thuc: '01-30-2022',
          tuan_id: 4,
          hoc_ky_nien_khoa_id: 1
        },
        {
          ngay_bat_dau: '02-07-2022',
          ngay_ket_thuc: '02-13-2022',
          tuan_id: 5,
          hoc_ky_nien_khoa_id: 1
        },
        {
          ngay_bat_dau: '02-14-2022',
          ngay_ket_thuc: '02-20-2022',
          tuan_id: 6,
          hoc_ky_nien_khoa_id: 1
        },
        {
          ngay_bat_dau: '02-21-2022',
          ngay_ket_thuc: '02-27-2022',
          tuan_id: 7,
          hoc_ky_nien_khoa_id: 1
        },
        {
          ngay_bat_dau: '03-06-2022',
          ngay_ket_thuc: '03-13-2022',
          tuan_id: 8,
          hoc_ky_nien_khoa_id: 1
        },
        {
          ngay_bat_dau: '03-14-2022',
          ngay_ket_thuc: '03-20-2022',
          tuan_id: 9,
          hoc_ky_nien_khoa_id: 1
        },
        {
          ngay_bat_dau: '03-21-2022',
          ngay_ket_thuc: '03-27-2022',
          tuan_id: 10,
          hoc_ky_nien_khoa_id: 1
        },
        {
          ngay_bat_dau: '03-28-2022',
          ngay_ket_thuc: '04-03-2022',
          tuan_id: 11,
          hoc_ky_nien_khoa_id: 1
        },
        {
          ngay_bat_dau: '04-04-2022',
          ngay_ket_thuc: '04-10-2022',
          tuan_id: 12,
          hoc_ky_nien_khoa_id: 1
        },
        {
          ngay_bat_dau: '04-11-2022',
          ngay_ket_thuc: '04-17-2022',
          tuan_id: 13,
          hoc_ky_nien_khoa_id: 1
        },
        {
          ngay_bat_dau: '04-18-2022',
          ngay_ket_thuc: '04-24-2022',
          tuan_id: 14,
          hoc_ky_nien_khoa_id: 1
        },
        {
          ngay_bat_dau: '04-25-2022',
          ngay_ket_thuc: '05-01-2022',
          tuan_id: 15,
          hoc_ky_nien_khoa_id: 1
        },
        {
          ngay_bat_dau: '05-02-2022',
          ngay_ket_thuc: '05-08-2022',
          tuan_id: 16,
          hoc_ky_nien_khoa_id: 1
        },
        {
          ngay_bat_dau: '05-09-2022',
          ngay_ket_thuc: '05-15-2022',
          tuan_id: 17,
          hoc_ky_nien_khoa_id: 1
        },
        {
          ngay_bat_dau: '05-16-2022',
          ngay_ket_thuc: '05-22-2022',
          tuan_id: 18,
          hoc_ky_nien_khoa_id: 1
        },
        {
          ngay_bat_dau: '05-23-2022',
          ngay_ket_thuc: '05-29-2022',
          tuan_id: 19,
          hoc_ky_nien_khoa_id: 1
        },
        {
          ngay_bat_dau: '05-30-2022',
          ngay_ket_thuc: '06-05-2022',
          tuan_id: 20,
          hoc_ky_nien_khoa_id: 1
        },
      ]);
    });
};
