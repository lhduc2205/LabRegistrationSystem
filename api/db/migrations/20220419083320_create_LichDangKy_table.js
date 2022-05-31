/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.up = function (knex) {
    return knex.schema.createTable('LichDangKy', (table) => {
        table.increments('id').primary();
        table.boolean('trang_thai').defaultTo(false);
        table.integer('tuan_id').notNullable().references('id').inTable('Tuan');
        table
            .integer('nhom_th_id')
            .notNullable()
            .references('id')
            .inTable('NhomThucHanh');
    });
};

/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.down = function (knex) {
    return knex.schema.dropTable('LichDangKy');
};
