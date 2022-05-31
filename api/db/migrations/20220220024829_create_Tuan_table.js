/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.up = function (knex) {
    return knex.schema.createTable('Tuan', (table) => {
        table.increments('id').primary();
        table.integer('ma_tuan').notNullable().unique();
        table.string('ten_tuan').notNullable();
    });
};

/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.down = function (knex) {
    return knex.schema.dropTable('Tuan');
};
