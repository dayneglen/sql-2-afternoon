-- Joining Practice
-- 1
SELECT * FROM invoice i
JOIN invoice_line il ON il.invoice_id = i.invoice_id
WHERE il.unit_price > 0.99;
-- 2
SELECT i.invoice_date, i.total, c.first_name, c.last_name FROM invoice i
JOIN customer c ON i.customer_id = c.customer_id;
-- 3
SELECT c.first_name, c.last_name, sr.first_name, sr.last_name FROM customer c
JOIN employee sr ON c.support_rep_id = sr.employee_id;
-- 4
SELECT al.title, ar.name FROM album al
JOIN artist ar on al.artist_id = ar.artist_id;
-- 5
SELECT pt.track_id FROM playlist_track pt
JOIN playlist pl ON pt.playlist_id = pl.playlist_id
WHERE pl.name = 'Music';
-- 6
SELECT t.name FROM playlist_track pt
JOIN track t ON pt.track_id = t.track_id
WHERE playlist_id = 5;
-- 7
SELECT t.name, pl.name FROM playlist_track pt
JOIN playlist pl ON pl.playlist_id = pt.playlist_id
JOIN track t on t.track_id = pt.track_id;
-- 8
SELECT a.title, t.name FROM track t
JOIN genre g ON t.genre_id = g.genre_id
JOIN album a ON t.album_id = a.album_id
WHERE g.name = 'Alternative & Punk';
-- Black Diamond
SELECT t.name, g.name, al.title, ar.name FROM playlist_track pt
JOIN track t ON pt.track_id = t.track_id
JOIN genre g ON t.genre_id = g.genre_id
JOIN album al ON t.album_id = al.album_id
JOIN artist ar ON al.artist_id = ar.artist_id
WHERE pt.playlist_id = 1;

-- Nested Queries
-- 1
SELECT * FROM invoice
WHERE invoice_id IN (
	SELECT invoice_id FROM invoice_line
	WHERE unit_price > 0.99
);
-- 2
SELECT * FROM playlist_track
WHERE playlist_id IN (
	SELECT playlist_id FROM playlist
	WHERE name = 'Music'
);
-- 3
SELECT name from track
WHERE track_id IN (
	SELECT track_id FROM playlist_track
	WHERE playlist_id = 5
);
-- 4
SELECT * from track
WHERE genre_id IN (
	SELECT genre_id FROM genre
	WHERE name = 'Comedy'
);
-- 5
SELECT * FROM track
WHERE album_id IN (
	SELECT album_id FROM album
	WHERE title = 'Fireball'
);
-- 6
SELECT * FROM track
WHERE album_id IN (
	SELECT album_id FROM album
	WHERE artist_id IN (
		SELECT artist_id FROM artist
		WHERE name = 'Queen'
));

-- Practice updating Rows
-- 1
UPDATE customer
SET fax = null
WHERE fax IS NOT null;
-- 2
UPDATE customer
SET company = 'Self'
WHERE company IS null;
-- 3
UPDATE customer
SET last_name = 'Thompson'
WHERE first_name = 'Julia' and last_name = 'Barnett';
-- 4
UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';
-- 5
UPDATE track
SET composer = 'The darkness around us'
WHERE composer IS NULL 
AND genre_id = (
	SELECT genre_id FROM genre
	WHERE name = 'Metal';
);

-- Group by
-- 1
SELECT COUNT(*), g.name FROM track t
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name;
-- 2
SELECT COUNT(*), g.name FROM track t
JOIN genre g ON t.genre_id = g.genre_id
WHERE g.name = 'Pop' OR g.name = 'Rock'
GROUP BY g.name;
-- 3
SELECT COUNT(*), ar.name FROM album al
JOIN artist ar ON ar.artist_id = al.artist_id
GROUP BY ar.name;

-- Use Distinct Rows

-- 1
SELECT DISTINCT composer
FROM track;
-- 2
SELECT DISTINCT billing_postal_code
FROM invoice;
-- 3
SELECT DISTINCT company
FROM customer;

-- Delete Rows

-- 1
DELETE FROM practice_delete WHERE type = 'bronze';
-- 2
DELETE FROM practice_delete WHERE type = 'silver';
-- 3
DELETE FROM practice_delete WHERE value = 150;

-- eCommerce Simulation
-- I didn't totally understand the instructions for this part. I created some tables and practiced working with them. I'm thinking of building a basic eCommerce site for my personal project. I was using this as practice as well to see how the database would be set up. Would love your opinion on how to set up a basic database for an eCommerce site sometime. Wasn't sure how to group tables, but this is what I came up with.

CREATE TABLE users (
	user_id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  email VARCHAR(100)
);

CREATE TABLE product (
	product_id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  price DECIMAL
);

CREATE TABLE orders (
	order_id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(user_id)
);

CREATE TABLE order_item (
	order_item_id SERIAL PRIMARY KEY,
  order_id INTEGER REFERENCES orders(order_id),
  product_id INTEGER REFERENCES product(product_id),
  quantity INTEGER
);

INSERT INTO users (name, email)
VALUES ('Justin', 'justin@justin.com'),
	('Dayne', 'dayne@dayne.com'),
    ('Samantha', 'sam@sam.com');

INSERT INTO product (name, price)
VALUES ('Broom', 15.50), ('Garbage Can', 10), ('Cup', 4.99);

INSERT INTO order_item (product_id, quantity, order_id)
VALUES (1, 2, 1), (2, 1, 1), (3, 1, 2);

SELECT u.name, o.order_id, p.name, oi.quantity FROM order_item oi
JOIN orders o ON oi.order_id = o.order_id
JOIN users u ON o.user_id = u.user_id
JOIN product p ON p.product_id = oi.product_id;

SELECT o.order_id, u.name, p.name, oi.quantity FROM order_item oi
JOIN orders o ON oi.order_id = o.order_id
JOIN users u ON o.user_id = u.user_id
JOIN product p ON p.product_id = oi.product_id
WHERE o.order_id = 1;



