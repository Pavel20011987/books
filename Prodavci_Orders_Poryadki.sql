-------------------------------------------------------------------------
					 /* Создание Базы Данных*/
-------------------------------------------------------------------------

CREATE DATABASE OrdersDB    
ON							  
(
	NAME = 'OrdersDB',            
	FILENAME = 'D:\GlowBytes_подготовка_к_собесам\OrdersDB.mdf', 
	SIZE = 10MB,                    
	MAXSIZE = 100MB,				
	FILEGROWTH = 10MB				
)
LOG ON						  
( 
	NAME = 'LogOrdersDB',            
	FILENAME = 'D:\GlowBytes_подготовка_к_собесам\OrdersDB.ldf', 
	SIZE = 5MB,                        
	MAXSIZE = 50MB,                    
	FILEGROWTH = 5MB                   
)   
COLLATE Cyrillic_General_CI_AS -- Задаем кодировку для базы данных по умолчанию

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
Напишите команду SELECT которая бы вывела номер порядка, сумму, и дату для
всех строк из таблицы Порядков
*/

SELECT onum, amt, odate FROM Orders;

/*
Напишите запрос который вывел бы все строки из таблицы Заказчиков, для которых номер продавца = 1001.
*/

SELECT * FROM Customers
WHERE snum = '1001';

/*
Напишите запрос который вывел бы таблицу со столбцами в следующем порядке:
city, sname, snum, comm.
*/
SELECT city, sname, snum, comm FROM Salespeople;

/*
Напишите команду SELECT которая вывела бы оценку (rating), сопровождаемую
именем каждого заказчика в San Jose.
*/

SELECT * FROM Customers
where city = 'San Jose';

/*
Напишите запрос, который вывел 
бы значения snum всех продавцов в текущем порядке из таблицы Порядков без каких бы то ни было повторений.
*/

SELECT DISTINCT snum FROM Orders;

/*
ГЛАВА 4
*/

/*
Предположим что вы хотите увидеть всех заказчиков с оценкой (rating) выше
200. Так как 200 — это скалярное значение, как и значение в столбце оценки, для их
сравнения вы можете использовать реляционный оператор.
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
Напишите запрос который может дать вам все порядки со значениями суммы выше
чем $1,000
*/

SELECT *
FROM Orders
WHERE amt > 1000;
/*
Напишите запрос который может выдать вам поля sname и city для всех продавцов
в Лондоне с комиссионными выше .10.
*/

SELECT sname, city
FROM Salespeople
WHERE city = 'London' AND comm > 10;

/*
Напишите запрос к таблице Заказчиков чей вывод может включить всех заказчиков
с оценкой =< 100, если они не находятся в Риме
*/
SELECT *
FROM Customers
WHERE rating > 100 OR city = 'Rome';
--или
SELECT *
FROM Customers
WHERE NOT rating < = 100 OR city = 'Rome';
--или
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
. Как можно проще переписать такой запрос ?
*/

SELECT *
FROM Salespeople;

/*
ГЛАВА 5
*/

USE OrdersDB
/*
В соответствии с нашей учебной базой данных на которой
вы обучаетесь по настоящее временя, если вы хотите найти всех продавцов, которые
размещены в Barcelona или в London, вы должны использовать следующий запрос
*/

SELECT *
FROM Salespeople
WHERE city = 'Barcelona' OR city = 'London';

SELECT *
FROM Salespeople
WHERE city IN ('Barcelona', 'London');

/*
Давайте найдем всех заказчиков
относящихся к продавцам имеющих значения snum = 1001, 1007, и 1004.
*/

SELECT *
FROM Customers
WHERE snum IN ( 1001, 1007, 1004 );

/*
Оператор Between
*/

SELECT *
FROM Salespeople
WHERE comm BETWEEN 10 AND 12;

/*
Оператор Between and IN
*/

SELECT *
FROM Salespeople
WHERE (comm BETWEEN 10 AND 12) AND NOT comm IN ('10', '12');

/*
Этот запрос выбирает всех заказчиков чьи имена попали в определенный алфавитный диапазон:
*/

