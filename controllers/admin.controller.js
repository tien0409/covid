const jwt = require('jsonwebtoken');
const mssql = require('mssql');

const connectDb = require('../utils/db');
const generateToken = require('../utils/generate-token');
const { JWT_SECRET } = require('../configs/env');

module.exports = {
    async currentUser(req, res) {
        if (req.headers && req.headers.authorization) {
            const token = req.headers.authorization.split(' ')[1];

            try {
                const payload = jwt.verify(token, JWT_SECRET);
                await connectDb();
                const ps = new mssql.PreparedStatement();
                ps.input('MaDonVi', mssql.Int);
                await ps.prepare('select * FROM DON_VI WHERE MaDonVi=@MaDonVi');
                const {recordset} = await ps.execute({MaDonVi: payload.userId});

                if (!recordset.length) {
                    res.status(404);
                    throw new Error('User not found');
                }

                res.json({
                    message: '',
                    data: {
                        user: {
                            MaDonVi: recordset[0].MaDonVi,
                            TenDonVi: recordset[0].MaDonVi,
                        }
                    }
                });
            } catch(_) {
                res.status(500).json({
                    message: _.message || 'Có lỗi xảy ra. Vui lòng thử lại sau',
                    data: null
                });
            }
        }},

    async login(req, res) {
        try {
            await connectDb();
            const ps = new mssql.PreparedStatement();
            ps.input('TaiKhoan', mssql.VarChar);
            ps.input('MatKhau', mssql.VarChar);
            await ps.prepare('select * FROM DON_VI WHERE TaiKhoan=@TaiKhoan AND MatKhau=@MatKhau');
            const {recordset} = await ps.execute({TaiKhoan: req.body.TaiKhoan, MatKhau: req.body.MatKhau});
            if(!recordset.length) {
                return res.status(404).json({
                    messagee: 'Tài khoản hoặc mật khẩu không chính xác',
                    data: null
                });
            }

            res.json({
                message: '',
                data: {
                    token: generateToken(recordset[0].MaDonVi)
                }
            });
        } catch(_) {
            res.status(500).json({
                message: _.message || 'Có lỗi xảy ra. Vui lòng thử lại sau',
                data: null
            });
        }
    }
};
