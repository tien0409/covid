const {format} = require('date-fns');
const connectDb = require('./utils/db');
const provinces = require('./constanst/provinces');

const init = async () => {
    try {
        const pool = await connectDb();
        const datetime = format(new Date(), 'MM-dd-yyyy');

        await pool.query('DELETE FROM DON_VI');
        provinces.map(province => {
            pool.query(`INSERT INTO DON_VI VALUES(N'${province.name}', 0, 'tk${province.code}', 'mk${province.code}', '${datetime}', '${datetime}')`);
        });

    } catch(_) {
        console.error('Error', _);
        process.exit();
    }
};

init();
