/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.up = function(knex) {
    return knex.schema.createTable('BuoiHoc', (table) => {
        table.increments('id').primary();
        table.string('ma_buoi_hoc').notNullable().unique();
        table.string('ten_buoi_hoc').notNullable();
    });
};

/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.down = function(knex) {
    return knex.schema.dropTable('BuoiHoc');
};
