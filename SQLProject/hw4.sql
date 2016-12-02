-- 6.5 How can results from two SQL queries be combined? Differentiate how the INTERSECT and EXCEPT commands work.
--Simple queries 
--6.7 List full details of all hotels. 
SELECT * 
FROM   hotel; 

--6.8 List full details of all hotels in London. 
SELECT * 
FROM   hotel 
WHERE  city = 'London'; 

--6.9 List the names and addresses of all guests living in London, alphabetically ordered by name.
SELECT g.guestname, 
       g.guestaddress 
FROM   guest g, 
       booking b, 
       hotel h 
WHERE  g.guestno = b.guestno 
       AND b.hotelno = h.hotelno 
       AND h.city = 'London'; 

--6.10 List all double or family rooms with a price below £40.00 per night, in ascending order of price.
SELECT * 
FROM   room 
WHERE  type = 'double' 
        OR type = 'family' 
           AND price < 40 
ORDER  BY price ASC; 

--6.11 List the bookings for which no dateTo has been specified. 
SELECT * 
FROM   booking 
WHERE  dateto IS NULL; 

--Aggregate functions 
--6.12 How many hotels are there? 
SELECT Count(*) AS Mycount 
FROM   hotel; 

--6.13 What is the average price of a room? 
SELECT Avg(price) AS MyAvg 
FROM   room; 

--6.14 What is the total revenue per night from all double rooms? 
SELECT Sum(price) AS revenuePerNight 
FROM   room 
WHERE  type = 'double'; 

--6.15 How many different guests have made bookings for August? 
SELECT g.guestname, 
       Count(*) 
FROM   booking b, 
       guest g 
WHERE  b.guestno = g.guestno 
       AND Month(datefrom) = 8 
GROUP  BY g.guestname 

--Subqueries and joins 
--6.16 List the price and type of all rooms at the Grosvenor Hotel. 
SELECT price, 
       [type] 
FROM   hotel h 
       JOIN room r 
         ON h.hotelno = r.hotelno 
WHERE  h.hotelname = 'Grosvenor'; 

--6.17 List all guests currently staying at the Grosvenor Hotel. 
SELECT g.* 
FROM   guest g 
       JOIN booking b 
         ON g.guestno = b.guestno 
       JOIN hotel h 
         ON b.hotelno = h.hotelno 
WHERE  h.hotelname = 'Grosvenor'; 

--6.18 List the details of all rooms at the Grosvenor Hotel, including the name of the guest staying in the room, if the
--room is occupied. 
SELECT r.roomno, 
       r.price, 
       r.type, 
       g.guestname, 
       h.hotelname 
FROM   room r 
       JOIN booking b 
         ON b.roomno = r.roomno 
       JOIN hotel h 
         ON b.hotelno = h.hotelno 
            AND r.hotelno = h.hotelno 
       JOIN guest g 
         ON g.guestno = b.guestno 
WHERE  h.hotelname = 'Grosvenor'; 

--6.19 What is the total income from bookings for the Grosvenor Hotel today? 
SELECT Sum(Datediff(day, b.datefrom, b.dateto) * r.price) AS totalIncome, 
       Sum(Datediff(day, b.datefrom, b.dateto))           AS daysofRent 
FROM   booking b 
       JOIN hotel h 
         ON b.hotelno = h.hotelno 
       JOIN room r 
         ON r.hotelno = h.hotelno 
            AND r.roomno = b.roomno 
WHERE  h.hotelname = 'Grosvenor' 

--  Grouping 
--6.22 List the number of rooms in each hotel. 
SELECT Count(*) AS NumberOfRooms, 
       h.hotelno, 
       h.hotelname, 
       h.city 
FROM   room r 
       JOIN hotel h 
         ON r.hotelno = h.hotelno 
GROUP  BY h.hotelno, 
          h.hotelname, 
          h.city 

--6.23 List the number of rooms in each hotel in London. 
SELECT Count(*) AS NumberOfRooms, 
       h.hotelno, 
       h.hotelname, 
       h.city 
FROM   room r 
       JOIN hotel h 
         ON r.hotelno = h.hotelno 
WHERE  h.city = 'London' 
GROUP  BY h.hotelno, 
          h.hotelname, 
          h.city 

--test to use exists
SELECT Count(*) AS NumberOfRooms, 
       r.hotelno 
FROM   room r 
WHERE  EXISTS(SELECT * 
              FROM   hotel h 
              WHERE  r.hotelno = h.hotelno 
                     AND h.city = 'London') 
GROUP  BY r.hotelno 
         

--6.24 What is the average number of bookings for each hotel in August? 
SELECT Count(*)avgBooking, 
       h.hotelname, 
       h.hotelno 
FROM   hotel h 
       JOIN booking b 
         ON b.hotelno = h.hotelno 
WHERE  Month(b.datefrom) = 8 
GROUP  BY h.hotelname, 
          h.hotelno 
union 
SELECT 0, 
       h.hotelname, 
       h.hotelno 
FROM   hotel h 
WHERE  h.hotelno NOT IN(SELECT h.hotelno 
                        FROM   hotel h 
                               JOIN booking b 
                                 ON b.hotelno = h.hotelno 
                        WHERE  Month(b.datefrom) = 8) 

--  Populating tables 
--6.27 Insert rows into each of these tables. 
--Hotel 
INSERT INTO hotel 
            (hotelno, 
             hotelname, 
             city) 
VALUES      (5, 
             'Rujia', 
             'Beijing'); 

INSERT INTO hotel 
            (hotelno, 
             hotelname, 
             city) 
VALUES      (6, 
             'Qiri', 
             'Shanghai'); 

--Room 
INSERT INTO room 
            (roomno, 
             hotelno, 
             type, 
             price) 
VALUES     (111, 
            5, 
            'single', 
            1000); 

INSERT INTO room 
            (roomno, 
             hotelno, 
             type, 
             price) 
VALUES     (111, 
            6, 
            'single', 
            150); 

--Guest 
INSERT INTO guest 
            (guestno, 
             guestname, 
             guestaddress) 
VALUES     (4, 
            'dewei', 
            '1000 N 4th , fairfield, iowa, usa'); 

INSERT INTO guest 
            (guestno, 
             guestname, 
             guestaddress) 
VALUES     (5, 
            'guru', 
            '1000 S 5th , fairfield, iowa, usa'); 

--Booking 
INSERT INTO booking 
            (hotelno, 
             guestno, 
             datefrom, 
             dateto, 
             roomno) 
VALUES     (5, 
            4, 
            '2016-08-02', 
            '2016-08-18', 
            111); 

INSERT INTO booking 
            (hotelno, 
             guestno, 
             datefrom, 
             dateto, 
             roomno) 
VALUES     (6, 
            4, 
            '2016-08-12', 
            '2016-08-28', 
            111); 

--6.28 Update the price of all rooms by 5%. 
UPDATE room 
SET    price = price * ( 1 + 0.05 ); 
--General 
/**6.29 Investigate the SQL dialect on any DBMS that you are currently using. Determine the system’s compliance with
--the DML statements of the ISO standard. Investigate the functionality of any extensions that the DBMS supports.
Are there any functions not supported? 
**/ 