CREATE TABLE Dates (
    dateFormatted	DATE PRIMARY KEY
				NOT NULL
				UNIQUE,
    dateRep 		DATE 	NOT NULL
                 		UNIQUE,
    day     		INT  NOT NULL,
    month   		INT  NOT NULL,
    year    		INT  NOT NULL
)
WITHOUT ROWID;
CREATE TABLE GeoData (
    geoId        TEXT   PRIMARY KEY
                        NOT NULL
			UNIQUE,
    popData2018  BIGINT,
    continentExp TEXT	NOT NULL
)
WITHOUT ROWID;
CREATE TABLE CaseData (
    dateFormatted 	DATE REFERENCES Dates (dateFormatted) 
                 		NOT NULL,
    geoId   		TEXT REFERENCES GeoData (geoId) ON DELETE RESTRICT
                                            		ON UPDATE CASCADE
                 		NOT NULL,
    cases   		INT  	NOT NULL,
    deaths  		INT  	NOT NULL,
    PRIMARY KEY (
        dateFormatted,
        geoId
    )
)
WITHOUT ROWID;
CREATE TABLE CountryID (
    geoId                   TEXT PRIMARY KEY
                                 REFERENCES GeoData (geoId) ON DELETE RESTRICT
                                                            ON UPDATE CASCADE
                                 NOT NULL
                                 UNIQUE,
    countriesAndTerritories TEXT NOT NULL
                                 UNIQUE,
    countryterritoryCode    TEXT 
)
WITHOUT ROWID;
