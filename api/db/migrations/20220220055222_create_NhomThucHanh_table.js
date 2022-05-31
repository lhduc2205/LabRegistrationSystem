/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.up = function (knex) {
    return knex.schema.createTable('NhomThucHanh', (table) => {
        table.increments('id').primary();
        table.integer('ma_nhom').notNullable();
        table.integer('so_luong_sinh_vien').notNullable();
        table.boolean('trang_thai').defaultTo(false);
        table
            .integer('lop_hoc_phan_id')
            .notNullable()
            .references('id')
            .inTable('LopHocPhan');
    });
};

/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.down = function (knex) {
    return knex.schema.dropTable('NhomThucHanh');
};
