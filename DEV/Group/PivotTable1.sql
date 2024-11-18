SELECT * FROM [Sales].[SalesTerritory] 

SELECT 
    [CountryRegionCode],
   SUM([SalesYTD]) SalesYTD
FROM [Sales].[SalesTerritory]
GROUP BY [CountryRegionCode]

/*
CountryRegionCode	SalesYTD
AU					5977814.9154
CA					6771829.1376
DE					3805202.3478
FR					4772398.3078
GB					5012905.3656
US					26411059.8792
*/

SELECT 
	  SUM(CASE [CountryRegionCode] WHEN 'AU' THEN SalesYTD END) [AU]
	, SUM(CASE [CountryRegionCode] WHEN 'CA' THEN SalesYTD END) [CA]
	, SUM(CASE [CountryRegionCode] WHEN 'DE' THEN SalesYTD END) [DE]
	, SUM(CASE [CountryRegionCode] WHEN 'FR' THEN SalesYTD END) [FR]
	, SUM(CASE [CountryRegionCode] WHEN 'GB' THEN SalesYTD END) [GB]
	, SUM(CASE [CountryRegionCode] WHEN 'US' THEN SalesYTD END) [US]
FROM [Sales].[SalesTerritory]
/*
AU				CA				DE				FR				GB				US
5977814.9154	6771829.1376	3805202.3478	4772398.3078	5012905.3656	26411059.8792
*/

SELECT 
	[GROUP]
	, SUM(CASE [CountryRegionCode] WHEN 'AU' THEN SalesYTD END) [AU]
	, SUM(CASE [CountryRegionCode] WHEN 'CA' THEN SalesYTD END) [CA]
	, SUM(CASE [CountryRegionCode] WHEN 'DE' THEN SalesYTD END) [DE]
	, SUM(CASE [CountryRegionCode] WHEN 'FR' THEN SalesYTD END) [FR]
	, SUM(CASE [CountryRegionCode] WHEN 'GB' THEN SalesYTD END) [GB]
	, SUM(CASE [CountryRegionCode] WHEN 'US' THEN SalesYTD END) [US]
FROM [Sales].[SalesTerritory]
GROUP BY [GROUP]

/*
GROUP			AU			CA			DE			FR			GB			US
Europe			NULL		NULL		3805202.34	4772398.30	5012905.36	NULL
North America	NULL		6771829.13	NULL		NULL		NULL		26411059.87
Pacific			5977814.91	NULL		NULL		NULL		NULL		NULL
*/
