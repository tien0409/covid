const mssql = require('mssql');

module.exports = {
    async getVaccines(req, res) {
        try {
            const {recordset} = await mssql.query`select * from VACCINE`;

            res.json({
                message: 'success',
                data: {vaccines: recordset}
            });
        } catch(_) {
            console.error(_);
            res.json({error:' abc'});
        }
    }
};
