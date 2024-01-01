-- Виведення жанру книги за її назвою
DROP PROCEDURE IF EXISTS get_genre_of_book;

CREATE OR REPLACE PROCEDURE get_genre_of_book(book_name_arg VARCHAR) 
LANGUAGE plpgsql
AS $$
DECLARE
    genre_name VARCHAR;
BEGIN
    SELECT genre.genre_name INTO genre_name
    FROM book
    	JOIN book_genre ON book.book_id = book_genre.book_id
    		JOIN genre ON book_genre.genre_id = genre.genre_id
    WHERE book.book_name = book_name_arg;

    RAISE NOTICE 'Book Genre: %', genre_name;
END;
$$; 

CALL get_genre_of_book('The Girl on the Train');
