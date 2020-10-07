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