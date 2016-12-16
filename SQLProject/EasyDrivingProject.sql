CREATE DATABASE easydring_dewei; 

go 

USE easydring_dewei; 

go 

CREATE TABLE Branch 
  ( 
     bid     INT PRIMARY KEY IDENTITY, 
     address NVARCHAR(100), 
     city    NVARCHAR(50) 
  ) 

go 

CREATE TABLE Car 
  ( 
     carNo              INT PRIMARY KEY IDENTITY, 
     registrationNumber INT 
  ) 

go 

CREATE TABLE Staff 
  ( 
     [sid]    INT PRIMARY KEY IDENTITY, 
     position NVARCHAR(100) NOT NULL, 
     carNo    INT 
          CONSTRAINT fk_staff_car FOREIGN KEY (carNo) REFERENCES Car(carNo), 
          gender   CHAR CHECK(gender IN('M', 'F')), 
          Dob      DATE, 
          bid      INT 
     CONSTRAINT fk_staff_branch FOREIGN KEY(bid) REFERENCES Branch(bid) 
  ) 

go 

CREATE TABLE Inspection 
  ( 
     insId            INT PRIMARY KEY IDENTITY, 
     numberFaults     INT, 
     faultDescription NVARCHAR(500), 
     carNo            INT 
     CONSTRAINT fk_inspection_car FOREIGN KEY(carNo) REFERENCES Car(carNo) 
  ) 

CREATE TABLE Client 
  ( 
     cId                  INT PRIMARY KEY IDENTITY, 
     personalDetails      NVARCHAR(100), 
     validPersonalLicense BIT DEFAULT 0, 
     specialNeeds         NVARCHAR(100), 
     writtenTestPasswd    BIT DEFAULT 0, 
     [sid]                INT 
          CONSTRAINT fk_client_staff FOREIGN KEY([sid]) REFERENCES Staff([sid]), 
     interviewId          INT 
  ) 

CREATE TABLE Interview 
  ( 
     interviewId    INT PRIMARY KEY, 
     [date]         DATE, 
     interviwerName NVARCHAR(50) NOT NULL, 
     cId            INT 
  ) 

--add relationship 
ALTER TABLE Client 
  ADD CONSTRAINT fk_client_interview FOREIGN KEY(interviewId) REFERENCES 
  Interview(interviewId) 

ALTER TABLE Interview 
  ADD CONSTRAINT fk_interview_client FOREIGN KEY([cid]) REFERENCES Client([cid]) 

CREATE TABLE DrivingTest 
  ( 
     cid               INT 
          CONSTRAINT fk_drivingtest_client FOREIGN KEY([cid]) REFERENCES Client( 
     [cid] 
          ), 
          [date]            DATE, 
          drivingTestPassed BIT DEFAULT 0, 
          reasonForFailing  NVARCHAR(100), 
     CONSTRAINT pk_cid_date PRIMARY KEY(cid, [date]) 
  ) 

CREATE TABLE Lession 
  ( 
     [sid]    INT 
          CONSTRAINT fk_lession_staff FOREIGN KEY([sid]) REFERENCES Staff([sid]) 
     , 
          cid      INT 
          CONSTRAINT fk_lession_client FOREIGN KEY(cid) REFERENCES Client(cid), 
          [date]   DATE, 
          [time]   DATETIME, 
          block    BIT, 
          carNo    INT 
          CONSTRAINT fk_lession_car FOREIGN KEY(carNo) REFERENCES Car(carNo), 
          mileage  INT, 
          progress NVARCHAR(100), 
          fee      INT, 
     CONSTRAINT pk_sid_cid_date_time PRIMARY KEY([sid], cid, [date], [time]) 
  ) 
  
  alter table Staff
  add  name nvarchar(100)
  
  alter table Client
  add  name nvarchar(100)
  
  alter table Lession
  drop column block
  --Part 2, start to u