const connectDb = require('../utils/db');

module.exports = {
    async getVaccines(req, res) {
        try {
            const pool = await connectDb();
            const {recordset} = await pool.query('select * from VACCINE');

            res.json({
                message: '',
                data: {vaccines: recordset}
            });
        } catch(_) {
            res.status(500).json({
                message: _.message || 'Có lỗi xảy ra. Vui lòng thử lại sau',
                data: null
            });
        }
    }
};
