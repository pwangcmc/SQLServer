select schema_name(t.schema_id) + '.' + t.[name] as table_view, 
    case when t.[type] = 'U' then 'Table'
        when t.[type] = 'V' then 'View'
        end as [object_type],
    case when c.[type] = 'PK' then 'Primary key'
        when c.[type] = 'UQ' then 'Unique constraint'
        when i.[type] = 1 then 'Unique clustered index'
        when i.type = 2 then 'Unique index'
        end as constraint_type, 
    c.[name] as constraint_name,
    substring(column_names, 1, len(column_names)-1) as [columns],
    i.[name] as index_name,
    case when i.[type] = 1 then 'Clustered index'
        when i.type = 2 then 'Index'
        end as index_type
from sys.objects t
    left outer join sys.indexes i
        on t.object_id = i.object_id
    left outer join sys.key_constraints c
        on i.object_id = c.parent_object_id 
        and i.index_id = c.unique_index_id
   cross apply (select col.[name] + ', '
                    from sys.index_columns ic
                        inner join sys.columns col
                            on ic.object_id = col.object_id
                            and ic.column_id = col.column_id
                    where ic.object_id = t.object_id
                        and ic.index_id = i.index_id
                            order by col.column_id
                            for xml path ('') ) D (column_names)
where is_unique = 1
and t.is_ms_shipped <> 1
order by schema_name(t.schema_id) + '.' + t.[name]

-- https://dataedo.com/kb/query/sql-server/list-unique-indexes-in-the-database

/*
table_view	    object_type	constraint_type	    constraint_name	    columns	        index_name	    index_type
dbo.Department	Table	    Unique constraint	UK_Department	    Deptid, name	UK_Department	Index
dbo.Employee	Table	    Primary key	        PK_Employee	        EmpId	        PK_Employee	    Clustered index
*/
