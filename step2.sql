DROP TABLE dailyTemperatures;

-- WBAN|adate|dailyTemp
-- gets daily average temperatures by getting the hourly data and getting mean
Create table dailyTemperatures AS 
SELECT 
	wban,from_unixtime(unix_timestamp(yearmonthday, 'yyyyMMdd'), 'yyyy-MM-dd') as adate,
	avg(drybulbcelsius) as dailyTemp 
from hourlydata WHERE WBAN=3011 group by WBAN,yearmonthday;
SELECT * FROM dailyTemperatures;
