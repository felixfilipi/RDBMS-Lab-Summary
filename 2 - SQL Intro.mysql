create database lec_lab;
use lec_lab;
create table SPESIALISASI(
Kode_Spesial char(5) primary key not null,
Spesialis varchar(25) not null);


create table DOKTER(
Id_Dokter char(5) Primary key not null,
Nama_Depan varchar(15) not null,
Nama_Belakang varchar(15),
Spesialis char(5),
Alamat varchar(50) not null,
No_Telp varchar(15),
Tarif numeric(10,2) not null,
foreign key (Spesialis) references SPESIALISASI(Kode_Spesial) on update cascade on delete
cascade
);


create table pasien(
Id_Pasien char(5) primary key not null,
Nama_Depan varchar(15) not null,
Nama_Belakang varchar(15),
Gender char(1) not null,
Alamat varchar(50),
No_Telepon varchar(15),
Umur int
);

create table resep(
Id_Resep char(10) primary key not null,
Pasien_Id char(5) not null,
Dokter_Id char(5) not null,
Tanggal date not null,
Harga numeric(10,2),
foreign key(Pasien_Id) references pasien(ID_Pasien) on update cascade on delete cascade,
foreign key(Dokter_Id) references dokter(Id_Dokter) on update cascade on delete cascade
);

create table kategori_obat(
Id_Kategori char(5) not null primary key,
kategori varchar(20) not null);


create table obat(
Id_Obat char(5) primary key not null,
Nama_Obat varchar(25) not null,
Harga_Satuan numeric(10,2) not null,
Kategori char(5),
foreign key (kategori) references kategori_obat(Id_Kategori) 
on update cascade on delete cascade
);


create table Detail_obat(
Id_Obat char(5) not null,
Id_Resep char(10) not null,
Jumlah int not null,
primary key (Id_Obat,Id_Resep),
foreign key(Id_Obat) references obat(Id_Obat) on update cascade on delete cascade,
foreign key(Id_Resep) references resep(Id_Resep) on update cascade on delete cascade
);

desc detail_obat;

insert into spesialisasi value ('SP001', 'Jantung'),('SP006','Bedah'),('SP005','Saraf'),
('SP007','Mata'),('SP008','Anak');



insert into dokter value 
('DR001', 'Syaiful', 'Anwar', 'SP001' ,'Jakarta Pusat','+6281111222','150000'),
('DR003', 'Edi', 'Harto', 'SP006', 'Bogor', '+6221211321', '200000'),
('DR004', 'Andrea', 'Dian', 'SP008', 'Depok', '+6288899988', '100000'),
('DR011', 'Dewi', NULL,'SP006', 'Bekasi', '+6212332111', '120000'),
('DR009', 'Muhammad', 'Ridwan', 'SP001', 'Depok', '+625656565', '120000'),
('DR012', 'Agung','Pribadi', 'SP005' ,'Jakarta Pusat','+624545111','180000'),
('DR007', 'James', 'Bon', 'SP007', 'Bekasi', '+620000007', '230000'),
('DR010', 'Ida','Nurhaida', 'SP008', 'Bogor', '+621921211', '70000');

insert into pasien value
('P0001', 'Ubet',NULL, 'L','Bandung', '+6282222123', '21'), 
('P0003', 'Juju','Jubaidah', 'P', 'Cimahi',NULL, '70'),
('P0002', 'Bon', 'Kurei', 'L', 'Bogor',NULL,'45'),
('P0005', 'Arya', 'Stak', 'P', 'Jakarta','+628989898','6'),
('P0008', 'Mario', 'Bolateli', 'L','Depok','+627117213','21'),
('P0009', 'Jamal', 'Widodo', 'L','Bekasi','+622167809','55'),
('P0010', 'Kiara',NULL,'P','Bogor',NULL, '4'),
('P0011', 'Bondan', 'Prakosa', 'L', 'Jakarta', '+6200101011', '21'),
('P0013', 'Gatot', 'Kaca', 'L', 'Solo',NULL, '45'),
('P0014', 'Pipit',NULL, 'P',NUll, '+6233333333', '23');


