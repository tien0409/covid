------------------- PROCEDURE -----------------------------
GO
-- tạo phiếu khai báo
CREATE OR ALTER PROC spTaoPhieuKB @MaNB INT,
                                  @AmTinh BIT,
                                  @MaPhieu INT OUTPUT,
                                  @ResCode BIT = 1 OUTPUT -- 0: failed, 1:success
AS
BEGIN TRY
    DECLARE @trancount BIT = 0

    IF @@TRANCOUNT = 0
        BEGIN
            BEGIN TRAN
                SET @trancount = 1
        END
    ELSE
        SAVE TRAN spTaoPKB

    INSERT INTO PHIEU_KHAI_BAO (MaNB, AmTinh)
    VALUES (@MaNB, @AmTinh)
    SET @MaPhieu = @@IDENTITY

    IF @trancount = 1
        COMMIT TRAN
END TRY
BEGIN CATCH
    IF @trancount = 1
        ROLLBACK TRAN
    ELSE
        ROLLBACK TRANSACTION spTaoPKB

    DECLARE @ErrMsg NVARCHAR(1000)
    DECLARE @ErrSeverity INT
    DECLARE @ErrState INT

    SELECT @ErrMsg = ERROR_MESSAGE(), @ErrSeverity = ERROR_SEVERITY(), @ErrState = ERROR_STATE()

    SET @ResCode = 0
END CATCH

-- cập nhật phiếu khai báo
GO
CREATE OR ALTER PROC spCapNhatPKB @MaPhieu INT,
                                  @AmTinh BIT,
                                  @MaNB INT,
                                  @ResCode BIT = 1 OUTPUT -- 0: failed, 1:success
AS
BEGIN TRY
    DECLARE @trancount BIT = 0

    IF @@TRANCOUNT = 0
        BEGIN
            BEGIN TRAN
                SET @trancount = 1
        END
    ELSE
        SAVE TRAN spCapNhatPKB

    UPDATE PHIEU_KHAI_BAO
    SET MaNB=@MaNB,
        AmTinh=@AmTinh
    WHERE MaPhieu = @MaPhieu

    IF @trancount = 1
        COMMIT TRAN
END TRY
BEGIN CATCH
    IF @trancount = 1
        ROLLBACK TRAN
    ELSE
        ROLLBACK TRANSACTION spCapNhatPKB

    DECLARE @ErrMsg NVARCHAR(1000)
    DECLARE @ErrSeverity INT
    DECLARE @ErrState INT

    SELECT @ErrMsg = ERROR_MESSAGE(), @ErrSeverity = ERROR_SEVERITY(), @ErrState = ERROR_STATE()

    SET @ResCode = 0
END CATCH

GO
-- tạo thông tin người khai báo
CREATE OR ALTER PROC spTaoNKB @MaPhieu INT,
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
                              @TenTinh NVARCHAR(20),
                              @ResCode BIT=1 OUTPUT -- 0: failed, 1: success
AS
BEGIN TRY
    DECLARE @trancount BIT = 0

    IF @@TRANCOUNT = 0
        BEGIN
            BEGIN TRAN
                SET @trancount = 1
        END
    ELSE
        SAVE TRAN spTaoNKB

    INSERT INTO NGUOI_KHAI_BAO
    VALUES (@MaPhieu, @CMND, @HoTen, @GioiTinh, @QuocTich, @NgaySinh, @SDT, @Email, @SoNha,
            @TenPhuong,
            @TenQuan, @TenTinh)

    IF @trancount = 1
        COMMIT TRAN
END TRY
BEGIN CATCH
    IF @trancount = 1
        ROLLBACK TRAN
    ELSE
        BEGIN
            ROLLBACK TRANSACTION spTaoNKB
        end

    DECLARE @ErrMsg NVARCHAR(1000)
    DECLARE @ErrSeverity INT
    DECLARE @ErrState INT

    SELECT @ErrMsg = ERROR_MESSAGE(), @ErrSeverity = ERROR_SEVERITY(), @ErrState = ERROR_STATE()

    SET @ResCode = 0
END CATCH


GO
-- cập nhật người khai báo
CREATE OR ALTER PROC spCapNhatNKB @MaPhieu INT,
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
                                  @TenTinh NVARCHAR(20),
                                  @ResCode BIT=1 OUTPUT -- 0: failed, 1: success
