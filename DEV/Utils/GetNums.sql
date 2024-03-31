CREATE FUNCTION [dbo].[GetNums](@low AS BIGINT = 1, @high AS BIGINT)
  RETURNS TABLE
AS
RETURN
  WITH
    L0 AS ( SELECT 1 AS c 
            FROM (VALUES(1),(1),(1),(1),(1),(1),(1),(1),
                        (1),(1),(1),(1),(1),(1),(1),(1)) AS D(c) ),
    L1 AS ( SELECT 1 AS c FROM L0 AS A CROSS JOIN L0 AS B ),
    L2 AS ( SELECT 1 AS c FROM L1 AS A CROSS JOIN L1 AS B ),
    L3 AS ( SELECT 1 AS c FROM L2 AS A CROSS JOIN L2 AS B ),
    Nums AS ( SELECT ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS rownum
              FROM L3 )
  SELECT TOP(@high - @low + 1)
     rownum AS rn,
     @high + 1 - rownum AS op,
     @low - 1 + rownum AS n
  FROM Nums
  ORDER BY rownum;
