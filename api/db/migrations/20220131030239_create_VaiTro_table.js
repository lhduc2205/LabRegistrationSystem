/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.up = function(knex) {
    return knex.schema.createTable('VaiTro', (table) => {
        table.increments('id').primary();
        table.string('ma_vai_tro').notNullable().unique();
        table.string('ten_vai_tro').notNullable();
    });
};

/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.down = function(knex) {
    return knex.schema.dropTable('VaiTro');
};
