SELECT *
FROM data_dictionary;

SELECT *
FROM stolen_vehicles;

SELECT *
FROM locations;

SELECT *
FROM make_details;

-- PROJECT 2
-- Select Statement
-- 1. Retrieve all columns from the `stolen_vehicles` table.
SELECT *
FROM stolen_vehicles;

-- 2. Select only the `vehicle_type`, `make_id`, and `color` columns from the `stolen_vehicles` table.
SELECT vehicle_type, make_id, color
FROM stolen_vehicles;

-- From Statement
-- 3. Write a query to display all records from the `make_details` table
SELECT *
FROM make_details;

-- 4. Retrieve all columns from the `locations` table.
SELECT *
FROM locations;

-- Where Statement
-- 5. Find all stolen vehicles that are of type "Trailer".
SELECT vehicle_id, vehicle_type, vehicle_desc
FROM stolen_vehicles
WHERE vehicle_type = "Trailer";

-- 6. Retrieve all stolen vehicles that were stolen after January 1, 2022.
SELECT vehicle_id, vehicle_type, date_stolen
FROM stolen_vehicles
WHERE date_stolen like "%2022%"; 

-- 7. Find all stolen vehicles that are of color "Silver".
SELECT vehicle_id, vehicle_type, color
FROM stolen_vehicles
WHERE color = "Silver";

--  Group By and Order By
-- 8. Count the number of stolen vehicles for each `vehicle_type` and order the results by the count in descending order.
SELECT vehicle_type, COUNT(vehicle_id)
FROM stolen_vehicles
GROUP BY vehicle_type
ORDER BY COUNT(vehicle_id) DESC;

-- 9. Find the total number of stolen vehicles for each `make_id` and order the results by `make_id`.
SELECT vehicle_type, SUM(make_id) AS make_id
FROM stolen_vehicles
GROUP BY vehicle_type
ORDER BY make_id;

-- Using Having vs. Where Statement
-- 10. Find the `make_id` values that have more than 10 stolen vehicles.
SELECT make_id, COUNT(vehicle_type) AS vehicle_stolen_type
FROM stolen_vehicles
GROUP BY make_id
HAVING vehicle_stolen_type > 10;
 
-- 11. Retrieve the `vehicle_type` values that have at least 5 stolen vehicles.
SELECT COUNT(vehicle_id), vehicle_type
FROM stolen_vehicles
GROUP BY vehicle_type
HAVING  COUNT(vehicle_id) >= 5;

-- Limit and Aliasing
-- 12. Retrieve the first 10 records from the `stolen_vehicles` table and alias the `vehicle_type` column as "Type".
SELECT vehicle_id, vehicle_type AS 'Type', make_id, model_year, vehicle_desc, color, date_stolen, location_id
FROM stolen_vehicles
LIMIT 10; 

-- 13. Find the top 5 most common colors of stolen vehicles and alias the count column as "Total".
SELECT vehicle_type, color, COUNT(vehicle_id) as Total
FROM stolen_vehicles
GROUP BY vehicle_type, color
LIMIT 5; 

-- Joins in MySQL
-- 14. Join the `stolen_vehicles` table with the `make_details` table to display 
-- `vehicle_type`, `make_name`, and `color` of each stolen vehicle.
SELECT SV.vehicle_type, SV.color, MD.make_name
FROM stolen_vehicles AS SV
INNER JOIN make_details AS MD
ON 
SV.make_id = MD.make_id;

-- 15. Join the `stolen_vehicles` table with the `locations` table to display 
-- the `vehicle_type`, `region`, and `country` where the vehicle was stolen.
SELECT vehicle_type, region, country
FROM stolen_vehicles AS SV
LEFT JOIN locations AS L
ON 
SV.location_id = L.location_id;

-- Unions in MySQL
-- 17. Write a query to combine the `make_name` from the `make_details` table and the 
-- `region` from the `locations` table into a single column.
SELECT make_name
FROM make_details
UNION
SELECT region
FROM locations;

 -- PROJECT 2
-- 18. Combine the `vehicle_type` from the `stolen_vehicles` table and the `make_type` 
-- from the `make_details` table into a single column
SELECT vehicle_type
FROM stolen_vehicles
UNION
SELECT make_type
FROM make_details;

-- Case Statements
-- 19. Create a new column called "Vehicle_Category" that categorizes vehicles as "Luxury" if 
-- the `make_type` is "Luxury" and "Standard" otherwise.
SELECT *
FROM make_details;

