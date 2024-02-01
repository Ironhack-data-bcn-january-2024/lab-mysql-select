-- 1.

USE sakila;

SELECT * FROM sakila.actor;

SELECT COUNT(DISTINCT(last_name)) AS unique_last_name
FROM actor;
-- 2.
SELECT * FROM sakila.film;

SELECT COUNT(DISTINCT(original_language_id)) AS unique_languages
FROM film;
SELECT COUNT(DISTINCT(language_id)) AS unique_languages
FROM film;

-- 3.

SELECT * FROM sakila.film;

SELECT COUNT(film_id) AS PG_13
FROM film
WHERE rating = "PG-13";

-- 4.

SELECT * FROM sakila.film;

SELECT title, length, release_year
FROM film
WHERE release_year = "2006"
ORDER BY length DESC
LIMIT 10;

-- 5. 

SELECT DATEDIFF('2006-02-15', '2005-05-24') 
AS days_difference;

-- 6.

SELECT *, MONTH(rental_date) AS month, DAYNAME(rental_date) AS weekday
FROM rental
LIMIT 20;

-- 7.

SELECT *,
CASE
WHEN DAYOFWEEK(rental_date) IN (1, 6) THEN 'weekend'
ELSE 'workday'
END AS day_type
FROM rental;

-- 8.

SELECT COUNT(rental_id)
FROM rental
WHERE rental_date
BETWEEN 2006-02-14 AND  2006-01-14;

-- 9. 

SELECT DISTINCT(rating)
FROM film;

-- 10.

SELECT DISTINCT(release_year)
FROM film;

-- 11.

SELECT title
FROM film
WHERE title LIKE ("%ARMAGEDDON%");

-- 12. 

SELECT title
FROM film
WHERE title LIKE ("%APOLLO%");

-- 13. 

SELECT title
FROM film
WHERE title LIKE ("%APOLLO");

-- 14. 

SELECT title
FROM film
WHERE title LIKE ("%DATE%");

-- 15.

SELECT title
FROM film
ORDER BY length(title) DESC
LIMIT 10;

-- 16. 

SELECT title
FROM film
ORDER BY length
LIMIT 10;

-- 17. 

SELECT COUNT(title) AS films_behind_scenes
FROM film
WHERE special_features LIKE ("%Behind the Scenes%");

-- 18.

SELECT title, release_year
FROM film
ORDER BY title ASC;

-- 19.

ALTER TABLE staff
DROP COLUMN picture;

-- 20.

SELECT *
FROM customer
WHERE first_name = "TAMMY" AND last_name = "SANDERS";

INSERT INTO staff VALUES 
(3, "Tammy", "Sanders", 79, "TAMMY.SANDERS@sakilacustomer.org", 2, 1, "Tam", "password", "2006-02-15 03:57:16");

-- 21.

SELECT *
FROM rental
WHERE rental_id = 1;

SELECT customer_id
FROM customer
WHERE first_name = "Charlotte" AND last_name = "Hunter";

SELECT film_id
FROM film
WHERE title = "Academy Dinosaur";

INSERT INTO rental VALUES
(16050, "2024-01-31 16:01:30", 1, 130, null, 1, "2024-01-31 16:01:30");

-- 22.

SELECT *
FROM customer
WHERE active = 0;


SET SQL_SAFE_UPDATES=0;

CREATE TABLE delete_users AS 
SELECT customer_id, email, last_update FROM customer WHERE active = 0; 

SELECT * FROM customer;
DELETE FROM customer WHERE active = 0;

-- Tratando de borrar los usuarios no activos me devuelve un error, pero debería funcionar
