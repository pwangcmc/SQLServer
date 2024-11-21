SELECT STUFF((
    SELECT ', ' + QUOTENAME(CalendarMonthYearLabel)
    FROM ( 
        SELECT DISTINCT CalendarMonthYearLabel, BeginningofMonth
        FROM [BI_INFO].[Dimension].[Date]
        WHERE FiscalYearUK = (SELECT FiscalYearUK 
                              FROM [BI_INFO].[Dimension].[Date] d
                              WHERE Date = CAST(GETDATE() AS DATE)
                             )
    ) AS DistinctValues
    ORDER BY BeginningofMonth
    FOR XML PATH(''), TYPE
).value('.', 'NVARCHAR(MAX)'), 1, 2, '');
