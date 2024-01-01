-- Видалення всіх книг, що мають рейтинг нижче за 4.4
DROP FUNCTION IF EXISTS clean_low_rated_books();

CREATE OR REPLACE FUNCTION clean_low_rated_books() RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM book
    WHERE rating < 4.4;
END;
$$;

ALTER TABLE book_author
DROP CONSTRAINT book_author_book_id_fkey,
ADD CONSTRAINT book_author_book_id_fkey
FOREIGN KEY (book_id)
REFERENCES book(book_id)
ON DELETE CASCADE;

ALTER TABLE book_genre
DROP CONSTRAINT book_genre_book_id_fkey,
ADD CONSTRAINT book_genre_book_id_fkey
FOREIGN KEY (book_id)
REFERENCES book(book_id)
ON DELETE CASCADE;

-- Виклик функції 
SELECT clean_low_rated_books();

-- Перевірка, що з book видалились книги з рейтингом нижче 4.4
SELECT * FROM book;
