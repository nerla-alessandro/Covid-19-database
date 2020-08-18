SELECT 	 countriesAndTerritories AS Country,
	 ROUND(CAST(SUM(deaths) AS FLOAT)/CAST(SUM(cases) AS FLOAT)*100.0, 2) AS "% Deaths"
FROM 	 CaseData INNER JOIN GeoData ON CaseData.geoId = GeoData.geoId
	 INNER JOIN CountryID ON GeoData.geoId = CountryID.geoId 
GROUP BY Country
ORDER BY "% Deaths" DESC 
LIMIT 10;
