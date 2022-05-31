const knex = require('knex');
const knexfile = require('./knexfile');

const db = knex(knexfile.development);

module.exports = db;

// const { Pool } = require('pg');

// const pool = new Pool();

// module.exports = {
//     query: (text, params) => pool.query(text, params),
// };
