-- Тригер,  який  відслідковує  модифікацію  таблиці book та створює окрему таблицю book_audit, 
-- в якій відображається, яка саме була здійснена операція (INSERT,  UPDATE  чи DELETE), 
-- яким користувачем, та записує час, коли відбулася дана операція.
DROP TRIGGER IF EXISTS book_update_details ON book;

DROP TABLE IF EXISTS book_audit;

CREATE TABLE book_audit (
  id SERIAL PRIMARY KEY,
  updated TIMESTAMP,
  user_name VARCHAR(50) NOT NULL,
  operation_type VARCHAR(10) NOT NULL
);

CREATE OR REPLACE FUNCTION table_book_audit() RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    INSERT INTO book_audit(updated, user_name, operation_type)
    VALUES(NOW(), current_user, 'INSERT');
  ELSIF TG_OP = 'UPDATE' THEN
    INSERT INTO book_audit(updated, user_name, operation_type)
    VALUES(NOW(), current_user, 'UPDATE');
  ELSIF TG_OP = 'DELETE' THEN
    INSERT INTO book_audit(updated, user_name, operation_type)
    VALUES(NOW(), current_user, 'DELETE');
  END IF;
  RETURN NULL;
END;
$$;

CREATE TRIGGER book_update_details
AFTER INSERT OR UPDATE OR DELETE ON book
FOR EACH ROW EXECUTE FUNCTION table_book_audit();

SELECT * FROM book;

UPDATE book SET price = 20 WHERE book_name = 'The Girl on the Train';

SELECT * FROM book_audit;
