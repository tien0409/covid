use master
go
DROP DATABASE DA_COVID
GO
CREATE DATABASE DA_COVID
GO
USE DA_COVID
GO

create table DON_VI
(
    MaDonVi     INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
    TenDonVi    NVARCHAR(30)       NOT NULL,
    MucDoLayLan INT                NOT NULL DEFAULT 0,
    TaiKhoan    VARCHAR(20)        NOT NULL,
    MatKhau     VARCHAR(20)        NOT NULL,
    CreatedAt   DATETIME                    DEFAULT GETDATE(),
    UpdatedAt   DATETIME                    DEFAULT GETDATE()
)

CREATE TABLE DOI_TUONG_NHIEM_BENH
(
    MaNB  INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
    TenNB varchar(2)         NOT NULL
)

-- chỉ dành cho F0, F1, F2
CREATE TABLE NGUOI_TIEP_XUC
(
    CMND      VARCHAR(12)  NOT NULL PRIMARY KEY,
    HoTen     NVARCHAR(50) NOT NULL,
    GioiTinh  BIT          NOT NULL,
    QuocTich  NVARCHAR(25) NOT NULL,
    NgaySinh  DATE         NOT NULL,
    SDT       VARCHAR(15)  NOT NULL,
    Email     VARCHAR(20),
    SoNha     NVARCHAR(20) NOT NULL,
    TenPhuong NVARCHAR(20) NOT NULL,
    TenQuan   NVARCHAR(20) NOT NULL,
    TenTinh   NVARCHAR(20) NOT NULL,
)

CREATE TABLE VACCINE
(
    MaVaccine  INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
    TenVaccine NVARCHAR(50)       NOT NULL,
    XuatXu     NVARCHAR(50)       NOT NULL
)

CREATE TABLE PHIEU_KHAI_BAO
(
    MaPhieu   INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
    MaNB      INT FOREIGN KEY REFERENCES DOI_TUONG_NHIEM_BENH (MaNB),
    MaVaccine INT FOREIGN KEY REFERENCES VACCINE (MaVaccine),
    DichTe    NVARCHAR(100),
    AmTinh    BIT      DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),
)

CREATE TABLE CT_TIEM_VACCINE
(
    MaPhieu  INT FOREIGN KEY REFERENCES PHIEU_KHAI_BAO (MaPhieu),
    LuotTiem INT DEFAULT 0,
    NgayTiem DATE NOT NULL,
    PRIMARY KEY (MaPhieu, LuotTiem)
)

CREATE TABLE NGUOI_KHAI_BAO
(
    MaPhieu   INT FOREIGN KEY REFERENCES PHIEU_KHAI_BAO (MaPhieu) PRIMARY KEY,
    CMND      VARCHAR(12)  NOT NULL,
    HoTen     NVARCHAR(50) NOT NULL,
    GioiTinh  BIT          NOT NULL,
    QuocTich  NVARCHAR(25) NOT NULL,
    NgaySinh  DATE         NOT NULL,
    SDT       VARCHAR(15)  NOT NULL,
    Email     VARCHAR(20),
    SoNha     NVARCHAR(20) NOT NULL,
    TenPhuong NVARCHAR(20) NOT NULL,
    TenQuan   NVARCHAR(20) NOT NULL,
    TenTinh   NVARCHAR(20) NOT NULL
)

-- chỉ dành cho F0, F1, F2
CREATE TABLE CT_TIEP_XUC
(
    MaPhieu     INT FOREIGN KEY REFERENCES PHIEU_KHAI_BAO (MaPhieu),
    CMNDNguoiTX VARCHAR(200),
    DiaDiemTX   NVARCHAR(50),
    ThoiGianTX  DATETIME,
    PRIMARY KEY (MaPhieu)
--     PRIMARY KEY (MaPhieu, CMNDNguoiKB)
)

CREATE TABLE PHIEU_TOAN_DAN
(
    MaPhieu   INT FOREIGN KEY REFERENCES PHIEU_KHAI_BAO (MaPhieu) PRIMARY KEY,
    MaDonVi   INT FOREIGN KEY REFERENCES DON_VI (MaDonVi),
    IsDeleted BIT DEFAULT 0
)

CREATE TABLE DOI_TUONG_NHAP_CANH
(
    MaDoiTuong  INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
    TenDoiTuong NVARCHAR(30)       NOT NULL,
)

CREATE TABLE PHIEU_NHAP_CANH
(
    MaPhieu    INT FOREIGN KEY REFERENCES PHIEU_KHAI_BAO (MaPhieu) PRIMARY KEY,
    MaDoiTuong INT FOREIGN KEY REFERENCES DOI_TUONG_NHAP_CANH (MaDoiTuong),
    CuaKhau    NVARCHAR(50) NOT NULL,
    IsDeleted  BIT DEFAULT 0
)

CREATE TABLE CO_SO_CACH_LY
(
    MaCSCL  INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
    TenCSCL NVARCHAR(60)       NOT NULL
);

CREATE TABLE PHIEU_DI_CHUYEN_NOI_DIA
(
    MaPhieu   INT FOREIGN KEY REFERENCES PHIEU_KHAI_BAO (MaPhieu) PRIMARY KEY,
    MaCSCL    INT FOREIGN KEY REFERENCES CO_SO_CACH_LY (MaCSCL),
    IsDeleted BIT DEFAULT 0
);

CREATE TABLE CT_LICH_TRINH
(
    MaPhieu      INT FOREIGN KEY REFERENCES PHIEU_KHAI_BAO (MaPhieu) PRIMARY KEY,
    DiaDiemDi    NVARCHAR(50) NOT NULL,
    DiaDiemDen   NVARCHAR(50) NOT NULL,
    PhuongTien   NVARCHAR(20) NOT NULL,
    NgayKhoiHanh DATE         NOT NULL,
    NgayKetThuc  DATE         NOT NULL,
)

