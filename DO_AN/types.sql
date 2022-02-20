CREATE TYPE DSNguoiTX AS TABLE
(
    CMND       VARCHAR(12) NOT NULL,
    DiaDiemTX  NVARCHAR(50),
    ThoiGianTX DATE
)

CREATE TYPE DSVaccineDaTiem AS TABLE
(
    MaVaccine INT NOT NULL,
    LuotTiem  INT NOT NULL,
    NgayTiem  DATE
)
select * FROM CO_SO_CACH_LY