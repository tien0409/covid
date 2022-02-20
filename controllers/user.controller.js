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
            res.status(500).json({
                message: _.message || 'Có lỗi xảy ra. Vui lòng thử lại sau',
                data: null
            });
        }
    },


    async getNationalForm(req, res) {
        try {

            await connectDb();
            const ps = new mssql.PreparedStatement();
            ps.input('MaPhieu', mssql.Int);
            await ps.prepare('SELECT * FROM vChiTietPTD WHERE MaPhieu=@MaPhieu');
            const {recordset} = await ps.execute({MaPhieu: req.params.id});

            res.json({
                message: '',
                data: {form: recordset[0]}
            });

        } catch(_) {
            res.status(500).json({
                message: _.message || 'Có lỗi xảy ra. Vui lòng thử lại sau',
                data: null
            });
        }
    },

    async getAllNationalForm(req, res) {
        try {

            const pool = await connectDb();
            const {recordset} = await pool.query('SELECT * from vChiTietPTD');

            res.json({
                message: '',
                data: {sheets: recordset}
            });

        } catch(_) {
            res.status(500).json({
                message: _.message || 'Có lỗi xảy ra. Vui lòng thử lại sau',
                data: null
            });
        }
    },

    async createDomesticForm(req, res) {
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
                .input('DiaDiemDi', req.body.DiaDiemDi)
                .input('DiaDiemDen', req.body.DiaDiemDen)
                .input('NgayKhoiHanh', req.body.NgayKhoiHanh)
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
                .execute('spTaoPhieuKhaiBaoND');
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

    async getALlDomestic(req, res) {
        try {

            const pool = await connectDb();
            const {recordset} = await pool.query('SELECT * from vChiTietPND');

            res.json({
                message: '',
                data: {sheets: recordset}
            });

        } catch(_) {
            res.status(500).json({
                message: _.message || 'Có lỗi xảy ra. Vui lòng thử lại sau',
                data: null
            });
        }
    },

    async createEntryForm(req, res) {
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
                .input('PhuongTien', req.body.PhuongTien)
                .input('DiaDiemQGKhoiHanh', req.body.DiaDiemQGKhoiHanh)
                .input('DiaDiemTinhKhoiHanh', req.body.DiaDiemTinhKhoiHanh)
                .input('DiaDiemQGNoiDen', req.body.DiaDiemQGNoiDen)
                .input('DiaDiemTinhNoiDen', req.body.DiaDiemTinhNoiDen)
                .input('NgayKhoiHanh', req.body.NgayKhoiHanh)
                .input('NgayNhapCanh', req.body.NgayNhapCanh)
                .input('DoiTuong', req.body.DoiTuong)
                .input('MaNB', req.body.MaNB)
                .input('MaCSCL', req.body.MaCSCL)
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
                .execute('spTaoPhieuKhaiBaoNC');
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

    async getAllEntry(req, res) {
        try {

            const pool = await connectDb();
            const {recordset} = await pool.query('SELECT * from vChiTietPNC');

            res.json({
                message: '',
                data: {sheets: recordset}
            });

        } catch(_) {
            res.status(500).json({
                message: _.message || 'Có lỗi xảy ra. Vui lòng thử lại sau',
                data: null
            });
        }
    },

    async getHistory(req, res) {
        try {
            await connectDb();
            const ps = new mssql.PreparedStatement();
            ps.input('CMND', mssql.VarChar);
            await ps.prepare(`
                    SELECT PKB.*, NKB.*, CTV.*, V.*
                    FROM PHIEU_KHAI_BAO PKB
                    INNER JOIN NGUOI_KHAI_BAO NKB on PKB.MaPhieu = NKB.MaPhieu
                    INNER JOIN CT_TIEM_VACCINE CTV on PKB.MaPhieu = CTV.MaPhieu
                    INNER JOIN VACCINE V on CTV.MaVaccine = V.MaVaccine
                    WHERE CMND=@CMND
            `);
            const {recordset} = await ps.execute({CMND: req.body.CMND});

            res.json({
                message: '',
                data: {history: recordset}
            });

        } catch(_) {
            res.status(500).json({
                message: _.message || 'Có lỗi xảy ra. Vui lòng thử lại sau',
                data: null
            });
        }
    }
};
