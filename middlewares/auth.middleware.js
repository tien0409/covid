const jwt = require('jsonwebtoken');
const mssql = require('mssql');
const connectDb = require('../utils/db');

const { JWT_SECRET } = require('../configs/env');

const auth = async (req, res, next) => {
    if (req.headers && req.headers.authorization) {
        const token = req.headers.authorization.split(' ')[1];

        try {
            const payload = jwt.verify(token, JWT_SECRET);
            await connectDb();
            const ps = new mssql.PreparedStatement();
            ps.input('MaDonVi', mssql.Int);
            await ps.prepare('select * FROM DON_VI WHERE MaDonVi=@MaDonVi');
            const {recordset} = await ps.execute({MaDonVi: payload.MaDonVi});

            if (!recordset.length) {
                res.status(404);
                throw new Error('User not found');
            }
            next();
        } catch (err) {
            res.status(401);
            throw new Error('Not authorized, token failed');
        }
    } else {
    // no token
        res.status(401);
        throw new Error('Not authorized, no token');
    }
};

module.exports = auth;
