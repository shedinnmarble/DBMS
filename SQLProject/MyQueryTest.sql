--left outer join, right join, full join, inner join

--inner join = join, left join == left outer join
select *
from Booking b
	full outer join Hotel h
		on b.hotelNo=h.hotelNo