/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.up = function(knex) {
    return knex.schema.createTable('PhanMem', (table) => {
        table.increments('id').primary();
        table.string('ma_phan_mem').notNullable();
        table.string('ten_phan_mem').notNullable();
        table.string('phien_ban').notNullable();
    });
};

/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.down = function(knex) {
    return knex.schema.dropTable('PhanMem');
};
