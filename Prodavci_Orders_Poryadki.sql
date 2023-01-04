-------------------------------------------------------------------------
					 /* �������� ���� ������*/
-------------------------------------------------------------------------

CREATE DATABASE OrdersDB    
ON							  
(
	NAME = 'OrdersDB',            
	FILENAME = 'D:\GlowBytes_����������_�_�������\OrdersDB.mdf', 
	SIZE = 10MB,                    
	MAXSIZE = 100MB,				
	FILEGROWTH = 10MB				
)
LOG ON						  
( 
	NAME = 'LogOrdersDB',            
	FILENAME = 'D:\GlowBytes_����������_�_�������\OrdersDB.ldf', 
	SIZE = 5MB,                        
	MAXSIZE = 50MB,                    
	FILEGROWTH = 5MB                   
)   
COLLATE Cyrillic_General_CI_AS -- ������ ��������� ��� ���� ������ �� ���������

USE OrdersDB

CREATE TABLE Salespeople
(
  snum int not null,
  sname varchar(50) not null,
  city varchar(50) not null,
  comm float not null,

  PRIMARY KEY(snum)

)

CREATE TABLE Customers
(
  cnum int not null,
  cname varchar(50) not null,
  city varchar(50) not null,
  rating int not null,
  snum int not null,

  PRIMARY KEY(cnum),
  FOREIGN KEY(snum) REFERENCES Salespeople(snum)

)



CREATE TABLE Orders
(
 onum int not null,
 amt float not null,
 odate date not null,
 cnum int not null,
 snum int not null,

 PRIMARY KEY(onum),
 FOREIGN KEY(cnum) REFERENCES Customers(cnum),
 FOREIGN KEY(snum) REFERENCES Salespeople(snum)
 )

 SELECT snum, sname, city, comm
FROM Salespeople;

SELECT sname, comm
FROM Salespeople;

SELECT odate, snum, onum, amt
FROM Orders;

SELECT snum
FROM Orders;

SELECT DISTINCT snum
FROM Orders;

SELECT sname, city
FROM Salespeople
WHERE city = 'LONDON';

SELECT *
FROM Customers
WHERE rating = 100;

/*
�������� ������� SELECT ������� �� ������ ����� �������, �����, � ���� ���
���� ����� �� ������� ��������
*/

SELECT onum, amt, odate FROM Orders;

/*
�������� ������ ������� ����� �� ��� ������ �� ������� ����������, ��� ������� ����� �������� = 1001.
*/

SELECT * FROM Customers
WHERE snum = '1001';

/*
�������� ������ ������� ����� �� ������� �� ��������� � ��������� �������:
city, sname, snum, comm.
*/
SELECT city, sname, snum, comm FROM Salespeople;

/*
�������� ������� SELECT ������� ������ �� ������ (rating), ��������������
������ ������� ��������� � San Jose.
*/

SELECT * FROM Customers
where city = 'San Jose';

/*
�������� ������, ������� ����� 
�� �������� snum ���� ��������� � ������� ������� �� ������� �������� ��� ����� �� �� �� ���� ����������.
*/

SELECT DISTINCT snum FROM Orders;

/*
����� 4
*/

/*
����������� ��� �� ������ ������� ���� ���������� � ������� (rating) ����
200. ��� ��� 200 � ��� ��������� ��������, ��� � �������� � ������� ������, ��� ��
��������� �� ������ ������������ ����������� ��������.
*/

SELECT *
FROM Customers
WHERE rating > 200;


SELECT * 
 FROM Customers 
 WHERE city = 'San Jose' 
AND rating > 200;

SELECT *
FROM Customers
WHERE city = 'San Jose' OR rating > 200;

SELECT *
FROM Customers
WHERE city = 'San Jose' OR NOT rating > 200;

SELECT *
FROM Customers
WHERE NOT( city = 'San Jose' OR rating > 200 );

SELECT *
FROM Customers
WHERE NOT city = 'San Jose' OR rating > 200 ;

SELECT *
FROM Orders
WHERE NOT ((odate = '1990-10-03' AND snum >1002) OR amt > 2000.00);


/*
�������� ������ ������� ����� ���� ��� ��� ������� �� ���������� ����� ����
��� $1,000
*/

SELECT *
FROM Orders
WHERE amt > 1000;
/*
�������� ������ ������� ����� ������ ��� ���� sname � city ��� ���� ���������
� ������� � ������������� ���� .10.
*/

SELECT sname, city
FROM Salespeople
WHERE city = 'London' AND comm > 10;

/*
�������� ������ � ������� ���������� ��� ����� ����� �������� ���� ����������
� ������� =< 100, ���� ��� �� ��������� � ����
*/
SELECT *
FROM Customers
WHERE rating > 100 OR city = 'Rome';
--���
SELECT *
FROM Customers
WHERE NOT rating < = 100 OR city = 'Rome';
--���
SELECT *
FROM Customers
WHERE NOT (rating < = 100 AND city < > 'Rome');

