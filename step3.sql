DROP TABLE moving_average_table;

-- WBAN|startdate|enddate|Moving_Average
CREATE table moving_average_table AS 
SELECT WBAN,
LAG (adate,13) OVER (ORDER BY adate) AS startdate,
adate as enddate,
avg(dailyTemp) over(partition by adate order by adate, adate rows between 13 preceding and current row) as Moving_Average
FROM dailyTemperatures;

SELECT * FROM moving_average_table;
