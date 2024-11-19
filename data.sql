DROP TABLE IF EXISTS authors CASCADE;
DROP TABLE IF EXISTS publishers CASCADE;
DROP TABLE IF EXISTS books CASCADE;
DROP TABLE IF EXISTS book_reviews CASCADE;


CREATE TABLE IF NOT EXISTS authors(
	id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	author_name VARCHAR(50),
	birth_date DATE,
	country VARCHAR(50)
);


CREATE TABLE IF NOT EXISTS publishers(
	id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name VARCHAR(50),
	city VARCHAR(50),
	founded_year DATE
);


CREATE TABLE IF NOT EXISTS books(
	id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	book_name VARCHAR(50) NOT NULL,
	author_id INTEGER NOT NULL REFERENCES authors(id) ON DELETE CASCADE,
	publisher_id INTEGER REFERENCES publishers(id) ON DELETE SET NULL,
	genre VARCHAR(50),
	published_date DATE DEFAULT CURRENT_DATE,
	price NUMERIC(7, 2) CHECK(price > 0)
);


CREATE TABLE IF NOT EXISTS book_reviews(
	id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	book_id INTEGER REFERENCES books(id) ON DELETE SET NULL,
	review_text VARCHAR(1000),
	grade INTEGER CHECK(grade >= 1 OR grade <= 10),
	review_date DATE DEFAULT CURRENT_DATE
);


INSERT INTO authors(author_name, birth_date, country) VALUES
('Toxir', '1985-07-24', 'Uzbekistan'),
('Sobir', '2000-03-20', 'Tajikistan'),
('Jalil', '1999-08-30', 'Turkmenistan'),
('Ali', '2001-05-14', 'Kazakhstan'),
('John', '1975-11-17', 'USA');


INSERT INTO publishers(name, city, founded_year) VALUES
('Birinchi nashriyot', 'Ferghana', '1970-01-12'),
('Ikkinchi nashriyot', 'Tashkent', '1971-02-13'),
('Uchinchi nashriyot', 'Andijan', '1972-03-14'),
('Tortinchi nashriyot', 'Namangan', '1973-04-15'),
('Beshinchi nashriyot', 'Khiva', '1974-05-16');


INSERT INTO books(book_name, author_id, publisher_id, genre, published_date, price) VALUES
('Otkan Kunlar', 1, 5, 'Tarixiy roman', '2019-02-24', 65000),
('Yulduzli Tunlar', 2, 4, 'Tarixiy roman', '2020-03-23', 75000),
('Songgi Tofon', 3, 2, 'Roman', '2021-04-22', 85000),
('Borilar izidan', 4, 1, 'Detektiv roman', '2022-01-21', 95000),
('Dunyoning ishlari', 5, 3, 'Qissa', '2023-05-20', 55000),
('Sariq devni minib', 5, 1, 'Sarguzasht roman', '2005-06-19', 45000),
('Ogay ona', 4, 2, 'Roman', '2017-08-18', 35000),
('Mehrobdan chayon', 3, 5, 'Tarixiy roman', '2016-09-17', 25000),
('Saodat Asri', 2, 3, 'Tarixiy roman', '2024-10-16', 95000),
('Liderlikning 21 muqarrar qonuni', 1, 4, 'Roman', '2012-11-15', 29000);


INSERT INTO book_reviews(book_id, review_text, grade) VALUES
(1, 'Zor kitob narxiga arziydi!', 8),
(5, NULL, 9),
(3, 'Olishni tavsiya qilaman!', 6),
(9, 'Eng zor kitob!', 10),
(6, NULL, 7);

-- 3 - topshiriq SELECT

SELECT * FROM authors;
SELECT * FROM publishers;
SELECT * FROM books;
SELECT * FROM book_reviews;

-- 3 - topshiriq  Column Aliases

SELECT author_name AS ism, birth_date AS author_birthday FROM authors;

SELECT name AS publisher_name, city AS from_city, founded_year AS since FROM publishers;

SELECT book_name AS book_title, price AS book_price FROM books;

SELECT review_text AS text, review_date AS date FROM book_reviews;

-- 3 - topshiriq ORDER BY

SELECT * FROM authors ORDER BY author_name;

SELECT * FROM publishers ORDER BY city;

SELECT * FROM books ORDER BY price;

SELECT * FROM book_reviews ORDER BY grade DESC;

-- 3 - topshiriq WHERE

SELECT * FROM authors WHERE country = 'Uzbekistan';

SELECT * FROM books WHERE genre = 'Roman';

SELECT * FROM book_reviews WHERE grade >= 9; 

-- 3 - topshiriq LIMIT VA FETCH

SELECT * FROM books LIMIT 7;

SELECT * FROM authors FETCH first 2 rows only;

-- 3 - topshiriq IN


SELECT * FROM books WHERE genre IN ('Detektiv roman', 'Tarixiy roman');

SELECT * FROM book_reviews WHERE grade IN (10, 9, 8);

-- 3 - topshiriq BETWEEN

SELECT * FROM books WHERE price BETWEEN 50000 and 100000;

SELECT * FROM book_reviews WHERE grade BETWEEN 9 and 10;

-- 3 - topshiriq LIKE

SELECT * FROM books WHERE book_name LIKE '%on%';

SELECT * FROM authors WHERE country LIKE '%tan%'

-- 3 - topshiriq IS NULL

SELECT * FROM book_reviews WHERE review_text IS NULL;

-- 3 - topshiriq GROUP BY

SELECT genre, COUNT(*) FROM books GROUP BY genre;

SELECT price, COUNT(*) FROM books GROUP BY price;

-- 4 - topshiriq

SELECT
	authors.author_name,
	books.book_name,
	books.price AS book_price,
	publishers.name AS publisher_name,
	publishers.city AS publisher_city,
	authors.country AS author_from
FROM books
JOIN authors ON authors.id = books.id
JOIN publishers ON publishers.id = books.id
JOIN book_reviews ON book_reviews.id = books.id;

-- ---------------------------------------------------

SELECT SUM(price) FROM books; -- kitoblarning jami narxi

SELECT COUNT(*) FROM publishers; -- nashriyotlar soni

SELECT AVG(grade) FROM book_reviews; -- o'rtacha baho

SELECT MIN(price) FROM books; -- eng arzon kitob

SELECT MAX(price) FROM books; -- eng qimmat kitob
