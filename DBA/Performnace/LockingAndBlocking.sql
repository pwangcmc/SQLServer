/*
== Meaning: SPID 65 is blocked by SPID 51 for 12 minutes
== and the wait type is LCK_M_S
session_id	blocking_session_id	wait_type	DurationInMins
65			51					LCK_M_S		12.633333
*/

SELECT  
	session_id							-- which run the select statement
	, blocking_session_id				-- which run the truncate table 
	, wait_type -- LCK_M_SCH_S
	, wait_duration_ms / 1000 / 60.0 DurationInMins
FROM sys.dm_os_waiting_tasks
WHERE blocking_session_id IS NOT NULL

exec sp_lock

SELECT 
	distinct
	request_session_id
	, DB_NAME(resource_database_id) DBName
	, resource_type, resource_subtype, resource_description
	, IIF (resource_associated_entity_id < 2147483647, 
		OBJECT_NAME(resource_associated_entity_id)
		, CAST(resource_associated_entity_id as varchar(100))) 
			ResourceName
	, request_mode, request_type, request_status
	--, * 
FROM sys.dm_tran_locks l
WHERE resource_type <> 'Database'
ORDER BY l.request_session_id

-----------------------------------
----- Get blocked session   ------
----------------------------------
SELECT 
	request_session_id
	, DB_NAME(resource_database_id) DBName
	, resource_type, resource_subtype, resource_description
	, IIF (resource_associated_entity_id < 2147483647, 
		OBJECT_NAME(resource_associated_entity_id)
		, CAST(resource_associated_entity_id as varchar(100))) 
			ResourceName
	, request_mode, request_type, request_status
	--, * 
FROM sys.dm_tran_locks l
WHERE request_status = 'WAIT'
ORDER BY l.request_session_id


SELECT * FROM sys.dm_exec_sessions
WHERE session_id IN (51,65)

SELECT st.text, * 
FROM sys.dm_exec_connections
CROSS APPLY sys.dm_exec_sql_text(most_recent_sql_handle) st
WHERE session_id IN (51,65)

SELECT 
	text
	, session_id, blocking_session_id 
	, * 
FROM sys.dm_exec_requests
CROSS APPLY sys.dm_exec_sql_text(sql_handle)
WHERE blocking_session_id > 0
	