/*
4
*/
SELECT *
FROM Orders
WHERE (amt < 1000 OR NOT (odate = '1990-10-03' AND cnum > 2003 ));

/*
5
*/

SELECT *
FROM Orders
WHERE NOT ((odate = '1990-10-03' OR snum > 1006) AND amt > = 1500 );


/*
. ��� ����� ����� ���������� ����� ������ ?
*/

SELECT *
FROM Salespeople;

/*
����� 5
*/

USE OrdersDB
/*
� ������������ � ����� ������� ����� ������ �� �������
�� ���������� �� ��������� �������, ���� �� ������ ����� ���� ���������, �������
��������� � Barcelona ��� � London, �� ������ ������������ ��������� ������
*/

SELECT *
FROM Salespeople
WHERE city = 'Barcelona' OR city = 'London';

SELECT *
FROM Salespeople
WHERE city IN ('Barcelona', 'London');

/*
������� ������ ���� ����������
����������� � ��������� ������� �������� snum = 1001, 1007, � 1004.
*/

SELECT *
FROM Customers
WHERE snum IN ( 1001, 1007, 1004 );

/*
�������� Between
*/

SELECT *
FROM Salespeople
WHERE comm BETWEEN 10 AND 12;

/*
�������� Between and IN
*/

SELECT *
FROM Salespeople
WHERE (comm BETWEEN 10 AND 12) AND NOT comm IN ('10', '12');

/*
���� ������ �������� ���� ���������� ��� ����� ������ � ������������ ���������� ��������:
*/

SELECT *
FROM Customers
WHERE cname BETWEEN 'A' AND 'G';

/*
������� ������ ���� ���������� ��� ����� ���������� � G
*/

SELECT *
FROM Customers
WHERE cname LIKE 'G%';

/*
����������� ��� �� ��������� ��� �������� �� ������ ��� ������ �� ����� ��������� Peal ��� Peel. �� ������ ������ ������������ ��
����� ������� �� ������ � ��������� ������� ����� �������� ��� ��������� ����
*/

SELECT *
FROM Salespeople
WHERE sname LIKE 'P__l%';

/*
 LIKE ���������, �� ������ ���������� ����� ���������
������ ��� ������ ESC. ������ ESC ������������ ����� ����� ��������� ��� �������������� � ���������, �
 �������� ��� ������� ��� ������������� ����� ������������������ ��� ������, � �� ��� ��������� ������.
*/

SELECT *
FROM Salespeople
WHERE sname LIKE '%/_%'ESCAPE'/';

SELECT *
FROM Salespeople
WHERE sname LIKE ' % /_ / / %'ESCAPE'/';

/*
IS NULL
*/

SELECT *
FROM Customers
WHERE city IS NULL;

/*
NOT NULL
*/

SELECT *
FROM Customers
WHERE city IS NOT NULL;

SELECT *
FROM Customers
WHERE NOT city IS NULL;

/*
�� ����� ����� ������������ NOT � IN:
*/

SELECT *
FROM Salespeople
WHERE city NOT IN ( 'London', 'San Jose' );

/*
� ��� � ������ ������ ��������� �� ���������:
*/

SELECT *
FROM Salespeople
WHERE NOT city IN ( 'London', ' San Jose' );

/*
1.�������� ��� ������� ������� ����� �� ������� ��� ������� �� 3 ��� 4 �������
1990

*/

SELECT * FROM Orders
WHERE odate IN ('1990-03-10','1990-04-10')

SELECT *
FROM Orders
WHERE odate IN (10/03/1990,10/04/1990);

/*
2. �������� ������ ������� ������� ���� ���������� ������������� ����������
Peel ��� Motika. (���������: �� ����� ������� ������, ���� snum ��������� ������ ������� � ������)

*/

Select * FROM Customers
WHERE snum IN(1001, 1004)

/*
3. �������� ������, ������� ����� ������� ���� ����������, ��� ����� ����������
� ����� ���������� � �������� �� A �� G.

*/
SELECT * FROM Customers
WHERE cname between 'A' and 'H'
/*
4. �������� ������ ������� ������� ���� ������������� ��� ����� ���������� �
����� C.

*/
SELECT * FROM Customers
WHERE cname LIKE 'C%'
/*
5. �������� ������ ������� ������� ��� ������� ������� ������� �������� ���
NULL � ���� amt (�����).
*/

SELECT * FROM Orders
WHERE NOT (amt = 0 or amt IS NULL)

/*
����� 6
*/

/*
����� ����� SUM ���� ����� ������� � ������� ��������
*/

SELECT SUM ((amt))
FROM Orders;

/*
���������� ���������� �����
� ��� ������� ��������
*/