AS
BEGIN TRY
    DECLARE @trancount BIT = 0
    IF @@TRANCOUNT = 0
        BEGIN
            BEGIN TRAN
                SET @trancount = 1
        END
    ELSE
        SAVE TRAN spCapNhatNKB

    UPDATE NGUOI_KHAI_BAO
    SET HoTen=@HoTen,
        GioiTinh=@GioiTinh,
        QuocTich=@QuocTich,
        NgaySinh=@NgaySinh,
        SDT=@SDT,
        CMND=@CMND,
        Email=@Email,
        SoNha=@SoNha,
        TenPhuong=@TenPhuong,
        TenQuan=@TenQuan,
        TenTinh=@TenTinh
    WHERE MaPhieu = @MaPhieu

    IF @trancount = 1
        COMMIT TRAN
END TRY
BEGIN CATCH
    IF @trancount = 1
        ROLLBACK TRAN
    ELSE
        ROLLBACK TRAN spCapNhatNKB

    DECLARE @ErrMsg NVARCHAR(1000)
    DECLARE @ErrSeverity INT
    DECLARE @ErrState INT

    SELECT @ErrMsg = ERROR_MESSAGE(), @ErrSeverity = ERROR_SEVERITY(), @ErrState = ERROR_STATE()

    SET @ResCode = 0
END CATCH

GO
-- tạo thông tin chi tiết tiếp xúc
CREATE OR ALTER PROC spTaoCTTX @MaPhieu INT,
                               @DsNguoiTX AS DSNguoiTX READONLY,
                               @ResCode BIT=1 OUTPUT -- 0: failed, 1: success
AS
BEGIN TRY
    DECLARE @trancount BIT = 0

    IF @@TRANCOUNT = 0
        BEGIN
            BEGIN TRAN
                SET @trancount = 1
        END
    ELSE
        SAVE TRAN spTaoCTTX

    INSERT INTO CT_TIEP_XUC(MaPhieu, CMNDNTX, DiaDiemTX, ThoiGianTX)
            (SELECT @MaPhieu, * FROM @DsNguoiTX)


    IF @trancount = 1
        COMMIT TRAN
END TRY
BEGIN CATCH
    IF @trancount = 1
        ROLLBACK TRAN
    ELSE
        ROLLBACK TRANSACTION spTaoCTTX

    DECLARE @ErrMsg NVARCHAR(1000)
    DECLARE @ErrSeverity INT
    DECLARE @ErrState INT

    SELECT @ErrMsg = ERROR_MESSAGE(), @ErrSeverity = ERROR_SEVERITY(), @ErrState = ERROR_STATE()
    RAISERROR (@ErrMsg, 16,1)

    SET @ResCode = 0
END CATCH

GO
-- tạo thông tin chi tiết tiêm vaccine
CREATE OR ALTER PROC spTaoCTTV @MaPhieu INT,
                               @DSVaccineDaTiem AS DSVaccineDaTiem READONLY,
                               @ResCode BIT=1 OUTPUT -- 0: failed, 1: success
AS
BEGIN TRY
    DECLARE @trancount BIT = 0

    IF @@TRANCOUNT = 0
        BEGIN
            BEGIN TRAN
                SET @trancount = 1
        END
    ELSE
        SAVE TRAN spTaoCTTV

    INSERT INTO CT_TIEM_VACCINE(MaPhieu, MaVaccine, LuotTiem, NgayTiem)
            (SELECT @MaPhieu, * FROM @DSVaccineDaTiem)


    IF @trancount = 1
        COMMIT TRAN
END TRY
BEGIN CATCH
    IF @trancount = 1
        ROLLBACK TRAN
    ELSE
        ROLLBACK TRANSACTION spTaoCTTV

    DECLARE @ErrMsg NVARCHAR(1000)
    DECLARE @ErrSeverity INT
    DECLARE @ErrState INT

    SELECT @ErrMsg = ERROR_MESSAGE(), @ErrSeverity = ERROR_SEVERITY(), @ErrState = ERROR_STATE()

    SET @ResCode = 0
END CATCH
GO
-- tạo chi tiết triệu chứng khi tạo phiếu
CREATE OR ALTER PROC spTaoCTTC @MaPhieu INT,
                               @TrieuChung NVARCHAR(101),
                               @ResCode BIT=1 OUTPUT -- 0: failed, 1: success