-- thêm cơ sở cách ly mặc định
INSERT INTO CO_SO_CACH_LY
VALUES (N'Cơ sở cách ly tập trung')
INSERT INTO CO_SO_CACH_LY
VALUES (N'Cơ sở cách ly tự chọn')

-- thêm đối tượng mặc định trong phiếu nhập cảnh
INSERT INTO DOI_TUONG_NHAP_CANH
VALUES (N'Chuyên gia')
INSERT INTO DOI_TUONG_NHAP_CANH
VALUES (N'Người Việt Nam')
INSERT INTO DOI_TUONG_NHAP_CANH
VALUES (N'Học sinh/Sinh viên quốc tế')
INSERT INTO DOI_TUONG_NHAP_CANH
VALUES (N'Khác')

-- thêm các đơn vi mặc định
INSERT INTO DON_VI
VALUES (N'Hà Nội', -1, 'hn', 'hn', GETDATE(), GETDATE())
INSERT INTO DON_VI
VALUES (N'Hưng Yên', -1, 'hy', 'hy', GETDATE(), GETDATE())
INSERT INTO DON_VI
VALUES (N'Quảng Ngãi', -1, 'qn', 'qn', GETDATE(), GETDATE())
INSERT INTO DON_VI
VALUES (N'HCM', -1, 'hcm', 'hcm', GETDATE(), GETDATE())

-- thêm đối tượng nhiễm bệnh mặc định
INSERT INTO DOI_TUONG_NHIEM_BENH
VALUES ('F0')
INSERT INTO DOI_TUONG_NHIEM_BENH
VALUES ('F1')
INSERT INTO DOI_TUONG_NHIEM_BENH
VALUES ('F2')
INSERT INTO DOI_TUONG_NHIEM_BENH
VALUES ('F3')

-- thêm vaccine mặc định
INSERT INTO VACCINE
VALUES (N'AstraZeneca', N'Mỹ')
INSERT INTO VACCINE
VALUES (N'SPUTNIK V', N'Nga')
INSERT INTO VACCINE
VALUES (N'Vero Cell', N'Pfizer/BioNTech')
INSERT INTO VACCINE
VALUES (N'Comirnaty ', N'Pfizer/BioNTech')

-- lấy thông tin
SELECT *
FROM DON_VI
SELECT *
FROM VACCINE
SELECT *
FROM DOI_TUONG_NHIEM_BENH
SELECT *
FROM CO_SO_CACH_LY
SELECT *
FROM PHIEU_KHAI_BAO
SELECT *
FROM NGUOI_KHAI_BAO
SELECT *
FROM PHIEU_TOAN_DAN
SELECT *
FROM PHIEU_NHAP_CANH
SELECT *
FROM PHIEU_DI_CHUYEN_NOI_DIA
SELECT *
FROM NGUOI_TIEP_XUC

------------------- FUNCTION -----------------------------
GO
-- hàm split lấy các giá trị
CREATE FUNCTION splitValues(@Values NVARCHAR(200), @SplitOn NVARCHAR(3)=',')
    RETURNS @tableValues TABLE
                         (
                             Value NVARCHAR(200)
                         )
AS
BEGIN
    WHILE(CHARINDEX(@SplitOn, @Values) > 0)
        BEGIN
            INSERT INTO @tableValues (value)
            SELECT Value = LTRIM(RTRIM(SUBSTRING(@Values, 1, CHARINDEX(@SplitOn, @Values) - 1)))
            SET @Values = SUBSTRING(@Values, CHARINDEX(@SplitOn, @Values) + LEN(@SplitOn), LEN(@Values))
        END
    INSERT INTO @tableValues (Value)
    Select Value = LTRIM(RTRIM(@Values))
    RETURN
END

------------------- PROCEDURE -----------------------------
GO
-- tạo phiếu khai báo toàn dân
CREATE OR ALTER PROC spTaoPhieuKhaiBaoTD @MaDonVi INT,
                                         @MaNB INT=NULL,
                                         @DichTe NVARCHAR(100)=NULL,
                                         @MaVaccine INT=NULL,
                                         @AmTinh BIT=0,
                                         @CMND VARCHAR(12),
                                         @HoTen NVARCHAR(50),
                                         @GioiTinh BIT=0,
                                         @QuocTich NVARCHAR(25),
                                         @NgaySinh DATE,
                                         @SDT VARCHAR(15),
                                         @Email VARCHAR(20)=NULL,
                                         @SoNha NVARCHAR(20),
                                         @TenPhuong NVARCHAR(20),
                                         @TenQuan NVARCHAR(20),
                                         @TenTinh NVARCHAR(20)
AS
BEGIN TRY
    BEGIN TRAN
        IF EXISTS(SELECT PTD.MaPhieu
                  FROM PHIEU_TOAN_DAN PTD
                           INNER JOIN NGUOI_KHAI_BAO NKB ON PTD.MaPhieu = NKB.MaPhieu
                  WHERE NKB.CMND = @CMND)
            RAISERROR ('Không thể tạo, người dùng đã từng khai báo phiếu toàn dân', 1, 1)
        IF NOT EXISTS(SELECT MaDonVi FROM DON_VI WHERE MaDonVi = @MaDonVi)
            RAISERROR ('Mã đơn vị không tồn tại',14,1)
        IF NOT EXISTS(SELECT MaNB FROM DOI_TUONG_NHIEM_BENH WHERE MaNB = @MaNB)
            RAISERROR ('Mã nhiễm bệnh không tồn tại',14,1)
        IF NOT @MaVaccine IS NULL AND NOT EXISTS(SELECT MaVaccine FROM VACCINE WHERE MaVaccine = @MaVaccine)
            RAISERROR ('Mã vaccine không tồn tại', 14, 1)
        IF @NgaySinh >= GETDATE()
            RAISERROR ('Ngày sinh không hợp lệ', 14, 1)

        -- tạo phiếu khai báo
        DECLARE @MaPhieu INT
        INSERT INTO PHIEU_KHAI_BAO (MaNB, MaVaccine, DichTe, AmTinh)
        VALUES (@MaNB, @MaVaccine, @DichTe, @AmTinh)
        SET @MaPhieu = @@IDENTITY

        -- tạo người khai báo
        INSERT INTO NGUOI_KHAI_BAO
        VALUES (@MaPhieu, @CMND, @HoTen, @GioiTinh, @QuocTich, @NgaySinh, @SDT, @Email, @SoNha,
                @TenPhuong,
                @TenQuan, @TenTinh)

        -- tạo phiếu khai báo toàn dân
        INSERT INTO PHIEU_TOAN_DAN VALUES (@MaPhieu, @MaDonVi, 0)
    COMMIT TRAN