SELECT AVG (amt)
FROM Orders;

/*
�� ����� �� ������������ ��, ��������, ����� ��������� ������ ��������� � ��������� ����� �������� � ������� �������� 
*/

SELECT * FROM
Orders

SELECT COUNT ( DISTINCT snum )
FROM Orders;

/*
����� ���������� ����� ����� ����� � �������, ����������� ������� COUNT
�� ���������� ������ ����� ����, ��� �������� � ��������� �������, ����� �� �������� ������� �� ������� 6.4:
*/

SELECT COUNT (*)
FROM Customers

/*
NULL �� �������
*/
SELECT COUNT ( ALL rating )
FROM Customers;

SELECT MAX ( blnc + (amt) )
FROM Orders;
/*
�� ������ ������� ���������� ������ ��� ������� �� ���, ������ MAX (amt) �� ������� 
�������� ��� ������� �������� ���� snum. GROUP BY, ������, �������� ��� ��������� �� ��� � ���� �������:
*/
SELECT snum, MAX (amt)
FROM Orders
GROUP BY snum;

/*
�� ������ ����� ������������ GROUP BY � �������������� ������. ������������� �������������� ������ �����, ����������� ��� �� ������ ������� ���������� ����� ������������
���������� ������ ��������� ������ ����. ����� ������� ���, �� ������ ������������� ������� �������� �� ����� ���������, � ��������� ������� MAX � ������
����� ������, ������� �����
*/

SELECT snum, odate, MAX ((amt))
FROM Orders
GROUP BY snum, odate;

/*
Having
*/
SELECT snum, odate, MAX ((amt))
FROM Orders
GROUP BY snum, odate
HAVING MAX ((amt)) > 3000.00;

/*
WHERE
*/

SELECT snum, MAX (amt)
FROM Orders
WHERE odate = '1990-03-10'
GROUP BY snum;/*IN*/SELECT snum, MAX (amt)
FROM Orders
GROUP BY snum
HAVING snum IN (1002,1007);SELECT odate, MAX ( SUM (amt) )
FROM Orders
GROUP BY odate;/*1. �������� ������, ������� �������� �� ��� ����� ������������ �� 3 �������.
*/
SELECT COUNT(*)
FROM Orders
WHERE odate = '1990-03-10';/*2. �������� ������, ������� �������� �� ����� ��������� ��-NULL �������� ����
city � ������� ����������.
*/SELECT COUNT (DISTINCT city)
FROM Customers;/*3. �������� ������, ������� ������ �� ���������� ����� ��� ������� ���������.
*/SELECT cnum, MIN(amt) FROM OrdersGROUP BY cnum;/*4. �������� ������, ������� �� ������� ���������� � ���������� �������, ���
����� ���������� � ����� G.
*/SELECT MIN(cname)FROM CustomersWHERE cname LIKE 'G%'/*5. �������� ������, ������� ������ �� ������ ������ � ������ ������.
*/SELECT city, MAX(rating)FROM CustomersGROUP BY city/*6. �������� ������, ������� �������� �� ����� ����������, �������������� ������
���� ���� �������. (���� �������� ���� ����� ������ ������� � ������ ����, ��
������ ����������� ������ ���� ���.)*/
SELECT odate, COUNT (DISTINCT snum)
FROM Orders
GROUP BY odate

/*
����� 7*/

/*
. ��������, �� ������ ��������, ����������� ������������ ������ �������� � ���������� ��������� � �� ���
���������� �����. ������ ����������:
*/

SELECT snum, sname, city, comm * 100
FROM Salespeople;

/*
�� ������ ����������������� ���������� ������ ���������� ������������
��� �������� �� ������ �������� (%).
*/

SELECT snum, sname, city, ' % ', comm * 100
FROM Salespeople;

/*
�������� �������� ��� ������ ����� ��������� ����������� ��� ����� ������.
��� �� ����� ����������� ����� �������������� ����� ����������� ����� ������ �
������������ �������������. �� ������ �������, ��� ���� �� ����� �����������
����� ��������� � ������ ������ ������, � �� ������ ���� ��� ��� ���� �������.
����������� ��� �� ����������� ����� ��� ������ ������� �� �������� ����� �������� ���������� 
� ������� ������� ���. �� ������ �������������� ��� �����
(��. ������� 7.3) ����������� ������ ��������� �������:

*/

SELECT ' For ', odate, ', there are ',
COUNT (DISTINCT onum), 'orders.'
FROM Orders
GROUP BY odate;

/*
������� ���������� ���� ������� ������� ����������
� ������� � ������� ������ ���������
*/
SELECT *
FROM Orders
ORDER BY cnum DESC;

/*
�� ����� ����� ������������� ������� � ������� ������� �������, ��������
� ������� ���� amt, ������ ������������ ���� cnum. (����� ������� � ������� 7.5):
*/

