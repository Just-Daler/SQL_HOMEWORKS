--1

 --2
 CREATE TABLE TestMultipleZero ( A INT NULL, B INT NULL, C INT NULL, D INT NULL );
 INSERT INTO TestMultipleZero(A,B,C,D) VALUES (0,0,0,1), (0,0,1,0), (0,1,0,0), (1,0,0,0), (0,0,0,0), (1,1,1,0);
 select * from TestMultipleZero
 WHERE A=1 OR B=1 OR C=1 OR D=1
 --3
 create table section1(id int, name varchar(20)) insert into section1 values (1, 'Been'), (2, 'Roma'), (3, 'Steven'), (4, 'Paulo'), (5, 'Genryh'), (6, 'Bruno'), (7, 'Fred'), (8, 'Andro')
  
 SELECT * FROM section1
 WHERE id %2=1
 --4
 SELECT MIN(ID) AS SMALLESTID
 FROM section1

 SELECT  TOP 1 *
 FROM section1
 ORDER BY id ASC
 --5
 SELECT MAX(ID) AS HIGHEST_ID
 FROM section1

 SELECT TOP 1 id, NAME FROM section1
 ORDER BY ID DESC
 --6
 SELECT * FROM section1
 WHERE name LIKE 'B%'
 --7
CREATE TABLE ProductCodes ( Code VARCHAR(20) );

INSERT INTO ProductCodes (Code) VALUES ('X-123'), ('X_456'), ('X#789'), ('X-001'), ('X%202'), ('X_ABC'), ('X#DEF'), ('X-999');

SELECT * FROM ProductCodes
WHERE CODE LIKE  '%\_%' ESCAPE '\'
