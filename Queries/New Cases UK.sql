SELECT 	dateFormatted AS Date, 
	cases AS "New Cases in UK"
FROM CaseData 
WHERE geoId = "UK" 
ORDER BY Date ASC;