SELECT  
	session_id -- which run the select statement
	, blocking_session_id  -- which run the truncate table 
	, wait_type -- LCK_M_SCH_S
	, wait_duration_ms / 1000 / 60.0 WaitDuration
FROM sys.dm_os_waiting_tasks
WHERE session_id = 51


SELECT  
	session_id  BlockedSPID -- which run the select statement
	, blocking_session_id BlockedBy  -- which run the truncate table 
	, wait_type -- LCK_M_SCH_S
	, wait_duration_ms / 1000 / 60.0 DurationInMins
FROM sys.dm_os_waiting_tasks
WHERE session_id = 51
