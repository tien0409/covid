const connectDb = require('../utils/db');

module.exports = {
    async getInfectedSubjects(req, res) {
        try {
            const pool = await connectDb();
            const {recordset} = await pool.query('select * from DOI_TUONG_NHIEM_BENH');

            res.json({
                message: '',
                data: {infectedSubjects: recordset}
            });
        } catch(_) {
            res.status(500).json({
                message: _.message || 'Có lỗi xảy ra. Vui lòng thử lại sau',
                data: null
            });
        }
    },

    async getSymptoms(req, res) {
        try {
            const pool = await connectDb();
            const {recordset} = await pool.query('select * from TRIEU_CHUNG');

            res.json({
                message: '',
                data: {symptoms: recordset}
            });
        } catch(_) {
            res.status(500).json({
                message: _.message || 'Có lỗi xảy ra. Vui lòng thử lại sau',
                data: null
            });
        }
    }
};
