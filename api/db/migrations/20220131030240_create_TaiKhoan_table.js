/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.up = function (knex) {
    return knex.schema.createTable('TaiKhoan', (table) => {
        table.string('email').primary();
        table.string('mat_khau').notNullable();
        table
            .integer('vai_tro_id')
            .notNullable()
            .defaultTo(2)
            .references('id')
            .inTable('VaiTro');
        table.timestamps(true, true);
    });
};

/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.down = function (knex) {
    return knex.schema.dropTable('TaiKhoan');
};
