--7)Write a stored procedure that takes in one argument, the staff number of an instructor.  The procedure outputs all details of all the lessons for that instructor.
create procedure usp_GetLessionInfoByStaffNumber
@staffId int
as
select *
from Lession
where sid=@staffId;

--test
exec usp_GetLessionInfoByStaffNumber 1

/*8)Write a stored procedure that takes in two arguments, a staff number and a date.  
The procedure shows details of All lessons for that staff instructor, starting at the date of the argument, 
and ending seven days later*/
alter proc usp_GetLessionsByStaffAndDateIn7Days
@staffId int, @startDate date
as
select *
from Lession
where sid=@staffId and [date] between @startDate and DATEADD (day , 7 , @startDate)

--test
exec usp_GetLessionsByStaffAndDateIn7Days @staffId=1, @startDate='2016-12-9'

select DATEADD (day , 7 ,'2016-12-8')

/*
8.5)    a)  Do the same as questions 7 and 8 above, but for a client number instead of a 
             staff number.

              b)  Create some stored procedures yourself which do something you would like   
              to see being done.

              c)  Extra credit  :  Study the code for some of the system stored procedures, for 
              example sp_help,  sp_statistics,  and others.  Ask me how you can view the code.
*/
create proc usp_GetLessionsByClientAndDateIn7Days
@clientId int, @startDate date
as
select *
from Lession
where cid=@clientId and [date] between @startDate and DATEADD (day , 7 , @startDate)

--test
exec usp_GetLessionsByClientAndDateIn7Days @clientId=1, @startDate='2016-12-9'


--b)


/*
9)a)  Create a View called Client_Lesson which does an inner join on the Client and    
     Lesson tables.  Run it to make sure it works properly!  

          b)  Create two more views that may be useful to you.  Test them!
     */
create view v_Client_Lesson
as
select c.cid,c.personalDetails,c.name, l.sid
from Client c, Lession l
where c.cid=l.cid;

select * from v_Client_Lesson

