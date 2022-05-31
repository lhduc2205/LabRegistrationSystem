/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.up = function(knex) {
    return knex.schema.createTable('HocKyNienKhoa', (table) => {
        table.increments('id').primary();
        table.date('ngay_bat_dau').notNullable();
        table.date('ngay_ket_thuc').nullable();
        table.integer('so_tuan').notNullable();
        table.integer('hoc_ky_id').notNullable().references('id').inTable('HocKy');
        table.integer('nien_khoa_id').notNullable().references('id').inTable('NienKhoa');
    });
};

/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.down = function(knex) {
    return knex.schema.dropTable('HocKyNienKhoa');
};