AS
BEGIN TRY
    DECLARE @trancount BIT = 0
    IF @@TRANCOUNT = 0
        BEGIN
            BEGIN TRAN
                SET @trancount = 1
        END
    ELSE
        SAVE TRAN spTaoCTTC

    INSERT INTO CT_TRIEU_CHUNG(MaPhieu, MaTrieuChung)
        (SELECT @MaPhieu, TC.MaTrieuChung
         FROM TRIEU_CHUNG TC
                  INNER JOIN (SELECT value AS TenTrieuChung FROM dbo.splitValues(@TrieuChung, ',')) TEMP
                             ON TEMP.TenTrieuChung = TC.TenTrieuChung)


    SELECT TC.MaTrieuChung
    FROM TRIEU_CHUNG TC
             INNER JOIN (SELECT value AS TenTrieuChung FROM dbo.splitValues('Ho', ',')) TEMP
                        ON TEMP.TenTrieuChung = TC.TenTrieuChung

    IF @trancount = 1
        COMMIT TRAN
END TRY
BEGIN CATCH
    IF @trancount = 1
        ROLLBACK TRAN
    ELSE
        ROLLBACK TRAN spTaoCTTC

    DECLARE @ErrMsg NVARCHAR(1000)
    DECLARE @ErrSeverity INT
    DECLARE @ErrState INT

    SELECT @ErrMsg = ERROR_MESSAGE(), @ErrSeverity = ERROR_SEVERITY(), @ErrState = ERROR_STATE()

    SET @ResCode = 0
END CATCH

GO
-- cập nhật chi tiết triệu chứng
CREATE OR ALTER PROC spCapNhatCTTC @MaPhieu INT,
                                   @TrieuChung NVARCHAR(100),
                                   @ResCode BIT=1 OUTPUT -- 0: failed, 1: success
AS
BEGIN TRY
    DECLARE @trancount BIT = 0
    IF @@TRANCOUNT = 0
        BEGIN
            BEGIN TRAN
                SET @trancount = 1
        END
    ELSE
        SAVE TRAN spCapNhatCTTC

    DELETE FROM CT_TRIEU_CHUNG WHERE MaPhieu = @MaPhieu
    INSERT INTO CT_TRIEU_CHUNG(MaPhieu, MaTrieuChung)
    VALUES (@MaPhieu,
            (SELECT TC.MaTrieuChung
             FROM TRIEU_CHUNG TC
                      INNER JOIN (SELECT value AS TenTrieuChung FROM splitValues(@TrieuChung, ',')) TEMP
                                 ON TEMP.TenTrieuChung = TC.TenTrieuChung))
    IF @trancount = 1
        COMMIT TRAN
END TRY
BEGIN CATCH
    IF @trancount = 1
        ROLLBACK
    ELSE
        ROLLBACK TRAN CapNhatCTTC

    DECLARE @ErrMsg NVARCHAR(1000)
    DECLARE @ErrSeverity INT
    DECLARE @ErrState INT

    SELECT @ErrMsg = ERROR_MESSAGE(), @ErrSeverity = ERROR_SEVERITY(), @ErrState = ERROR_STATE()

    SET @ResCode = 0
END CATCH

GO
-- tạo phiếu khai báo toàn dân
CREATE OR ALTER PROC spTaoPhieuKhaiBaoTD @MaDonVi INT,
                                         @MaNB INT=NULL,
                                         @TrieuChung NVARCHAR(100)=NULL,
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
                                         @TenTinh NVARCHAR(20),
                                         @DSVaccineDaTiem AS DSVaccineDaTiem READONLY,
                                         @DsNguoiTX AS DSNguoiTX READONLY