END TRY
BEGIN CATCH
    ROLLBACK TRAN
    DECLARE @ErrMsg NVARCHAR(1000)
    DECLARE @ErrSeverity INT
    DECLARE @ErrState INT

    SELECT @ErrMsg = ERROR_MESSAGE(), @ErrSeverity = ERROR_SEVERITY(), @ErrState = ERROR_STATE()
    RAISERROR (@ErrMsg, @ErrSeverity, @ErrState)
END CATCH

GO

-- cập nhật phiếu khai báo
CREATE OR ALTER PROC spCapNhatPhieuKhaiBaoTD @MaPhieuKB INT,
                                             @MaDonVi INT,
                                             @MaNB INT=NULL,
                                             @DichTe NVARCHAR(100)=NULL,
                                             @MaVaccine INT=NULL,
                                             @AmTinh BIT=0,
                                             @HoTen NVARCHAR(50),
                                             @GioiTinh BIT=0,
                                             @QuocTich NVARCHAR(25),
                                             @NgaySinh DATE,
                                             @CMND VARCHAR(12),
                                             @SDT VARCHAR(15),
                                             @Email VARCHAR(20)=NULL,
                                             @SoNha NVARCHAR(20),
                                             @TenPhuong NVARCHAR(20),
                                             @TenQuan NVARCHAR(20),
                                             @TenTinh NVARCHAR(20)
AS
BEGIN TRY
    BEGIN TRAN
        IF NOT EXISTS(SELECT PTD.MaPhieu
                      FROM PHIEU_TOAN_DAN PTD
                               INNER JOIN NGUOI_KHAI_BAO NKB ON PTD.MaPhieu = NKB.MaPhieu
                      WHERE NKB.CMND = @CMND)
            RAISERROR ('Người dùng chưa từng khai báo phiếu toàn dân', 1, 1)
        IF NOT EXISTS(SELECT MaDonVi FROM DON_VI WHERE MaDonVi = @MaDonVi)
            RAISERROR ('Mã đơn vị không tồn tại',14,1)
        IF NOT EXISTS(SELECT MaNB FROM DOI_TUONG_NHIEM_BENH WHERE MaNB = @MaNB)
            RAISERROR ('Mã nhiễm bệnh không tồn tại',14,1)
        IF NOT @MAVACCINE IS NULL AND NOT EXISTS(SELECT MaVaccine FROM VACCINE WHERE MaVaccine = @MaVaccine)
            RAISERROR ('Mã vaccine không tồn tại', 14, 1)
        IF @NgaySinh >= GETDATE()
            RAISERROR ('Ngày sinh không hợp lệ', 14, 1)

        -- cập nhật phiếu khai báo
        UPDATE PHIEU_KHAI_BAO
        SET MaNB=@MaNB,
            DichTe=@DichTe,
            AmTinh=@AmTinh,
            MaVaccine=@MaVaccine
        WHERE MaPhieu = @MaPhieuKB

        -- cập nhật thông tin người khai báo
        UPDATE NGUOI_KHAI_BAO
        SET HoTen=@HoTen,
            GioiTinh=@GioiTinh,
            QuocTich=@QuocTich,
            NgaySinh=@NgaySinh,
            SDT=@SDT,
            Email=@Email,
            SoNha=@SoNha,
            TenPhuong=@TenPhuong,
            TenQuan=@TenQuan,
            TenTinh=@TenTinh
        WHERE MaPhieu = @MaPhieuKB

        -- cập nhật thông tin phiếu khai báo toàn dân
        UPDATE PHIEU_TOAN_DAN
        SET MaDonVi=@MaDonVi
        WHERE MaPhieu = @MaPhieuKB
    COMMIT TRAN
END TRY
BEGIN CATCH
    ROLLBACK TRAN
    DECLARE @ErrMsg NVARCHAR(1000)
    DECLARE @ErrSeverity INT
    DECLARE @ErrState INT

    SELECT @ErrMsg = ERROR_MESSAGE(), @ErrSeverity = ERROR_SEVERITY(), @ErrState = ERROR_STATE()
    RAISERROR (@ErrMsg, @ErrSeverity, @ErrState)
END CATCH

GO

-- tạo phiếu khai báo nội địa
CREATE OR ALTER PROC spTaoPhieuKhaiBaoND @MaCSCL INT,
                                         @MaNB INT=NULL,
                                         @DichTe NVARCHAR(100)=NULL,
                                         @MaVaccine INT=NULL,
                                         @AmTinh BIT=0,
                                         @DiaDiemDi NVARCHAR(50),
                                         @DiaDiemDen NVARCHAR(50),
                                         @PhuongTien NVARCHAR(50),
                                         @NgayKhoiHanh DATE,
                                         @NgayKetThuc DATE,
                                         @CMND VARCHAR(12),
                                         @HoTen NVARCHAR(50),
                                         @GioiTinh BIT=0,
                                         @QuocTich NVARCHAR(25),
                                         @NgaySinh DATE,
                                         @SDT VARCHAR(15),
                                         @Email VARCHAR(20)=NULL,
                                         @SoNha NVARCHAR(20),
                                         @TenPhuong NVARCHAR(20),
                                         @TenQuan NVARCHAR(20),
                                         @TenTinh NVARCHAR(20)
