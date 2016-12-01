-- 6.5 How can results from two SQL queries be combined? Differentiate how the INTERSECT and EXCEPT commands work.

--Simple queries
--6.7 List full details of all hotels.
select *
	from Hotel;
--6.8 List full details of all hotels in London.
select * 
	from Hotel 
	where city ='London';
--6.9 List the names and addresses of all guests living in London, alphabetically ordered by name.
select g.guestName, g.guestAddress 
	from Guest g, Booking b, Hotel h
	where g.guestNo=b.guestNo and b.hotelNo=h.hotelNo and h.city='London';
	
--6.10 List all double or family rooms with a price below £40.00 per night, in ascending order of price.
select * 
	from Room
	where type='double' or type='family' and price<40
	order by price asc;

--6.11 List the bookings for which no dateTo has been specified.
select *
	from Booking
	where dateTo is null;
	
--Aggregate functions
--6.12 How many hotels are there?
select COUNT(*) as Mycount
	from Hotel;
--6.13 What is the average price of a room?
select AVG(price) as MyAvg
	from Room;
--6.14 What is the total revenue per night from all double rooms?
select SUM(price) as revenuePerNight
	from Room 
	where type='double';
--6.15 How many different guests have made bookings for August?
select g.guestName,COUNT(*) 
	from Booking b, Guest g
	where b.guestNo=g.guestNo and MONTH(dateFrom)=8
	group by g.guestName
--Subqueries and joins
--6.16 List the price and type of all rooms at the Grosvenor Hotel.
select price,[type]
	from Hotel h 
	join Room r
	on h.hotelNo=r.hotelNo
	where h.hotelName='Grosvenor';
--6.17 List all guests currently staying at the Grosvenor Hotel.
select g.*
	from guest g
		join Booking b
		on g.guestNo=b.guestNo
		join Hotel h
		on b.hotelNo=h.hotelNo
			where h.hotelName='Grosvenor';
--6.18 List the details of all rooms at the Grosvenor Hotel, including the name of the guest staying in the room, if the
--room is occupied.
select r.roomNo,r.price,r.type,g.guestName,h.hotelName
	from Room r
		join Booking b
		on b.roomNo=r.roomNo
		join Hotel h
		on b.hotelNo=h.hotelNo and r.hotelNo=h.hotelNo
		join Guest g
		on g.guestNo=b.guestNo
		where h.hotelName='Grosvenor';
--6.19 What is the total income from bookings for the Grosvenor Hotel today?

select sum(DATEDIFF(day, b.dateFrom,b.dateTo)*r.price) as totalIncome, sum(DATEDIFF(day, b.dateFrom,b.dateTo)) as daysofRent
	from Booking b
	join Hotel h
	on b.hotelNo=h.hotelNo
	join Room r
	on r.hotelNo=h.hotelNo and r.roomNo=b.roomNo
	where h.hotelName='Grosvenor'
	
--	Grouping
--6.22 List the number of rooms in each hotel.
select COUNT(*) as NumberOfRooms,h.hotelNo,h.hotelName,h.city
	from Room r
	join Hotel h
	on r.hotelNo=h.hotelNo
	group by h.hotelNo,h.hotelName,h.city
	
--6.23 List the number of rooms in each hotel in London.
select COUNT(*) as NumberOfRooms,h.hotelNo,h.hotelName,h.city
	from Room r
	join Hotel h
	on r.hotelNo=h.hotelNo
	where h.city='London'
	group by h.hotelNo,h.hotelName,h.city
--6.24 What is the average number of bookings for each hotel in August?
select COUNT(*)avgBooking,h.hotelName,h.hotelNo
	from Hotel h
	join Booking b
	on b.hotelNo=h.hotelNo
	
	where MONTH(b.dateFrom)=8
	group by h.hotelName,h.hotelNo
union
select 0, h.hotelName,h.hotelNo
	from Hotel h
	where h.hotelNo not in(
		select h.hotelNo
	from Hotel h
	join Booking b
	on b.hotelNo=h.hotelNo
	
	where MONTH(b.dateFrom)=8
	)