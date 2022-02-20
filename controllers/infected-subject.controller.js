const mssql = require('mssql');
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
            const {recordset} = await pool.query('select * from vChiTietTrieuChung');

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
    },

    async getSymptom(req, res) {
        try {
            await connectDb();
            const ps = new mssql.PreparedStatement();
            ps.input('MaTrieuChung', mssql.Int);
            await ps.prepare('SELECT * FROM vChiTietTrieuChung WHERE MaTrieuChung=@MaTrieuChung');
            const {recordset} = await ps.execute({MaTrieuChung: req.params.id});

            if(!recordset.length) {
                return res.status(404).json({
                    message: 'Không tìm thấy dữ liệu',
                    data: null
                });
            }

            res.json({
                message: '',
                data: {symptom: recordset}
            });
        } catch(_) {
            res.status(500).json({
                message: _.message || 'Có lỗi xảy ra. Vui lòng thử lại sau',
                data: null
            });
        }
    },

    async updateSymptom(req, res) {
        try {
            await connectDb();
            const ps = new mssql.PreparedStatement();
            ps.input('TenTrieuChung', mssql.NVarChar);
            ps.input('MoTa', mssql.NVarChar);
            await ps.prepare('UPDATE TRIEU_CHUNG SET TenTrieuChung=@TenTrieuChung, MoTa=@MoTa');
            await ps.execute({TenTrieuChung: req.body.TenTrieuChung,MoTa: req.body.MoTa});

            res.json({
                message: '',
                data: null
            });
        } catch(_) {
            res.status(500).json({
                message: _.message || 'Có lỗi xảy ra. Vui lòng thử lại sau',
                data: null
            });
        }
    },

    async createSymptom(req, res) {
        try {
            await connectDb();
            const ps = new mssql.PreparedStatement();
            ps.input('TenTrieuChung', mssql.NVarChar);
            ps.input('MoTa', mssql.NVarChar);
            await ps.prepare('INSERT INTO TRIEU_CHUNG VALUES (@TenTrieuChung, @MoTa, 0)');
            await ps.execute({TenTrieuChung: req.body.TenTrieuChung,MoTa: req.body.MoTa});

            res.json({
                message: '',
                data: null
            });
        } catch(_) {
            res.status(500).json({
                message: _.message || 'Có lỗi xảy ra. Vui lòng thử lại sau',
                data: null
            });
        }
    },

    async removeSymptom(req, res) {
        try {
            await connectDb();
            const ps = new mssql.PreparedStatement();
            ps.input('MaTrieuChung', mssql.Int);
            await ps.prepare('UPDATE TRIEU_CHUNG SET DaXoa=1 WHERE MaTrieuChung=@MaTrieuChung');
            await ps.execute({MaTrieuChung: req.params.id});

            res.json({
                message: '',
                data: null
            });
        } catch(_) {
            res.status(500).json({
                message: _.message || 'Có lỗi xảy ra. Vui lòng thử lại sau',
                data: null
            });

        }
    },

    async getCSCL (req, res) {
        try {
            const pool = await connectDb();
            const {recordset} = await pool.query('select * from CO_SO_CACH_LY');

            res.json({
                message: '',
                data: {CSCL: recordset}
            });
        } catch(_) {
            res.status(500).json({
                message: _.message || 'Có lỗi xảy ra. Vui lòng thử lại sau',
                data: null
            });
        }
    }
};
