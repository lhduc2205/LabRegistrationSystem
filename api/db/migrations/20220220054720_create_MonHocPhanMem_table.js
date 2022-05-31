/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.up = function(knex) {
    return knex.schema.createTable('MonHocPhanMem', (table) => {
        table.increments('id').primary();
        table.integer('phan_mem_id').notNullable().references('id').inTable('PhanMem');
        table.integer('mon_hoc_id').notNullable().references('id').inTable('MonHoc');
    });
};

/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.down = function(knex) {
    return knex.schema.dropTable('MonHocPhanMem');
};
