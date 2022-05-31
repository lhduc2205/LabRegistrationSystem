// Update with your config settings.
/**
 * @type { Object.<string, import("knex").Knex.Config> }
 */
module.exports = {
    development: {
        client: 'postgresql',
        connection: {
            database: 'QL_DangKy_ThucHanh',
            user: 'postgres',
            password: '3563949zx',
            timezone: 'utc+07:00',
        },
        pool: {
            afterCreate: function (connection, callback) {
                connection.query('SET timezone = utc;', function (err) {
                    callback(err, connection);
                });
            },
        },
        migrations: {
            directory: './migrations',
        },
        seeds: {
            directory: './seeds',
        },
    },
};