AS
BEGIN TRY
    BEGIN TRAN
        IF EXISTS(SELECT PND.MaPhieu
                  FROM PHIEU_DI_CHUYEN_NOI_DIA PND
                           INNER JOIN NGUOI_KHAI_BAO NKB ON PND.MaPhieu = NKB.MaPhieu
                  WHERE NKB.CMND = @CMND)
            RAISERROR ('Không thể tạo, người dùng đã từng khai báo', 1, 1)
        IF NOT EXISTS(SELECT MaCSCL FROM CO_SO_CACH_LY WHERE MaCSCL = @MaCSCL)
            RAISERROR ('Mã cơ sở cách ly không tồn tại',14,1)
        IF NOT @MaNB IS NULL AND NOT EXISTS(SELECT MaNB FROM DOI_TUONG_NHIEM_BENH WHERE MaNB = @MaNB)
            RAISERROR ('Mã nhiễm bệnh không tồn tại',14,1)
        IF NOT @MAVACCINE IS NULL AND NOT EXISTS(SELECT MaVaccine FROM VACCINE WHERE MaVaccine = @MaVaccine)
            RAISERROR ('Mã vaccine không tồn tại', 14, 1)
        IF @NgaySinh >= GETDATE()
            RAISERROR ('Ngày sinh không hợp lệ', 14, 1)
        IF @NgayKhoiHanh > @NgayKetThuc
            RAISERROR ('Ngày kết thúc lịch trình không hợp lệ', 14, 1)

        DECLARE @MaPhieuKB INT
        -- tạo phiếu khai báo
        INSERT INTO PHIEU_KHAI_BAO(MaNB, MaVaccine, DichTe, AmTinh)
        VALUES (@MaNB, @MaVaccine, @DichTe, @AmTinh)
        SET @MaPhieuKB = @@IDENTITY

        -- tạo người khai báo
        INSERT INTO NGUOI_KHAI_BAO(MaPhieu, CMND, HoTen, GioiTinh, QuocTich, NgaySinh, SDT, Email,
                                   SoNha, TenPhuong, TenQuan, TenTinh)
        VALUES (@MaPhieuKB, @CMND, @HoTen, @GioiTinh, @QuocTich, @NgaySinh, @SDT, @Email, @SoNha,
                @TenPhuong,
                @TenQuan, @TenTinh)

        -- tạo phiếu khai báo nội địa
        INSERT INTO PHIEU_DI_CHUYEN_NOI_DIA VALUES (@MaPhieuKB, @MaCSCL, 0)

        -- tạo chi tiết lịch trình
        INSERT INTO CT_LICH_TRINH(MaPhieu, DiaDiemDi, DiaDiemDen, PhuongTien, NgayKhoiHanh, NgayKetThuc)
        VALUES (@MaPhieuKB, @DiaDiemDi, @DiaDiemDen, @PhuongTien, @NgayKhoiHanh, @NgayKetThuc)
    COMMIT TRAN
END TRY
BEGIN CATCH
    ROLLBACK TRAN
    DECLARE @ErrMsg NVARCHAR(1000)
    DECLARE @ErrSeverity INT
    DECLARE @ErrState INT

    SELECT @ErrMsg = ERROR_MESSAGE(), @ErrSeverity = ERROR_SEVERITY(), @ErrState = ERROR_STATE()
    RAISERROR (@ErrMsg, @ErrSeverity, @ErrState)
END CATCH

GO

-- cập nhật phiếu khai báo nội địa
CREATE OR ALTER PROC spCapNhatPhieuND @MaPhieuKB INT,
                                      @MaCSCL INT,
                                      @MaNB INT=NULL,
                                      @DichTe NVARCHAR(100)=NULL,
                                      @MaVaccine INT=NULL,
                                      @AmTinh BIT=0,
                                      @DiaDiemDi NVARCHAR(50),
                                      @DiaDiemDen NVARCHAR(50),
                                      @PhuongTien NVARCHAR(50),
                                      @NgayKhoiHanh DATE,
                                      @NgayKetThuc DATE,
                                      @HoTen NVARCHAR(50),
                                      @CMND VARCHAR(12),
                                      @GioiTinh BIT=0,
                                      @QuocTich NVARCHAR(25),
                                      @NgaySinh DATE,
                                      @SDT VARCHAR(15),
                                      @Email VARCHAR(20)=NULL,
                                      @SoNha NVARCHAR(20),
                                      @TenPhuong NVARCHAR(20),
                                      @TenQuan NVARCHAR(20),
                                      @TenTinh NVARCHAR(20)
