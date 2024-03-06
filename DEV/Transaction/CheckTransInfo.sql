-- How to check current session's IOSLATION LEVEL
DBCC USEROPTIONS
/*
Set Option	                  Value
textsize	                    2147483647
language	                    us_english
dateformat	                  mdy
datefirst	                    7
lock_timeout	                -1
quoted_identifier	            SET
arithabort	                  SET
ansi_null_dflt_on	            SET
ansi_warnings	                SET
ansi_padding	                SET
ansi_nulls	                  SET
concat_null_yields_null	      SET
isolation level	              read committed
*/

SELECT 
  CASE transaction_isolation_level
	WHEN 1 THEN 'READ UNCOMMITTED'
	WHEN 2 THEN 'READ COMMITTED'
	WHEN 3 THEN 'REPEATABLE READ'
	WHEN 4 THEN 'SERIALIZABLE'
	WHEN 5 THEN 'SNAPSHOT'
    ELSE 'Unspecified' 
  END AS transaction_isolation_level,
FROM sys.dm_exec_sessions 
WHERE session_id = @@SPID


-- Syntax for SQL Server and Azure SQL Database
  
SET TRANSACTION ISOLATION LEVEL
    { READ UNCOMMITTED
    | READ COMMITTED
    | REPEATABLE READ
    | SNAPSHOT
    | SERIALIZABLE
    }
