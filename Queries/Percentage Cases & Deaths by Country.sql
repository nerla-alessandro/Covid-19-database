SELECT  countriesAndTerritories AS Country, 
        ROUND(CAST(SUM(cases) AS FLOAT)/popData2018*100.0, 2) AS "% Cases of Population", 
        ROUND(CAST(SUM(deaths) AS FLOAT)/popData2018*100.0, 2) AS "% Deaths of Population"
FROM    CaseData INNER JOIN GeoData ON CaseData.geoId = GeoData.geoId
        INNER JOIN CountryID ON GeoData.geoId = CountryID.geoId
GROUP BY Country;
