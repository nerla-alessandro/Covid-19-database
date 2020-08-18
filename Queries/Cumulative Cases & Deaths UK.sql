SELECT   dateFormatted AS Date,
         SUM(deaths) OVER (ORDER BY dateFormatted) AS "Cumulative UK Deaths",
	 SUM(cases) OVER (ORDER BY dateFormatted) AS "Cumulative UK Cases"
FROM     CaseData
WHERE    geoId = "UK"
ORDER BY Date;
