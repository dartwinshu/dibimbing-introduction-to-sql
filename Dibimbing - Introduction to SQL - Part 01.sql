-- Hands-On 
-- Basics
SELECT 'dartwin';
SELECT 'welcome to the dibimbing';
SELECT 25;
SELECT 25.12;

SELECT 'Olan' as name , 'male' as gender, '22' as age, true as smoking;

-- Time and Date
SELECT now();
SELECT current_date;
SELECT current_time;

SELECT '10-09-2001'::DATE;
SELECT '10:09:10'::TIME;
SELECT '10-09-2001 10:09:10'::TIMESTAMP;
SELECT '10-09-2001 10:09:10.123'::TIMESTAMP;

-- Data Type Conversion
SELECT TO_TIMESTAMP('2001-10-09 10:09:10', 'YYYY-MM-DD HH24:MI:SS');

SELECT TO_CHAR('10-09-2001 10:09:10.123'::TIMESTAMP, 'YYYY-MM-DD');
SELECT TO_CHAR('10-09-2001 10:09:10.123'::TIMESTAMP, 'HH24:MI:SS');

-- Concatenation
SELECT 'olan' || ',' || 'male'

SELECT * FROM users;
SELECT id, title, name, gender FROM users;
SELECT id, title ||' '|| name AS name, gender FROM users;

SELECT * FROM user_address;
SELECT * FROM user_contact;
SELECT * FROM transactions;

-- Assignmnet
-- Soal No. 1

SELECT 'hello' || 'world';

SELECT *
FROM user_address;

SELECT user_id, 
	street_name ||' No. '|| building_number ||', '|| city ||', '|| state ||', '|| post_code ||', '|| country ||' ('|| latitude ||', '|| longitude ||')' AS address
FROM user_address;

SELECT user_id, 
	concat (street_name, ' No. ', building_number, ', ', city, ', ', state, ', ', post_code, ', ', country, ' (', latitude, ', ', longitude, ')') AS address
FROM user_address;

-- Soal No. 2
SELECT * 
FROM transactions;

SELECT *
FROM transactions
WHERE (price >= 10000000) AND (price < 20000000) AND (discount >= 100000) AND (discount <= 110000);

-- Soal No. 3
SELECT user_id,
	(base_price / 10000)*1.2 AS price_sgd,
	(base_price / 10000)*0.025 AS discount_sgd,
	(base_price / 10000)*1.2*0.1 AS tax_sgd,
	(base_price / 10000)*(1.2 - 0.025 + (1.2*0.1)) AS total_sgd
FROM transactions;
	
-- Soal No. 4
SELECT *
FROM users;

SELECT *
FROM users
WHERE (blood_type IS null) AND ((games LIKE '%old%') OR (games ILIKE '%And%') OR (games ILIKE '%man%'));
