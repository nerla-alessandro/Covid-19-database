INSERT INTO Dates (dateFormatted, dateRep, day, month, year)
SELECT DISTINCT DATE(substr(dateRep,7)||'-'||substr(dateRep,4,2)||'-'||substr(dateRep,1,2)), daterep, day, month, year
FROM dataset;

INSERT INTO GeoData (geoId, popData2018, continentExp)
SELECT DISTINCT geoId, popData2018, continentExp
FROM dataset;

INSERT INTO CountryID (geoId, countriesAndTerritories, countryterritoryCode)
SELECT DISTINCT geoId, countriesAndTerritories, countryterritoryCode
FROM dataset;

INSERT INTO CaseData (dateFormatted, geoId, cases, deaths)
SELECT DATE(substr(dateRep,7)||'-'||substr(dateRep,4,2)||'-'||substr(dateRep,1,2)), geoId, cases, deaths
FROM dataset;
