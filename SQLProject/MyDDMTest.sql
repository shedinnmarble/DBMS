--create database 
create DATABASE dreamhome; 
go
use DreamHome;
--create table 
create TABLE Branch 
  ( 
     branchNo INT  PRIMARY KEY, 
     street   VARCHAR(256), 
     city     VARCHAR(50), 
     postcode INT 
  ); 
go
create TABLE Staff 
  ( 
     staffNo  INT IDENTITY(1, 3) PRIMARY KEY, 
     fName    VARCHAR(256) NOT NULL, 
     lName    VARCHAR(256) NOT NULL, 
     branchNo INT, 
    constraint chk_staffNo check (staffNo>0)
	,constraint fk_staff_Brahcn foreign key(branchNo) references Branch  on update cascade on delete set null
     ); 
go





create  TABLE PropertyForRent 
  ( 
     propertyNo INT IDENTITY(1, 100) PRIMARY KEY, 
     street     VARCHAR(256), 
     city       VARCHAR(50), 
     postcode   VARCHAR(10), 
     OwnerNo    INT 
          FOREIGN KEY (OwnerNo) REFERENCES PrivateOwner, 
          staffNo    INT 
          FOREIGN KEY (staffNo) REFERENCES Staff, 
          branchNo   INT 
     FOREIGN KEY (branchNo) REFERENCES Branch, 
  ) 
go;
CREATE TABLE Client 
  ( 
     clientNo INT IDENTITY(1, 1) PRIMARY KEY, 
     sex  char not null default 'M' check(sex in('M','F')),
     fName    VARCHAR(256) NOT NULL, 
     lName    VARCHAR(256) NOT NULL, 
     telNo    VARCHAR(20), 
     prefType VARCHAR(20), 
     maxRent  INT DEFAULT 0, 
     eMail    VARCHAR(100) 
  ) 
go;
CREATE TABLE PrivateOwner 
  ( 
     ownerNo INT IDENTITY(1, 10) PRIMARY KEY, 
     fName   VARCHAR(256) NOT NULL, 
     lName   VARCHAR(256) NOT NULL, 
  ) 
go;
create TABLE Viewing 
  ( 
     clientNo   INT foreign key(clientNo) references Client, 
     propertyNo INT foreign key(propertyNo) references PropertyForRent, 
     viewDate   DATE, 
     comment    VARCHAR(200), 
     PRIMARY KEY(clientNo, propertyNo, viewDate) 
  ) ;
  go
 --change table
 
 --alter table Client
	--alter column sex char(1) not null 
	
--create table test(
--CREATE DOMAIN Street AS VARCHAR(25);
--)

--general constraints
--limit each brunch has no more than 2 staff
--create ASSERTION  stafftoMuch
--	check (not exists(select ))

--create schema test;

create table test.test(
id int,
zip zip check (zip <>'00000')
)

create type zip from varchar(5) not null; 
--create index
create unique index index_Staff_fName 
on Staff(fName asc,LName desc)

--crate view
create view V_Staff_Branch 
as
select b.*,s.fName,s.lName,s.staffNo from Branch b join Staff s on s.branchNo=b.branchNo

--transcition
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;  

BEGIN TRANSACTION; 

COMMIT TRANSACTION; 


	