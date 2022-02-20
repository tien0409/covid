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
CREATE OR ALTER TRIGGER tgThemNKB
    ON NGUOI_KHAI_BAO
    AFTER INSERT AS
BEGIN
    DECLARE @MaPhieuKB INT
    DECLARE @MaPhieuKB_NNB INT
    DECLARE @CMND VARCHAR(12)

    SET @MaPhieuKB = (SELECT MaPhieu FROM inserted)
    SET @CMND = (SELECT CMND FROM inserted)
    SET @MaPhieuKB_NNB = (SELECT TOP 1 MaPhieu FROM CT_TIEP_XUC WHERE DATEDIFF(DAY, ThoiGianTX, GETDATE()) < 14)

    IF @MaPhieuKB_NNB IS NOT NULL
        BEGIN
            DECLARE @MaNB INT
            SET @MaNB = (SELECT MaNB FROM PHIEU_KHAI_BAO WHERE MaPhieu = @MaPhieuKB_NNB)

            IF EXISTS(SELECT * FROM DOI_TUONG_NHIEM_BENH WHERE MaNB = (@MaNB + 1))
                UPDATE PHIEU_KHAI_BAO SET MaNB = (@MaNB + 1) WHERE MaPhieu = @MaPhieuKB
        END
END

GO
CREATE OR ALTER TRIGGER tgThemPTD
    ON PHIEU_TOAN_DAN
    AFTER INSERT AS
BEGIN
    DECLARE @MaPhieuKB INT
    DECLARE @CMND VARCHAR(12)

    SELECT @MaPhieuKB = PKB.MaPhieu, @CMND = NKB.CMND
    FROM inserted AS PKB
             INNER JOIN NGUOI_KHAI_BAO NKB ON PKB.MaPhieu = NKB.MaPhieu

    -- kiểm tra xem đã từng khai báo chưa ( phiếu nội địa, phiếu nhập cảnh)
--     IF EXISTS(SELECT MaPhieu FROM PHIEU_DI_CHUYEN_NOI_DIA WHERE MaPhieu = @MaPhieuKB)
--         UPDATE PHIEU_DI_CHUYEN_NOI_DIA SET IsDeleted = 1 WHERE MaPhieu = @MaPhieuKB
--     IF EXISTS(SELECT MaPhieu FROM PHIEU_NHAP_CANH WHERE MaPhieu = @MaPhieuKB)
--         UPDATE PHIEU_NHAP_CANH SET IsDeleted = 1 WHERE MaPhieu = @MaPhieuKB
    -- kiểm tra xem có phải người này đã từng tiếp xúc với người bị bệnh chưa
    IF EXISTS(SELECT CMND FROM NGUOI_TIEP_XUC WHERE CMND = @CMND)
        BEGIN
            DECLARE @MaPhieuKB_NguoiBenh INT

            UPDATE NGUOI_TIEP_XUC SET DaKhaiBao=1 WHERE CMND = @CMND

            -- tìm người bệnh mà đã tiếp xúc
--             SELECT MIN(DATEDIFF(DAY, CTTX.ThoiGianTX, GETDATE())) FROM CT_TIEP_XUC CTTX WHERE CTTX.CMNDNTX = @CMND
        END

END

GO
CREATE OR ALTER TRIGGER tgThemPNC
    ON PHIEU_NHAP_CANH
    AFTER INSERT AS
BEGIN
    DECLARE @MaPhieuKB INT

    SELECT @MaPhieuKB = MaPhieu FROM inserted

    -- kiểm tra xem đã từng khai báo chưa ( phiếu nội địa, phiếu toàn dân)
--     IF EXISTS(SELECT MaPhieu FROM PHIEU_TOAN_DAN WHERE MaPhieu = @MaPhieuKB)
--         UPDATE PHIEU_TOAN_DAN SET IsDeleted = 1 WHERE MaPhieu = @MaPhieuKB
--     IF EXISTS(SELECT MaPhieu FROM PHIEU_DI_CHUYEN_NOI_DIA WHERE MaPhieu = @MaPhieuKB)
--         UPDATE PHIEU_DI_CHUYEN_NOI_DIA SET IsDeleted = 1 WHERE MaPhieu = @MaPhieuKB
END

GO
CREATE OR ALTER TRIGGER tgThemPND
    ON PHIEU_DI_CHUYEN_NOI_DIA
    AFTER INSERT AS
BEGIN
    DECLARE @MaPhieuKB INT

    SELECT @MaPhieuKB = MaPhieu FROM inserted

    -- kiểm tra xem đã từng khai báo chưa ( phiếu nội địa, phiếu toàn dân)
--     IF EXISTS(SELECT MaPhieu FROM PHIEU_TOAN_DAN WHERE MaPhieu = @MaPhieuKB)
--         UPDATE PHIEU_TOAN_DAN SET IsDeleted = 1 WHERE MaPhieu = @MaPhieuKB
--     IF EXISTS(SELECT MaPhieu FROM PHIEU_NHAP_CANH WHERE MaPhieu = @MaPhieuKB)
--         UPDATE PHIEU_NHAP_CANH SET IsDeleted = 1 WHERE MaPhieu = @MaPhieuKB
END