SELECT *
FROM Customers
WHERE cname BETWEEN 'A' AND 'G';

/*
Давайте найдем всех заказчиков чьи имена начинаются с G
*/

SELECT *
FROM Customers
WHERE cname LIKE 'G%';

/*
Предположим что вы неуверены как записано по буквам имя одного из ваших продавцов Peal или Peel. Вы можете просто использовать ту
часть которую вы знаете и групповые символы чтобы находить все возможные пары
*/

SELECT *
FROM Salespeople
WHERE sname LIKE 'P__l%';

/*
 LIKE предикате, вы можете определить любой одиночный
символ как символ ESC. Символ ESC используется сразу перед процентом или подчеркиванием в предикате, и
 означает что процент или подчеркивание будет интерпретироваться как символ, а не как групповой символ.
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
Мы можем также использовать NOT с IN:
*/

SELECT *
FROM Salespeople
WHERE city NOT IN ( 'London', 'San Jose' );

/*
А это — другой способ подобного же выражения:
*/

SELECT *
FROM Salespeople
WHERE NOT city IN ( 'London', ' San Jose' );

/*
1.Напишите два запроса которые могли бы вывести все порядки на 3 или 4 Октября
1990

*/

SELECT * FROM Orders
WHERE odate IN ('1990-03-10','1990-04-10')

SELECT *
FROM Orders
WHERE odate IN (10/03/1990,10/04/1990);

/*
2. Напишите запрос который выберет всех заказчиков обслуживаемых продавцами
Peel или Motika. (Подсказка: из наших типовых таблиц, поле snum связывает вторую таблицу с первой)

*/

Select * FROM Customers
WHERE snum IN(1001, 1004)

/*
3. Напишите запрос, который может вывести всех заказчиков, чьи имена начинаются
с буквы попадающей в диапазон от A до G.

*/
SELECT * FROM Customers
WHERE cname between 'A' and 'H'
/*
4. Напишите запрос который выберет всех пользователей чьи имена начинаются с
буквы C.

*/
SELECT * FROM Customers
WHERE cname LIKE 'C%'
/*
5. Напишите запрос который выберет все порядки имеющие нулевые значения или
NULL в поле amt (сумма).
*/

SELECT * FROM Orders
WHERE NOT (amt = 0 or amt IS NULL)

/*
ГЛАВА 6
*/

/*
Чтобы найти SUM всех наших покупок в таблицы Порядков
*/

SELECT SUM ((amt))
FROM Orders;

/*
Нахождение усредненой суммы
— это похожая операция
*/

SELECT AVG (amt)
FROM Orders;

/*
Мы могли бы использовать ее, например, чтобы сосчитать номера продавцов в настоящее время описаных в таблице Порядков 
*/

SELECT * FROM
Orders

SELECT COUNT ( DISTINCT snum )
FROM Orders;

/*
Чтобы подсчитать общее число строк в таблице, используйте функцию COUNT
со звездочкой вместо имени поля, как например в следующем примере, вывод из которого показан на Рисунке 6.4:
*/

SELECT COUNT (*)
FROM Customers

/*
NULL не считает
*/
SELECT COUNT ( ALL rating )
FROM Customers;

SELECT MAX ( blnc + (amt) )
FROM Orders;
/*
Вы можете сделать раздельный запрос для каждого из них, выбрав MAX (amt) из таблицы 
Порядков для каждого значения поля snum. GROUP BY, однако, позволит Вам поместить их все в одну команду:
*/
SELECT snum, MAX (amt)
FROM Orders
GROUP BY snum;