SELECT *
FROM Orders
ORDER BY cnum DESC, amt DESC;


SELECT snum, odate, MAX (amt)
FROM Orders
GROUP BY snum, odate
ORDER BY snum;

/*
�������������� �� ������ �������
*/

SELECT sname, comm
FROM Salespeople
ORDER BY 2 DESC;

/*
��������, ������� ��������� ������� �������
�� ����� ���������, � ������� ���������� � ��������� �������, ��� �������� � ������� 7.8
*/

SELECT snum, COUNT ( DISTINCT onum )
FROM Orders
GROUP BY snum
ORDER BY 2 DESC;

/*
1.����������� ��� ������ �������� ����� 12% ������������. �������� ������ �
������� �������� ������� ��� �� ������� ����� �������, ����� ��������, � ����� ������������ �������� ��� ����� �������.

*/

SELECT onum, snum, amt * .12 
FROM Orders;

/*
2. �������� ������ � ������� ���������� ������� ��� �� ����� ������ ������ � ������ ������. ����� ������ ���� � ����� �����:
For the city (city), the highest rating is: (rating).

*/
SELECT 'For the city ', city, ', the highest rating is: ', MAX(rating) 
FROM Customers
GROUP BY city;

/*
3. �������� ������ ������� ������� �� ������ ���������� � ���������� �������.
����� ���� ������ (rating) ������� �������������� ������ �������� � ��� �������.

*/
SELECT rating, cname, cnum 
FROM Customers
ORDER BY rating DESC;

/*
4. �������� ������ ������� �� ������� ����� ������� �� ������ ���� � �������
���������� � ���������� �������.
*/

SELECT odate, SUM(amt) 
FROM Orders
GROUP BY odate
ORDER BY 2 DESC;

/*
����� 8

*/

/*
����������� ��� �� ������ ��������� � ������������ ������ �������� �����
���������� � ������ � ������� ��� �����, ������� �� ������� ��� ���������� ��������� � ���������� ��� ����� ������. �� ������ ������ ����� ������� �������� �
������ � ������� ���������� ���� ���������� ���� �� ������ ������. �� ����� ��
������� ���, ����� ��������� ������� (����� ������������ � ������� 8.1):
*/

SELECT Customers.cname, Salespeople.sname, Salespeople.city
FROM Salespeople, Customers
WHERE Salespeople.city = Customers.city;

/*
����������� ������ �� ����� ���������� ���������� �����������
*/

SELECT Customers.cname, Salespeople.sname
FROM Customers, Salespeople
WHERE Salespeople.snum = Customers.snum;

/*
�� ������, ����������, ������������ ����� �� �����������
���������� � �����������. ����� ������� ������ ������� ���� ����������� (�����
*/

SELECT sname, cname
FROM Salespeople, Customers
WHERE sname < cname AND rating < 200;

/*
����������� ���� � ����� ������
*/

SELECT onum, cname, Orders.cnum, Orders.snum
FROM Salespeople, Customers,Orders
WHERE Customers.city < > Salespeople.city
AND Orders.cnum = Customers.cnum
AND Orders.snum = Salespeople.snum;

/*
1. �������� ������, ������� �� ����� ������ ������� ��������, ����������������
������ ���������, ������� �������� ��� �������.

*/

SELECT * FROM Orders;
SELECT * FROM Customers;

SELECT Orders.onum, Customers.cname
FROM Orders, Customers
WHERE Customers.cnum = Orders.cnum;


/*
2. �������� ������, ������� �� ������� ����� �������� � ��������� ��� �������
������� ����� ������ ��������.

*/


SELECT  Orders.onum, Customers.cname, Salespeople.sname
FROM Orders, Customers, Salespeople
WHERE Customers.cnum = Orders.cnum AND Salespeople.snum = Orders.snum;

/*
3. �������� ������, ������� �� ������� ���� ����������, ������������� ��������� � ������������� ���� 12%. �������� ��� ���������, ��� �������� � ������
������������ ��������.

*/


SELECT cname, sname, comm
FROM Salespeople, Customers
WHERE Salespeople.snum = Customers.snum AND comm > 12;

/*
4. �������� ������, ������� �������� �� ����� ������������ �������� ���
������� ������� ��������� � ������� ���� 100.
*/
SELECT * FROM Salespeople
SELECT * FROM Customers;
SELECT * FROM Orders;

SELECT onum, comm * amt
FROM Salespeople, Orders, Customers
WHERE rating > 100 AND
Orders.cnum = Customers.cnum AND
Orders.snum = Salespeople.snum;

/*
����� 9
*/

/*
������� ������, ������� ������� ��� ���� ���������� ������� ���� � ��� ��
����� ������� (����� ������������ � ������� 9.1):
*/

SELECT first.cname, second.cname, first.rating
FROM Customers first, Customers second
WHERE first.rating = second.rating;

