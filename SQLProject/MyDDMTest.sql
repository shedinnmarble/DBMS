--create database 
CREATE DATABASE dreamhome; 

--create table 
CREATE TABLE Branch 
  ( 
     branchNo INT IDENTITY(1, 1) PRIMARY KEY, 
     street   VARCHAR(256), 
     city     VARCHAR(50), 
     postcode INT 
  ); 

CREATE TABLE Staff 
  ( 
     staffNo  INT IDENTITY(1, 3) PRIMARY KEY, 
     fName    VARCHAR(256) NOT NULL, 
     lName    VARCHAR(256) NOT NULL, 
     branchNo INT 
     FOREIGN KEY(branchNo) REFERENCES Branch 
  ); 

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

CREATE TABLE Client 
  ( 
     clientNo INT IDENTITY(1, 1) PRIMARY KEY, 
     fName    VARCHAR(256) NOT NULL, 
     lName    VARCHAR(256) NOT NULL, 
     telNo    VARCHAR(20), 
     prefType VARCHAR(20), 
     maxRent  INT DEFAULT 0, 
     eMail    VARCHAR(100) 
  ) 

CREATE TABLE PrivateOwner 
  ( 
     ownerNo INT IDENTITY(1, 10) PRIMARY KEY, 
     fName   VARCHAR(256) NOT NULL, 
     lName   VARCHAR(256) NOT NULL, 
  ) 

create TABLE Viewing 
  ( 
     clientNo   INT foreign key(clientNo) references Client, 
     propertyNo INT foreign key(propertyNo) references PropertyForRent, 
     viewDate   DATE, 
     comment    VARCHAR(200), 
     PRIMARY KEY(clientNo, propertyNo, viewDate) 
  ) ;
  
 --change table
 
 alter table Client
	alter column sex char(1) not null 
	
--create table test(
--CREATE DOMAIN Street AS VARCHAR(25);
--)
	