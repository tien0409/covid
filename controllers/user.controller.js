const connectDb = require('../utils/db');

module.exports = {
    async createNationalForm(req, res) {
        try {
            const pool = await connectDb();
            await pool.request()
                .input('MaDonVi', req.body.MaDonVi)
                .input('MaNB', req.body.MaNB)
                .input('TrieuChung', req.body.TrieuChung)
                .input('MaVaccine', req.body.MaVaccine)
                .input('AmTinh', req.body.AmTinh)
                .input('CMND', req.body.CMND)
                .input('HoTen', req.body.HoTen)
                .input('GioiTinh', req.body.GioiTinh)
                .input('QuocTich', req.body.QuocTich)
                .input('NgaySinh', req.body.NgaySinh)
                .input('SDT', req.body.SDT)
                .input('Email', req.body.Email)
                .input('SoNha', req.body.SoNha)
                .input('TenPhuong', req.body.TenPhuong)
                .input('TenQuan', req.body.TenQuan)
                .input('TenTinh', req.body.TenTinh)
                .execute('spTaoPhieuKhaiBaoTD');
            res.json({
                message: ''
            });

        } catch(_) {
            res.status(500).json({
                message: _.message || 'Có lỗi xảy ra. Vui lòng thử lại sau',
                data: null
            });
        }
    },
};
