const mssql = require('mssql');

let pool;

const sqlConfig = {
    user: process.env.USER_SQL,
    password: process.env.PASS_SQL,
    database: process.env.DB_NAME,
    server: 'localhost',
    options: {
        encrypt: true, // for azure
        trustServerCertificate: true
    }
};

const connectDb = async () =>  {
    try {
        pool = await mssql.connect(sqlConfig);
        return pool;
    } catch(err) {
        console.log('Connect faild');
        process.exit(-1);
    }
};

module.exports = connectDb;