AS
BEGIN TRY
    BEGIN TRAN
        IF NOT EXISTS(SELECT PND.MaPhieu
                      FROM PHIEU_DI_CHUYEN_NOI_DIA PND
                               INNER JOIN NGUOI_KHAI_BAO NKB ON PND.MaPhieu = NKB.MaPhieu
                      WHERE NKB.CMND = @CMND)
            RAISERROR ('Không thể cập nhật, người dùng chưa từng khai báo', 1, 1)
        IF NOT EXISTS(SELECT MaCSCL FROM CO_SO_CACH_LY WHERE MaCSCL = @MaCSCL)
            RAISERROR ('Mã cơ sở cách ly không tồn tại',14,1)
        IF NOT EXISTS(SELECT MaNB FROM DOI_TUONG_NHIEM_BENH WHERE MaNB = @MaNB)
            RAISERROR ('Mã nhiễm bệnh không tồn tại',14,1)
        IF NOT @MAVACCINE IS NULL AND NOT EXISTS(SELECT MaVaccine FROM VACCINE WHERE MaVaccine = @MaVaccine)
            RAISERROR ('Mã vaccine không tồn tại', 14, 1)
        IF @NgaySinh >= GETDATE()
            RAISERROR ('Ngày sinh không hợp lệ', 14, 1)
        IF @NgayKhoiHanh < @NgayKetThuc
            RAISERROR ('Ngày kết thúc lịch trình không hợp lệ', 14, 1)

        -- cập nhật thông tin phiếu khai báo
        UPDATE PHIEU_KHAI_BAO
        SET MaNB=@MaNB,
            DichTe=@DichTe,
            AmTinh=@AmTinh,
            MaVaccine=@MaVaccine,
            UpdatedAt=GETDATE()
        WHERE MaPhieu = @MaPhieuKB

        -- cập nhật thông tin người khai báo
        UPDATE NGUOI_KHAI_BAO
        SET HoTen=@HoTen,
            GioiTinh=@GioiTinh,
            QuocTich=@QuocTich,
            NgaySinh=@NgaySinh,
            SDT=@SDT,
            Email=@Email,
            SoNha=@SoNha,
            TenPhuong=@TenPhuong,
            TenQuan=@TenQuan,
            TenTinh=@TenTinh
        WHERE MaPhieu = @MaPhieuKB

        -- cập nhật thông tin phiếu khai báo nội địa
        UPDATE PHIEU_DI_CHUYEN_NOI_DIA
        SET MaCSCL=@MaCSCL
        WHERE MaPhieu = @MaPhieuKB

        -- cập nhật ct lich trình
        UPDATE CT_LICH_TRINH
        SET DiaDiemDi=@DiaDiemDi,
            DiaDiemDen=@DiaDiemDen,
            PhuongTien=@PhuongTien,
            NgayKhoiHanh=@NgayKhoiHanh,
            NgayKetThuc=@NgayKetThuc
        WHERE MaPhieu = @MaPhieuKB
    COMMIT TRAN
END TRY
BEGIN CATCH
    ROLLBACK TRAN
    DECLARE @ErrMsg NVARCHAR(1000)
    DECLARE @ErrSeverity INT
    DECLARE @ErrState INT

    SELECT @ErrMsg = ERROR_MESSAGE(), @ErrSeverity = ERROR_SEVERITY(), @ErrState = ERROR_STATE()
    RAISERROR (@ErrMsg, @ErrSeverity, @ErrState)
END CATCH

GO

CREATE OR ALTER PROC spTaoPhieuKhaiBaoNC @MaDoiTuong INT,
                                         @CuaKhau NVARCHAR(50),
                                         @MaNB INT=NULL,
                                         @DichTe NVARCHAR(100)=NULL,
                                         @MaVaccine INT=NULL,
                                         @AmTinh BIT=0,
                                         @DiaDiemDi NVARCHAR(50),
                                         @DiaDiemDen NVARCHAR(50),
                                         @PhuongTien NVARCHAR(50),
                                         @NgayKhoiHanh DATE,
                                         @NgayKetThuc DATE,
                                         @CMND VARCHAR(12),
                                         @HoTen NVARCHAR(50),
                                         @GioiTinh BIT=0,
                                         @QuocTich NVARCHAR(25),
                                         @NgaySinh DATE,
                                         @SDT VARCHAR(15),
                                         @Email VARCHAR(20)=NULL,
                                         @SoNha NVARCHAR(20),
                                         @TenPhuong NVARCHAR(20),
                                         @TenQuan NVARCHAR(20),
                                         @TenTinh NVARCHAR(20)
AS
BEGIN TRY
    BEGIN TRAN
        IF EXISTS(SELECT PNC.MaPhieu
                  FROM PHIEU_NHAP_CANH PNC
                           INNER JOIN NGUOI_KHAI_BAO NKB ON PNC.MaPhieu = NKB.MaPhieu
                  WHERE NKB.CMND = @CMND)
            RAISERROR ('Không thể tạo, người dùng đã từng khai báo phiếu nhập cảnh', 1, 1)
        IF NOT EXISTS(SELECT MaDoiTuong FROM DOI_TUONG_NHAP_CANH WHERE MaDoiTuong = @MaDoiTuong)
            RAISERROR ('Mã đối tượng nhập cảnh không tồn tại', 14, 1)
        IF NOT @MaNB IS NULL AND NOT EXISTS(SELECT MaNB FROM DOI_TUONG_NHIEM_BENH WHERE MaNB = @MaNB)
            RAISERROR ('Mã nhiễm bệnh không tồn tại',14,1)
        IF NOT @MaVaccine IS NULL AND NOT EXISTS(SELECT MaVaccine FROM VACCINE WHERE MaVaccine = @MaVaccine)
            RAISERROR ('Mã vaccine không tồn tại', 14, 1)
        IF @NgaySinh >= GETDATE()
            RAISERROR ('Ngày sinh không hợp lệ', 14, 1)
        IF @NgayKhoiHanh > @NgayKetThuc
            RAISERROR ('Ngày kết thúc lịch trình không hợp lệ', 14, 1)

        DECLARE @MaPhieuKB INT
        -- tạo phiếu khai báo
        INSERT INTO PHIEU_KHAI_BAO(MaNB, MaVaccine, DichTe, AmTinh)
        VALUES (@MaNB, @MaVaccine, @DichTe, @AmTinh)
        SET @MaPhieuKB = @@IDENTITY

        -- tạo người khai báo
        INSERT INTO NGUOI_KHAI_BAO
        VALUES (@MaPhieuKB, @CMND, @HoTen, @GioiTinh, @QuocTich, @NgaySinh, @SDT, @Email, @SoNha, @TenPhuong,
                @TenQuan, @TenTinh)

        -- tạo phiếu khai báo nhập cảnh
        INSERT INTO PHIEU_NHAP_CANH
        VALUES (@MaPhieuKB, @MaDoiTuong, @CuaKhau, 0)

        -- tạo chi tiết lịch trình
        INSERT INTO CT_LICH_TRINH
        VALUES (@MaPhieuKB, @DiaDiemDi, @DiaDiemDen, @PhuongTien, @NgayKhoiHanh, @NgayKetThuc)
    COMMIT TRAN
