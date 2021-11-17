const mssql = require('mssql');
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
        await mssql.connect(sqlConfig);
        console.log('Connect success');
    } catch(err) {
        console.log('Connect faild');
        process.exit(-1);
    }
};

module.exports = connectDb;