AS
BEGIN TRY
    BEGIN TRAN
        IF EXISTS(SELECT PTD.MaPhieu
                  FROM PHIEU_TOAN_DAN PTD
                           INNER JOIN NGUOI_KHAI_BAO NKB ON PTD.MaPhieu = NKB.MaPhieu
                  WHERE NKB.CMND = @CMND)
            RAISERROR (N'Không thể tạo, người dùng đã từng khai báo phiếu toàn dân', 1, 1)
        IF NOT EXISTS(SELECT MaDonVi FROM DON_VI WHERE MaDonVi = @MaDonVi)
            RAISERROR (N'Đơn vị không tồn tại',14,1)
        IF @MaNB IS NOT NULL AND NOT EXISTS(SELECT MaNB FROM DOI_TUONG_NHIEM_BENH WHERE MaNB = @MaNB)
            RAISERROR (N'Thông tin nhiễm bệnh không tồn tại',14,1)
        IF @NgaySinh >= GETDATE()
            RAISERROR (N'Ngày sinh không hợp lệ', 14, 1)

        DECLARE @MaPhieu INT
        DECLARE @ResCode BIT

        -- tạo phiếu khai báo
        EXEC spTaoPhieuKB @MaNB, @AmTinh, @MaPhieu=@MaPhieu OUTPUT, @ResCode=@ResCode OUTPUT
        IF @ResCode = 0
            RAISERROR (N'Tạo phiếu khai báo thất bại', 16, 1)

        -- tạo người khai báo
        EXEC spTaoNKB @MaPhieu, @CMND, @HoTen, @GioiTinh, @QuocTich,
             @NgaySinh, @SDT, @Email, @SoNha, @TenPhuong,
             @TenQuan, @TenTinh, @ResCode=@ResCode OUTPUT
        IF @ResCode = 0
            RAISERROR (N'Tạo người khai báo thất bại', 16, 1)

        -- tạo chi tiết tiếp xúc
        IF EXISTS(SELECT * FROM @DsNguoiTX)
            BEGIN
                EXEC spTaoCTTX @MaPhieu, @DsNguoiTX, @ResCode=@ResCode OUTPUT
                IF @ResCode = 0
                    RAISERROR (N'Tạo chi tiết tiếp xúc thất bại', 16, 1)
            END

        -- tạo chi tiết tiêm vaccine
        IF EXISTS(SELECT * FROM @DSVaccineDaTiem)
            BEGIN
                EXEC spTaoCTTV @MaPhieu, @DSVaccineDaTiem, @ResCode=@ResCode OUTPUT
                IF @ResCode = 0
                    RAISERROR (N'Tạo chi tiết tiêm vaccine thất bại', 16, 1)
            END

        -- tạo chi tiết triệu chứng
        EXEC spTaoCTTC @MaPhieu, @TrieuChung, @ResCode=@ResCode OUTPUT
        IF @ResCode = 0
            RAISERROR (N'Tạo chi tiết triệu chứng thất bại', 16, 1)

        -- tạo phiếu khai báo toàn dân
        INSERT INTO PHIEU_TOAN_DAN VALUES (@MaPhieu, @MaDonVi, 0)

        IF @@TRANCOUNT > 0
            COMMIT
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
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
                                             @TrieuChung NVARCHAR(100)=NULL,
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
            RAISERROR (N'Người dùng chưa từng khai báo phiếu toàn dân', 1, 1)
        IF NOT EXISTS(SELECT MaDonVi FROM DON_VI WHERE MaDonVi = @MaDonVi)
            RAISERROR (N'Đơn vị không tồn tại',14,1)
        IF @MaNB IS NOT NULL AND NOT EXISTS(SELECT MaNB FROM DOI_TUONG_NHIEM_BENH WHERE MaNB = @MaNB)
            RAISERROR (N'Tên nhiễm bệnh không tồn tại',14,1)
        IF NOT @MAVACCINE IS NULL AND NOT EXISTS(SELECT MaVaccine FROM VACCINE WHERE MaVaccine = @MaVaccine)
            RAISERROR (N'Vaccine không tồn tại', 14, 1)
        IF @NgaySinh >= GETDATE()
            RAISERROR (N'Ngày sinh không hợp lệ', 14, 1)

        DECLARE @ResCode BIT

        -- cập nhật phiếu khai báo
        EXEC spCapNhatPKB @MaPhieuKB, @MaVaccine, @AmTinh, @MaNB, @ResCode=@ResCode OUTPUT
        IF @ResCode = 0
            RAISERROR (N'Cập nhật phiếu khai báo thất bại', 16, 1)

        -- cập nhật thông tin người khai báo
        EXEC spCapNhatNKB @MaPhieuKB, @CMND, @HoTen,
             @GioiTinh, @QuocTich, @NgaySinh,
             @SDT, @Email, @SoNha, @TenPhuong,
             @TenQuan, @TenTinh, @ResCode=@ResCode OUTPUT
        IF @ResCode = 0
            RAISERROR (N'Cập nhật thông tin người khai báo thất bại', 16, 1)

        -- cập nhật thông tin chi tiết triệu chứng
        EXEC spCapNhatCTTC @MaPhieuKB, @TrieuChung, @ResCode=@ResCode OUTPUT
        IF @ResCode = 0
            RAISERROR (N'Cập nhật chi tiết triệu chứng thất bại', 16, 1)

        -- cập nhật thông tin phiếu khai báo toàn dân
        UPDATE PHIEU_TOAN_DAN
        SET MaDonVi=@MaDonVi
        WHERE MaPhieu = @MaPhieuKB

        IF @@TRANCOUNT > 0
            COMMIT TRAN
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRAN
    DECLARE @ErrMsg NVARCHAR(1000)
    DECLARE @ErrSeverity INT
    DECLARE @ErrState INT

    SELECT @ErrMsg = ERROR_MESSAGE(), @ErrSeverity = ERROR_SEVERITY(), @ErrState = ERROR_STATE()
    RAISERROR (@ErrMsg, @ErrSeverity, @ErrState)
