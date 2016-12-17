--7)Write a stored procedure that takes in one argument, the staff number of an instructor.  The procedure outputs all details of all the lessons for that instructor.
CREATE PROCEDURE usp_GetLessionInfoByStaffNumber @staffId int
AS
  SELECT
    *
  FROM Lession
  WHERE sid = @staffId;

  --test
  EXEC usp_GetLessionInfoByStaffNumber 1;
GO

/*8)Write a stored procedure that takes in two arguments, a staff number and a date.  
The procedure shows details of All lessons for that staff instructor, starting at the date of the argument, 
and ending seven days later*/
CREATE PROC usp_GetLessionsByStaffAndDateIn7Days @staffId int, @startDate date
AS
  SELECT
    *
  FROM Lession
  WHERE sid = @staffId
  AND [date] BETWEEN @startDate AND DATEADD(DAY, 7, @startDate)

  --test
  EXEC usp_GetLessionsByStaffAndDateIn7Days @staffId = 1,
                                            @startDate = '2016-12-9'

  SELECT
    DATEADD(DAY, 7, '2016-12-8');
GO

/*
8.5)    a)  Do the same as questions 7 and 8 above, but for a client number instead of a 
             staff number.

              b)  Create some stored procedures yourself which do something you would like   
              to see being done.

              c)  Extra credit  :  Study the code for some of the system stored procedures, for 
              example sp_help,  sp_statistics,  and others.  Ask me how you can view the code.
*/
CREATE PROC usp_GetLessionsByClientAndDateIn7Days @clientId int, @startDate date
AS
  SELECT
    *
  FROM Lession
  WHERE cid = @clientId
  AND [date] BETWEEN @startDate AND DATEADD(DAY, 7, @startDate);
GO
--test

EXEC usp_GetLessionsByClientAndDateIn7Days @clientId = 1,
                                           @startDate = '2016-12-9';


--b)


/*
9)a)  Create a View called Client_Lesson which does an inner join on the Client and    
     Lesson tables.  Run it to make sure it works properly!  

        
     */
GO
CREATE VIEW v_Client_Lesson
AS
SELECT
  c.cid,
  c.personalDetails,
  c.name,
  l.sid
FROM Client c,
     Lession l
WHERE c.cid = l.cid;
GO
SELECT
  *
FROM v_Client_Lesson;

--  b)  Create two more views that may be useful to you.  Test them!
GO

CREATE VIEW v_Staff_Car
AS
SELECT
  s.name,
  c.carNo
FROM Staff s,
     Car c
WHERE s.carNo = c.carNo

GO
SELECT
  *
FROM v_Staff_Car

GO

/*10)  a)  Create a user defined function that returns the total lessons that a client has taken up to today.


  */


CREATE FUNCTION getTotalLessonsByClient (@clientId int)
RETURNS int
AS
BEGIN
  DECLARE @count int;
  SELECT
    @count = (SELECT
      COUNT(*)
    FROM Lession l
    WHERE @clientId = l.cid)
END
RETURN @count

GO

SELECT
  dbo.getTotalLessonsByClient(1) AS NumberOfCourse

GO
--  b)  Create a user defined function that returns the total lessons that a client has taken before a date supplied by the user.
CREATE FUNCTION getTotalBeforeDateLessionByClientId (@clientId int, @date date)
RETURNS int
BEGIN
  DECLARE @count int;
  SELECT
    @count = (SELECT
      COUNT(*)
    FROM Lession l
    WHERE @clientId = l.cid
    AND l.date <= @date)
  RETURN @count
END

GO

SELECT
  dbo.getTotalBeforeDateLessionByClientId(1, '2016-12-16') AS NumberOfCourse
  
  GO
  /*11 Create a user defined function that returns a table which does an inner join on the Client and Lesson tables, 
  for a particular client which is supplied by the user.  Run it to make sure it works properly!  
  */
  alter function getLessionsDetailByClientId(@cientId int)
  returns table
  as  
	return( select c.cid, c.name, l.date, l.time ,l.fee
	from Client c, Lession l
	where c.cid = l.cid)
		
	go
		
select * from getLessionsDetailByClientId(1)

/*
  12)  Triggers :

             a)  Read about them in the Help menu.

             b)  In the Staff table, add an attribute to keep track of the total 
                  number of clients that an instructor has.  Whenever a new client is added to 
                  the Client table, we add one to the above new attribute, to the staff person who 
                  is working with this new client.  A similar thing is done if a client is removed 
                  from our Client table.*/

--add column
alter table Staff
add  noOfClients int default 0
go
create trigger changeNumberOfClients on Client
after insert
as
declare @sid int

update Staff set noOfClients =( select count(*) from client c, Inserted i where c.sid=i.sid) 
where [sid]=@sid
  