use lab_1;
set sql_mode = 'PIPES_AS_CONCAT';

#1
SELECT TreatmentTypeName, TreatmentName, Price FROM MsTreatment
JOIN  MsTreatmentType ON MsTreatment.TreatmentTypeId = MsTreatmentType.TreatmentTypeId
WHERE (TreatmentTypeName LIKE '%hair%' OR TreatmentTypeName 
LIKE '%menicure%') AND MsTreatment.Price < 100000;

#2
select distinct StaffName, lower(left(StaffName,1))|| 
lower(reverse(substr(reverse(StaffName), 1, LOCATE(' ',reverse(StaffName))-1)))||
'@oosalon.com'as StaffEmail from HeaderSalonServices join MsStaff on
HeaderSalonServices.StaffId = MsStaff.StaffId and dayname(TransactionDate)='Thursday';

#3
select replace(TransactionId,'TR','Trans') as 'New Transaction Id', TransactionId 
as 'Old Transaction Id', TransactionDate, StaffName, CustomerName from 
HeaderSalonServices join MsStaff on MsStaff.StaffId=HeaderSalonServices.StaffId join
MsCustomer on HeaderSalonServices.CustomerId=MsCustomer.CustomerId 
and datediff('2012-12-24',TransactionDate) = 2;

#4
select DATE_ADD(TransactionDate, INTERVAL 5 DAY) as 'New Transaction Date',
TransactionDate as 'Old Transaction Date', CustomerName from HeaderSalonServices 
join MsCustomer on HeaderSalonServices.CustomerId=MsCustomer.CustomerId 
and day(TransactionDate)!=20;

#5
select dayname(TransactionDate) as 'Day', CustomerName, TreatmentName 
from HeaderSalonServices join MsCustomer on 
HeaderSalonservices.CustomerId = MsCustomer.CustomerId join MsStaff 
on HeaderSalonServices.StaffId = MsStaff.StaffId join DetailSalonServices 
on HeaderSalonServices.TransactionId = DetailSalonServices.TransactionId join MsTreatment 
on DetailSalonServices.TreatmentId = MsTreatment.TreatmentId 
where StaffGender like 'female'and StaffPosition like 'TOP%' order by CustomerName asc;

#6
select MsCustomer.CustomerId, CustomerName, HeaderSalonServices.TransactionId, 
count(DetailSalonServices.TreatmentId) as TotalTreatment from MsCustomer join
HeaderSalonServices on HeaderSalonServices.CustomerId = MsCustomer.CustomerId join
DetailSalonServices on HeaderSalonServices.TransactionId = DetailSalonServices.TransactionId
group by MsCustomer.CustomerId, MsCustomer.CustomerName, HeaderSalonServices.TransactionId
order by count(DetailSalonServices.TreatmentId) desc;

#7
select MsCustomer.CustomerId, HeaderSalonServices.TransactionId, MsCustomer.CustomerName, 
sum(MsTreatment.price) as 'Total Price' from HeaderSalonServices
join MsCustomer on (MsCustomer.CustomerId = HeaderSalonServices.CustomerId) 
join DetailSalonServices on (DetailSalonServices.TransactionId = HeaderSalonServices.
TransactionId)join MsTreatment on (DetailSalonServices.TreatmentId = MsTreatment.TreatmentId)
group by MsCustomer.CustomerId, HeaderSalonServices.TransactionId
having sum(MsTreatment.price) > (SELECT AVG(total) as average 
FROM (SELECT SUM(Price) as total FROM MsTreatment
JOIN DetailSalonServices ON DetailSalonServices.TreatmentId = MsTreatment.TreatmentId
JOIN HeaderSalonServices ON DetailSalonServices.TransactionId = HeaderSalonServices.
TransactionId GROUP BY DetailSalonServices.TransactionId) as total) order by sum(price) desc;

#7
select MsCustomer.CustomerId, HeaderSalonServices.TransactionId, MsCustomer.CustomerName, 
sum(MsTreatment.price) as 'Total Price' 
from HeaderSalonServices
join MsCustomer on (MsCustomer.CustomerId = HeaderSalonServices.CustomerId) 
join DetailSalonServices on (DetailSalonServices.TransactionId = HeaderSalonServices.TransactionId)
join MsTreatment on (DetailSalonServices.TreatmentId = MsTreatment.TreatmentId)
group by MsCustomer.CustomerId, HeaderSalonServices.TransactionId
having sum(MsTreatment.price) >  
(select sum(alias.average) from (select avg(price) as average from MsTreatment) as alias)
order by sum(MsTreatment.price) desc;