END CATCH

GO
-- tạo phiếu khai báo nội địa
CREATE OR ALTER PROC spTaoPhieuKhaiBaoND @MaNB INT=NULL,
                                         @TrieuChung NVARCHAR(100)=NULL,
                                         @MaVaccine INT=NULL,
                                         @AmTinh BIT=0,
                                         @DiaDiemDi NVARCHAR(100),
                                         @DiaDiemDen NVARCHAR(100),
                                         @NgayKhoiHanh DATE,
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
                                         @TenTinh NVARCHAR(20),
                                         @DSVaccineDaTiem AS DSVaccineDaTiem READONLY,
                                         @DsNguoiTX AS DSNguoiTX READONLY
AS
BEGIN TRY
    BEGIN TRAN
        IF EXISTS(SELECT PND.MaPhieu
                  FROM PHIEU_DI_CHUYEN_NOI_DIA PND
                           INNER JOIN NGUOI_KHAI_BAO NKB ON PND.MaPhieu = NKB.MaPhieu
                  WHERE NKB.CMND = @CMND)
            RAISERROR (N'Không thể tạo, người dùng đã từng khai báo', 1, 1)
        IF @MaNB IS NOT NULL AND NOT EXISTS(SELECT MaNB FROM DOI_TUONG_NHIEM_BENH WHERE MaNB = @MaNB)
            RAISERROR (N'Mã nhiễm bệnh không tồn tại',14,1)
        IF NOT @MAVACCINE IS NULL AND NOT EXISTS(SELECT MaVaccine FROM VACCINE WHERE MaVaccine = @MaVaccine)
            RAISERROR (N'Mã vaccine không tồn tại', 14, 1)
        IF @NgaySinh >= GETDATE()
            RAISERROR (N'Ngày sinh không hợp lệ', 14, 1)

        DECLARE @MaPhieu INT
        DECLARE @ResCode BIT

        -- tạo phiếu khai báo
        EXEC spTaoPhieuKB @MaNB, @AmTinh, @MaPhieu=@MaPhieu OUTPUT, @ResCode=@ResCode OUTPUT
        IF @ResCode = 0
            RAISERROR (N'Tạo phiếu khai báo thất bại', 16, 1)

        -- tạo người khai báo
        EXEC spTaoNKB @MaPhieu, @CMND, @HoTen, @GioiTinh, @QuocTich,
             @NgaySinh, @SDT, @Email, @SoNha, @TenPhuong,
             @TenQuan, @TenTinh, @ResCode=@ResCode OUTPUT
        IF @ResCode = 0
            RAISERROR (N'Tạo người khai báo thất bại', 16, 1)

        -- tạo chi tiết tiếp xúc
        IF EXISTS(SELECT * FROM @DsNguoiTX)
            BEGIN
                EXEC spTaoCTTX @MaPhieu, @DsNguoiTX, @ResCode=@ResCode OUTPUT
                IF @ResCode = 0
                    RAISERROR (N'Tạo chi tiết tiếp xúc thất bại', 16, 1)
            END

        -- tạo chi tiết tiêm vaccine
        IF EXISTS(SELECT * FROM @DSVaccineDaTiem)
            BEGIN
                EXEC spTaoCTTV @MaPhieu, @DSVaccineDaTiem, @ResCode=@ResCode OUTPUT
                IF @ResCode = 0
                    RAISERROR (N'Tạo chi tiết tiêm vaccine thất bại', 16, 1)
            END

        -- tạo chi tiết triệu chứng
        EXEC spTaoCTTC @MaPhieu, @TrieuChung, @ResCode=@ResCode OUTPUT
        IF @ResCode = 0
            RAISERROR (N'Tạo chi tiết triệu chứng thất bại', 16, 1)

        -- tạo phiếu khai báo nội địa
        INSERT INTO PHIEU_DI_CHUYEN_NOI_DIA VALUES (@MaPhieu, @DiaDiemDi, @DiaDiemDen, @NgayKhoiHanh, 0)

        IF @@TRANCOUNT > 0
            COMMIT
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
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
                                      @MaNB INT,
                                      @TrieuChung NVARCHAR(100),
                                      @MaVaccine INT=NULL,
                                      @AmTinh BIT=0,
                                      @DiaDiemDi NVARCHAR(50),
                                      @DiaDiemDen NVARCHAR(50),
                                      @NgayKhoiHanh DATE,
                                      @HoTen NVARCHAR(50),
                                      @CMND VARCHAR(12),
                                      @GioiTinh BIT=0,
                                      @QuocTich NVARCHAR(25),
                                      @NgaySinh DATE,
                                      @SDT VARCHAR(15),
                                      @Email VARCHAR(20),
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
            RAISERROR (N'Không thể cập nhật, người dùng chưa từng khai báo', 1, 1)
        IF @MaNB IS NOT NULL AND NOT EXISTS(SELECT MaNB FROM DOI_TUONG_NHIEM_BENH WHERE MaNB = @MaNB)
            RAISERROR (N'Tên nhiễm bệnh không tồn tại',14,1)
        IF NOT @MAVACCINE IS NULL AND NOT EXISTS(SELECT MaVaccine FROM VACCINE WHERE MaVaccine = @MaVaccine)
            RAISERROR (N'Mã vaccine không tồn tại', 14, 1)
        IF @NgaySinh >= GETDATE()
            RAISERROR (N'Ngày sinh không hợp lệ', 14, 1)

        DECLARE @ResCode BIT

        -- cập nhật phiếu khai báo
        EXEC spCapNhatPKB @MaPhieuKB, @MaVaccine, @AmTinh, @MaNB, @ResCode=@ResCode OUTPUT
        IF @ResCode = 0
            RAISERROR (N'Cập nhật phiếu khai báo thất bại', 16, 1)

        -- cập nhật thông tin người khai báo
        EXEC spCapNhatNKB @MaPhieuKB, @CMND, @HoTen,
             @GioiTinh, @QuocTich, @NgaySinh,
             @SDT, @Email, @SoNha, @TenPhuong,
             @TenQuan, @TenTinh, @ResCode=@ResCode OUTPUT
        IF @ResCode = 0
            RAISERROR (N'Cập nhật thông tin người khai báo thất bại', 16, 1)

        -- cập nhật thông tin chi tiết triệu chứng
        EXEC spCapNhatCTTC @MaPhieuKB, @TrieuChung, @ResCode=@ResCode OUTPUT
        IF @ResCode = 0
            RAISERROR (N'Cập nhật chi tiết triệu chứng thất bại', 16, 1)

        -- cập nhật thông tin phiếu khai báo nội địa
        UPDATE PHIEU_DI_CHUYEN_NOI_DIA
        SET DiaDiemDi=@DiaDiemDi,
            DiaDiemDen=@DiaDiemDen,
            NgayKhoiHanh=@NgayKhoiHanh
        WHERE MaPhieu = @MaPhieuKB

        IF @@TRANCOUNT > 0
            COMMIT TRAN
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRAN

    DECLARE @ErrMsg NVARCHAR(1000)
    DECLARE @ErrSeverity INT
    DECLARE @ErrState INT

    SELECT @ErrMsg = ERROR_MESSAGE(), @ErrSeverity = ERROR_SEVERITY(), @ErrState = ERROR_STATE()
    RAISERROR (@ErrMsg, @ErrSeverity, @ErrState)
