DROP TABLE hourlydata;
DROP TABLE dailyTemperatures;
DROP TABLE moving_average_table;

CREATE EXTERNAL TABLE hourlydata
(
    WBAN int,
	yearmonthday string,
	Time varchar(255),
	StationType varchar(255),
	SkyCondition varchar(255),
	SkyConditionFlag varchar(255),
	Visibility varchar(255),
	VisibilityFlag varchar(255),
	WeatherType varchar(255),
	WeatherTypeFlag varchar(255),
	DryBulbFarenheit int,
	DryBulbFarenheitFlag varchar(255),
	DryBulbCelsius int,
	DryBulbCelsiusFlag varchar(255),
	WetBulbFarenheit varchar(255),
	WetBulbFarenheitFlag varchar(255),
	WetBulbCelsius varchar(255),
	WetBulbCelsiusFlag varchar(255),
	DewPointFarenheit varchar(255),
	DewPointFarenheitFlag varchar(255),
	DewPointCelsius varchar(255),
	DewPointCelsiusFlag varchar(255),
	RelativeHumidity varchar(255),
	RelativeHumidityFlag varchar(255),
	WindSpeed varchar(255),
	WindSpeedFlag varchar(255),
	WindDirection varchar(255),
	WindDirectionFlag varchar(255),
	ValueForWindCharacter varchar(255),
	ValueForWindCharacterFlag varchar(255),
	StationPressure varchar(255),
	StationPressureFlag varchar(255),
	PressureTendency varchar(255),
	PressureTendencyFlag varchar(255),
	PressureChange varchar(255),
	PressureChangeFlag varchar(255),
	SeaLevelPressure varchar(255),
	SeaLevelPressureFlag varchar(255),
	RecordType varchar(255),
	RecordTypeFlag varchar(255),
	HourlyPrecip varchar(255),
	HourlyPrecipFlag varchar(255),
	Altimeter varchar(255),
	AltimeterFlag varchar(255)
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS TEXTFILE location '/weatherdata/'
tblproperties("skip.header.line.count"="1");

-- WBAN|adate|dailyTemp
-- gets daily average temperatures by getting the hourly data and getting mean
Create table dailyTemperatures AS 
SELECT 
	wban,from_unixtime(unix_timestamp(yearmonthday, 'yyyyMMdd'), 'yyyy-MM-dd') as adate,
	avg(drybulbcelsius) as dailyTemp 
from hourlydata WHERE WBAN=3011 group by WBAN,yearmonthday;
--SELECT * FROM dailyTemperatures;

-- WBAN|startdate|enddate|Moving_Average
CREATE table moving_average_table AS 
SELECT WBAN,
LAG (adate,13) OVER (ORDER BY adate) AS startdate,
adate as enddate,
avg(dailyTemp) over(partition by adate order by adate, adate rows between 13 preceding and current row) as Moving_Average
FROM dailyTemperatures;

--SELECT * FROM moving_average_table;

-- WBAN|startdate|enddate|Highest_Temperature
--SELECT WBAN,startdate,enddate,MAX(Moving_Average) as Highest_Temperature from moving_average_table;
--select top 1 * from moving_average_table order by Moving_Average desc
select * from moving_average_table order by Moving_Average desc limit 1
