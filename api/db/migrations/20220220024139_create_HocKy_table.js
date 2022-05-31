/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.up = function(knex) {
    return knex.schema.createTable('HocKy', (table) => {
        table.increments('id').primary();
        table.string('ma_hoc_ky').notNullable().unique();
        table.string('ten_hoc_ky').notNullable();
    });
};

/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.down = function(knex) {
    return knex.schema.dropTable('HocKy');
};
