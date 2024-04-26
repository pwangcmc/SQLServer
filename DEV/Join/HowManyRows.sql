SELECT COUNT(*) 
FROM SALES.ORDERVALUES A
INNER JOIN Sales.OrderValues b
	ON a.custid =  b.custid
GO

; WITH CTE AS ( 
	SELECT custid, count(*) CustCNT, count(*) * count(*) DCount
	FROM sales.OrderValues a
	GROUP BY custid
) 
SELECT SUM(dcount) FROM cte

-- Both returns 10,712
