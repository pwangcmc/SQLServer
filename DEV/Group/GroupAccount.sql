DROP TABLE IF EXISTS AccountInOut
GO
CREATE TABLE AccountInOut (
	AcctId int
	, cat varchar(3)
	, ActDate date
)
GO

INSERT INTO AccountInOut VALUES
(1, 'IN', '2020-03-04'), (2, 'IN', '2021-03-04'), (2, 'OUT', '2022-05-04')
, (1, 'OUT', '2024-03-04'), (3, 'IN', '2021-01-04')
, (1, 'IN', '2021-05-04')
, (4, 'OUT', '2012-5-04'), (4, 'IN', '2011-01-04')
GO

SELECT * FROM AccountInOut ORDER BY AcctId

; WITH CTEIN AS (
	SELECT AcctId, MAX(ActDate) ActDate 
	FROM AccountInOut
	WHERE Cat = 'IN'
	GROUP BY AcctId
)
, CTEOUT AS (
	SELECT AcctId, MAX(ActDate) ActDate 
	FROM AccountInOut
	WHERE Cat = 'OUT'
	GROUP BY AcctId
)

SELECT ctein.AcctId, CTEIN.ActDate InDate, CTEOUT.ActDate OutDate 
FROM CTEIN LEFT JOIN CTEOUT ON CTEIN.AcctId = CTEOUT.AcctId