/*
Вы можете также использовать GROUP BY с многочислеными полями. Совершенствуя вышеупомянутый пример далее, предположим что вы хотите увидеть наибольшую сумму приобретений
получаемую каждым продавцом каждый день. Чтобы сделать это, вы должны сгруппировать таблицу Порядков по датам продавцов, и применить функцию MAX к каждой
такой группе, подобно этому
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
GROUP BY odate;/*1. Напишите запрос, который сосчитал бы все суммы приобретений на 3 Октября.
*/
SELECT COUNT(*)
FROM Orders
WHERE odate = '1990-03-10';/*2. Напишите запрос, который сосчитал бы число различных не-NULL значений поля
city в таблице Заказчиков.
*/SELECT COUNT (DISTINCT city)
FROM Customers;/*3. Напишите запрос, который выбрал бы наименьшую сумму для каждого заказчика.
*/SELECT cnum, MIN(amt) FROM OrdersGROUP BY cnum;/*4. Напишите запрос, который бы выбирал заказчиков в алфавитном порядке, чьи
имена начинаются с буквы G.
*/SELECT MIN(cname)FROM CustomersWHERE cname LIKE 'G%'/*5. Напишите запрос, который выбрал бы высшую оценку в каждом городе.
*/SELECT city, MAX(rating)FROM CustomersGROUP BY city/*6. Напишите запрос, который сосчитал бы число заказчиков, регистрирующих каждый
день свои порядки. (Если продавец имел более одного порядка в данный день, он
должен учитываться только один раз.)*/
SELECT odate, COUNT (DISTINCT snum)
FROM Orders
GROUP BY odate

/*
ГЛАВА 7*/

/*
. Например, вы можете пожелать, представить комиссионные вашего продавца в процентном отношении а не как
десятичные числа. Просто достаточно:
*/

SELECT snum, sname, city, comm * 100
FROM Salespeople;

/*
Вы можете усовершенствовать предыдущий пример представив комиссионные
как проценты со знаком процента (%).
*/

SELECT snum, sname, city, ' % ', comm * 100
FROM Salespeople;

/*
Обратите внимание что пробел перед процентом вставляется как часть строки.
Эта же самая особенность может использоваться чтобы маркировать вывод вместе с
вставляемыми комментариями. Вы должны помнить, что этот же самый комментарий
будет напечатан в каждой строке вывода, а не просто один раз для всей таблицы.
Предположим что вы генерируете вывод для отчета который бы указывал число порядков получаемых 
в течение каждого дня. Вы можете промаркировать ваш вывод
(см. Рисунок 7.3) сформировав запрос следующим образом:

*/

SELECT ' For ', odate, ', there are ',
COUNT (DISTINCT onum), 'orders.'
FROM Orders
GROUP BY odate;

/*
Давайте рассмотрим нашу таблицу порядка приводимую
в порядок с помощью номера заказчика
*/
SELECT *
FROM Orders
ORDER BY cnum DESC;

/*
Мы можем также упорядочивать таблицу с помощью другого столбца, например
с помощью поля amt, внутри упорядочения поля cnum. (вывод показан в Рисунке 7.5):
*/

SELECT *
FROM Orders
ORDER BY cnum DESC, amt DESC;


SELECT snum, odate, MAX (amt)
FROM Orders
GROUP BY snum, odate
ORDER BY snum;

/*
Упорядочивание по номеру столбца
*/

SELECT sname, comm
FROM Salespeople
ORDER BY 2 DESC;

/*
Например, давайте сосчитаем порядки каждого
из наших продавцов, и выведем результаты в убывающем порядке, как показано в Рисунке 7.8
*/

SELECT snum, COUNT ( DISTINCT onum )
FROM Orders
GROUP BY snum
ORDER BY 2 DESC;

/*
1.Предположим что каждый продавец имеет 12% комиссионных. Напишите запрос к
таблице Порядков который мог бы вывести номер порядка, номер продавца, и сумму комиссионных продавца для этого порядка.

*/

SELECT onum, snum, amt * .12 
FROM Orders;

/*
2. Напишите запрос к таблице Заказчиков который мог бы найти высшую оценку в каждом городе. Вывод должен быть в такой форме:
For the city (city), the highest rating is: (rating).

*/
SELECT 'For the city ', city, ', the highest rating is: ', MAX(rating) 
FROM Customers
GROUP BY city;

/*
3. Напишите запрос который выводил бы список заказчиков в нисходящем порядке.
Вывод поля оценки (rating) должден сопровождаться именем закзчика и его номером.

*/
SELECT rating, cname, cnum 
FROM Customers
ORDER BY rating DESC;

/*
4. Напишите запрос который бы выводил общие порядки на каждый день и помещал
результаты в нисходящем порядке.
*/