/*
����� �������� ��������� �����
��������� ���������� ���������� � ���� ��, � ����� ��������� �����,
��������� � �������� �������.
*/

SELECT first.cname, second.cname, first.rating
FROM Customers first, Customers second
WHERE first.rating = second.rating
AND first.cname < second.cname;

/*
��� ��� ������ �������� ������ ���� �������� � ������ � ������ ������ ��������, ������ ��� ����� ������������ 
����� ��������� ���������� � ������� ��������, �� ������ ��������� � ����� �� ������� �������
*/

SELECT first.onum, first.cnum, first.snum,
second.onum, second.cnum, second.snum
FROM Orders first, Orders second
WHERE first.cnum = second.cnum
AND first.snum < > second.snum;

/*
.
����������� ��� �� ��� �� ��������� ����� ���������� � ������ ��������.
�������� ������ ��������� ������� �������� ������������� ���� ����������, ��
������ ��� ������� ������������ ��������. 
�� ����� ������ ������, ������ ��������� ������ �������� ���������, �� ��������� ������ �� �����������, ����� �������
��� ��������� ���������� ����������, ������� �� ������ ���������.
*/

SELECT a.cnum, b.cnum, c.cnum
FROM Customers a, Customers b, Customers c
WHERE a.rating = 100 AND b.rating = 200 AND c.rating = 300;

/*
�� ������ ����� ��������, ��� �� ������ ����������� ������������ ������
��������� ��� ������� ������� ��������� � ����������� FROM �������, � ����������� SELECT. ������, ����������� ��� ������� ���������� �������������� ������������� ������ ��� ��� ����� ���������� � ��������� �������. ��������,
��������� ������ ������� ���� ���������� ����������� � ������� ��� ��������
Serres (snum 1002) ����� ��������� (����� ������������ � ������� 9.4):
*/

SELECT b.cnum, b.cname
FROM Customers a, Customers b
WHERE a.snum = 1002
AND b.city = a.city;

/*
�� ������ ����� ������� ����������� ������� �������� � ��������� �������
� ���������� ��������� �������. 
��������� ������ ���������� ������� ������������� � �����: 
����� ����� ��� ���� ���������� ������������� ����� ���������.
� �� �� ����� �����, ���� ������ ���������� ��������� � �������� 
��������� � ������ ����� �������� (����� ������� �� ������� 9.5):
*/

SELECT sname, Salespeople.snum, first.cname, second.cname
FROM Customers first, Customers second, Salespeople
WHERE first.snum = second.snum
AND Salespeople.snum = first.snum
AND first.cnum < second.cnum;

/*
1. �������� ������, ������� �� ����� ��� ���� ���������, ������� � ����� � ���
�� ������. ��������� ���������� ��������� � ���� ��, � ����� ��������� �����,
��������� � �������� �������.

*/

SELECT first.sname, second.sname
FROM Salespeople first, Salespeople second
WHERE first.city = second.city AND first.sname < second.sname;

/*
2. �������� ������, ������� ����� �� ��� ���� �������� �� ������ ����������,
������ ���� ����������, � �������� ��������� �� ������, ��� � ���������� �������.

*/

SELECT cname, first.onum, second.onum
FROM Orders first, Orders second, Customers
WHERE first.cnum = second.cnum AND
first.cnum = Customers.cnum AND
first.onum < second.onum;

--��� ����� ����� ����� ��������� �������, �� � ����� ������ ��� ���������� ���������� ������ ���� ������ ��.
/*
3. �������� ������, ������� ����� �� ����� (cname) � ������ (city) ���� ����������
� ����� �� ������� (rating) ��� � Hoffman�. �������� ������, ������������ ����
cnum Hoffman� � �� ��� ������, ��� ����� ��� ����� ���� ������������ ���� ���
������ ����� ���������.
*/

SELECT * FROM Customers;

SELECT a.cname, a.city
FROM Customers a, Customers b
WHERE a.rating = b.rating AND b.cnum = 2001;

/*
����� 10
*/

/*
��������, ����������� ��� �� ����� ��� ��������: Motika,
 �� �� ����� �������� ��� ���� snum, � ����� ������� ��� ������� �� ������� ��������. ������� ����
������ ����� ������� ��� (����� ������������ � ������� 10.1):

*/

SELECT * 
FROM Orders
WHERE snum = (SELECT snum 
               FROM Salespeople
			   WHERE sname = 'Motika'); 
/*
������� ����������� ���������� ��������� � ������� 1004, � ����� ������������� � �������� �������� ������� � ������� ���������
*/

/*
��������� �� ����� ������ ������ �������� � Barcelona � Rifkin, �� ���������
����� �������� ��������� �������� snum � ������������� ����� ������. �� ��� �
������ � ������ ������. ����������� SQL ��� ������ ����� ������������� �������������, � ���� ������ ������������ ������� ������
 �������� �� Barcelona � �������, ��������� ������� ��� ��������, � ���� ������� �������� �������.
*/

