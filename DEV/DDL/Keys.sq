USE tempdb
GO

DROP TABLE IF EXISTS Child
GO

DROP TABLE IF EXISTS Parent
GO

CREATE TABLE Parent (
	CONSTRAINT PK_Parent_pid PRIMARY KEY (pid)
	, CONSTRAINT UK_Parent_pcode UNIQUE (pcode)
	, pid INT, pcode INT, pname varchar(50)
	, pui INT
)
GO

CREATE UNIQUE INDEX idx_Parent_pui ON Parent (Pui)
GO

CREATE TABLE Child (
	cid INT
	, CONSTRAINT PK_Child_cid PRIMARY KEY (cid)
	, pid int
	, CONSTRAINT FK_Child_cid_Parent_pid Foreign KEY (pid) References Parent(pid)
	, pcode int
	, CONSTRAINT FK_Child_pcode_Parent_pcode Foreign KEY (pid) References Parent(pid)
	, pui int
	, CONSTRAINT FK_Child_pui_Parent_pui Foreign KEY (pui) References Parent(pui)
)

/*
In SQL Server Management Studio (SSMS), when you expand the "Keys" folder for a table in the Object Explorer, you'll typically find the various keys associated with that table. These keys can include:

Primary Key: This is a unique identifier for each row in the table. It ensures that each row has a unique value for the primary key column(s).
Foreign Key: If the table has any foreign key constraints, you'll see them listed under this folder. Foreign keys establish a relationship between two tables by enforcing referential integrity.
Unique Key: Similar to a primary key, a unique key constraint ensures that each value in the specified column(s) is unique. However, unlike a primary key, a unique key does not necessarily enforce the NOT NULL constraint.
Clustered Index Key: If the table has a clustered index defined on it, you'll see the clustered index key listed here. The clustered index determines the physical order of the rows in the table.
Non-clustered Index Keys: Any non-clustered indexes defined on the table will have their keys listed under this folder. Non-clustered indexes provide a separate copy of selected columns from the table, sorted by the index key.
*/