SELECT odate, SUM(amt) 
FROM Orders
GROUP BY odate
ORDER BY 2 DESC;

/*
Глава 8

*/

/*
Предположим что вы хотите поставить в соответствии вашему продавцу ваших
заказчиков в городе в котором они живут, поэтому вы увидите все комбинации продавцов и заказчиков для этого города. Вы будете должны брать каждого продавца и
искать в таблице Заказчиков всех заказчиков того же самого города. Вы могли бы
сделать это, введя следующую команду (вывод показывается в Рисунке 8.1):
*/

SELECT Customers.cname, Salespeople.sname, Salespeople.city
FROM Salespeople, Customers
WHERE Salespeople.city = Customers.city;

/*
Объединение таблиц по связи состоянием справочной целостности
*/

SELECT Customers.cname, Salespeople.sname
FROM Customers, Salespeople
WHERE Salespeople.snum = Customers.snum;

/*
Вы можете, фактически, использовать любой из реляционных
операторов в обьединении. Здесь показан пример другого вида объединения (вывод
*/

SELECT sname, cname
FROM Salespeople, Customers
WHERE sname < cname AND rating < 200;

/*
Объединение двух и более таблиц
*/

SELECT onum, cname, Orders.cnum, Orders.snum
FROM Salespeople, Customers,Orders
WHERE Customers.city < > Salespeople.city
AND Orders.cnum = Customers.cnum
AND Orders.snum = Salespeople.snum;

/*
1. Напишите запрос, который бы вывел список номеров порядков, сопровождающихся
именем заказчика, который создавал эти порядки.

*/

SELECT * FROM Orders;
SELECT * FROM Customers;

SELECT Orders.onum, Customers.cname
FROM Orders, Customers
WHERE Customers.cnum = Orders.cnum;


/*
2. Напишите запрос, который бы выдавал имена продавца и заказчика для каждого
порядка после номера порядков.

*/


SELECT  Orders.onum, Customers.cname, Salespeople.sname
FROM Orders, Customers, Salespeople
WHERE Customers.cnum = Orders.cnum AND Salespeople.snum = Orders.snum;

/*
3. Напишите запрос, который бы выводил всех заказчиков, обслуживаемых продавцом с комиссионными выше 12%. Выведите имя заказчика, имя продавца и ставку
комиссионных продавца.

*/


SELECT cname, sname, comm
FROM Salespeople, Customers
WHERE Salespeople.snum = Customers.snum AND comm > 12;

/*
4. Напишите запрос, который вычислил бы сумму комиссионных продавца для
каждого порядка заказчика с оценкой выше 100.
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
ГЛАВА 9
*/

/*
Имеется пример, который находит все пары заказчиков имеющих один и тот же
самый рейтинг (вывод показывается в Рисунке 9.1):
*/

SELECT first.cname, second.cname, first.rating
FROM Customers first, Customers second
WHERE first.rating = second.rating;

/*
Чтобы избежать дубликаты строк
Исключите комбинации заказчиков с ними же, а также дубликаты строк,
выводимых в обратным порядке.
*/

SELECT first.cname, second.cname, first.rating
FROM Customers first, Customers second
WHERE first.rating = second.rating
AND first.cname < second.cname;

/*
Так как каждый заказчик должен быть назначен к одному и только одному продавцу, каждый раз когда определенный 
номер заказчика появляется в таблице Порядков, он должен совпадать с таким же номером продавц
*/

SELECT first.onum, first.cnum, first.snum,
second.onum, second.cnum, second.snum
FROM Orders first, Orders second
WHERE first.cnum = second.cnum
AND first.snum < > second.snum;

/*
.
Предположим что вы еще не назначили ваших заказчиков к вашему продавцу.
Компания должна назначить каждому продавцу первоначально трех заказчиков, по
одному для каждого рейтингового значения. 
Вы лично можете решить, какого заказчика какому продавцу назначить, но следующий запрос вы используете, чтобы увидеть
все возможные комбинации заказчиков, которых вы можете назначать.
*/