END TRY
BEGIN CATCH
    ROLLBACK TRAN
    DECLARE @ErrMsg NVARCHAR(1000)
    DECLARE @ErrSeverity INT
    DECLARE @ErrState INT

    SELECT @ErrMsg = ERROR_MESSAGE(), @ErrSeverity = ERROR_SEVERITY(), @ErrState = ERROR_STATE()
    RAISERROR (@ErrMsg, @ErrSeverity, @ErrState)
END CATCH

GO

CREATE OR ALTER PROC spCapNhatPhieuKhaiBaoNC @MaPhieuKB INT,
                                             @MaDoiTuong INT,
                                             @CuaKhau NVARCHAR(50),
                                             @MaNB INT=NULL,
                                             @DichTe NVARCHAR(100)=NULL,
                                             @MaVaccine INT=NULL,
                                             @AmTinh BIT=0,
                                             @DiaDiemDi NVARCHAR(50),
                                             @DiaDiemDen NVARCHAR(50),
                                             @PhuongTien NVARCHAR(50),
                                             @NgayKhoiHanh DATE,
                                             @NgayKetThuc DATE,
                                             @CMND VARCHAR(12),
                                             @HoTen NVARCHAR(50),
                                             @GioiTinh BIT=0,
                                             @QuocTich NVARCHAR(25),
                                             @NgaySinh DATE,
                                             @SDT VARCHAR(15),
                                             @Email VARCHAR(20)=NULL,
                                             @SoNha NVARCHAR(20),
                                             @TenPhuong NVARCHAR(20),
                                             @TenQuan NVARCHAR(20),
                                             @TenTinh NVARCHAR(20)
AS
BEGIN TRY
    BEGIN TRAN
        IF NOT EXISTS(SELECT PNC.MaPhieu
                      FROM PHIEU_NHAP_CANH PNC
                               INNER JOIN NGUOI_KHAI_BAO NKB ON PNC.MaPhieu = NKB.MaPhieu
                      WHERE NKB.CMND = @CMND)
            RAISERROR ('Không thể cập nhật, người dùng chưa từng khai báo nhập cảnh', 1, 1)
        IF NOT EXISTS(SELECT MaDoiTuong FROM DOI_TUONG_NHAP_CANH WHERE MaDoiTuong = @MaDoiTuong)
            RAISERROR ('Mã đối tượng nhập cảnh không tồn tại', 14, 1)
        IF NOT EXISTS(SELECT MaNB FROM DOI_TUONG_NHIEM_BENH WHERE MaNB = @MaNB)
            RAISERROR ('Mã nhiễm bệnh không tồn tại',14,1)
        IF NOT @MaVaccine IS NULL AND NOT EXISTS(SELECT MaVaccine FROM VACCINE WHERE MaVaccine = @MaVaccine)
            RAISERROR ('Mã vaccine không tồn tại', 14, 1)
        IF @NgaySinh >= GETDATE()
            RAISERROR ('Ngày sinh không hợp lệ', 14, 1)
        IF @NgayKhoiHanh < @NgayKetThuc
            RAISERROR ('Ngày kết thúc lịch trình không hợp lệ', 14, 1)

        -- cập nhật thông tin phiếu khai báo
        UPDATE PHIEU_KHAI_BAO
        SET MaNB=@MaNB,
            MaVaccine=@MaVaccine,
            DichTe=@DichTe,
            AmTinh=@AmTinh,
            UpdatedAt=GETDATE()
        WHERE MaPhieu = @MaPhieuKB

        -- cập nhật thông tin người khai báo
        UPDATE NGUOI_KHAI_BAO
        SET HoTen=@HoTen,
            GioiTinh=@GioiTinh,
            QuocTich=@QuocTich,
            NgaySinh=@NgaySinh,
            SDT=@SDT,
            Email=@Email,
            SoNha=@SoNha,
            TenPhuong=@TenPhuong,
            TenQuan=@TenQuan,
            TenTinh=@TenTinh
        WHERE MaPhieu = @MaPhieuKB

        -- cập nhật thông tin phiếu khai báo nội địa
        UPDATE PHIEU_NHAP_CANH
        SET MaDoiTuong=@MaDoiTuong,
            CuaKhau=@CuaKhau
        WHERE MaPhieu = @MaPhieuKB

        -- cập nhật ct lich trình
        UPDATE CT_LICH_TRINH
        SET DiaDiemDi=@DiaDiemDi,
            DiaDiemDen=@DiaDiemDen,
            PhuongTien=@PhuongTien,
            NgayKhoiHanh=@NgayKhoiHanh,
            NgayKetThuc=@NgayKetThuc
        WHERE MaPhieu = @MaPhieuKB
    COMMIT TRAN
END TRY
BEGIN CATCH
    ROLLBACK TRAN
    DECLARE @ErrMsg NVARCHAR(1000)
    DECLARE @ErrSeverity INT
    DECLARE @ErrState INT

    SELECT @ErrMsg = ERROR_MESSAGE(), @ErrSeverity = ERROR_SEVERITY(), @ErrState = ERROR_STATE()
    RAISERROR (@ErrMsg, @ErrSeverity, @ErrState)
END CATCH

