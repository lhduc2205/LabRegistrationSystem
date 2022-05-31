/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.up = function (knex) {
    return knex.schema.createTable('MonHoc', (table) => {
        table.increments('id').primary();
        table.string('ma_mon_hoc').notNullable();
        table.string('ten_mon_hoc').notNullable();
        table.string('viet_tat').notNullable();
        table.integer('so_tin_chi').notNullable();
    });
};

/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.down = function (knex) {
    return knex.schema.dropTable('MonHoc');
};
