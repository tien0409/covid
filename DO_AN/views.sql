------------------- VIEW -----------------------------
-- tạo view lấy đầy đủ thông tin phiếu toàn dân
GO
CREATE OR ALTER VIEW vChiTietPTD
AS
SELECT PKB.MaPhieu,
       DTNB.TenNB,
       PKB.AmTinh,
       DV.TenDonVi,
       NKB.CMND,
       NKB.HoTen,
       CASE NKB.GioiTinh WHEN 1 THEN 'Nam' WHEN 0 THEN N'Nữ' ELSE N'Khác' END as 'GioiTinh',
       NKB.QuocTich,
       STRING_AGG(VC.TenVaccine, ',')                                         AS VaccineDaTiem,
       STRING_AGG(TC.TenTrieuChung, ',')                                      as TrieuChung,
       PKB.UpdatedAt
FROM PHIEU_KHAI_BAO AS PKB
         INNER JOIN PHIEU_TOAN_DAN AS PTD ON PKB.MaPhieu = PTD.MaPhieu
         INNER JOIN DOI_TUONG_NHIEM_BENH AS DTNB ON DTNB.MaNB = PKB.MaNB
         INNER JOIN NGUOI_KHAI_BAO AS NKB ON NKB.MaPhieu = PKB.MaPhieu
         INNER JOIN CT_TIEM_VACCINE AS CTTVC ON CTTVC.MaPhieu = PKB.MaPhieu
         INNER JOIN VACCINE AS VC ON VC.MaVaccine = CTTVC.MaVaccine
         INNER JOIN CT_TRIEU_CHUNG AS CTTC ON CTTC.MaPhieu = PKB.MaPhieu
         INNER JOIN TRIEU_CHUNG AS TC ON TC.MaTrieuChung = CTTC.MaTrieuChung
         INNER JOIN DON_VI AS DV ON DV.MaDonVi = PTD.MaDonVi
WHERE PTD.DaXoa = 0
GROUP BY PKB.MaPhieu, DTNB.TenNB, PKB.AmTinh, DV.TenDonVi, NKB.CMND,
         NKB.HoTen, NKB.GioiTinh, NKB.QuocTich, PKB.UpdatedAt

-- tạo view lấy đầy đủ thông tin phiếu nội địa
GO
CREATE OR ALTER VIEW vChiTietPND
AS
SELECT PKB.MaPhieu,
       DTNB.TenNB,
       PKB.AmTinh,
       PKB.UpdatedAt,
       NKB.CMND,
       NKB.HoTen,
       NKB.QuocTich,
       PDCND.NgayKhoiHanh,
       PDCND.DiaDiemDi,
       PDCND.DiaDiemDen,
       CASE NKB.GioiTinh WHEN 1 THEN 'Nam' WHEN 0 THEN N'Nữ' ELSE N'Khác' END as 'GioiTinh',
       STRING_AGG(VC.TenVaccine, ',')                                         as VaccineDaTiem,
       STRING_AGG(TC.TenTrieuChung, ',')                                      as TrieuChung
FROM PHIEU_KHAI_BAO AS PKB
         INNER JOIN PHIEU_DI_CHUYEN_NOI_DIA AS PDCND ON PKB.MaPhieu = PDCND.MaPhieu
         LEFT JOIN DOI_TUONG_NHIEM_BENH AS DTNB ON DTNB.MaNB = PKB.MaNB
         INNER JOIN NGUOI_KHAI_BAO AS NKB ON NKB.MaPhieu = PKB.MaPhieu
         LEFT JOIN CT_TIEM_VACCINE AS CTTVC ON CTTVC.MaPhieu = PKB.MaPhieu
         INNER JOIN VACCINE AS VC ON VC.MaVaccine = CTTVC.MaVaccine
         INNER JOIN CT_TRIEU_CHUNG AS CTTC ON CTTC.MaPhieu = PKB.MaPhieu
         INNER JOIN TRIEU_CHUNG AS TC ON TC.MaTrieuChung = CTTC.MaTrieuChung
WHERE PDCND.DaXoa = 0
GROUP BY PKB.MaPhieu, DTNB.TenNB, PKB.AmTinh, NKB.CMND, NKB.QuocTich,
         PDCND.NgayKhoiHanh, PDCND.DiaDiemDi, PDCND.DiaDiemDen, NKB.HoTen, NKB.GioiTinh, VC.TenVaccine,
         TC.TenTrieuChung, PKB.UpdatedAt

-- tạo view lấy đầy đủ thông tin phiếu nhập cảnh
GO
CREATE OR ALTER VIEW vChiTietPNC
AS
SELECT PKB.MaPhieu,
       DTNB.TenNB,
       PKB.AmTinh,
       PKB.UpdatedAt,
       NKB.CMND,
       NKB.HoTen,
       NKB.QuocTich,
       PNC.DoiTuong,
       PNC.PhuongTien,
       PNC.DiaDiemQGKhoiHanh,
       PNC.DiaDiemTinhKhoiHanh,
       PNC.DiaDiemQGNoiDen,
       PNC.DiaDiemTinhNoiDen,
       PNC.NgayKhoiHanh,
       PNC.NgayNhapCanh,
       CSCL.TenCSCL,
       CASE NKB.GioiTinh WHEN 1 THEN 'Nam' WHEN 0 THEN N'Nữ' ELSE N'Khác' END as 'GioiTinh',
       STRING_AGG(VC.TenVaccine, ',')                                         as VaccineDaTiem,
       STRING_AGG(TC.TenTrieuChung, ',')                                      as TrieuChung
