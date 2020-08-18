SELECT  continentExp as Continent, 
        dateFormatted as Date,
        SUM(cases) AS "New Cases", 
        SUM(deaths) AS "New Deaths" 
FROM    CaseData 
        INNER JOIN GeoData 
        ON CaseData.geoId = GeoData.geoId 
GROUP BY Continent, Date
ORDER BY Date ASC;