SELECT a.cnum, b.cnum, c.cnum
FROM Customers a, Customers b, Customers c
WHERE a.rating = 100 AND b.rating = 200 AND c.rating = 300;

/*
Вы должны также понимать, что не всегда обязательно использовать каждый
псевдоним или таблицу которые упомянуты в предложении FROM запроса, в предложении SELECT. Иногда, предложение или таблица становятся запрашиваемыми исключительно потому что они могут вызываться в предикате запроса. Например,
следующий запрос находит всех заказчиков размещенных в городах где продавец
Serres (snum 1002) имеет заказиков (вывод показывается в Рисунке 9.4):
*/

SELECT b.cnum, b.cname
FROM Customers a, Customers b
WHERE a.snum = 1002
AND b.city = a.city;

/*
Вы можете также создать обьединение которое включает и различные таблицы
и псевдонимы одиночной таблицы. 
Следующий запрос объединяет таблицу Пользователей с собой: 
чтобы найти все пары заказчиков обслуживаемых одним продавцом.
В то же самое время, этот запрос объединяет заказчика с таблицей 
Продавцов с именем этого продавца (вывод показан на Рисунке 9.5):
*/

SELECT sname, Salespeople.snum, first.cname, second.cname
FROM Customers first, Customers second, Salespeople
WHERE first.snum = second.snum
AND Salespeople.snum = first.snum
AND first.cnum < second.cnum;

/*
1. Напишите запрос, который бы вывел все пары продавцов, живущих в одном и том
же городе. Исключите комбинации продавцов с ними же, а также дубликаты строк,
выводимых в обратным порядке.

*/

SELECT first.sname, second.sname
FROM Salespeople first, Salespeople second
WHERE first.city = second.city AND first.sname < second.sname;

/*
2. Напишите запрос, который вывел бы все пары порядков по данным заказчикам,
именам этих заказчиков, и исключал дубликаты из вывода, как в предыдущем вопросе.

*/

SELECT cname, first.onum, second.onum
FROM Orders first, Orders second, Customers
WHERE first.cnum = second.cnum AND
first.cnum = Customers.cnum AND
first.onum < second.onum;

--Ваш вывод может иметь некоторые отличия, но в вашем ответе все логические компоненты должны быть такими же.
/*
3. Напишите запрос, который вывел бы имена (cname) и города (city) всех заказчиков
с такой же оценкой (rating) как у Hoffmanа. Напишите запрос, использующий поле
cnum Hoffmanа а не его оценку, так чтобы оно могло быть использовано если его
оценка вдруг изменится.
*/

SELECT * FROM Customers;

SELECT a.cname, a.city
FROM Customers a, Customers b
WHERE a.rating = b.rating AND b.cnum = 2001;

/*
ГЛАВА 10
*/

/*
Например, предположим что мы знаем имя продавца: Motika,
 но не знаем значение его поля snum, и хотим извлечь все порядки из таблицы Порядков. Имеется один
способ чтобы сделать это (вывод показывается в Рисунке 10.1):

*/

SELECT * 
FROM Orders
WHERE snum = (SELECT snum 
               FROM Salespeople
			   WHERE sname = 'Motika'); 
/*
Сначала выполняется внутренний подзапрос и выводит 1004, а затем подставляется в предикат внешнего запроса и выводит результат
*/

/*
Поскольку мы имеем только одного продавца в Barcelona — Rifkin, то подзапрос
будет выбирать одиночное значение snum и следовательно будет принят. Но это —
только в данном случае. Большинство SQL баз данных имеют многочисленых пользователей, и если другой пользователь добавит нового
 продавца из Barcelona в таблицу, подзапрос выберет два значения, и ваша команда потерпит неудачу.
*/

SELECT *
FROM Orders
WHERE snum = ( SELECT snum
FROM Salespeople
WHERE city = 'Barcelona' );

/*
Предположим что мы хотим найти все порядки кредитований для тех продавцов которые обслуживают Hoffmanа (cnum = 2001).
Имеется один способ, чтобы сделать это (вывод показывается в Рисунке 10.2):
*/

SELECT *
FROM Orders
WHERE snum = ( SELECT DISTINCT snum
FROM Orders
WHERE cnum = 2001 );

