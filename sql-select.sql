USE shakila;

-- 1. How many distinct (different) actors' last names are there?
SELECT COUNT(DISTINCT(last_name)) AS actors_diff_last_names
FROM actor; 
    -- Sol: 121
    
-- 2. In how many different languages where the films originally produced? 
	-- (Use the column language_id from the film table)
SELECT COUNT(DISTINCT(language_id))
FROM film; 
-- Sol : 1

-- 3. How many movies were released with "PG-13" rating
SELECT COUNT(rating) AS movies_13
FROM film
WHERE rating = "PG-13"; 
-- Sol 223

-- 4. Get 10 the longest movies from 2006.
SELECT title  AS top_10_len
FROM film
ORDER BY length DESC
LIMIT 10;

-- 5.How many days has been the company operating
SELECT DATEDIFF(max(rental_date), min(rental_date)) AS company_days
FROM rental;
    
-- 6. Show rental info with additional columns month and weekday.
SELECT rental_date, 
	MONTH(rental_date) AS month_, 
    WEEKDAY(rental_date) AS week_day
FROM rental    
LIMIT 20;

-- 7. Add an additional column day_type with values 'weekend' and 'workday' 
	-- depending on the rental day of the week.
SELECT rental_date, 
	MONTH(rental_date) AS month_, 
    WEEKDAY(rental_date) AS week_day,
    CASE WEEKDAY(rental_date)
		WHEN 1 THEN "workday"
        WHEN 2 THEN "workday"
        WHEN 3 THEN "workday"
        WHEN 4 THEN "workday"
        WHEN 5 THEN "workday"
        WHEN 6 THEN "weekday"
        WHEN 7 THEN "weekday"
	END AS day_type
FROM rental    
LIMIT 20;


-- 8. How many rentals were in the last month of activity?
SELECT 
	MONTH(rental_date),
	COUNT(rental_date)
FROM rental
GROUP BY MONTH(rental_date)
ORDER BY MONTH(rental_date) -- No tengo claro que ordene por fecha, sino por num 
LIMIT 1;

-- 9. Get film ratings.
SELECT rating 
FROM film;

-- 10. Get release years.
SELECT release_year
FROM film;

-- 11. Get all films with ARMAGEDDON in the title. ?¿?¿?
SELECT title 
FROM film
WHERE title = "ARMAGEDDON";
-- Sol: 0

-- 12. Get all films with APOLLO in the title
SELECT title 
FROM film
WHERE title = "APOLLO";

-- 13. Get all films which title ends with APOLLO.
SELECT title 
FROM film
WHERE title LIKE "%APOLLO";

-- 14. Get all films with word DATE in the title.
SELECT title 
FROM film
WHERE title LIKE "%DATE%";

-- 15. Get 10 films with the longest title.
SELECT title, 
	LENGTH(title) AS length
FROM film
ORDER BY length DESC
LIMIT 10;


-- 16. Get 10 the longest films.
SELECT title, length
FROM film
ORDER BY length DESC
LIMIT 10;

-- 17. How many films include Behind the Scenes content?
SELECT COUNT(special_features)
FROM film
WHERE special_features = "Behind the Scenes";
-- Sol: 70


-- 18. List films ordered by release year and title in alphabetical order.
SELECT release_year, title
FROM film
ORDER BY release_year DESC, title;

-- 19. Drop column picture from staff.
ALTER TABLE staff
DROP COLUMN picture;

-- 20. A new person is hired to help Jon.Her name is TAMMY SANDERS, 
	-- and she is a customer. Update the database accordingly.

INSERT INTO staff VALUES (3,
(SELECT first_name FROM customer WHERE first_name = "TAMMY" AND last_name = "SANDERS"),
(SELECT last_name FROM customer WHERE first_name = "TAMMY" AND last_name = "SANDERS"),
(SELECT address_id FROM customer WHERE first_name = "TAMMY" AND last_name = "SANDERS"),
(SELECT email FROM customer WHERE first_name = "TAMMY" AND last_name = "SANDERS"),
(SELECT store_id FROM customer WHERE first_name = "TAMMY" AND last_name = "SANDERS"),
(SELECT active FROM customer WHERE first_name = "TAMMY" AND last_name = "SANDERS"),
(SELECT first_name FROM customer WHERE first_name = "TAMMY" AND last_name = "SANDERS"),
NULL,
(NOW()));

-- Error Code: 1136. Column count doesn't match value count at row 1
	-- macheaban las columnas con los valore, tambien porque el indice se suponia que era autogenerado
    -- pero luego no o eso parece 
    
-- 21. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1.
	-- You can use current date for the rental_date column in the rental table. 
	-- Hint: Check the columns in the table rental and see what information you would need to add there. 
    -- You can query those pieces of information. For eg., you would notice that you need customer_id information as well. 
    -- To get that you can use the following query:
    
INSERT INTO rental VALUES (16050,
(NOW()),
(SELECT inventory_id FROM inventory WHERE film_id = 1 ORDER BY last_update DESC LIMIT 1),
(SELECT customer_id FROM customer WHERE first_name = 'CHARLOTTE' AND last_name = 'HUNTER'),
(NOW()),
1,
(NOW()));

-- 22. Delete non-active users, but first, create a backup table deleted_users to 
	-- store customer_id, email, and the date for the users that would be deleted. 
    -- Follow these steps:

-- Check if there are any non-active users
-- Create a table backup table as suggested
-- Insert the non active users in the table backup table
-- Delete the non active users from the table customer

SELECT DISTINCT(active) FROM customer;
SELECT * FROM customer WHERE active = 0;

CREATE TABLE IF NOT EXISTS deleted_users (
	customer_id SMALLINT, 
    email VARCHAR(40),
    date DATE);
    
SELECT rental_date FROM rental;

INSERT INTO deleted_users
SELECT customer_id, email, NOW()  FROM customer WHERE active = 0;

SET SQL_SAFE_UPDATES=0;
DELETE FROM customer WHERE active = 0;