insert into RESEP value
('R250115001' ,'P0001' ,'DR011' ,'2015-01-25',NULL),
('R250115002', 'P0009', 'DR001', '2015-01-25',NULL),
('R260115001' ,'P0008' ,'DR007' ,'2015-01-26',NULL),
('R270115001', 'P0014', 'DR003', '2015-01-27',NULL),
('R300115001', 'P0010', 'DR010', '2015-01-30',NULL),
('R300115002', 'P0013', 'DR003', '2015-01-30',NULL),
('R010215001', 'P0009', 'DR001', '2015-02-01',NULL),
('R010215002', 'P0003', 'DR009', '2015-02-01',NULL),
('R010215003', 'P0010', 'DR010', '2015-02-01',NULL),
('R020215001', 'P0005', 'DR004', '2015-02-02',NULL),
('R020215002', 'P0009', 'DR001', '2015-02-02',NULL),
('R020215003', 'P0014', 'DR012', '2015-02-02',NULL),
('R030215001', 'P0005', 'DR004', '2015-02-03',NULL),
('R030215002', 'P0003', 'DR009', '2015-02-03',NULL);



insert into detail_obat value
('OB013', 'R250115001', '1'),('OB002', 'R250115002', '5'),('OB003', 'R250115002', '2'),
('OB012', 'R270115001', '1'),('OB015', 'R300115001', '1'),('OB002', 'R010215001', '5'),
('OB001', 'R010215002', '2'),('OB002', 'R010215002' ,'4'),('OB014', 'R010215003', '1'),
('OB016', 'R020215001', '2'),('OB002', 'R020215002', '3'),('OB003', 'R020215002', '1'),
('OB007', 'R020215003', '4'),('OB008', 'R020215003', '6'),('OB016', 'R030215001', '1'),
('OB003', 'R030215002', '2'),('OB004', 'R030215002', '4');

set foreign_key_checks=1;

insert into kategori_obat value
('OK001', 'Jantung'),
('OK002', 'Saraf'),
('OK003', 'Infus'),
('OK004', 'Nutrisi'),
('OK005', 'Mata');


insert into obat value
('OB001', 'Akrinor Tablet', '65000', 'OK001'),('OB002', 'Cardiject Vial', '7800', 'OK001'),
('OB003', 'Fargoxin Injeksi', '21000', 'OK001'),('OB004', 'Kendaron Ampul', '20000', 'OK001'),
('OB005', 'Tiaryt Tablet', '16000', 'OK001'),('OB006', 'Exelon Capsule 3 Mg', '70000', 'OK002'),
('OB007', 'Fordesia Tablet', '79000', 'OK002'),('OB008', 'Reminyl Tablet 4 Mg', '33000', 'OK002'),
('OB009', 'Albucid Tetes Mata', '15000', 'OK005'),('OB010', 'Cendo Fenicol Salep Mata', '20000', 'OK005'),
('OB011', 'Interflox Tetes Mata', '36000', 'OK005'),('OB012', 'Haemaccel Infus', '200000', 'OK003'),
('OB013', 'Human Albumin Infus', '900000', 'OK003'),('OB014', 'Curfos Syrup', '74000', 'OK004'),
('OB015', 'Vitacur Syrup', '36000', 'OK004'),('OB016', 'Cerebrovit Active', '133000', 'OK004');
select *from obat;
#1
select nama_obat, harga_satuan,kategori_obat.kategori from obat,kategori_obat where 
obat.kategori = kategori_obat.id_kategori and harga_satuan < 50000;

#2
select id_pasien, concat(nama_depan,' ',nama_belakang) as nama_pasien
,gender,alamat,Umur from pasien where concat(nama_depan,nama_belakang) like '%o%';

#3
select concat(pasien.nama_depan,' ',pasien.nama_belakang) as nama_pasien, umur, 
concat(dokter.nama_depan,' ',dokter.nama_belakang) as dokter
from pasien,dokter,resep,spesialisasi where pasien.id_pasien = resep.pasien_id
and resep.dokter_id = dokter.id_dokter and dokter.spesialis = spesialisasi.kode_spesial
and SPESIALISASI.Spesialis='Jantung' group by nama_pasien;

#4
select resep.id_resep,tanggal from resep,detail_obat,obat where 
detail_obat.Id_resep = resep.id_resep and detail_obat.id_obat = obat.id_obat and
Nama_obat = 'Cardiject Vial' order by tanggal asc ;

#5
select obat.id_obat,nama_obat from obat, detail_obat where
obat.id_obat=detail_obat.id_obat
and detail_obat.jumlah>2 group by id_obat;
