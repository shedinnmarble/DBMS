/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [hotelNo]
      ,[guestNo],
      [dateFrom]
      ,month([dateFrom]) as MonthDate
      ,[dateTo]
      ,[roomNo]
  FROM [Hotel].[dbo].[Booking];
  
  SELECT TOP 1000 [guestNo]
      ,[guestName]
      ,[guestAddress]
  FROM [Hotel].[dbo].[Guest];
  
  select * from Hotel;
  select * from Room;