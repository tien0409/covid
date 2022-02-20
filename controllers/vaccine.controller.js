const mssql = require('mssql');
const connectDb = require('../utils/db');

module.exports = {
    async getVaccines(req, res) {
        try {
            const pool = await connectDb();
            const {recordset} = await pool.query('SELECT * from vChiTietVaccine');

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
    },

    async getVaccine(req, res) {
        try {
            await connectDb();
            const ps = new mssql.PreparedStatement();
            ps.input('MaVaccine', mssql.Int);
            await ps.prepare('select * FROM VACCINE WHERE MaVaccine=@MaVaccine');
            const {recordset} = await ps.execute({MaVaccine: req.params.id});

            res.json({
                message: '',
                data: {vaccine: recordset[0]}
            });
        } catch(_) {
            res.status(500).json({
                message: _.message || 'Có lỗi xảy ra. Vui lòng thử lại sau',
                data: null
            });
        }
    },

    async updateVaccine(req, res) {
        try {
            await connectDb();
            const ps = new mssql.PreparedStatement();
            ps.input('MaVaccine', mssql.Int);
            ps.input('TenVaccine', mssql.NVarChar);
            ps.input('XuatXu', mssql.NVarChar);
            await ps.prepare('UPDATE VACCINE SET TenVaccine=@TenVaccine, XuatXu=@XuatXu WHERE MaVaccine=@MaVaccine');
            await ps.execute({TenVaccine: req.body.TenVaccine,XuatXu: req.body.XuatXu, MaVaccine: req.params.id});

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

    async createVaccine(req, res) {
        try {
            await connectDb();
            const ps = new mssql.PreparedStatement();
            ps.input('TenVaccine', mssql.NVarChar);
            ps.input('XuatXu', mssql.NVarChar);
            await ps.prepare('INSERT INTO VACCINE VALUES (@TenVaccine, @XuatXu)');
            await ps.execute({TenVaccine: req.body.TenVaccine,XuatXu: req.body.XuatXu});

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

    async deleteVaccine(req, res) {
        try {
            await connectDb();
            const ps = new mssql.PreparedStatement();
            ps.input('MaVaccine', mssql.Int);
            await ps.prepare('DELETE VACCINE WHERE MaVaccine=@MaVaccine');
            await ps.execute({MaVaccine: req.params.id});

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

};
