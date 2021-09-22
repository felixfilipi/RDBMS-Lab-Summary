create database lab_1;

create table MsCustomer(
CustomerId char(5) primary key not null,
CustomerName varchar(50),
CustomerGender varchar(10),
CustomerPhone varchar(13),
CustomerAddress varchar(100),
constraint cek_customerid check (CustomerId regexp binary '^CU[0-9][0-9][0-9]'),
constraint cek_customergender check (CustomerGender in ('Male','Female')));

set foreign_key_checks=1;


describe MsTreatment;
create table MsStaff(
StaffId char(5) primary key not null,
StaffName varchar(50),
StaffGender varchar(10),
StaffPhone varchar(13),
StaffAddress varchar(100),
StaffSalary numeric(11,2),
StaffPosition varchar(20),
constraint cek_staffid check (staffId regexp binary '^SF[0-9][0-9][0-9]'),
constraint cek_staffgender check (StaffGender in ('Male','Female'))
);
create table MsTreatmentType(
TreatmentTypeId char(5) primary key not null,
TreatmentTypeName varchar(50),
constraint cek_TreatmentTypeId check(TreatmentTypeId regexp binary '^TT[0-9][0-9][0-9]')
);
drop table MsTreatment;
create table MsTreatment(
TreatmentId char(5) primary key not null,
TreatmentTypeId char(5) not null,
TreatmentName varchar(50),
Price numeric(11,2),
constraint cek_TreatmentId check (TreatmentId regexp binary '^TM[0-9][0-9][0-9]'),
foreign key (TreatmentTypeId) references MsTreatmentType(TreatmentTypeId)
on update cascade on delete cascade
);

create table HeaderSalonServices(
TransactionId char(5) primary key not null,
CustomerId char(5) not null,
StaffId char(5) not null,
TransactionDate date,
PaymentType varchar(20),
constraint cek_TransactionId check (TransactionId regexp binary '^TR[0-9][0-9][0-9]'),
foreign key (CustomerId) references MsCustomer(CustomerId)on update cascade on delete cascade,
foreign key (StaffId) references MsStaff(StaffId)on update cascade on delete cascade
);

CREATE TABLE Student  
( post_id INT NOT NULL AUTO_INCREMENT, user_id INT NOT NULL,  
 CONSTRAINT Post_PK  
    PRIMARY KEY (user_id, post_id), 
 CONSTRAINT post_id_UQ  
    UNIQUE (post_id)               
) ENGINE = InnoDB ;  