------------------- TRIGGER -----------------------------
GO
-- DROP TRIGGER IF EXISTS tgThemKhaiBao
-- CREATE OR ALTER TRIGGER tgThemKhaiBao
--     ON PHIEU_KHAI_BAO
--     AFTER INSERT AS
-- BEGIN
--     DECLARE @CMND VARCHAR(12)
--     DECLARE @MaNB INT
--     DECLARE @MaPhieuKB INT
--
--     SELECT @MaPhieuKB = MaPhieu, @MaNB = MaNB FROM inserted
--
--     -- kiểm tra xem có phải là người nhiễm bệnh hay không
--     IF EXISTS(SELECT MaNB FROM DOI_TUONG_NHIEM_BENH WHERE MaNB = @MaNB)
--         BEGIN
--             SELECT *
--             FROM CT_TIEP_XUC CTTX
--                      INNER JOIN PHIEU_KHAI_BAO PKB on PKB.MaPhieu = CTTX.MaPhieu
--                      INNER JOIN DOI_TUONG_NHIEM_BENH DTNB on DTNB.MaNB = PKB.MaNB
--             WHERE PKB.MaPhieu = @MaPhieuKB

GO
CREATE OR ALTER TRIGGER tgThemPTD
    ON PHIEU_TOAN_DAN
    AFTER INSERT AS
BEGIN
    DECLARE @MaPhieuKB INT

    SELECT @MaPhieuKB = MaPhieu FROM inserted

    -- kiểm tra xem đã từng khai báo chưa ( phiếu nội địa, phiếu nhập cảnh)
    IF EXISTS(SELECT MaPhieu FROM PHIEU_DI_CHUYEN_NOI_DIA WHERE MaPhieu = @MaPhieuKB)
        UPDATE PHIEU_DI_CHUYEN_NOI_DIA SET IsDeleted = 1 WHERE MaPhieu = @MaPhieuKB
    IF EXISTS(SELECT MaPhieu FROM PHIEU_NHAP_CANH WHERE MaPhieu = @MaPhieuKB)
        UPDATE PHIEU_NHAP_CANH SET IsDeleted = 1 WHERE MaPhieu = @MaPhieuKB
END

GO
CREATE OR ALTER TRIGGER tgThemPNC
    ON PHIEU_NHAP_CANH
    AFTER INSERT AS
BEGIN
    DECLARE @MaPhieuKB INT

    SELECT @MaPhieuKB = MaPhieu FROM inserted

    -- kiểm tra xem đã từng khai báo chưa ( phiếu nội địa, phiếu toàn dân)
    IF EXISTS(SELECT MaPhieu FROM PHIEU_TOAN_DAN WHERE MaPhieu = @MaPhieuKB)
        UPDATE PHIEU_TOAN_DAN SET IsDeleted = 1 WHERE MaPhieu = @MaPhieuKB
    IF EXISTS(SELECT MaPhieu FROM PHIEU_DI_CHUYEN_NOI_DIA WHERE MaPhieu = @MaPhieuKB)
        UPDATE PHIEU_DI_CHUYEN_NOI_DIA SET IsDeleted = 1 WHERE MaPhieu = @MaPhieuKB
END

GO
CREATE OR ALTER TRIGGER tgThemPND
    ON PHIEU_DI_CHUYEN_NOI_DIA
    AFTER INSERT AS
BEGIN
    DECLARE @MaPhieuKB INT

    SELECT @MaPhieuKB = MaPhieu FROM inserted

    -- kiểm tra xem đã từng khai báo chưa ( phiếu nội địa, phiếu toàn dân)
    IF EXISTS(SELECT MaPhieu FROM PHIEU_TOAN_DAN WHERE MaPhieu = @MaPhieuKB)
        UPDATE PHIEU_TOAN_DAN SET IsDeleted = 1 WHERE MaPhieu = @MaPhieuKB
    IF EXISTS(SELECT MaPhieu FROM PHIEU_NHAP_CANH WHERE MaPhieu = @MaPhieuKB)
        UPDATE PHIEU_NHAP_CANH SET IsDeleted = 1 WHERE MaPhieu = @MaPhieuKB
END

------------------- VIEW -----------------------------

-- tạo view lấy đầy đủ thông tin phiếu toàn dân
GO
CREATE OR ALTER VIEW vChiTietPTD
AS
SELECT PKB.MaPhieu,
       DTNB.TenNB,
       PKB.DichTe,
       PKB.AmTinh,
       DV.TenDonVi,
       NKB.CMND,
       NKB.HoTen,
       CASE NKB.GioiTinh WHEN 1 THEN 'Nam' WHEN 0 THEN 'Nữ' ELSE 'Khác' END as 'Giới tính',
       NKB.QuocTich,
       NKB.NgaySinh,
       NKB.SDT,
       NKB.Email,
       NKB.SoNha,
       NKB.TenPhuong,
       NKB.TenQuan,
       NKB.TenTinh,
       STRING_AGG(VC.TenVaccine, ',')                                          VaccineDaTiem
FROM PHIEU_KHAI_BAO AS PKB
         INNER JOIN PHIEU_TOAN_DAN AS PTD ON PKB.MaPhieu = PTD.MaPhieu
         LEFT JOIN DOI_TUONG_NHIEM_BENH AS DTNB ON DTNB.MaNB = PKB.MaNB
         INNER JOIN NGUOI_KHAI_BAO AS NKB ON NKB.MaPhieu = PKB.MaPhieu
         INNER JOIN VACCINE AS VC ON VC.MaVaccine = PKB.MaVaccine
         LEFT JOIN CT_TIEM_VACCINE AS CTTVC ON CTTVC.MaPhieu = PKB.MaPhieu
         INNER JOIN DON_VI AS DV ON DV.MaDonVi = PTD.MaDonVi
