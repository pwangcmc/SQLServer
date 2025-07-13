SELECT COUNT(*) FROM dbo.AccountPremiumChange				-- 15,819

/*
To identify all AccountNumber + AccountDid combinations that 
have redundant date ranges (i.e., one record fully contained within another)
use a JOIN-based query to detect them.
*/
SELECT 
	--DISTINCT A.AccountNumber, A.AccountDid
	*
FROM dbo.AccountPremiumChange A
JOIN dbo.AccountPremiumChange B
    ON A.AccountNumber = B.AccountNumber
    AND A.AccountDid = B.AccountDid
    AND B.ValidFromDate <= A.ValidFromDate
    AND B.ValidToDate >= A.ValidToDate
    AND (A.ValidFromDate <> B.ValidFromDate OR A.ValidToDate <> B.ValidToDate)
ORDER BY A.AccountNumber, A.AccountDid;


/*
*****************  Identify which row is redundat - Subquery ******************
*/

SELECT 
    A.AccountNumber,
    A.AccountDid,
    A.ValidFromDate,
    A.ValidToDate,
    CASE 
        WHEN EXISTS (
            SELECT 1
            FROM dbo.AccountPremiumChange B
            WHERE A.AccountNumber = B.AccountNumber
              AND A.AccountDid = B.AccountDid
              AND B.ValidFromDate <= A.ValidFromDate
              AND B.ValidToDate >= A.ValidToDate
              AND (A.ValidFromDate <> B.ValidFromDate OR A.ValidToDate <> B.ValidToDate)
        )
        THEN 'Redundant'
        ELSE 'Valid'
    END AS Status
FROM dbo.AccountPremiumChange A
ORDER BY A.AccountNumber, A.AccountDid, A.ValidFromDate;

-- EXCEPT

/*
*****************  Identify which row is redundat - JOIN ******************
*/
SELECT 
    A.AccountNumber,
    A.AccountDid,
    A.ValidFromDate,
    A.ValidToDate,
    CASE 
        WHEN B.AccountNumber IS NOT NULL THEN 'Redundant'
        ELSE 'Valid'
    END AS Status
FROM dbo.AccountPremiumChange A
LEFT JOIN dbo.AccountPremiumChange B
    ON A.AccountNumber = B.AccountNumber
    AND A.AccountDid = B.AccountDid
    AND B.ValidFromDate <= A.ValidFromDate
    AND B.ValidToDate >= A.ValidToDate
    AND (A.ValidFromDate <> B.ValidFromDate OR A.ValidToDate <> B.ValidToDate)
ORDER BY A.AccountNumber, A.AccountDid, A.ValidFromDate;






/*******************************************************/
/********** Small Test ********************/
; WITH Test AS (
	SELECT * FROM dbo.AccountPremiumChange WHERE AccountNumber = '1006742'
)
SELECT   a.AccountNumber A_AccountNumber, a.ValidFromDate A_ValidFromDate, a.ValidToDate A_ValidToDate  
	   , b.AccountNumber B_AccountNumber, b.ValidFromDate B_ValidFromDate, b.ValidToDate B_ValidToDate
FROM Test a
CROSS JOIN Test b
WHERE  A.AccountNumber = B.AccountNumber
    AND A.AccountDid = B.AccountDid
	AND (A.ValidFromDate <> B.ValidFromDate OR A.ValidToDate <> B.ValidToDate)

	AND B.ValidFromDate <= A.ValidFromDate
    AND B.ValidToDate >= A.ValidToDate

ORDER BY a.ValidFromDate