CREATE TABLE UserInfo(
  UserId INT(10) NOT NULL,
  Name VARCHAR(50),
  Description TEXT,
  Company VARCHAR(48),
  Location VARCHAR(48),
  Website VARCHAR(48),
  PhoneNumber VARCHAR(16),
  FOREIGN KEY (UserId) REFERENCES User (UserId) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT chk_phone CHECK (PhoneNumber <= 12 AND PhoneNumber like '08[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
  CONSTRAINT chk_website CHECK (Website like '%.%')
) ENGINE = InnoDB;

SELECT * FROM INFORMATION_SCHEMA.INNODB_SYS_INDEXES WHERE NAME = 'UserId';

CREATE TABLE User(
  UserId INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Email VARCHAR(20),
  Password VARCHAR(16),
  LastActivity DATETIME,
  IsOnline BOOL,
  IsSupplier BOOL,
  IsAdmin BOOL,
  CONSTRAINT chk_email CHECK (Email like '%@%.%')
) ENGINE = InnoDB;

CREATE TABLE UserPhoto(
  PhotoId  INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  UserId  INT(10) NOT NULL,
  PhotoName VARCHAR(48) NOT NULL,
  FOREIGN KEY (UserId) REFERENCES User (UserId) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

create database testcok;
use testcok;
desc student;
drop table student;
set check_constraint_checks = 0;

CREATE UNIQUE INDEX index_name ON detailsalonservices ( transactionid, treatmentid);
CREATE UNIQUE INDEX index_header ON headersalonservices ( transactionid);
SHOW INDEX FROM hsalonservices;
create table DetailSalonServices(
TransactionId char(5) not null,
TreatmentId char(5) not null,
foreign key (TransactionId) references HeaderSalonServices(TransactionId)
on update cascade on delete cascade,
foreign key (TreatmentId) references MsTreatment(TreatmentId)
on update cascade on delete cascade
);


create table DetailSalonServices(
TransactionId char(5) not null,
TreatmentId char(5) not null,
foreign key (TransactionId) references HeaderSalonServices(TransactionId)
on update cascade on delete cascade,
foreign key (TreatmentId) references MsTreatment(TreatmentId)
on update cascade on delete cascade);

alter table DetailSalonServices add primary key (TransactionId,TreatmentId);

set foreign_key_checks = 0;
alter table MsStaff add constraint check_staffname check(char_length(StaffName) >= 5 and char_length(StaffName) <= 20);
alter table MsStaff drop check check_staffname;
set foreign_key_checks = 1;

set check_constraint_checks=0;
alter table MsStaff add constraint check_staffname 
check(char_length(StaffName)>=5 and char_length(StaffName)<=20);
set check_constraint_checks=1;

select * from MsStaff;

insert into MsStaff values('SF006','Bri','Male','140150510','Rumah Putri',14.5,'AAADD');

alter table MsStaff drop constraint cek_staffname;
insert into MsStaff values('SF002','Put','Male','08123842424','De ClusterLumba2',24.2,'CEO');
select * from MsStaff;
alter table MsTreatment add description varchar(100);
alter table MsTreatment drop column description; 
use lab_1;

insert into MsStaff values ('SF006','Jeklin Harefa','Female','085265433322',
'Kebon Jeruk Street no 140','3000000','Stylist'),
('SF007','Lavinia','Female','085755500011','Kebon Jeruk Street no 135','3000000','Stylist'),
('SF008','Stephen Adrianto','Male','085564223311', 'Mandala Street no 14','3000000','Stylist'),
('SF009','Rico Wijaya','Male','085710252525','Keluarga Street no 78','3000000','Stylist');

insert into HeaderSalonServices values ('TR010','CU001','SF004','2012/12/23','Credit'),
('TR011','CU002','SF006','2012/12/24','Credit'),
('TR012','CU003','SF007','2012/12/24','Cash'),
('TR013','CU004','SF005','2012/12/25','Debit'),
('TR014','CU005','SF007','2012/12/25','Debit'),
('TR015','CU005','SF005','2012/12/26','Credit'),
('TR016','CU002','SF001','2012/12/26','Cash'),
('TR017','CU003','SF002','2012/12/26','Credit'),
('TR018','CU005','SF001','2012/12/27','Debit');

insert into DetailSalonServices values ('TR010','TM003'),
('TR010','TM005'),('TR010','TM010'),('TR011','TM015'),('TR011','TM025'),('TR012','TM009'),
('TR013','TM003'),('TR013','TM006'),('TR013','TM015'),('TR014','TM016'),('TR015','TM016')
,('TR015','TM006'),('TR016','TM015'),('TR016','TM003'),('TR016','TM005'),('TR017','TM003')
,('TR018','TM006'),('TR018','TM005'),('TR018','TM007');

insert into HeaderSalonServices values ('TR019','CU005','SF004', CURDATE() + 3,'Credit');

insert into MsStaff values ('SF010','Effendy Lesmana','Male','085218587878',
'Tanggerang City Street no 88', round(RAND() * (5000000-3000000) + 3000000,'Stylist'));

#4
insert into MsCustomer values('CU001','Franky','Male','08566543338',
'Daan Mogot baru Street no 6'),('CU002','Emalia Dewi','Female','085264782135',
'Tanjung Duren street no 185'),('CU003','Elysia Chen','Female','08575406611',
'Kebon Jeruk Street no 120'),('CU004','Brando Kartawijaya','Male','081170225561',
'Greenvil Street no 88'),('CU005','Andy Putra','Male','087751321421',
'Sunter Street no 42');

UPDATE MsCustomer SET CustomerPhone = REPLACE(CustomerPhone,'08','628');

#5
insert into MsStaff values
('SF001','Dian Felita Tanoto','Female','085265442222','Palmerah Street no 56','15000000'
,'Top Stylist'),
('SF002','Melissa Pratiwi','Female','085755552011','Kebon Jerusk Street no 151','10000000'
,'Top Stylist'),
('SF003','Livia Ashianti','Female','085218542222','Kebon Jerusk Street no 19','7000000'
,'Stylist'),
('SF004','Indra Saswita','Male','085564223311','Sunter Street no 91','7000000','Stylist'),
('SF005','Ryan Nixon Salim','Male','085710255522','Kebon Jerusk Street no 123','3000000'
,'Stylist');

UPDATE MsStaff SET StaffPosition = 'Top Stylist', StaffSalary=StaffSalary+7000000
where StaffName LIKE 'Effendy Lesmana';

UPDATE MsCustomer,HeaderSalonServices
SET MsCustomer.CustomerName = LEFT(CustomerName, instr (CustomerName,' '))
WHERE DAY(TransactionDate)=24;

Update MsCustomer set CustomerName = concat('Ms. ',CustomerName)
WHERE CustomerId IN ('CU002','CU003');

#8
UPDATE MsCustomer,HeaderSalonServices
SET MsCustomer.CustomerAddress = ('Daan Mogot Baru Street No. 23') 
where MsCustomer.CustomerId = headersalonservices.customerid and
exists (select *from msstaff where MsStaff.StaffId = HeaderSalonServices.StaffId 
and dayname(transactiondate)= 'Thursday' AND StaffName = 'Indra Saswita');
 
 select *from mscustomer;
 select *from msstaff;
 select *from headersalonservices;
 
#9
insert into HeaderSalonServices values
('TR001','CU001','SF004','2012-12-20','Credit'),
('TR002','CU002','SF005','2012-12-20','Credit'),
('TR003','CU003','SF003','2012-12-20','Cash'),
('TR004','CU004','SF005','2012-12-20','Debit'),
('TR005','CU005','SF003','2012-12-21','Debit'),
('TR006','CU001','SF005','2012-12-21','Credit'),
('TR007','CU002','SF001','2012-12-22','Cash'),
('TR008','CU003','SF002','2012-12-22','Credit'),
('TR009','CU004','SF004','2012-12-22','Debit'),
('TR010','CU005','SF004','2012-12-23','Credit');

INSERT INTO MsTreatmentType VALUES	
('TT001', 'Hair Treatment'),
('TT002', 'Hair Spa Treatment'),
('TT003', 'Make Up and Facial'),
('TT004', 'Menicure Pedicure'),
('TT005', 'Premium Treatment');

DELETE HeaderSalonServices FROM HeaderSalonServices join
MsCustomer on HeaderSalonServices.CustomerId = MsCustomer.CustomerId where
instr (CustomerName,' ') = 0;
select *from headersalonservices;

INSERT INTO MsTreatment VALUES	
		('TM001', 'TT001', 'Cutting by Stylist','150000'),
		('TM002', 'TT001', 'Cutting by Top Stylist','450000'),
		('TM003', 'TT001', 'Cutting Pony','50000'),
		('TM004', 'TT001', 'Blow','90000'),
		('TM005', 'TT001', 'Coloring','480000'),
		('TM006', 'TT001', 'Highlight','320000'),
		('TM007', 'TT001', 'Japanese Perm','700000'),
		('TM008', 'TT001', 'Digital Perm','1100000'),
		('TM009', 'TT001', 'Special Perm','1100000'),
		('TM010', 'TT001', 'Rebonding Treatment','1100000'),
		('TM011', 'TT002', 'Creambath','150000'),
		('TM012', 'TT002', 'Hair Spa','250000'),
		('TM013', 'TT002', 'Hair Mask','250000'),
		('TM014', 'TT002', 'Hand Spa Reflexy','200000'),
		('TM015', 'TT002', 'Reflexy','250000'),
		('TM016', 'TT002', 'Back Therapy Massage','300000'),
		('TM017', 'TT003', 'Make Up','500000'),
		('TM018', 'TT003', 'Make Up Wedding','5000000'),
		('TM019', 'TT003', 'Facial','300000'),
		('TM020', 'TT004', 'Manicure','80000'),
		('TM021', 'TT004', 'Pedicure','100000'),
		('TM022', 'TT004', 'Nail Extension','250000'),
		('TM023', 'TT004', 'Nail Acrylic Infill','340000'),
		('TM024', 'TT005', 'Japanese Treatment','350000'),
		('TM025', 'TT005', 'Scalp Treatment','250000'),
		('TM026', 'TT005', 'Crystal Treatment','400000');
        
DELETE MsTreatment FROM MsTreatment JOIN MsTreatmentType 
ON (MsTreatmentType.TreatmentTypeId = MsTreatment.TreatmentTypeId) 
WHERE TreatmentTypeName NOT LIKE '%treatment%';
select *from mstreatment;


#1
select *from MsStaff where StaffGender = 'Female';

#2
select StaffName, concat('Rp. ',StaffSalary) as StaffSalary from MsStaff 
where StaffName like '%m%';
use lab_1;
#3
select TreatmentName, Price from MsTreatment join MsTreatmentType on 
MsTreatment.TreatmentTypeId = MsTreatmentType.TreatmentTypeId
where MsTreatmentType.TreatmentTypeName in('Hair Spa Treatment','Make Up and Facial');

#4
select StaffName, StaffPosition, date_format(TransactionDate, '%b %d. %Y') 
from MsStaff join HeaderSalonServices 
on MsStaff.StaffId = HeaderSalonServices.StaffId where StaffSalary 
between 7000000 and 10000000 ORDER BY TransactionDate ASC; 

#5
select LEFT(CustomerName,LOCATE(' ',CustomerName)), LEFT(CustomerGender,1),PaymentType from MsCustomer
join HeaderSalonServices on MsCustomer.CustomerId = HeaderSalonServices.CustomerId where
PaymentType = 'Debit'; 

#6
SELECT CONCAT(LEFT(CustomerName,1)) , dayname(TransactionDate)  FROM MsCustomer 
join HeaderSalonServices on MsCustomer.CustomerId = HeaderSalonServices.CustomerId where 
datediff(TransactionDate,"2012-12-24")<3 ORDER BY TransactionDate ASC;

use lab_1;

