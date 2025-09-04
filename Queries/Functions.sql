
-- create function (Levenshtein_Distance)

CREATE OR ALTER FUNCTION dbo.Levenshtein_Distance
(
    @s NVARCHAR(4000),
    @t NVARCHAR(4000)
)
RETURNS INT
AS
BEGIN
    DECLARE @m INT = LEN(@s);
    DECLARE @n INT = LEN(@t);

    IF @m = 0 RETURN @n;
    IF @n = 0 RETURN @m;

    DECLARE @d TABLE
    (
        i INT,
        j INT,
        cost INT,
        PRIMARY KEY (i, j)
    );

    DECLARE @i INT;
    DECLARE @j INT;
    DECLARE @s_i NCHAR(1);
    DECLARE @t_j NCHAR(1);
    DECLARE @cost INT;
    DECLARE @insertCost INT;
    DECLARE @deleteCost INT;
    DECLARE @replaceCost INT;

    -- initialize first column
    SET @i = 0;
    WHILE @i <= @m
    BEGIN
        INSERT INTO @d (i, j, cost) VALUES (@i, 0, @i);
        SET @i += 1;
    END;

    -- initialize first row (skip (0,0) to avoid duplicate)
    SET @j = 1;
    WHILE @j <= @n
    BEGIN
        INSERT INTO @d (i, j, cost) VALUES (0, @j, @j);
        SET @j += 1;
    END;

    -- fill matrix
    SET @i = 1;
    WHILE @i <= @m
    BEGIN
        SET @s_i = SUBSTRING(@s, @i, 1);
        SET @j = 1;
        WHILE @j <= @n
        BEGIN
            SET @t_j = SUBSTRING(@t, @j, 1);

            IF (@s_i = @t_j) 
                SET @cost = 0; 
            ELSE 
                SET @cost = 1;

            -- calculate costs
            SELECT @insertCost = cost FROM @d WHERE i = @i - 1 AND j = @j; -- deletion
            SELECT @deleteCost = cost FROM @d WHERE i = @i AND j = @j - 1; -- insertion
            SELECT @replaceCost = cost FROM @d WHERE i = @i - 1 AND j = @j - 1; -- substitution

            SET @insertCost = @insertCost + 1;
            SET @deleteCost = @deleteCost + 1;
            SET @replaceCost = @replaceCost + @cost;

            -- take minimum
            SET @cost = (SELECT MIN(v) FROM (VALUES (@insertCost), (@deleteCost), (@replaceCost)) AS value(v));

            INSERT INTO @d (i, j, cost) VALUES (@i, @j, @cost);

            SET @j += 1;
        END;
        SET @i += 1;
    END;

    SELECT @cost = cost FROM @d WHERE i = @m AND j = @n;

    RETURN @cost;
END;





-- create function (Levenshtein_Similarity)

CREATE OR ALTER FUNCTION dbo.Levenshtein_Similarity
(
    @s NVARCHAR(4000),
    @t NVARCHAR(4000)
)
RETURNS FLOAT
AS
BEGIN
    DECLARE @distance INT = dbo.Levenshtein(@s, @t);
    DECLARE @maxLen INT = CASE WHEN LEN(@s) > LEN(@t) THEN LEN(@s) ELSE LEN(@t) END;
    IF @maxLen = 0 RETURN 1; -- both strings empty → 100% match
    RETURN 1.0 - CAST(@distance AS FLOAT) / @maxLen;
END;
GO