ALTER TABLE make_details
ADD column Vehicle_Category TEXT; 

UPDATE make_details
SET Vehicle_Category =
CASE WHEN make_type = "luxury" THEN  "luxury"
WHEN make_type = "standard" THEN "standard"
ELSE "otherwise"
END; 

-- 20. Use a CASE statement to categorize stolen vehicles as "Old" if the `model_year` is before 2010, "Mid" if
--  between 2010 and 2019, and "New" if 2020 or later.
SELECT vehicle_id, vehicle_type,
CASE  
WHEN model_year < "2010" THEN "OLD"
WHEN model_year BETWEEN  "2010" AND "2019" THEN "MID"
WHEN model_year >= 2020 THEN "NEW"
ELSE "unknown"
END AS stolen_vehicle_category
FROM stolen_vehicles;

-- Aggregate Functions
-- 21. Calculate the total number of stolen vehicles.
SELECT SUM(vehicle_id) AS total_number_of_stolen_vehicles
FROM stolen_vehicles;

-- 22. Find the average population of regions where vehicles were stolen.
SELECT AVG(population)
FROM locations;

-- 23. Determine the maximum and minimum `model_year` of stolen vehicles.
SELECT MAX(model_year), MIN(model_year) 
FROM stolen_vehicles;

-- String Functions

-- 24. Retrieve the `make_name` from the `make_details` table and convert it to uppercase
SELECT UPPER(make_name) AS make_name_upper
FROM make_details;

-- 25. Find the length of the `vehicle_desc` for each stolen vehicle.
SELECT vehicle_id, LENGTH(vehicle_desc) AS vehicle_desc_length
FROM stolen_vehicles;

-- 25. Concatenate the `vehicle_type` and `color` columns from the `stolen_vehicles` table 
-- into a single column called "Description".
SELECT vehicle_id, CONCAT(vehicle_type, ' ', color) AS Description
FROM stolen_vehicles;

-- Update Records
-- 26. Update the `color` of all stolen vehicles with `vehicle_type` "Trailer" to "Black".
UPDATE stolen_vehicles
SET color = "Black"
WHERE vehicle_type = "Trailer";

SELECT *
FROM stolen_vehicles;

-- 27. Change the `make_name` of `make_id` 623 to "New Make Name" in the `make_details` table
UPDATE make_details
SET make_name = "New_make_name"
WHERE make_id = "623";
SELECT *
FROM make_details;

-- Bonus Questions
-- 28. Write a query to find the top 3 regions with the highest number of stolen vehicles.
SELECT SUM(vehicle_id), vehicle_type, region
FROM stolen_vehicles AS SV
LEFT JOIN locations AS L
ON 
SV.location_id = L.location_id
GROUP BY vehicle_type, region
HAVING SUM(vehicle_id)
LIMIT 3;

-- 29. Retrieve the `make_name` and the total number of stolen vehicles for each make, but only for 
-- makes that have more than 5 stolen vehicles.
SELECT SUM(vehicle_id) AS total_number_of_vehicle, vehicle_type, make_name
FROM stolen_vehicles AS SV
INNER JOIN make_details AS MD
ON 
MD.make_id = SV.make_id
GROUP BY vehicle_type, make_name
HAVING total_number_of_vehicle > 5;

-- 30. Use a JOIN to find the `region` and `country` where the most vehicles were stolen.
SELECT COUNT(vehicle_id), vehicle_type, region, country
FROM stolen_vehicles AS SV
INNER JOIN locations AS L
ON 
SV.location_id = L.location_id
GROUP BY vehicle_type, region, country
ORDER BY COUNT(vehicle_id)DESC
LIMIT 1;

-- 31. Write a query to find the percentage of stolen vehicles that are of type "Boat Trailer". 

SELECT (COUNT(CASE WHEN vehicle_type = 'Boat Trailer' THEN 1 END) / COUNT(vehicle_type) * 100) AS BOat_trailer_percentage
FROM stolen_vehicles;
       

-- 32. Use a CASE statement to create a new column called "Density_Category" that categorizes regions as "High Density" 
-- if `density` is greater than 500, "Medium Density" if between 200 and 500, and "Low Density" if less than 200.
SELECT location_id, region, country, density,
CASE
WHEN density > 500 THEN "High Density"
WHEN density  BETWEEN 200 AND 500 THEN "Medium density"
WHEN density < 200 THEN "Low Density"
ELSE "otherwise"
END AS Density_Category
FROM Locations;
