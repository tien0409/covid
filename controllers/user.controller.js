const mssql = require('mssql');
const connectDb = require('../utils/db');

module.exports = {
    async createNationalForm(req, res) {
        try {
            const DSVaccineDaTIem = new mssql.Table();
            DSVaccineDaTIem.columns.add('MaVaccine', mssql.Int);
            DSVaccineDaTIem.columns.add('LuotTiem', mssql.Int);
            DSVaccineDaTIem.columns.add('NgayTiem', mssql.VarChar);
            req.body.DSVaccineDaTiem.map(vaccine => {
                DSVaccineDaTIem.rows.add(vaccine.MaVaccine, vaccine.LuotTiem, vaccine.NgayTiem);
            });

            const DSNguoiTX = new mssql.Table();
            DSNguoiTX.columns.add('CMND', mssql.VarChar);
            DSNguoiTX.columns.add('DiaDiemTX', mssql.NVarChar);
            DSNguoiTX.columns.add('ThoiGianTX', mssql.VarChar);
            req.body.DSNguoiTX.map(nguoiTX => {
                DSNguoiTX.rows.add(nguoiTX.CMND, nguoiTX.DiaDiemTX, nguoiTX.ThoiGianTX);
            });

            const pool = await connectDb();
            await pool.request()
                .input('DSVaccineDaTiem', mssql.TYPES.TVP, DSVaccineDaTIem)
                .input('DsNguoiTX', mssql.TYPES.TVP, DSNguoiTX)
                .input('MaDonVi', req.body.MaDonVi)
                .input('MaNB', req.body.MaNB)
                .input('TrieuChung', req.body.TrieuChung)
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
            console.log('_', _);
            res.status(500).json({
                message: _.message || 'Có lỗi xảy ra. Vui lòng thử lại sau',
                data: null
            });
        }
    },
};