/*
вы хотите увидеть все порядки имеющие сумму приобретений выше средней на 4-е
Октября (вывод показан на Рисуноке 10.3):
*/

SELECT *
FROM Orders
WHERE amt > (SELECT AVG(amt)
              FROM Orders
			  WHERE odate = '1990-04-10')

/*
Средние комиссионные продавца из Лондона
*/

SELECT AVG (comm)
FROM Salespeople
WHERE city = 'London';

/*
Мы можем, следовательно, использовать 
IN чтобы выполнить такой же подзапрос, 
который не будет работать с реляционным оператором, и найти все атрибуты таблицы Порядков для продавца в
Лондоне (вывод показывается в Рисунке 10.4):
*/

SELECT *
FROM Orders
WHERE snum IN ( SELECT snum
FROM Salespeople
WHERE city = 'LONDON' );

--2 вариант
--не оптимальный

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
Устранение DISTINCT
*/

SELECT onum, amt, odate
FROM Orders
WHERE snum IN ( SELECT snum
FROM Orders
WHERE cnum = 2001 );

/*
Мы хотим вывести все значения комиссионные всех продавцов обслуживающих
заказчиков в Лондоне:
*/
SELECT comm
FROM Salespeople
WHERE snum IN ( SELECT snum
FROM Customers
WHERE city = 'London' );

/*
Это может быть выполнено или с помощью реляционных операторов или с IN. Например, следующий запрос использует
реляционный оператор = (вывод показывается в Рисунке 10.6):
*/

SELECT *
FROM Customers
WHERE cnum = ( SELECT snum + 1000
FROM Salespeople
WHERE sname = 'Serres' );

/*
Эта команда подсчитывает заказчиков с оценками выше среднего в San Jose.
Так как имеются другие оценки отличные от 300, они должны быть выведены с числом
номеров заказчиков которые имели эту оценку.
*/

SELECT rating, COUNT ( DISTINCT cnum )
FROM Customers
GROUP BY rating
HAVING rating > ( SELECT AVG (rating)
FROM Customers
WHERE city = 'San Jose' );

/*
1. Напишите запрос, который бы использовал подзапрос для получения всех порядков для заказчика с именем Cisneros. 
Предположим, что вы не знаете номера этого заказчика, указываемого в поле cnum.

*/
SELECT *
FROM Orders
WHERE cnum = (SELECT cnum
              FROM Customers
			  WHERE cname = 'Cisneros')

--или
SELECT *
FROM Orders
WHERE cnum IN (SELECT cnum
FROM Customers
WHERE cname = 'Cisneros');

/*
2. Напишите запрос, который вывел бы имена и оценки всех заказчиков, которые
имеют усредненые порядки.

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
3. Напишите запрос, который бы выбрал общую сумму всех приобретений в порядках
для каждого продавца, у которого эта общая сумма больше, чем сумма наибольшего порядка в таблице.
*/
SELECT snum, SUM(amt)
FROM Orders
GROUP BY snum
HAVING SUM(amt) > (SELECT MAX(amt)
FROM Orders);

/*
ГЛАВА 11 Соотнесенные подзапросы

*/

/*
Имеется один способ найти всех заказчиков в порядках на 10-е марта (вывод показывается в Рисунке 11.1):*/

SELECT *
FROM Customers 
WHERE '1990-03-10' IN ( SELECT odate
FROM Orders 
WHERE Customers.cnum = Orders.cnum );

/*
В вышеупомянутом примере, SQL осуществляет следующую процедуру:
1. Он выбирает строку Hoffman из таблицы Заказчиков.
2. Сохраняет эту строку как текущую строку-кандидат под псевдонимом — "внешним".
3. Затем он выполняет подзапрос. Подзапрос просматривает всю таблицу Порядков
чтобы найти строки где значение cnum поле — такое же как значение outer.cnum,
которое в настоящее время равно 2001, — поле cnum строки Hoffmanа. Затем он
извлекает поле odate из каждой строки таблицы Порядков, для которой это верно, и
формирует набор значений поля odate.
4. Получив набор всех значений поля odate, для поля cnum = 2001, он проверяет предикат основного запроса чтобы видеть имеется ли значение на 3 Октября в этом
наборе. Если это так (а это так), то он выбирает строку Hoffmanа для вывода ее из
основного запроса.
5. Он повторяет всю процедуру, используя строку Giovanni как строку-кандидата, и
затем сохраняет повторно пока каждая строка таблицы Заказчиков не будет проверена
*/

