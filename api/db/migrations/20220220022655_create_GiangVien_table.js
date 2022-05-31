/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.up = function (knex) {
    return knex.schema.createTable('GiangVien', (table) => {
        table.increments('id').primary();
        table.string('ma_gv').notNullable().unique();
        table.string('ho_ten').notNullable();
        table.boolean('gioi_tinh').notNullable();
        table.datetime('ngay_sinh').notNullable();
        table.string('sdt').notNullable();
        table
            .integer('bo_mon_id')
            .notNullable()
            .references('id')
            .inTable('BoMon');
        table
            .string('email_gv')
            .notNullable()
            .references('email')
            .inTable('TaiKhoan');
        table.timestamps(true, true);
    });
};

/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.down = function (knex) {
    return knex.schema.dropTable('GiangVien');
};
