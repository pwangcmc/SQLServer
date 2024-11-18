SELECT * FROM [Sales].[SalesTerritory] 

SELECT 
    [CountryRegionCode],
   SUM([SalesYTD]) SalesYTD
FROM [Sales].[SalesTerritory]
GROUP BY [CountryRegionCode]

SELECT 
	  SUM(CASE [CountryRegionCode] WHEN 'AU' THEN SalesYTD END) [AU]
	, SUM(CASE [CountryRegionCode] WHEN 'CA' THEN SalesYTD END) [CA]
	, SUM(CASE [CountryRegionCode] WHEN 'DE' THEN SalesYTD END) [DE]
	, SUM(CASE [CountryRegionCode] WHEN 'FR' THEN SalesYTD END) [FR]
	, SUM(CASE [CountryRegionCode] WHEN 'GB' THEN SalesYTD END) [GB]
	, SUM(CASE [CountryRegionCode] WHEN 'US' THEN SalesYTD END) [US]
FROM [Sales].[SalesTerritory]
