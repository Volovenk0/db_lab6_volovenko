-- Перевірка функції
SELECT * FROM books;
SELECT clean_low_rated_books();
SELECT * FROM books;

-- Перевірка процедури
CALL get_genre_of_book('1984');

-- Перевірка тригера
INSERT INTO book (book_id, book_name, price, rating) VALUES (555, 'Oksana in KPI', 500, 5);
UPDATE book SET price = 50 WHERE book_name = 'A Man Called Ove';
DELETE FROM book WHERE rating = 4.8;