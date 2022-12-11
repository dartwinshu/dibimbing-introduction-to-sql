-- Hands-On
-- Aggregation

SELECT * FROM transactions;

SELECT sum(price) FROM transactions;
SELECT avg(price) FROM transactions;

SELECT count(*) FROM users;
SELECT count(id) FROM users;
SELECT count(1) FROM users; -- 1 = hanya simbol saja
SELECT count(2) FROM users; -- 2 = hanya simbol saja

SELECT * FROM transactions;
SELECT count(*) AS transaction_number, sum(price) AS total_transaction FROM transactions;
SELECT min(price) FROM transactions;
SELECT max(price) FROM transactions;
SELECT avg(price) FROM transactions;

SELECT sum(price)/count(*), round(avg(price), 0) FROM transactions;

SELECT sum(price)::float/count(*), avg(price) FROM transactions; -- Postgre SQL
SELECT cast(sum(price) AS float)/count(*), avg(price) FROM transactions; -- SQL

-- Conditional Statement

SELECT user_id, price,
CASE
	WHEN (price > 10000000 AND price < 12000000) THEN '10% Discount'
	WHEN price > 12000000 THEN '15% Discount'
	ELSE 'No Discount'
END AS Discount
FROM transactions;

SELECT COALESCE(NULL, NULL, 2, NULL, 4);

SELECT NULLIF(2,3);

SELECT * FROM users;

SELECT id, title, name, gender FROM users;

SELECT id, title, name, gender,
	CASE 
		WHEN gender = 'Male' THEN 'Laki-laki'
		WHEN gender = 'Female' THEN 'Perempuan'
		ELSE 'Tidak Terdefinisi'
	END
	AS gender_id
FROM users;

SELECT gender FROM users
GROUP BY gender; -- Menentukan apa saja gender-nya, milih satu-satu

SELECT DISTINCT gender FROM users; -- Menentukan apa saja gender-nya, munculkan semua, baru memilih

SELECT id, title, name, blood_type FROM users;

SELECT id, title, name, COALESCE(blood_type, 'Unidentified') FROM users; -- Sama dengan IF NULL THEN -- PostgreSQL -- MySQL (IFNUL)

SELECT * FROM user_contact;

SELECT id, user_id, phone_number, email_address, company_email_address,
	COALESCE(company_email_address, email_address, 'Unidentified') AS primary_email_address
FROM user_contact;
	
SELECT * FROM transactions;

SELECT *, nullif(price, base_price + tax) FROM transactions;

SELECT *,
	CASE
		WHEN NULLIF(price, base_price + tax) = 0 THEN 0
		WHEN NULLIF(price, base_price + tax) != 0 THEN 
			CASE
				WHEN price - (base_price + tax) > 0 THEN 0.1 * (price - (base_price + tax))
				ELSE price - (base_price + tax)
			END
	END
	AS optimum_discount
FROM transactions;

-- Union and Join

SELECT * FROM user_contact;

SELECT id FROM user_contact
UNION
SELECT id FROM transactions
ORDER BY id;

SELECT id FROM user_contact
UNION All
SELECT id FROM transactions
ORDER BY id;

SELECT *, title || ' ' || name AS fullname FROM users
left JOIN transactions
ON users.id = transactions.id;

SELECT 1 AS number
UNION all
SELECT 2 AS number
UNION all
SELECT 3 AS number;

SELECT 1 AS number, 'A' AS provider
UNION all
SELECT 2 AS number, 'B' AS provider
UNION all
SELECT 3 AS number, 'C' AS provider;

SELECT * FROM user_address;
SELECT * FROM car_brand;

SELECT country FROM user_address
UNION all
SELECT country FROM car_brand
ORDER BY country desc; -- Descending

SELECT country FROM user_address
UNION
SELECT country FROM car_brand
ORDER BY country desc; -- Descending

SELECT DISTINCT * FROM (
	SELECT country FROM user_address
	UNION all
	SELECT country FROM car_brand
	ORDER BY country asc
) A;

SELECT * FROM users;
SELECT * FROM user_address;

SELECT 
	u.id, u.name, ua.country
	FROM users u
	INNER JOIN
	user_address ua
ON u.id = ua.user_id;

SELECT 
	u.id, u.name, ua.country, uc.phone_number
	FROM users u
	INNER JOIN
	user_address ua
ON u.id = ua.user_id
	INNER JOIN
	user_contact uc
ON u.id = uc.user_id;

-- Window Function
SELECT id, user_id, item_name, price,
	avg (price) OVER (PARTITION BY item_name ORDER BY id) AS "Avg Item Price"
FROM transactions

SELECT * FROM user_job;

SELECT * FROM user_job ORDER BY title;

SELECT title, salary
FROM user_job;

SELECT DISTINCT title FROM user_job;

SELECT round(avg(salary),0) FROM user_job
WHERE title = 'Data Analyst';

SELECT u.id, u.name, uj.title, uj.salary,
	round(avg(salary) OVER (PARTITION BY uj.title), 0)
	AS avg_salary
FROM user_job uj
INNER JOIN
	users u
ON u.id = uj.user_id
ORDER BY title asc;

-- Assignment
-- Soal No. 1

SELECT * FROM user_job;

SELECT count(*) AS total_employee, 
	min(salary) AS min_salary, 
	max(salary) AS max_salary, 
	avg(salary) AS avg_salary, 
	sum(salary) AS total_salary
FROM user_job;

SELECT count(*) AS total_employee, 
	min(salary) AS min_salary, 
	max(salary) AS max_salary, 
	round(avg(salary), 0) AS avg_salary, 
	sum(salary) AS total_salary
FROM user_job;

-- Soal No. 2

SELECT id, user_id, title,
CASE
	WHEN salary <= 8000000 THEN 1
	WHEN salary > 8000000 AND salary <= 11000000 THEN 2
	WHEN salary > 11000000 AND salary <= 15000000 THEN 3
	WHEN salary > 15000000 AND salary <= 19000000 THEN 4
	WHEN salary > 19000000 THEN 5
END
AS LEVEL,
CASE
	WHEN salary <= 8000000 THEN 'Entry'
	WHEN salary > 8000000 AND salary <= 11000000 THEN 'Junior'
	WHEN salary > 11000000 AND salary <= 15000000 THEN 'Medior'
	WHEN salary > 15000000 AND salary <= 19000000 THEN 'Senior'
	WHEN salary > 19000000 THEN 'Expert'
	ELSE 'Unknown'
END
AS experience
FROM user_job
ORDER BY LEVEL DESC, title asc;

-- Soal No. 3

SELECT * FROM users;
SELECT * FROM cars;
SELECT * FROM car_brand;

SELECT 
	u.id, u.title ||' '|| u.name AS name, cb.brand ||' '|| c.name ||', '|| c.YEAR AS car
FROM users u
	LEFT JOIN
	cars c
ON u.car_id = c.id
	LEFT JOIN
	car_brand cb 
ON c.car_brand_id = cb.id
ORDER BY cb.brand ASC, c.name ASC, c.YEAR DESC;

-- Soal No. 4

SELECT * FROM user_job;

SELECT
	u.id, u.title ||' '|| u.name AS name, uj.title, uj.salary,
	round(avg(uj.salary) OVER (PARTITION BY uj.title), 0) AS avg_salary,
	min(uj.salary) OVER (PARTITION BY uj.title) AS min_salary,
	max(uj.salary) OVER (PARTITION BY uj.title) AS max_salary
FROM users u
	LEFT JOIN
	user_job uj
ON u.id = uj.user_id
ORDER BY uj.title ASC, uj.salary DESC;