END CATCH

GO

CREATE OR ALTER PROC spTaoPhieuKhaiBaoNC @MaNB INT=NULL,
                                         @MaCSCL INT,
                                         @TrieuChung NVARCHAR(100)=NULL,
                                         @MaVaccine INT=NULL,
                                         @AmTinh BIT=0,
                                         @DoiTuong NVARCHAR(50),
                                         @PhuongTien NVARCHAR(50),
                                         @DiaDiemQGKhoiHanh NVARCHAR(100),
                                         @DiaDiemTinhKhoiHanh NVARCHAR(100),
                                         @DiaDiemQGNoiDen NVARCHAR(100),
                                         @DiaDiemTinhNoiDen NVARCHAR(100),
                                         @NgayKhoiHanh DATE,
                                         @NgayNhapCanh DATE,
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
                                         @TenTinh NVARCHAR(20),
                                         @DSVaccineDaTiem AS DSVaccineDaTiem READONLY,
                                         @DsNguoiTX AS DSNguoiTX READONLY
AS
BEGIN TRY
    BEGIN TRAN
        IF EXISTS(SELECT PNC.MaPhieu
                  FROM PHIEU_NHAP_CANH PNC
                           INNER JOIN NGUOI_KHAI_BAO NKB ON PNC.MaPhieu = NKB.MaPhieu
                  WHERE NKB.CMND = @CMND)
            RAISERROR (N'Không thể tạo, người dùng đã từng khai báo phiếu nhập cảnh', 1, 1)
        IF @MaNB IS NOT NULL AND NOT EXISTS(SELECT MaNB FROM DOI_TUONG_NHIEM_BENH WHERE MaNB = @MaNB)
            RAISERROR (N'Tên nhiễm bệnh không tồn tại',14,1)
        IF NOT EXISTS(SELECT MaCSCL FROM CO_SO_CACH_LY WHERE MaCSCL = @MaCSCL)
            RAISERROR (N'Cơ sở cách ly không tồn tại',14,1)
        IF NOT @MaVaccine IS NULL AND NOT EXISTS(SELECT MaVaccine FROM VACCINE WHERE MaVaccine = @MaVaccine)
            RAISERROR (N'Mã vaccine không tồn tại', 14, 1)
        IF @NgaySinh >= GETDATE()
            RAISERROR (N'Ngày sinh không hợp lệ', 14, 1)
        IF @NgayKhoiHanh > @NgayNhapCanh
            RAISERROR (N'Ngày kết thúc lịch trình không hợp lệ', 14, 1)

        DECLARE @MaPhieu INT
        DECLARE @ResCode BIT

        -- tạo phiếu khai báo
        EXEC spTaoPhieuKB @MaNB, @AmTinh, @MaPhieu=@MaPhieu OUTPUT, @ResCode=@ResCode OUTPUT
        IF @ResCode = 0
            RAISERROR (N'Tạo phiếu khai báo thất bại', 16, 1)

        -- tạo người khai báo
        EXEC spTaoNKB @MaPhieu, @CMND, @HoTen, @GioiTinh, @QuocTich,
             @NgaySinh, @SDT, @Email, @SoNha, @TenPhuong,
             @TenQuan, @TenTinh, @ResCode=@ResCode OUTPUT
        IF @ResCode = 0
            RAISERROR (N'Tạo người khai báo thất bại', 16, 1)

        -- tạo chi tiết tiếp xúc
        IF EXISTS(SELECT * FROM @DsNguoiTX)
            BEGIN
                EXEC spTaoCTTX @MaPhieu, @DsNguoiTX, @ResCode=@ResCode OUTPUT
                IF @ResCode = 0
                    RAISERROR (N'Tạo chi tiết tiếp xúc thất bại', 16, 1)
            END

        -- tạo chi tiết tiêm vaccine
        IF EXISTS(SELECT * FROM @DSVaccineDaTiem)
            BEGIN
                EXEC spTaoCTTV @MaPhieu, @DSVaccineDaTiem, @ResCode=@ResCode OUTPUT
                IF @ResCode = 0
                    RAISERROR (N'Tạo chi tiết tiêm vaccine thất bại', 16, 1)
            END

        -- tạo chi tiết triệu chứng
        EXEC spTaoCTTC @MaPhieu, @TrieuChung, @ResCode=@ResCode OUTPUT
        IF @ResCode = 0
            RAISERROR (N'Tạo chi tiết triệu chứng thất bại', 16, 1)

        -- tạo phiếu khai báo nhập cảnh
        INSERT INTO PHIEU_NHAP_CANH
        VALUES (@MaPhieu, @MaCSCL, @DoiTuong, @PhuongTien, @NgayKhoiHanh, @NgayNhapCanh, @DiaDiemQGKhoiHanh,
                @DiaDiemTinhKhoiHanh, @DiaDiemQGNoiDen, @DiaDiemTinhNoiDen, 0)

        IF @@TRANCOUNT > 0
            COMMIT TRAN
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRAN

    DECLARE @ErrMsg NVARCHAR(1000)
    DECLARE @ErrSeverity INT
    DECLARE @ErrState INT

    SELECT @ErrMsg = ERROR_MESSAGE(), @ErrSeverity = ERROR_SEVERITY(), @ErrState = ERROR_STATE()
    RAISERROR (@ErrMsg, @ErrSeverity, @ErrState)
