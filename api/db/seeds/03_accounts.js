const bcrypt = require('bcrypt');
const hash = bcrypt.hashSync('3563949zx', 10);

/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */

exports.seed = function (knex) {
    // Deletes ALL existing entries
    return knex('TaiKhoan')
        .del()
        .then(function () {
            // Inserts seed entries
            return knex('TaiKhoan').insert([
                { email: 'admin', mat_khau: hash, vai_tro_id: 1 },
                { email: 'tca@cit.ctu.edu.vn', mat_khau: hash },
                { email: 'lnk@cit.ctu.edu.vn', mat_khau: hash },
            ]);
        });
};