SELECT *
FROM Orders
WHERE snum = ( SELECT snum
FROM Salespeople
WHERE city = 'Barcelona' );

/*
����������� ��� �� ����� ����� ��� ������� ������������ ��� ��� ��������� ������� ����������� Hoffman� (cnum = 2001).
������� ���� ������, ����� ������� ��� (����� ������������ � ������� 10.2):
*/

SELECT *
FROM Orders
WHERE snum = ( SELECT DISTINCT snum
FROM Orders
WHERE cnum = 2001 );

/*
�� ������ ������� ��� ������� ������� ����� ������������ ���� ������� �� 4-�
������� (����� ������� �� �������� 10.3):
*/

SELECT *
FROM Orders
WHERE amt > (SELECT AVG(amt)
              FROM Orders
			  WHERE odate = '1990-04-10')

/*
������� ������������ �������� �� �������
*/

SELECT AVG (comm)
FROM Salespeople
WHERE city = 'London';

/*
�� �����, �������������, ������������ 
IN ����� ��������� ����� �� ���������, 
������� �� ����� �������� � ����������� ����������, � ����� ��� �������� ������� �������� ��� �������� �
������� (����� ������������ � ������� 10.4):
*/

SELECT *
FROM Orders
WHERE snum IN ( SELECT snum
FROM Salespeople
WHERE city = 'LONDON' );

--2 �������
--�� �����������

SELECT onum, amt, odate, cnum, Orders.snum
FROM Orders, Salespeople
WHERE Orders.snum = Salespeople.snum
AND Salespeople.city = 'London';

/*
*/

SELECT onum, amt, odate
FROM Orders
WHERE snum = ( SELECT snum
FROM Orders
WHERE cnum = 2001 );

/*
���������� DISTINCT
*/

SELECT onum, amt, odate
FROM Orders
WHERE snum IN ( SELECT snum
FROM Orders
WHERE cnum = 2001 );

/*
�� ����� ������� ��� �������� ������������ ���� ��������� �������������
���������� � �������:
*/
SELECT comm
FROM Salespeople
WHERE snum IN ( SELECT snum
FROM Customers
WHERE city = 'London' );

/*
��� ����� ���� ��������� ��� � ������� ����������� ���������� ��� � IN. ��������, ��������� ������ ����������
����������� �������� = (����� ������������ � ������� 10.6):
*/

SELECT *
FROM Customers
WHERE cnum = ( SELECT snum + 1000
FROM Salespeople
WHERE sname = 'Serres' );

/*
��� ������� ������������ ���������� � �������� ���� �������� � San Jose.
��� ��� ������� ������ ������ �������� �� 300, ��� ������ ���� �������� � ������
������� ���������� ������� ����� ��� ������.
*/

SELECT rating, COUNT ( DISTINCT cnum )
FROM Customers
GROUP BY rating
HAVING rating > ( SELECT AVG (rating)
FROM Customers
WHERE city = 'San Jose' );

/*
1. �������� ������, ������� �� ����������� ��������� ��� ��������� ���� �������� ��� ��������� � ������ Cisneros. 
�����������, ��� �� �� ������ ������ ����� ���������, ������������ � ���� cnum.

*/
SELECT *
FROM Orders
WHERE cnum = (SELECT cnum
              FROM Customers
			  WHERE cname = 'Cisneros')

--���
SELECT *
FROM Orders
WHERE cnum IN (SELECT cnum
FROM Customers
WHERE cname = 'Cisneros');

/*
2. �������� ������, ������� ����� �� ����� � ������ ���� ����������, �������
����� ���������� �������.

*/

SELECT * FROM Customers
SELECT * FROM Orders

SELECT DISTINCT cname, rating
FROM Customers, Orders
WHERE amt > (SELECT AVG (amt)
FROM Orders)
AND Orders.cnum = Customers.cnum;

SELECT DISTINCT cname, rating
FROM Customers, Orders
WHERE amt > (SELECT AVG (amt)
FROM Orders)
AND Orders.cnum = Customers.cnum;

/*
3. �������� ������, ������� �� ������ ����� ����� ���� ������������ � ��������
��� ������� ��������, � �������� ��� ����� ����� ������, ��� ����� ����������� ������� � �������.
*/
SELECT snum, SUM(amt)
FROM Orders
GROUP BY snum
HAVING SUM(amt) > (SELECT MAX(amt)
FROM Orders);

/*
����� 11 ������������ ����������

*/

/*
������� ���� ������ ����� ���� ���������� � �������� �� 10-� ����� (����� ������������ � ������� 11.1):*/

SELECT *
FROM Customers 
WHERE '1990-03-10' IN ( SELECT odate
FROM Orders 
WHERE Customers.cnum = Orders.cnum );

