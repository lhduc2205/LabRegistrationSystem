/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.up = function (knex) {
    return knex.schema.createTable('PhongPhanMem', (table) => {
        table.increments('id').primary();
        table
            .integer('phong_id')
            .notNullable()
            .references('id')
            .inTable('PhongThucHanh');
        table
            .integer('phan_mem_id')
            .notNullable()
            .references('id')
            .inTable('PhanMem');
    });
};

/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.down = function (knex) {
    return knex.schema.dropTable('PhongPhanMem');
};
