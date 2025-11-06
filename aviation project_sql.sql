SELECT * FROM 7oct.flights;
# AVERAGE ARRIVAL DELAY BY AIRLINE
SELECT 
    AIRLINE,
    ROUND(AVG(ARRIVAL_DELAY), 2) AS Avg_Arrival_Delay
FROM flights
WHERE ARRIVAL_DELAY IS NOT NULL
GROUP BY AIRLINE
ORDER BY Avg_Arrival_Delay DESC;


# PERCENTAGE OF FLIGHTS CANCELLED PER AIRLINE
SELECT 
    AIRLINE,
    ROUND(SUM(CANCELLED) / COUNT(*) * 100, 2) AS Cancelled_Percentage
FROM flights
GROUP BY AIRLINE
ORDER BY Cancelled_Percentage DESC;


#ON-TIME PERFORMANCE(FLIGHTS ARRIVING WITHIN 15 MINUTES OF SCHEDULE)
SELECT 
    AIRLINE,
    ROUND(SUM(CASE WHEN ARRIVAL_DELAY <= 15 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS OnTime_Percentage
FROM flights
GROUP BY AIRLINE
ORDER BY OnTime_Percentage DESC;


--  count of airline cancelled > 1000 group by daywise and airline ----
select airline,count(cancelled) as Count_of_Cancelled,
CASE day_of_week
    WHEN 1 THEN 'Monday'
    WHEN 2 THEN 'Tuesday'
    WHEN 3 THEN 'Wednesday'
    WHEN 4 THEN 'Thursday'
    WHEN 5 THEN 'Friday'
    WHEN 6 THEN 'Saturday'
    WHEN 7 THEN 'Sunday'
    ELSE 'Invalid Week Number'
    END AS Day_name
FROM flights
group by airline ,day_name
having count_of_cancelled > 1000
order by count_of_cancelled ;


-- top 5 airlines with maximum average delay.
SELECT 
	AIRLINE,
        avg (ARRIVAL_DELAY + DEPARTURE_DELAY) as avg_total_delay
FROM flights
WHERE ARRIVAL_DELAY is not null
	or DEPARTURE_DELAY is not null
GROUP BY AIRLINE
ORDER BY avg_total_delay DESC
limit 5;


#Top 10 airports with highest average departure delay
SELECT
         ORIGIN_AIRPORT,
         ROUND(AVG(DEPARTURE_DELAY), 2) AS Avg_Departure_Delay,
         COUNT(*) AS Total_Flights
FROM flights
WHERE DEPARTURE_DELAY IS NOT NULL
GROUP BY ORIGIN_AIRPORT
HAVING Total_Flights > 1000
ORDER BY Avg_Departure_Delay DESC
LIMIT 10;


#Top 5 flights covering longest distance*
select
    flight_number, 
    distance
FROM
    flights
ORDER BY
    distance DESC
LIMIT 5;


#Top 10 States with Most Airports
SELECT * FROM airports;
SELECT STATE, COUNT(*) AS total_airports
FROM airports
GROUP BY STATE
ORDER BY total_airports DESC
LIMIT 10;