-- 2 вариант
/*
Конечно, вы могли бы решить ту же самую проблему используя обьединение, следующего вида
*/

SELECT * 
FROM Customers first, Orders second
WHERE first.cnum = second.cnum AND second.odate = '1990-03-10' 

/*
Предположим что мы хотим видеть имена и номера всех продавцов которые
имеют более одного заказчика. Следующий запрос выполнит это для вас (вывод показывается в Рисунке 11.3):
*/

SELECT snum, sname
FROM Salespeople main
WHERE 1 < ( SELECT COUNT (*)
FROM Customers
WHERE snum = main.snum );

/*
Выявление ошибок
*/

SELECT *
FROM Orders main
WHERE NOT snum = ( SELECT snum
FROM Customers
WHERE cnum = main.cnum );

/*
Вы можете также использовать соотнесенный подзапрос, основанный на той же
самой таблице, что и основной запрос. Это даст вам возможность извлечть определенные сложные формы произведенной информации. Например, мы можем найти все
порядки со значениями сумм приобретений выше среднего для их заказчиков (вывод
показан в Рисунке 11.4):
*/

SELECT *
FROM Orders k
WHERE amt > ( SELECT AVG(amt)
FROM Orders t
WHERE k.cnum = t.cnum );

/*
Конечно, в нашей маленькой типовой таблице, где большиство заказчиков имеют только один порядок,
 большинство значений являются одновременно средними и
следовательно не выбираются. Давайте введем команду другим способом (вывод показывается в Рисунке 11.5):
*/

SELECT *
FROM Orders out
WHERE amt >= ( SELECT AVG (amt)
FROM Orders inn
WHERE inn.cnum = out.cnum );

/*
Предположим, что вы хотите суммировать значения сумм приобретений покупок
из таблицы Порядков, сгруппировав их по датам, удалив все даты где бы SUM не был
по крайней мере на 2000.00 выше максимальной (MAX) суммы:*/SELECT odate, SUM (amt)
FROM Orders a
GROUP BY odate
HAVING SUM (amt) > ( SELECT 2000.00 + MAX (amt)
FROM Orders b
WHERE a.odate = b.odate );

/*
1. Напишите команду SELECT, использующую соотнесенный подзапрос, 
которая выберет имена и номера всех заказчиков с максимальными для их городов оценками.

*/
SELECT cnum, cname
FROM Customers out
WHERE rating = (SELECT MAX (rating)
FROM Customers inn
WHERE inn.city = out.city);
/*
2. Напишите два запроса, которые выберут всех продавцов (по их имени и номеру)
которые, в своих городах имеют заказчиков, которых они не обслуживают. 
Один запрос — с использованием обьединения и один — с соотнесенным подзапросом. 
Которое из решений будет более изящным? (Подсказка: один из способом это
сделать, состоит в том, чтобы находить всех заказчиков, не обслуживаемых данным продавцом 
и определить, находится ли каждый из них в городе продавца.)
*/


--Решение с помощью соотнесенного подзапроса:

SELECT snum, sname
FROM Salespeople main
WHERE city IN (SELECT city
FROM Customers inn
WHERE inn.snum <> main.snum);

--Решение с помощью объединения:
SELECT DISTINCT first.snum, sname
FROM Salespeople first, Customers second
WHERE first.city = second.city AND first.snum <> second.snum;

/*
Соотнесенный подзапрос находит всех заказчиков, не обслуживаемых данным
продавцом, и выясняет: живет ли кто-нибудь из них в его городе. Решение с помощью
обьединения является более простым и более интуитивным. Оно находит случаи, где
поля city совпадают, а поля snums нет. Следовательно, обьединение является более
изящным решением для этой проблемы, чем то, которое мы исследовали до этого.
Имеется еще более изящное решение с помощью подзапроса, с которым Вы столкнетесь позже
*/

