/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.up = function(knex) {
    return knex.schema.createTable('ChiTietHocKyNienKhoa', (table) => {
        table.increments('id').primary();
        table.date('ngay_bat_dau').notNullable();
        table.date('ngay_ket_thuc').notNullable();
        table.integer('tuan_id').notNullable().references('id').inTable('Tuan');
        table.integer('hoc_ky_nien_khoa_id').notNullable().references('id').inTable('HocKyNienKhoa');
    });
};

/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.down = function(knex) {
    return knex.schema.dropTable('ChiTietHocKyNienKhoa');
};