/*
� �������������� �������, SQL ������������ ��������� ���������:
1. �� �������� ������ Hoffman �� ������� ����������.
2. ��������� ��� ������ ��� ������� ������-�������� ��� ����������� � "�������".
3. ����� �� ��������� ���������. ��������� ������������� ��� ������� ��������
����� ����� ������ ��� �������� cnum ���� � ����� �� ��� �������� outer.cnum,
������� � ��������� ����� ����� 2001, � ���� cnum ������ Hoffman�. ����� ��
��������� ���� odate �� ������ ������ ������� ��������, ��� ������� ��� �����, �
��������� ����� �������� ���� odate.
4. ������� ����� ���� �������� ���� odate, ��� ���� cnum = 2001, �� ��������� �������� ��������� ������� ����� ������ ������� �� �������� �� 3 ������� � ����
������. ���� ��� ��� (� ��� ���), �� �� �������� ������ Hoffman� ��� ������ �� ��
��������� �������.
5. �� ��������� ��� ���������, ��������� ������ Giovanni ��� ������-���������, �
����� ��������� �������� ���� ������ ������ ������� ���������� �� ����� ���������
*/

-- 2 �������
/*
�������, �� ����� �� ������ �� �� ����� �������� ��������� �����������, ���������� ����
*/

SELECT * 
FROM Customers first, Orders second
WHERE first.cnum = second.cnum AND second.odate = '1990-03-10' 

/*
����������� ��� �� ����� ������ ����� � ������ ���� ��������� �������
����� ����� ������ ���������. ��������� ������ �������� ��� ��� ��� (����� ������������ � ������� 11.3):
*/

SELECT snum, sname
FROM Salespeople main
WHERE 1 < ( SELECT COUNT (*)
FROM Customers
WHERE snum = main.snum );

/*
��������� ������
*/

SELECT *
FROM Orders main
WHERE NOT snum = ( SELECT snum
FROM Customers
WHERE cnum = main.cnum );

/*
�� ������ ����� ������������ ������������ ���������, ���������� �� ��� ��
����� �������, ��� � �������� ������. ��� ���� ��� ����������� �������� ������������ ������� ����� ������������� ����������. ��������, �� ����� ����� ���
������� �� ���������� ���� ������������ ���� �������� ��� �� ���������� (�����
������� � ������� 11.4):
*/

SELECT *
FROM Orders k
WHERE amt > ( SELECT AVG(amt)
FROM Orders t
WHERE k.cnum = t.cnum );

/*
�������, � ����� ��������� ������� �������, ��� ���������� ���������� ����� ������ ���� �������,
 ����������� �������� �������� ������������ �������� �
������������� �� ����������. ������� ������ ������� ������ �������� (����� ������������ � ������� 11.5):
*/

SELECT *
FROM Orders out
WHERE amt >= ( SELECT AVG (amt)
FROM Orders inn
WHERE inn.cnum = out.cnum );

/*
�����������, ��� �� ������ ����������� �������� ���� ������������ �������
�� ������� ��������, ������������ �� �� �����, ������ ��� ���� ��� �� SUM �� ���
�� ������� ���� �� 2000.00 ���� ������������ (MAX) �����:*/SELECT odate, SUM (amt)
FROM Orders a
GROUP BY odate
HAVING SUM (amt) > ( SELECT 2000.00 + MAX (amt)
FROM Orders b
WHERE a.odate = b.odate );

/*
1. �������� ������� SELECT, ������������ ������������ ���������, 
������� ������� ����� � ������ ���� ���������� � ������������� ��� �� ������� ��������.

*/
SELECT cnum, cname
FROM Customers out
WHERE rating = (SELECT MAX (rating)
FROM Customers inn
WHERE inn.city = out.city);
/*
2. �������� ��� �������, ������� ������� ���� ��������� (�� �� ����� � ������)
�������, � ����� ������� ����� ����������, ������� ��� �� �����������. 
���� ������ � � �������������� ����������� � ���� � � ������������ �����������. 
������� �� ������� ����� ����� �������? (���������: ���� �� �������� ���
�������, ������� � ���, ����� �������� ���� ����������, �� ������������� ������ ��������� 
� ����������, ��������� �� ������ �� ��� � ������ ��������.)
*/


--������� � ������� ������������� ����������:

SELECT snum, sname
FROM Salespeople main
WHERE city IN (SELECT city
FROM Customers inn
WHERE inn.snum <> main.snum);

--������� � ������� �����������:
SELECT DISTINCT first.snum, sname
FROM Salespeople first, Customers second
WHERE first.city = second.city AND first.snum <> second.snum;