END CATCH

GO
CREATE OR ALTER PROC spCapNhatPhieuKhaiBaoNC @MaPhieuKB INT,
                                             @MaNB INT,
                                             @MaCSCL INT,
                                             @TrieuChung NVARCHAR(100),
                                             @MaVaccine INT,
                                             @AmTinh BIT,
                                             @DiaDiemQGKhoiHanh NVARCHAR(100),
                                             @DiaDiemTinhKhoiHanh NVARCHAR(100),
                                             @DiaDiemQGNoiDen NVARCHAR(100),
                                             @DiaDiemTinhNoiDen NVARCHAR(100),
                                             @DoiTuong NVARCHAR(50),
                                             @PhuongTien NVARCHAR(50),
                                             @NgayKhoiHanh DATE,
                                             @NgayNhapCanh DATE,
                                             @CMND VARCHAR(12),
                                             @HoTen NVARCHAR(50),
                                             @GioiTinh BIT,
                                             @QuocTich NVARCHAR(25),
                                             @NgaySinh DATE,
                                             @SDT VARCHAR(15),
                                             @Email VARCHAR(20),
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
            RAISERROR (N'Không thể cập nhật, người dùng chưa từng khai báo nhập cảnh', 1, 1)
        IF @MaNB IS NOT NULL AND NOT EXISTS(SELECT MaNB FROM DOI_TUONG_NHIEM_BENH WHERE MaNB = @MaNB)
            RAISERROR (N'Mã nhiễm bệnh không tồn tại',14,1)
        IF NOT @MaVaccine IS NULL AND NOT EXISTS(SELECT MaVaccine FROM VACCINE WHERE MaVaccine = @MaVaccine)
            RAISERROR (N'Mã vaccine không tồn tại', 14, 1)
        IF @NgaySinh >= GETDATE()
            RAISERROR (N'Ngày sinh không hợp lệ', 14, 1)
        IF @NgayKhoiHanh < @NgayNhapCanh
            RAISERROR (N'Ngày kết thúc lịch trình không hợp lệ', 14, 1)

        -- cập nhật thông tin phiếu khai báo
        DECLARE @ResCode BIT

        -- cập nhật phiếu khai báo
        EXEC spCapNhatPKB @MaPhieuKB, @MaVaccine, @AmTinh, @MaNB, @ResCode=@ResCode OUTPUT
        IF @ResCode = 0
            RAISERROR (N'Cập nhật phiếu khai báo thất bại', 16, 1)

        -- cập nhật thông tin người khai báo
        EXEC spCapNhatNKB @MaPhieuKB, @CMND, @HoTen,
             @GioiTinh, @QuocTich, @NgaySinh,
             @SDT, @Email, @SoNha, @TenPhuong,
             @TenQuan, @TenTinh, @ResCode=@ResCode OUTPUT
        IF @ResCode = 0
            RAISERROR (N'Cập nhật thông tin người khai báo thất bại', 16, 1)

        -- cập nhật thông tin chi tiết triệu chứng
        EXEC spCapNhatCTTC @MaPhieuKB, @TrieuChung, @ResCode=@ResCode OUTPUT
        IF @ResCode = 0
            RAISERROR (N'Cập nhật chi tiết triệu chứng thất bại', 16, 1)

        -- cập nhật thông tin phiếu khai báo nội địa
        UPDATE PHIEU_NHAP_CANH
        SET MaCSCL=@MaCSCL,
            DoiTuong=@DoiTuong,
            PhuongTien=@PhuongTien,
            NgayKhoiHanh=@NgayKhoiHanh,
            NgayNhapCanh=@NgayNhapCanh,
            DiaDiemQGKhoiHanh=@DiaDiemQGKhoiHanh,
            DiaDiemTinhKhoiHanh=@DiaDiemTinhKhoiHanh,
            DiaDiemQGNoiDen=@DiaDiemQGNoiDen,
            DiaDiemTinhNoiDen=@DiaDiemTinhNoiDen
        WHERE MaPhieu = @MaPhieuKB

        IF @@TRANCOUNT > 0
            COMMIT TRAN
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRAN

    DECLARE @ErrMsg NVARCHAR(1000)
    DECLARE @ErrSeverity INT
    DECLARE @ErrState INT

    SELECT @ErrMsg = ERROR_MESSAGE(), @ErrSeverity = ERROR_SEVERITY(), @ErrState = ERROR_STATE()
    RAISERROR (@ErrMsg, @ErrSeverity, @ErrState)
END CATCH