#8
select 'Mr. '||StaffName as Name, StaffPosition,StaffSalary from MsStaff where
StaffGender='male' union select 'Ms. '||StaffName as Name, StaffPosition,StaffSalary 
from MsStaff where StaffGender ='female' order by name, staffposition asc;

#9
select TreatmentName, 'Rp. '||cast(Price as char) as Price,'Minimum Price' as 'Status' 
from (select min(price) as minimum from MsTreatment) as minim,MsTreatment 
where price = minimum union select TreatmentName, 'Rp. ' || cast(Price as char) as Price, 
'Maximum Price' as 'Status' from (select max(price) as maximum 
from MsTreatment) as maks, MsTreatment where price = maximum;

#10
select CustomerName as 'Longest Name of Staff and Customer',length(CustomerName) 
as 'Length of Name','Customer' as 'Status' from (select max(length(CustomerName)) as maxcus
from MsCustomer)as maxcustomer,MsCustomer where length(CustomerName)=maxcus
union select StaffName as 'Longest Name of Staff and Customer',length(StaffName) as
'Length of Name','Staff' as 'Status' from MsStaff,(select max(length(StaffName)) as maxstaf 
from MsStaff) as maxstaff where length(StaffName)=maxstaf;

#modul 7
#1
select TreatmentId, TreatmentName from MsTreatment where TreatmentId in ('TM001','TM002');

#2
select TreatmentName, Price from MsTreatment
where MsTreatment.TreatmentTypeId in (select MsTreatmentType.TreatmentTypeId 
from MsTreatmentType where TreatmentTypeName not in ('Hair Treatment','Hair Spa Treatment'));

#3
select CustomerName, CustomerPhone, CustomerAddress from mscustomer,HeaderSalonServices 
where MsCustomer.CustomerId = HeaderSalonServices.CustomerId and
length(CustomerName)>8 and dayname(TransactionDate)in ('Friday');

#4
insert into DetailSalonServices values ('TR009','TM005');
select TreatmentTypeName, TreatmentName,Price from 
MsCustomer,MsTreatment,MsTreatmentType,DetailSalonServices,HeaderSalonServices where
MsTreatment.TreatmentTypeId = MsTreatmentType.TreatmentTypeId and
MsTreatment.TreatmentId = DetailSalonServices.TreatmentId and
DetailSalonServices.TransactionId = HeaderSalonServices.TransactionId and
HeaderSalonServices.CustomerId = MsCustomer.CustomerId and
MsCustomer.CustomerName in (select CustomerName from MsCustomer where 
CustomerName like '%Putra%') and day(TransactionDate)=25;

#5
select StaffName, CustomerName, date_format(TransactionDate, "%b %d, %Y") as TransactionDate,
TreatmentId from MsStaff,MsCustomer, HeaderSalonServices, DetailSalonServices
where exists(select MsTreatment.TreatmentId from MsTreatment where 
DetailSalonServices.TreatmentId =  MsTreatment.TreatmentId and
MsStaff.StaffId = HeaderSalonServices.StaffId
and MsCustomer.CustomerId = HeaderSalonServices.CustomerId and
HeaderSalonServices.TransactionId = DetailSalonServices.TransactionId and
convert(right(MsTreatment.TreatmentId,1),unsigned)%2=0);

#6
select CustomerName,CustomerPhone,CustomerAddress from MsCustomer
where exists(select StaffName from MsStaff,HeaderSalonServices where 
MsCustomer.CustomerId=HeaderSalonServices.CustomerId and 
HeaderSalonServices.StaffId = MsStaff.StaffId and length(StaffName)%2=1);

#7
select right(StaffId,3) as ID, 
substring(substring(StaffName, instr(StaffName, ' '),length(StaffName)),1,
instr(substring(StaffName,instr(StaffName,' ')+1,length(StaffName)),' ')) as Name
from MsStaff where length(StaffName) - length(replace(StaffName,' ','')) = 2 
and exists (select CustomerGender from MsCustomer,
HeaderSalonServices where MsCustomer.CustomerId = HeaderSalonServices.CustomerId and 
CustomerGender not like "Male"); 

