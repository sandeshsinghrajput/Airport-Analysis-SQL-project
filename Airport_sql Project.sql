create database Project;
-- Air travel is a key component of global connectivity and economic development.
-- The project seeks to analyze airport data to uncover trends in 
-- passenger volume, flight frequency, and seat availability,
--  and to understand how factors such as city population impact airport operations.

use project;
SELECT 
    *
FROM
    Airport;
SELECT 
    origin_city_name,
    dest_city_name,
    SUM(passengers) AS total_passenger
FROM
    Airport
GROUP BY 1 , 2
ORDER BY total_passenger DESC
LIMIT 5;
-- this give the insights of top5 busiest airport in terms of passenger population

SELECT 
    origin_city_name,
    dest_city_name,
    AVG(passengers) AS avg_passenger
FROM
    Airport
GROUP BY 1 , 2
ORDER BY avg_passenger DESC
LIMIT 10;
 -- this gives the top10 busiest route in terms of avg_passenger travelling from that route
 
 select origin_city_name,dest_city_name, count(airline_id) as total_flights
 from Airport
 group by 1,2
 order by total_flights desc
 limit 10;
-- this gives the top10 hihest trafic routes

with seating_capacity as(
select airline_id,max(passengers) as seat_capacity
from Airport
group by 1
having max(passengers)>0
),

seat_utilization as (
select a.airline_id, a.passengers * 100/sc.seat_capacity as seat_utilization
from Airport as a join seating_capacity as sc 
on a.airline_id = sc.airline_id )

select airline_id , round(avg(seat_utilization),2) as avg_utilization
from seat_utilization
group by 1
order by avg_utilization desc;
-- This gives the averge seat utilization of different Airlines
-- so airline 21656 is using their full seat capacity.

select dest_city_name,dest_airport_id, sum(passengers) as total_passengers
from airport 
where passengers > 0
group by 1,2
order by total_passengers desc
limit 10;
-- This gives us top10 highest most popular distination city according to total passenger.