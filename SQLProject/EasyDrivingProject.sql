
create database EasyDring_Dewei;
go
use EasyDring_Dewei;
go
create table Branch(
bid int primary key identity,
address nvarchar(100),
city nvarchar(50)
)
go
create table Car(
	carNo int primary key identity,	
	registrationNumber int			
)
go
create table Staff(
[sid] int primary key identity,
position nvarchar(100) not null,
carNo int constraint FK_Staff_Car foreign key (carNo) references Car(carNo),
gender char check(gender in('M','F')),
Dob date,
bid int constraint FK_Staff_Branch foreign key(bid)  references Branch(bid)
)
go
create table Inspection(
	insId int primary key identity,
	numberFaults int,
	faultDescription nvarchar(500),
	carNo int constraint FK_Inspection_Car foreign key(carNo) references Car(carNo)	
)

create table Client(
	cId int primary key identity,
	personalDetails nvarchar(100),
	validPersonalLicense bit default 0,
	specialNeeds nvarchar(100),
	writtenTestPasswd bit default 0,
	[sid] int constraint FK_Client_Staff foreign key([sid]) references Staff([sid]),
	interviewId int
	
)


create table Interview(
	interviewId int primary key,
	[date] date,
	interviwerName nvarchar(50) not null,
	cId int
)
--add relationship
alter table Client
add  constraint FK_Client_Interview foreign key(interviewId) references Interview(interviewId)
alter table Interview
add constraint FK_Interview_Client foreign key([cid]) references Client([cid])


create table DrivingTest(
cid int constraint FK_DrivingTest_Client foreign key([cid]) references Client([cid]),
[date] date,
drivingTestPassed bit default 0,
reasonForFailing nvarchar(100),
constraint PK_cid_date primary key(cid,[date])
)

create table Lession(
[sid] int constraint FK_Lession_Staff foreign key([sid]) references Staff([sid]),
cid int constraint FK_Lession_Client foreign key(cid) references Client(cid),
[date] date,
[time] datetime,
block bit,
carNo int constraint FK_Lession_Car foreign key(carNo) references Car(carNo),
mileage int,
progress nvarchar(100),
fee int,
constraint PK_sid_cid_date_time primary key([sid],cid,[date],[time])
)





