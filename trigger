CREATE OR REPLACE TRIGGER TRIGGER1
AFTER UPDATE OR DELETE ON Library
FOR EACH ROW
BEGIN
  IF UPDATING THEN
    INSERT INTO Library_Audit (BookID, Title, Action_Type)
    VALUES (:OLD.BookID, :OLD.Title, 'UPDATE');
  ELSIF DELETING THEN
    INSERT INTO Library_Audit (BookID, Title, Action_Type)
    VALUES (:OLD.BookID, :OLD.Title, 'DELETE');
  END IF;
END;
/

CREATE TABLE Library (
    BookID NUMBER PRIMARY KEY,
    Title VARCHAR2(50),
    Author VARCHAR2(50)
);

CREATE TABLE Library_Audit (
    BookID NUMBER,
    Title VARCHAR2(50),
    Author VARCHAR2(50),
    Action_Type VARCHAR2(10),
    Action_Date DATE DEFAULT SYSDATE
);

INSERT INTO Library VALUES (1, 'DBMS Concepts', 'Ramakrishnan');
INSERT INTO Library VALUES (2, 'C Programming', 'Dennis Ritchie');
INSERT INTO Library VALUES (3, 'Java Fundamentals', 'Herbert Schildt');

COMMIT;