/*
ГЛАВА 12 Использование оператора EXISTS
*/

/*
Он берет
подзапрос как аргумент и оценивает его как верный, если тот производит 
любой вывод или как неверный, если тот не делает этого. 
Этим он отличается от других операторов предиката, в которых он не может быть неизвестным. Например, мы можем
решить, извлекать ли нам некоторые данные из таблицы Заказчиков если, и только
если, один или более заказчиков в этой таблице находятсяся в San Jose (вывод для
этого запроса показывается в Рисунке 12.1):
*/
SELECT cnum, cname, city
FROM Customers
WHERE EXISTS ( SELECT *
FROM Customers
WHERE city = 'San Jose' );

/*
Следовательно информация из внутреннего запроса будет сохранена, если выведена
непосредственно, когда вы используете EXISTS таким способом. 
Например, мы можем вывести продавцов, которые имеют многочисленых заказчиков (вывод для этого
запроса показывается в Рисунке 12.2):*/SELECT DISTINCT snum
FROM Customers out
WHERE EXISTS ( SELECT *
FROM Customers inn
WHERE inn.snum = out.snum
AND inn.cnum < > out.cnum );

/*
Однако для нас может быть полезнее вывести больше информации об этих продавцах, 
а не только их номера. Мы можем сделать это, объединив таблицу Заказчиков
с таблицей Продавцов (вывод для запроса показывается в Рисунке 12.3):
*/

SELECT DISTINCT first.snum, sname, first.city
FROM Salespeople first, Customers second
WHERE EXISTS ( SELECT *
FROM Customers third
WHERE second.snum = third.snum
AND second.cnum < > third.cnum )
AND first.snum = second.snum;

/*
Предыдущий пример дал понять что EXISTS может работать в комбинации с
операторами Буля. Конечно, то что является 
самым простым способом для использования и вероятно наиболее часто используется с EXISTS — это оператор NOT. Один
из способов которым мы могли бы найти всех продавцов только с одним заказчиком
будет состоять в том, чтобы инвертировать наш предыдущий пример. (Вывод для этого запроса показывается в Рисунке 12.4.)

*/

SELECT DISTINCT snum
FROM Customers out
WHERE NOT EXISTS ( SELECT *
FROM Customers inn
WHERE inn.snum = out.snum
AND inn.cnum <> out.cnum );

/*
Имеется запрос, который извлекает строки всех продавцов которые имеют заказчиков с больше чем одним текущим порядком. 
Это не обязательно самое простое
решение этой проблемы, но оно предназначено скорее показать улучшеную логику
SQL. Вывод этой информации связывает все три наши типовых таблицы:
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
1. Напишите запрос который бы использовал оператор EXISTS для извлечения всех
продавцов которые имеют заказчиков с оценкой 300.

*/

SELECT *
FROM Salespeople first
WHERE EXISTS (SELECT *
FROM Customers second
WHERE first.snum = second.snum AND rating = 300);

/*
2. Как бы вы решили предыдущую проблему используя обьединение ?

*/

SELECT a.snum, sname, a.city, comm
FROM Salespeople a, Customers b
WHERE a.snum = b.snum AND b.rating = 300;

/*
3. Напишите запрос использующий оператор EXISTS который выберет всех продавцов 
с заказчиками размещенными в их городах которые ими не обслуживаются.

*/

SELECT *
FROM Salespeople a
WHERE EXISTS (SELECT *
FROM Customers b
WHERE b.city = a.city AND a.snum <> b.snum);

/*
4. Напишите запрос который извлекал бы из таблицы Заказчиков каждого заказчика
назначенного к продавцу который в данный момент имеет по крайней мере еще
одного заказчика (кроме заказчика которого вы выберете) с порядками в таблице
Порядков (подсказка: это может быть похоже на структуру в примере с нашим трехуровневым подзапросом).
*/


SELECT *
FROM Customers a
WHERE EXISTS (SELECT *
FROM Orders b
WHERE a.snum = b.snum AND a.cnum <> b.cnum)