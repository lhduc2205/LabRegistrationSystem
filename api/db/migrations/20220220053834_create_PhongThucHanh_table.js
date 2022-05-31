/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.up = function (knex) {
    return knex.schema.createTable('PhongThucHanh', (table) => {
        table.increments('id').primary();
        table.string('ten_phong').notNullable();
        table.integer('so_cho_ngoi').notNullable();
        table.integer('dung_luong_ram').nullable();
        table.integer('dung_luong_o_cung').nullable();
        table.string('cpu').nullable();
        table.string('gpu').nullable();
        table
            .integer('bo_mon_id')
            .notNullable()
            .references('id')
            .inTable('BoMon');
    });
};

/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.down = function (knex) {
    return knex.schema.dropTable('PhongThucHanh');
};
