GO
EXEC spTaoPhieuKhaiBaoTD @MaDonVi=2, @DichTe=N'Ốm, sốt', @MaVaccine=1, @CMND='23f1a', @MaNB=1,
     @HoTen=N'abac', @GioiTinh=1, @QuocTich=N'Việt Nam', @NgaySinh='04-09-2000',
     @SDT='0337362871', @Email='a@gmail.com', @SoNha='18', @TenPhuong='Abc', @TenQuan='xyz', @TenTinh='HN'

EXEC spTaoPhieuKhaiBaoND @MaCSCL=1, @DichTe=N'Ốm, sốt', @MaVaccine=2, @CMND='20712312',
     @HoTen=N'Lê Anh Tiến', @GioiTinh=1, @QuocTich=N'Việt Nam', @NgaySinh='04-09-2000',
     @SDT='0337362871', @Email='a@gmail.com', @SoNha='18', @TenPhuong='Abc', @TenQuan='xyz', @TenTinh='HY',
     @DiaDiemDi='HY', @DiaDiemDen='HCM', @PhuongTien='Xe dap', @NgayKhoiHanh='08-20-2021', @NgayKetThuc='08-24-2021'

EXEC spTaoPhieuKhaiBaoNC @MaDoiTuong=1, @CuaKhau='cua khau a', @DichTe=N'Ốm, sốt', @MaVaccine=3,
     @CMND='2sd123142', @MaNB=2,
     @HoTen=N'Lê Anh Tiến', @GioiTinh=1, @QuocTich=N'Việt Nam', @NgaySinh='04-09-2000',
     @SDT='0337362871', @Email='a@gmail.com', @SoNha='18', @TenPhuong='Abc', @TenQuan='xyz', @TenTinh='HY',
     @DiaDiemDi='HY', @DiaDiemDen='HCM', @PhuongTien='Xe dap', @NgayKhoiHanh='08-20-2021', @NgayKetThuc='10-04-2021'

SELECT *
FROM vChiTietPNC
SELECT *
FROM vChiTietPND
SELECT *
FROM vChiTietPTD
SELECT *
FROM vChiTietDonVi
