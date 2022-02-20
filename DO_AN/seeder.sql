-- thêm cơ sở cách ly mặc định
INSERT INTO CO_SO_CACH_LY (TenCSCL)
VALUES (N'Cơ sở cách ly tập trung')
INSERT INTO CO_SO_CACH_LY
VALUES (N'Cơ sở cách ly tự chọn')

-- thêm các đơn vi mặc định
-- INSERT INTO DON_VI
-- VALUES (N'Hà Nội', -1, 'hn', 'hn', GETDATE(), GETDATE())
-- INSERT INTO DON_VI
-- VALUES (N'Hưng Yên', -1, 'hy', 'hy', GETDATE(), GETDATE())
-- INSERT INTO DON_VI
-- VALUES (N'Quảng Ngãi', -1, 'qn', 'qn', GETDATE(), GETDATE())
-- INSERT INTO DON_VI
-- VALUES (N'HCM', -1, 'hcm', 'hcm', GETDATE(), GETDATE())

-- thêm đối tượng nhiễm bệnh mặc định
INSERT INTO DOI_TUONG_NHIEM_BENH
VALUES ('F0')
INSERT INTO DOI_TUONG_NHIEM_BENH
VALUES ('F1')
INSERT INTO DOI_TUONG_NHIEM_BENH
VALUES ('F2')

-- thêm vaccine mặc định
INSERT INTO VACCINE
VALUES (N'AstraZeneca', N'Mỹ')
INSERT INTO VACCINE
VALUES (N'SPUTNIK V', N'Nga')
INSERT INTO VACCINE
VALUES (N'Vero Cell', N'Pfizer/BioNTech')
INSERT INTO VACCINE
VALUES (N'Comirnaty ', N'Pfizer/BioNTech')

-- thêm các triệu chứng
INSERT INTO TRIEU_CHUNG
VALUES(N'Ốm', N'', 0)
INSERT INTO TRIEU_CHUNG
VALUES(N'Sốt', N'', 0)
INSERT INTO TRIEU_CHUNG
VALUES(N'Ho', N'', 0)
INSERT INTO TRIEU_CHUNG
VALUES(N'Mất vị giác', N'', 0)