#8
select TreatmentTypeName, TreatmentName,Price from(select avg(price) as average from
MsTreatment) as avrg, MsTreatmentType, MsTreatment  
where MsTreatment.TreatmentTypeId = MsTreatmentType.TreatmentTypeId and price>average;

#9
select StaffName, StaffPosition, StaffSalary from(select max(StaffSalary) as maximum
, min(StaffSalary) as minimum from MsStaff) as Staff ,MsStaff where StaffSalary = maximum
or StaffSalary = minimum;

#10
select CustomerName, CustomerPhone, CustomerAddress, count(MsTreatment.TreatmentId) as 
'Count Treatment' from(select max(Semua) as maximum from(select count(MsTreatment.TreatmentId) 
as semua from MsCustomer,HeaderSalonServices, DetailSalonServices, MsTreatment where 
MsCustomer.CustomerId = HeaderSalonServices.CustomerId and 
HeaderSalonServices.TransactionId = DetailSalonServices.TransactionId and
DetailSalonServices.TreatmentId = MsTreatment.TreatmentId 
group by MsCustomer.CustomerName, MsCustomer.CustomerPhone, MsCustomer.CustomerAddress) 
as semua)as maximum, MsCustomer,MsTreatment,DetailSalonServices,HeaderSalonServices where
MsCustomer.CustomerId = HeaderSalonServices.CustomerId and 
HeaderSalonServices.TransactionId = DetailSalonServices.TransactionId and
DetailSalonServices.TreatmentId = MsTreatment.TreatmentId group by
MsCustomer.CustomerName, MsCustomer.CustomerPhone, MsCustomer.CustomerAddress,maximum 
having count(DetailSalonServices.TreatmentId) = maximum;

select *from mscustomer;
select *from mstreatment;
select *from mstreatmenttype;
select *from detailsalonservices;
select *from headersalonservices;
select *from msstaff;

#lab8
#1
create view ViewBonus As
	select replace(CustomerId,'CU','BN') as BinusId,CustomerName from MsCustomer 
    where length(CustomerName)>10;
select *from ViewBonus;

#2
create view ViewCustomerData As
	select substr(CustomerName,1,instr(CustomerName,' ')) as Name, 
	CustomerAddress, CustomerPhone from MsCustomer where CustomerName like '% %';  
select *from ViewCustomerData;

#3
create view ViewTreatment As
	select TreatmentName, TreatmentTypeName,'Rp. '|| Price as Price from MsTreatment,
    MsTreatmentType where MsTreatmentType.TreatmentTypeId = MsTreatment.TreatmentTypeId
	and price between 450000 and 800000
    and TreatmentTypeName = 'Hair Treatment';
select *from ViewTreatment;

#4
create view ViewTransaction As
	select StaffName,CustomerName, 
    date_format(TransactionDate, "%d %b %Y") as TransactionDate, 
	PaymentType from MsStaff,MsCustomer,HeaderSalonServices where 
	MsStaff.StaffId = HeaderSalonServices.StaffId and
	MsCustomer.CustomerId=HeaderSalonServices.CustomerId and
	Day(TransactionDate) between 21 and 25
	and PaymentType = 'Credit';
select *from ViewTransaction;

#5
create view ViewBonusCustomer As
	select Replace(MsCustomer.CustomerId,'CU','BN') as BonusID, 
	lower(substr(CustomerName,instr(CustomerName,' '),length(CustomerName))) as Name,
	dayname(TransactionDate) as 'Day', 
	date_format(TransactionDate, "%m/%d/%Y") as TransactionDate from MsCustomer,
	HeaderSalonServices,MsStaff where MsCustomer.CustomerId = HeaderSalonServices.CustomerId
	and MsStaff.StaffId = HeaderSalonServices.StaffId
	and CustomerName like "% %" and right(StaffName,instr(StaffName,' ')) like "%a%";
select *from ViewBonusCustomer;

#6
create view ViewTransactionByLivia As
	select HeaderSalonServices.TransactionId,date_format(TransactionDate, "%b %d, %Y") 
	as 'Date', TreatmentName 
	from HeaderSalonServices, MsTreatment, DetailSalonServices, MsStaff where 
	HeaderSalonServices.TransactionId = DetailSalonServices.TransactionId and
	DetailSalonServices.TreatmentId = MsTreatment.TreatmentId and
	HeaderSalonServices.StaffId = MsStaff.StaffId and
	Day(TransactionDate) = 21 and StaffName like 'Livia Ashianti';
select *from ViewTransactionByLivia; 


