/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.up = function(knex) {
    return knex.schema.createTable('BoMon', (table) => {
        table.increments('id').primary();
        table.string('ten_bo_mon').notNullable();
        table.string('viet_tat').notNullable().unique();
    });
};

/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.down = function(knex) {
  return knex.schema.dropTable('BoMon');
};
