USE SQL_github
GO

IF NOT EXISTS (
    SELECT * 
    FROM sys.tables 
    WHERE name = 'AccountPremiumChange' AND schema_id = SCHEMA_ID('dbo')
)
BEGIN
    CREATE TABLE dbo.AccountPremiumChange (
        AccountNumber INT,
        AccountDid INT,
        ValidFromDate DATE,
        ValidToDate DATE
    );
END

BULK INSERT dbo.AccountPremiumChange
FROM 'C:\talktopeng github\SQLServer\Sample Data\Overlapping Account SCD2.csv'
WITH (
    FIRSTROW = 1,              -- No header row
    FIELDTERMINATOR = ',',     -- Delimiter
    ROWTERMINATOR = '\n',      -- New line
    -- TEXTQUALIFIER = '"',       -- Optional, for quoted values
    TABLOCK
);