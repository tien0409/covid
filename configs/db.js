const env = require('./env');

module.exports = {
    user: env.USER_SQL,
    password: env.PASSWORD_SQL,
    database: env.DATABASE,
    server: 'localhost',
    options: {
        encrypt: true, // for azure
        trustServerCertificate: true
    }
};
