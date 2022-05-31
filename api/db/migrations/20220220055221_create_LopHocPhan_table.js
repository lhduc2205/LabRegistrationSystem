/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.up = function (knex) {
    return knex.schema.createTable('LopHocPhan', (table) => {
        table.increments('id').primary();
        table.string('ma_lop_hoc_phan').notNullable();
        table.integer('so_luong_sinh_vien').nullable();
        table.integer('thu_id').notNullable().references('id').inTable('Thu');
        table
            .integer('mon_hoc_id')
            .notNullable()
            .references('id')
            .inTable('MonHoc');
        table
            .integer('buoi_hoc_id')
            .notNullable()
            .references('id')
            .inTable('BuoiHoc');
        table
            .integer('giang_vien_id')
            .nullable()
            .references('id')
            .inTable('GiangVien');
        table
            .integer('hoc_ky_nien_khoa_id')
            .notNullable()
            .references('id')
            .inTable('HocKyNienKhoa');
    });
};

/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.down = function (knex) {
    return knex.schema.dropTable('LopHocPhan');
};
