const connectDb = require('../utils/db');

module.exports = {
    async getProvinces(req, res) {
        try {
            const pool = await connectDb();
            const {recordset} = await pool.query('select * from DON_VI');

            res.json({
                message: '',
                data: {provinces: recordset}
            });
        } catch(_) {
            res.status(500).json({
                message: _.message || 'Có lỗi xảy ra. Vui lòng thử lại sau',
                data: null
            });
        }
    }
};