#7
alter view ViewCustomerData as
	select right(CustomerId,3) as ID, CustomerName as 'Name', CustomerAddress as 'Address',
	CustomerPhone as 'Phone' from MsCustomer
	where CustomerName like "% %";
select *from ViewCustomerData;

#8
create view ViewCustomer as
	select CustomerId, CustomerName, CustomerGender from MsCustomer;
select *from ViewCustomer;

insert into ViewCustomer (CustomerId, CustomerName, CustomerGender) 
values ('CU006','Cristian','Male');
select *from MsCustomer;

#9
delete from ViewCustomerData where ID='005';

#10
drop view ViewCustomerData;
select *from Viewcustomerdata;

#lab 9
#1
create procedure sp1(in choice varchar(5))
select CustomerId, CustomerName, CustomerGender, CustomerAddress from  MsCustomer
where CustomerId = choice;

call sp1('CU001');

#2
Delimiter $$
Create procedure sp2(in input varchar(50))
Begin
	if (select (length(CustomerName) % 2 = 1) from MsCustomer where input=CustomerName) then 
	select 'Character Length of Mentor Name is an Odd Number';
	else select MsCustomer.CustomerId,  MsCustomer.CustomerName, MsCustomer.CustomerGender, 
    HeaderSalonServices.TransactionId, HeaderSalonServices.TransactionDate 
	from MsCustomer,HeaderSalonServices where MsCustomer.CustomerName like 
    '%'||input||'%' and MsCustomer.CustomerId = HeaderSalonServices.CustomerId;
 	End if;
End $$
delimiter ;

drop procedure sp2;
call sp2('Elysia Chen');
select *from headersalonservices;
select *from mscustomer;

#3
Delimiter $$
Create procedure sp3(in InputId char(5),InputName varchar(50),
InputGender varchar(5), InputPhone varchar(13))
Begin
if exists(select * from MsStaff Where InputId = StaffId)
then update MsStaff
set StaffName = InputName, StaffGender = InputGender, StaffPhone = InputPhone 
where InputId = StaffId;
else select 'Staff does not exists';
end if;END $$
Delimiter ;
call sp3('SF008', 'Ryan Nixon', 'Male', '08567756123');

drop procedure sp3;
select *from msstaff;
show procedure status;

#4
Delimiter $$
Create Trigger trig1 
after update on MsCustomer for each row 
begin
CREATE TEMPORARY TABLE temp(
    customerid char(5),
    customername varchar(50),
    customergender varchar(50),
    customerphone varchar(50),
    customeraddress varchar(50)
);

insert into temp values (old.customerid,old.customername,old.customergender,old.customerphone
,old.customeraddress),(new.customerid,new.customername,new.customergender,new.customerphone
,new.customeraddress);
    end $$
Delimiter ;

Update MsCustomer SET CustomerName = 'Franky Quo' WHERE CustomerId = 'CU001';
drop trigger trig1;
select *from temp;


#5
Delimiter $$
Create Trigger trig2 
after insert on MsCustomer for each row 
begin
    delete from mscustomer
	where customerid in 
	(select customerid
	from mscustomer
	) limit 1;
end $$
Delimiter ;

insert into mscustomer values('CU006','Yogie Soesanto','Male','085562133000',
'Pelaskih Street no 52');

#6
delimiter $$
create trigger trig3
before delete on MsCustomer for each row 
begin 
    create temporary table temp1(
    customerid char(5),
    customername varchar(50),
    customergender varchar(50),
    customerphone varchar(50),
    customeraddress varchar(50)
    );
	insert into temp1 values
	(old.customerid, old.customername, old.customergender, old.customerphone, 
    old.customeraddress);
end $$
delimiter ;

delete from mscustomer where customerid = 'CU002';
select *from temp1;

#7
DELIMITER $$
CREATE PROCEDURE cur1 ()
begin
declare titles text default 'The length from Staffname';

	cur_msname cursor
		for select msstaff.staffname 
		from msstaff;
begin
	open cur_msname;
	loop
		fetch cur_msname into rec_oddeven;
		exit when not found;
	
		if length(rec_oddeven.staffname) % 2 = 0 then
			raise notice '% % is odd number',titles,rec_oddeven.staffname;
		else
			raise notice '% % is even number',titles,rec_oddeven.staffname;
		end if;
	end loop;
	close cur_msname;
	return staffname;
end$$
delimiter ;


select cur1();