FROM PHIEU_KHAI_BAO AS PKB
         INNER JOIN PHIEU_NHAP_CANH AS PNC ON PKB.MaPhieu = PNC.MaPhieu
         INNER JOIN DOI_TUONG_NHIEM_BENH AS DTNB ON DTNB.MaNB = PKB.MaNB
         INNER JOIN NGUOI_KHAI_BAO AS NKB ON NKB.MaPhieu = PKB.MaPhieu
         INNER JOIN CO_SO_CACH_LY as CSCL ON CSCL.MaCSCL = PNC.MaCSCL
         INNEr JOIN CT_TIEM_VACCINE AS CTTVC ON CTTVC.MaPhieu = PKB.MaPhieu
         INNER JOIN VACCINE AS VC ON VC.MaVaccine = CTTVC.MaVaccine
         INNER JOIN CT_TRIEU_CHUNG AS CTTC ON CTTC.MaPhieu = PKB.MaPhieu
         INNER JOIN TRIEU_CHUNG AS TC ON TC.MaTrieuChung = CTTC.MaTrieuChung
WHERE PNC.DaXoa = 0
GROUP BY PKB.MaPhieu, DTNB.TenNB, PKB.AmTinh, NKB.CMND,
         NKB.HoTen, NKB.GioiTinh, NKB.QuocTich, CSCL.TenCSCL,
         PNC.PhuongTien, PNC.DoiTuong, PNC.NgayKhoiHanh, PNC.NgayNhapCanh,
         PNC.DiaDiemQGKhoiHanh, PNC.DiaDiemTinhNoiDen, PNC.DiaDiemQGNoiDen,
         PNC.DiaDiemTinhKhoiHanh, PKB.UpdatedAt

-- tạo view lấy thông tin chi tiết vể các đơn vị
Go
CREATE OR ALTER VIEW vChiTietDonVi
AS
SELECT DV.TenDonVi,
       COUNT(*)                                              as 'SoNguoiKhaiBao',
       COUNT(CASE DTNB.TenNB WHEN 'F0' THEN 1 ELSE NULL END) as 'SoF0',
       COUNT(CASE DTNB.TenNB WHEN 'F1' THEN 1 ELSE NULL END) as 'SoF1',
       COUNT(CASE DTNB.TenNB WHEN 'F2' THEN 1 ELSE NULL END) as 'SoF2'
FROM DON_VI AS DV
         INNER JOIN PHIEU_TOAN_DAN AS PTD ON DV.MaDonVi = PTD.MaDonVi
         INNER JOIN PHIEU_KHAI_BAO AS PKB ON PKB.MaPhieu = PTD.MaPhieu
         LEFT JOIN DOI_TUONG_NHIEM_BENH AS DTNB ON DTNB.MaNB = PKB.MaNB
GROUP BY DV.TenDonVi

-- lấy thông tin vaccine
GO
CREATE OR ALTER VIEW vChiTietVaccine
AS
SELECT VC.MaVaccine, VC.TenVaccine, VC.XuatXu, COUNT(CTTV.LuotTiem) AS DaSuDung
FROM VACCINE VC
         LEFT JOIN CT_TIEM_VACCINE CTTV on VC.MaVaccine = CTTV.MaVaccine
GROUP BY VC.TenVaccine, VC.MaVaccine, VC.XuatXu

-- lấy thông tin triệu chứng nhiễm bệnh
GO
CREATE OR ALTER VIEW vChiTietTrieuChung
AS
SELECT TC.MaTrieuChung,
       TC.TenTrieuChung,
       TC.MoTa,
       COUNT(*) AS SoNguoiNhiemBenhDaBi,
       NKB.HoTen,
       NKB.CMND,
       DTNB.TenNB,
       PKB.AmTinh
FROM TRIEU_CHUNG TC
         INNER JOIN CT_TRIEU_CHUNG CTTC ON TC.MaTrieuChung = CTTC.MaTrieuChung
         INNER JOIN PHIEU_KHAI_BAO PKB on CTTC.MaPhieu = PKB.MaPhieu
         INNER JOIN DOI_TUONG_NHIEM_BENH DTNB on PKB.MaNB = DTNB.MaNB
         INNER JOIN NGUOI_KHAI_BAO NKB on PKB.MaPhieu = NKB.MaPhieu
WHERE TC.DaXoa = 0
   OR TC.DaXoa IS NULL
GROUP BY TC.MaTrieuChung, TC.TenTrieuChung, TC.MoTa, NKB.HoTen, NKB.CMND, DTNB.TenNB, PKB.AmTinh