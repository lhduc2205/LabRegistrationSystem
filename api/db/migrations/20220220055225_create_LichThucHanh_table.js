/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.up = function (knex) {
    return knex.schema.createTable('LichThucHanh', (table) => {
        table.increments('id').primary();
        table.date('ngay_bat_dau').notNullable();
        table.integer('tuan_id').notNullable().references('id').inTable('Tuan');
        table.integer('thu_id').notNullable().references('id').inTable('Thu');
        table
            .integer('nhom_th_id')
            .notNullable()
            .references('id')
            .inTable('NhomThucHanh');
        table
            .integer('phong_id')
            .notNullable()
            .references('id')
            .inTable('PhongThucHanh');
        table
            .integer('buoi_hoc_id')
            .notNullable()
            .references('id')
            .inTable('BuoiHoc');
    });
};

/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.down = function (knex) {
    return knex.schema.dropTable('LichThucHanh');
};