WHERE PTD.IsDeleted = 0
GROUP BY PKB.MaPhieu, DTNB.TenNB, PKB.DichTe, PKB.AmTinh, DV.TenDonVi, NKB.CMND,
         NKB.HoTen, NKB.GioiTinh, NKB.QuocTich, NKB.NgaySinh, NKB.SDT, NKB.Email, NKB.SoNha,
         NKB.TenPhuong, NKB.TenQuan, NKB.TenTinh

-- tạo view lấy đầy đủ thông tin phiếu nội địa
GO
CREATE OR ALTER VIEW vChiTietPND
AS
SELECT PKB.MaPhieu,
       CSCL.TenCSCL,
       DTNB.TenNB,
       PKB.DichTe,
       PKB.AmTinh,
       NKB.CMND,
       NKB.HoTen,
       CASE NKB.GioiTinh WHEN 1 THEN 'Nam' WHEN 0 THEN 'Nữ' ELSE 'Khác' END as 'Giới tính',
       NKB.QuocTich,
       NKB.NgaySinh,
       NKB.SDT,
       NKB.Email,
       NKB.SoNha,
       NKB.TenPhuong,
       NKB.TenQuan,
       NKB.TenTinh,
       CTLT.DiaDiemDen,
       CTLT.DiaDiemDi,
       CTLT.NgayKhoiHanh,
       CTLT.NgayKetThuc,
       CTLT.PhuongTien,
       STRING_AGG(VC.TenVaccine, ',')                                          VaccineDaTiem
FROM PHIEU_KHAI_BAO AS PKB
         INNER JOIN PHIEU_DI_CHUYEN_NOI_DIA AS PDCND ON PKB.MaPhieu = PDCND.MaPhieu
         LEFT JOIN DOI_TUONG_NHIEM_BENH AS DTNB ON DTNB.MaNB = PKB.MaNB
         INNER JOIN CT_LICH_TRINH AS CTLT ON CTLT.MaPhieu = PKB.MaPhieu
         INNER JOIN CO_SO_CACH_LY AS CSCL ON CSCL.MaCSCL = PDCND.MaCSCL
         INNER JOIN NGUOI_KHAI_BAO AS NKB ON NKB.MaPhieu = PKB.MaPhieu
         INNER JOIN VACCINE AS VC ON VC.MaVaccine = PKB.MaVaccine
         LEFT JOIN CT_TIEM_VACCINE AS CTTVC ON CTTVC.MaPhieu = PKB.MaPhieu
WHERE PDCND.IsDeleted = 0
GROUP BY PKB.MaPhieu, CSCL.TenCSCL, DTNB.TenNB, PKB.DichTe, PKB.AmTinh, NKB.CMND,
         NKB.HoTen, NKB.GioiTinh, NKB.QuocTich, NKB.NgaySinh, NKB.SDT, NKB.Email, NKB.SoNha,
         NKB.TenPhuong, NKB.TenQuan, NKB.TenTinh, CTLT.DiaDiemDen, CTLT.DiaDiemDi, CTLT.NgayKhoiHanh,
         CTLT.NgayKetThuc, CTLT.PhuongTien

-- tạo view lấy đầy đủ thông tin phiếu nhập cảnh
CREATE OR ALTER VIEW vChiTietPNC
AS
SELECT PKB.MaPhieu,
       DTNC.TenDoiTuong,
       DTNB.TenNB,
       PKB.DichTe,
       PKB.AmTinh,
       NKB.CMND,
       NKB.HoTen,
       CASE NKB.GioiTinh WHEN 1 THEN 'Nam' WHEN 0 THEN 'Nữ' ELSE 'Khác' END as 'Giới tính',
       NKB.QuocTich,
       NKB.NgaySinh,
       NKB.SDT,
       NKB.Email,
       NKB.SoNha,
       NKB.TenPhuong,
       NKB.TenQuan,
       NKB.TenTinh,
       CTLT.DiaDiemDen,
       CTLT.DiaDiemDi,
       CTLT.NgayKhoiHanh,
       CTLT.NgayKetThuc,
       CTLT.PhuongTien,
       STRING_AGG(VC.TenVaccine, ',')                                          VaccineDaTiem
FROM PHIEU_KHAI_BAO AS PKB
         INNER JOIN PHIEU_NHAP_CANH AS PNC ON PKB.MaPhieu = PNC.MaPhieu
         LEFT JOIN DOI_TUONG_NHIEM_BENH AS DTNB ON DTNB.MaNB = PKB.MaNB
         INNER JOIN CT_LICH_TRINH AS CTLT ON CTLT.MaPhieu = PKB.MaPhieu
         INNER JOIN DOI_TUONG_NHAP_CANH AS DTNC ON DTNC.MaDoiTuong = PNC.MaDoiTuong
         INNER JOIN NGUOI_KHAI_BAO AS NKB ON NKB.MaPhieu = PKB.MaPhieu
         INNER JOIN VACCINE AS VC ON VC.MaVaccine = PKB.MaVaccine
         LEFT JOIN CT_TIEM_VACCINE AS CTTVC ON CTTVC.MaPhieu = PKB.MaPhieu
WHERE PNC.IsDeleted = 0
GROUP BY PKB.MaPhieu, DTNC.TenDoiTuong, DTNB.TenNB, PKB.DichTe, PKB.AmTinh, NKB.CMND,
         NKB.HoTen, NKB.GioiTinh, NKB.QuocTich, NKB.NgaySinh, NKB.SDT, NKB.Email, NKB.SoNha,
         NKB.TenPhuong, NKB.TenQuan, NKB.TenTinh, CTLT.DiaDiemDen, CTLT.DiaDiemDi, CTLT.NgayKhoiHanh,
         CTLT.NgayKetThuc, CTLT.PhuongTien

-- tạo view lấy thông tin chi tiết vể các đơn vị
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

-- tạo view lấy thông tin các

------------------- INDEXES -----------------------------
GO

------------------- EXECUTE -----------------------------
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
