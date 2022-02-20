------------------- FUNCTION -----------------------------
-- hàm split lấy các giá trị
CREATE FUNCTION dbo.splitValues(@Values NVARCHAR(200), @SplitOn NVARCHAR(3)=',')
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