/*
������������ ��������� ������� ���� ����������, �� ������������� ������
���������, � ��������: ����� �� ���-������ �� ��� � ��� ������. ������� � �������
����������� �������� ����� ������� � ����� �����������. ��� ������� ������, ���
���� city ���������, � ���� snums ���. �������������, ����������� �������� �����
������� �������� ��� ���� ��������, ��� ��, ������� �� ����������� �� �����.
������� ��� ����� ������� ������� � ������� ����������, � ������� �� ����������� �����
*/

/*
����� 12 ������������� ��������� EXISTS
*/

/*
�� �����
��������� ��� �������� � ��������� ��� ��� ������, ���� ��� ���������� 
����� ����� ��� ��� ��������, ���� ��� �� ������ �����. 
���� �� ���������� �� ������ ���������� ���������, � ������� �� �� ����� ���� �����������. ��������, �� �����
������, ��������� �� ��� ��������� ������ �� ������� ���������� ����, � ������
����, ���� ��� ����� ���������� � ���� ������� ����������� � San Jose (����� ���
����� ������� ������������ � ������� 12.1):
*/
SELECT cnum, cname, city
FROM Customers
WHERE EXISTS ( SELECT *
FROM Customers
WHERE city = 'San Jose' );

/*
������������� ���������� �� ����������� ������� ����� ���������, ���� ��������
���������������, ����� �� ����������� EXISTS ����� ��������. 
��������, �� ����� ������� ���������, ������� ����� ������������� ���������� (����� ��� �����
������� ������������ � ������� 12.2):*/SELECT DISTINCT snum
FROM Customers out
WHERE EXISTS ( SELECT *
FROM Customers inn
WHERE inn.snum = out.snum
AND inn.cnum < > out.cnum );

/*
������ ��� ��� ����� ���� �������� ������� ������ ���������� �� ���� ���������, 
� �� ������ �� ������. �� ����� ������� ���, ��������� ������� ����������
� �������� ��������� (����� ��� ������� ������������ � ������� 12.3):
*/

SELECT DISTINCT first.snum, sname, first.city
FROM Salespeople first, Customers second
WHERE EXISTS ( SELECT *
FROM Customers third
WHERE second.snum = third.snum
AND second.cnum < > third.cnum )
AND first.snum = second.snum;

/*
���������� ������ ��� ������ ��� EXISTS ����� �������� � ���������� �
����������� ����. �������, �� ��� �������� 
����� ������� �������� ��� ������������� � �������� �������� ����� ������������ � EXISTS � ��� �������� NOT. ����
�� �������� ������� �� ����� �� ����� ���� ��������� ������ � ����� ����������
����� �������� � ���, ����� ������������� ��� ���������� ������. (����� ��� ����� ������� ������������ � ������� 12.4.)

*/

SELECT DISTINCT snum
FROM Customers out
WHERE NOT EXISTS ( SELECT *
FROM Customers inn
WHERE inn.snum = out.snum
AND inn.cnum <> out.cnum );

/*
������� ������, ������� ��������� ������ ���� ��������� ������� ����� ���������� � ������ ��� ����� ������� ��������. 
��� �� ����������� ����� �������
������� ���� ��������, �� ��� ������������� ������ �������� ��������� ������
SQL. ����� ���� ���������� ��������� ��� ��� ���� ������� �������:
*/

SELECT *
FROM Salespeople first
WHERE EXISTS (SELECT *
FROM Customers second
WHERE first.snum = second.snum
AND 1 < (SELECT COUNT (*)
FROM Orders
WHERE Orders.cnum = second.cnum));

/*
1. �������� ������ ������� �� ����������� �������� EXISTS ��� ���������� ����
��������� ������� ����� ���������� � ������� 300.

*/

SELECT *
FROM Salespeople first
WHERE EXISTS (SELECT *
FROM Customers second
WHERE first.snum = second.snum AND rating = 300);

/*
2. ��� �� �� ������ ���������� �������� ��������� ����������� ?

*/

SELECT a.snum, sname, a.city, comm
FROM Salespeople a, Customers b
WHERE a.snum = b.snum AND b.rating = 300;

/*
3. �������� ������ ������������ �������� EXISTS ������� ������� ���� ��������� 
� ����������� ������������ � �� ������� ������� ��� �� �������������.

*/

SELECT *
FROM Salespeople a
WHERE EXISTS (SELECT *
FROM Customers b
WHERE b.city = a.city AND a.snum <> b.snum);

/*
4. �������� ������ ������� �������� �� �� ������� ���������� ������� ���������
������������ � �������� ������� � ������ ������ ����� �� ������� ���� ���
������ ��������� (����� ��������� �������� �� ��������) � ��������� � �������
�������� (���������: ��� ����� ���� ������ �� ��������� � ������� � ����� ������������� �����������).
*/


SELECT *
FROM Customers a
WHERE EXISTS (SELECT *
FROM Orders b
WHERE a.snum = b.snum AND a.cnum <> b.cnum)