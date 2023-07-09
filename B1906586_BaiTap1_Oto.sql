-- Le Thai Giao Tien B1906586 --

drop table HangXe CASCADE CONSTRAINTS;
drop table DongCo CASCADE CONSTRAINTS;
drop table DongXe CASCADE CONSTRAINTS;
drop table PhienBan CASCADE CONSTRAINTS;
drop table PhanKhucXe CASCADE CONSTRAINTS;
drop table DamPhan CASCADE CONSTRAINTS;
drop table Xe CASCADE CONSTRAINTS;
drop table ThongSoKyThuat CASCADE CONSTRAINTS;
drop table NoiLanBanh CASCADE CONSTRAINTS;
drop table GiaLanBanh CASCADE CONSTRAINTS;
-- Hang Xe
create table HangXe(
	HX_Ma char(7) NOT NULL check (regexp_like (HX_Ma, 'HX\d{5}')),
	HX_Ten varchar(100) NOT NULL,
	PRIMARY KEY (HX_Ma)
);
-- Dong Co
create table DongCo(
	DC_Ma char(7) NOT NULL check (regexp_like (DC_Ma, 'DC\d{5}')),
	HX_Ma char(7),
	DC_Ten varchar(200) NOT NULL,
	PRIMARY KEY (DC_Ma),
	CONSTRAINT FK_DC_HX FOREIGN KEY (HX_Ma) REFERENCES HangXe(HX_Ma)
);
-- Dong Xe
create table DongXe(
	DX_Ma char(7) NOT NULL check (regexp_like (DX_Ma, 'DX\d{5}')),
	HX_Ma char(7),
	DX_Ten varchar(200) NOT NULL,
	PRIMARY KEY (DX_Ma),
	CONSTRAINT FK_DX_HX FOREIGN KEY (HX_Ma) REFERENCES HangXe(HX_Ma)
);
-- Phien Ban
create table PhienBan(
	PB_Ma char(7) NOT NULL check (regexp_like (PB_Ma, 'PB\d{5}')),
	DX_Ma char(7),
	PB_Ten varchar(100) NOT NULL,
	PRIMARY KEY (PB_Ma),
	CONSTRAINT FK_PB_HX FOREIGN KEY (DX_Ma) REFERENCES DongXe(DX_Ma)
);
-- Phan Khuc Xe
create table PhanKhucXe(
	PKX_Ma char(7) NOT NULL check (regexp_like (PKX_Ma, 'PKX\d{4}')),
	PKX_Ten varchar(100) NOT NULL,
	PRIMARY KEY (PKX_Ma)
);

-- Dam Phan
create table DamPhan(
	DP_Ma char(7) NOT NULL check (regexp_like (DP_Ma, 'DP\d{5}')),
	DP_Ten varchar(300),
	PRIMARY KEY (DP_Ma)
);

ALTER TABLE DamPhan
    ADD DP_GiaTri float(15);
    
ALTER TABLE DamPhan
    MODIFY DP_GiaTri float(15) DEFAULT 0;
Select * from DamPhan;
-- Xe
create table Xe(
	X_Ma char(7) NOT NULL check (regexp_like (X_Ma, 'X\d{6}')),
	PB_Ma char(7),
	PKX_Ma char(7),
	DC_Ma char(7),
	DP_Ma char(7),
	X_GiaNiemYet float(20) NOT NULL CHECK (X_GiaNiemYet > 0),
	PRIMARY KEY (X_Ma),
	CONSTRAINT FK1_X_PB FOREIGN KEY (PB_Ma) REFERENCES PhienBan(PB_Ma),
	CONSTRAINT FK2_X_PKX FOREIGN KEY (PKX_Ma) REFERENCES PhanKhucXe(PKX_Ma),
	CONSTRAINT FK3_X_DC FOREIGN KEY (DC_Ma) REFERENCES DongCo(DC_Ma),
	CONSTRAINT FK4_X_DP FOREIGN KEY (DP_Ma) REFERENCES DamPhan(DP_Ma)
);
ALTER TABLE Xe
    MODIFY DP_Ma char(7) DEFAULT 'DP00000';
commit;
-- Thong So Ky Thuat
create table ThongSoKyThuat(
	TSKT_Ma char(7) NOT NULL check (regexp_like (TSKT_Ma, 'TSKT\d{3}')),
	X_Ma char(7),
	TSKT_CongSuat varchar(50),
	TSKT_MomenXoan varchar(200),
	TSKT_HopSo varchar(50),
	TSKT_HeDanDong varchar(50),
	TSKT_SoCho int NOT NULL CHECK (TSKT_SoCho > 0),
	PRIMARY KEY (TSKT_Ma),
	CONSTRAINT FK_TSKT_X FOREIGN KEY (X_Ma) REFERENCES Xe(X_Ma)
);--ALTER TABLE ThongSoKyThuat MODIFY TSKT_MomenXoan varchar(200);

-- Noi Lan Banh
create table NoiLanBanh(
	NLB_Ma char(7) NOT NULL check (regexp_like (NLB_Ma, 'NLB\d{4}')),
	NLB_Ten varchar(100) NOT NULL,
	PRIMARY KEY (NLB_Ma)
);
ALTER TABLE NoiLanBanh
    ADD NLB_GiaTri float(15); -- chi so % nhan voi gia niem yet
select * from NoiLanBanh;
-- Gia Lan Banh
create table GiaLanBanh(
	GLB_Ma char(7) NOT NULL check (regexp_like (GLB_Ma, 'GLB\d{4}')),
	X_Ma char(7),
	NLB_Ma char(7),
	GLB_PhiTruocBa float(20) DEFAULT NULL,
	GLB_PhiSDDuongBo float(20) DEFAULT 1560000,
	GLB_BaoHiem float(20) DEFAULT 437000,
	GLB_PhiDKBienSo float(20) DEFAULT 20000000,
	GLB_PhiDangKiem float(20) DEFAULT 340000,
	GLB_TongCong float(20) DEFAULT NULL,
	CONSTRAINT PK_GLB PRIMARY KEY(GLB_Ma, X_Ma, NLB_Ma),
    CONSTRAINT FK1_GLB_X FOREIGN KEY (X_Ma) REFERENCES Xe(X_Ma),
	CONSTRAINT FK2_GLB_NLB FOREIGN KEY (NLB_Ma) REFERENCES NoiLanBanh(NLB_Ma)
);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Hang Xe
INSERT INTO HangXe (HX_Ma, HX_Ten) VALUES ('HX00001', 'Aston Martin');
INSERT INTO HangXe (HX_Ma, HX_Ten) VALUES ('HX00002', 'Audi');
INSERT INTO HangXe (HX_Ma, HX_Ten) VALUES ('HX00003', 'Bentley');
INSERT INTO HangXe (HX_Ma, HX_Ten) VALUES ('HX00004', 'BMW');
INSERT INTO HangXe (HX_Ma, HX_Ten) VALUES ('HX00005', 'Ford');
INSERT INTO HangXe (HX_Ma, HX_Ten) VALUES ('HX00006', 'Honda');
INSERT INTO HangXe (HX_Ma, HX_Ten) VALUES ('HX00007', 'Hyundai');
INSERT INTO HangXe (HX_Ma, HX_Ten) VALUES ('HX00008', 'Isuzu');
INSERT INTO HangXe (HX_Ma, HX_Ten) VALUES ('HX00009', 'Jaguar');
INSERT INTO HangXe (HX_Ma, HX_Ten) VALUES ('HX00010', 'Jeep');
INSERT INTO HangXe (HX_Ma, HX_Ten) VALUES ('HX00011', 'Kia');
INSERT INTO HangXe (HX_Ma, HX_Ten) VALUES ('HX00012', 'Land Rover');
INSERT INTO HangXe (HX_Ma, HX_Ten) VALUES ('HX00013', 'Lexus');
INSERT INTO HangXe (HX_Ma, HX_Ten) VALUES ('HX00014', 'Maserati');
INSERT INTO HangXe (HX_Ma, HX_Ten) VALUES ('HX00015', 'Mazda');
INSERT INTO HangXe (HX_Ma, HX_Ten) VALUES ('HX00016', 'Mercedes');
INSERT INTO HangXe (HX_Ma, HX_Ten) VALUES ('HX00017', 'MG');
INSERT INTO HangXe (HX_Ma, HX_Ten) VALUES ('HX00018', 'Mini');
INSERT INTO HangXe (HX_Ma, HX_Ten) VALUES ('HX00019', 'Mitsubishi');
INSERT INTO HangXe (HX_Ma, HX_Ten) VALUES ('HX00020', 'Nissan');
INSERT INTO HangXe (HX_Ma, HX_Ten) VALUES ('HX00021', 'Peugeot');
INSERT INTO HangXe (HX_Ma, HX_Ten) VALUES ('HX00022', 'Porsche');
INSERT INTO HangXe (HX_Ma, HX_Ten) VALUES ('HX00023', 'Ram');
INSERT INTO HangXe (HX_Ma, HX_Ten) VALUES ('HX00024', 'Subaru');
INSERT INTO HangXe (HX_Ma, HX_Ten) VALUES ('HX00025', 'Suzuki');
INSERT INTO HangXe (HX_Ma, HX_Ten) VALUES ('HX00026', 'Toyota');
INSERT INTO HangXe (HX_Ma, HX_Ten) VALUES ('HX00027', 'Vinfast');
INSERT INTO HangXe (HX_Ma, HX_Ten) VALUES ('HX00028', 'Volkswagen');
INSERT INTO HangXe (HX_Ma, HX_Ten) VALUES ('HX00029', 'Volvo');
commit;
select * from HangXe;
---------------------------------------------------------------------------------------------------------------------------------------
-- Dong Co
INSERT INTO DongCo (DC_Ma, HX_Ma, DC_Ten) VALUES ('DC00001', 'HX00002', 'TFSI 2.0 Mild-hybrid 12V');
INSERT INTO DongCo (DC_Ma, HX_Ma, DC_Ten) VALUES ('DC00002', 'HX00002', 'TFSI 3.0 Mild-hybrid 48V');
INSERT INTO DongCo (DC_Ma, HX_Ma, DC_Ten) VALUES ('DC00003', 'HX00003', '4.0 Twin-turbocharged V8 TSI');
INSERT INTO DongCo (DC_Ma, HX_Ma, DC_Ten) VALUES ('DC00004', 'HX00003', '4.0 V8');
INSERT INTO DongCo (DC_Ma, HX_Ma, DC_Ten) VALUES ('DC00005', 'HX00018', 'I4, TwinPower Turbo');
INSERT INTO DongCo (DC_Ma, HX_Ma, DC_Ten) VALUES ('DC00006', 'HX00018', 'Xang, I4, TwinPower Turbo');
INSERT INTO DongCo (DC_Ma, HX_Ma, DC_Ten) VALUES ('DC00007', 'HX00022', 'Boxer H-4 Tang ap');
INSERT INTO DongCo (DC_Ma, HX_Ma, DC_Ten) VALUES ('DC00008', 'HX00022', 'Boxer H-6, twin-turbo');
INSERT INTO DongCo (DC_Ma, HX_Ma, DC_Ten) VALUES ('DC00009', 'HX00027', 'Xang 1.4, 4 xi lanh thang hang');
INSERT INTO DongCo (DC_Ma, HX_Ma, DC_Ten) VALUES ('DC00010', 'HX00027', 'I-4, DOHC, tang ap, van bien thien');
commit;
select * from DongCo;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Dong Xe
INSERT INTO DongXe (DX_Ma, HX_Ma, DX_Ten) VALUES ('DX00001', 'HX00002', 'A4 2021');
INSERT INTO DongXe (DX_Ma, HX_Ma, DX_Ten) VALUES ('DX00002', 'HX00002', 'A6 2021');
INSERT INTO DongXe (DX_Ma, HX_Ma, DX_Ten) VALUES ('DX00003', 'HX00002', 'A7 2021');
INSERT INTO DongXe (DX_Ma, HX_Ma, DX_Ten) VALUES ('DX00004', 'HX00003', 'Flying Spur 2021');
INSERT INTO DongXe (DX_Ma, HX_Ma, DX_Ten) VALUES ('DX00005', 'HX00003', 'Continental 2021');
INSERT INTO DongXe (DX_Ma, HX_Ma, DX_Ten) VALUES ('DX00006', 'HX00018', '3 Door 2021');
INSERT INTO DongXe (DX_Ma, HX_Ma, DX_Ten) VALUES ('DX00007', 'HX00018', '5 Door 2021');
INSERT INTO DongXe (DX_Ma, HX_Ma, DX_Ten) VALUES ('DX00008', 'HX00022', '718 2021');
INSERT INTO DongXe (DX_Ma, HX_Ma, DX_Ten) VALUES ('DX00009', 'HX00022', '911 2021');
INSERT INTO DongXe (DX_Ma, HX_Ma, DX_Ten) VALUES ('DX00010', 'HX00027', 'Fadil 2021');
INSERT INTO DongXe (DX_Ma, HX_Ma, DX_Ten) VALUES ('DX00011', 'HX00027', 'Lux A2.0 2021');
commit;
select * from DongXe;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Phien Ban
INSERT INTO PhienBan (PB_Ma, DX_Ma, PB_Ten) VALUES ('PB00001', 'DX00001', '45 TFSI quattro');
INSERT INTO PhienBan (PB_Ma, DX_Ma, PB_Ten) VALUES ('PB00002', 'DX00001', '40 TFSI Advanced Plus');
INSERT INTO PhienBan (PB_Ma, DX_Ma, PB_Ten) VALUES ('PB00003', 'DX00001', '40 TFSI Advanced');
INSERT INTO PhienBan (PB_Ma, DX_Ma, PB_Ten) VALUES ('PB00004', 'DX00002', '45 TFSI');
INSERT INTO PhienBan (PB_Ma, DX_Ma, PB_Ten) VALUES ('PB00005', 'DX00003', '55 TFSI quattro');
INSERT INTO PhienBan (PB_Ma, DX_Ma, PB_Ten) VALUES ('PB00006', 'DX00004', 'V8');
INSERT INTO PhienBan (PB_Ma, DX_Ma, PB_Ten) VALUES ('PB00007', 'DX00005', 'GT V8');
INSERT INTO PhienBan (PB_Ma, DX_Ma, PB_Ten) VALUES ('PB00008', 'DX00006', 'Cooper S 3 c?a');
INSERT INTO PhienBan (PB_Ma, DX_Ma, PB_Ten) VALUES ('PB00009', 'DX00007', 'Cooper S 5 c?a');
INSERT INTO PhienBan (PB_Ma, DX_Ma, PB_Ten) VALUES ('PB00010', 'DX00008', 'Cayman');
INSERT INTO PhienBan (PB_Ma, DX_Ma, PB_Ten) VALUES ('PB00011', 'DX00008', 'Boxster');
INSERT INTO PhienBan (PB_Ma, DX_Ma, PB_Ten) VALUES ('PB00012', 'DX00008', 'Cayman T');
INSERT INTO PhienBan (PB_Ma, DX_Ma, PB_Ten) VALUES ('PB00013', 'DX00008', 'Boxster T');
INSERT INTO PhienBan (PB_Ma, DX_Ma, PB_Ten) VALUES ('PB00014', 'DX00008', 'Cayman S');
INSERT INTO PhienBan (PB_Ma, DX_Ma, PB_Ten) VALUES ('PB00015', 'DX00008', 'Boxster S');
INSERT INTO PhienBan (PB_Ma, DX_Ma, PB_Ten) VALUES ('PB00016', 'DX00009', 'Carerra');
INSERT INTO PhienBan (PB_Ma, DX_Ma, PB_Ten) VALUES ('PB00017', 'DX00009', 'Carerra 4');
INSERT INTO PhienBan (PB_Ma, DX_Ma, PB_Ten) VALUES ('PB00018', 'DX00009', 'Carerra Cabriolet');
INSERT INTO PhienBan (PB_Ma, DX_Ma, PB_Ten) VALUES ('PB00019', 'DX00009', 'Carerra S');
INSERT INTO PhienBan (PB_Ma, DX_Ma, PB_Ten) VALUES ('PB00020', 'DX00009', 'Carerra 4 Cabriolet');
INSERT INTO PhienBan (PB_Ma, DX_Ma, PB_Ten) VALUES ('PB00021', 'DX00009', 'Targa 4');
INSERT INTO PhienBan (PB_Ma, DX_Ma, PB_Ten) VALUES ('PB00022', 'DX00010', 'Tieu chuan');
INSERT INTO PhienBan (PB_Ma, DX_Ma, PB_Ten) VALUES ('PB00023', 'DX00010', 'Nang cao');
INSERT INTO PhienBan (PB_Ma, DX_Ma, PB_Ten) VALUES ('PB00024', 'DX00010', 'Cao cap');
INSERT INTO PhienBan (PB_Ma, DX_Ma, PB_Ten) VALUES ('PB00025', 'DX00011', 'Tieu chuan');
INSERT INTO PhienBan (PB_Ma, DX_Ma, PB_Ten) VALUES ('PB00026', 'DX00011', 'Nang cao');
INSERT INTO PhienBan (PB_Ma, DX_Ma, PB_Ten) VALUES ('PB00027', 'DX00011', 'Cao cap');
commit;
select * from PhienBan;
------------------------------------------------------------------------------------------------------------------------------------------------------
-- Phan Khuc Xe
INSERT INTO PhanKhucXe (PKX_Ma, PKX_Ten) VALUES ('PKX0001', 'Xe sang co nho');
INSERT INTO PhanKhucXe (PKX_Ma, PKX_Ten) VALUES ('PKX0002', 'Xe sang co trung');
INSERT INTO PhanKhucXe (PKX_Ma, PKX_Ten) VALUES ('PKX0003', 'Sieu sang co lon');
INSERT INTO PhanKhucXe (PKX_Ma, PKX_Ten) VALUES ('PKX0004', 'Sieu xe / Xe the thao');
INSERT INTO PhanKhucXe (PKX_Ma, PKX_Ten) VALUES ('PKX0005', 'Xe nho co A');
INSERT INTO PhanKhucXe (PKX_Ma, PKX_Ten) VALUES ('PKX0006', 'Xe co trung hang E');
commit;
select * from PhanKhucXe;
---------------------------------------------------------------------------------------------------------------------------------------------------
-- Dam Phan
INSERT INTO DamPhan (DP_Ma, DP_Ten) VALUES ('DP00001', 'Khuyen mai');
INSERT INTO DamPhan (DP_Ma, DP_Ten) VALUES ('DP00002', 'Tang 10 - 40 trieu dong');
INSERT INTO DamPhan (DP_Ma, DP_Ten) VALUES ('DP00003', 'Tang 10 - 30 trieu dong');
INSERT INTO DamPhan (DP_Ma, DP_Ten) VALUES ('DP00004', 'Tang 10% khi mua xe tra thang hoac ho tro lai xuat ngan hang khi tra gop');

INSERT INTO DamPhan (DP_Ma, DP_Ten, DP_GiaTri) VALUES ('DP00000', 'Khong dam phan', DEFAULT);
UPDATE DamPhan
    SET DP_GiaTri = DEFAULT 
    WHERE DP_Ma = 'DP00001';
UPDATE DamPhan
    SET DP_GiaTri = DEFAULT 
    WHERE DP_Ma = 'DP00003';
UPDATE DamPhan
    SET DP_GiaTri = DEFAULT 
    WHERE DP_Ma = 'DP00004';
commit;
select * from DamPhan;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Xe
INSERT INTO Xe (X_Ma, PB_Ma, PKX_Ma, DC_Ma, DP_Ma, X_GiaNiemYet) VALUES ('X000001', 'PB00006','PKX0003', 'DC00003', NULL, 19500000000);
INSERT INTO Xe (X_Ma, PB_Ma, PKX_Ma, DC_Ma, DP_Ma, X_GiaNiemYet) VALUES ('X000002', 'PB00008','PKX0001', 'DC00005', 'DP00002', 1839000000);
INSERT INTO Xe (X_Ma, PB_Ma, PKX_Ma, DC_Ma, DP_Ma, X_GiaNiemYet) VALUES ('X000003', 'PB00010','PKX0004', 'DC00007', NULL, 3600000000);
INSERT INTO Xe (X_Ma, PB_Ma, PKX_Ma, DC_Ma, DP_Ma, X_GiaNiemYet) VALUES ('X000004', 'PB00022','PKX0005', 'DC00009', 'DP00004', 425000000);
UPDATE Xe
    SET DP_Ma = DEFAULT 
    WHERE X_Ma = 'X000001';
UPDATE Xe
    SET DP_Ma = DEFAULT 
    WHERE X_Ma = 'X000003';
commit;
select * from Xe;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Thong So Ky Thuat
INSERT INTO ThongSoKyThuat VALUES ('TSKT001', 'X000001','542/6000', '770/2000-4500', '8 cap ly hop kep', 'AWD', 5);
INSERT INTO ThongSoKyThuat VALUES ('TSKT002', 'X000002','192 hp/5000 - 6000', '280 Nm/1350 - 4600', 'Ly hop kep 7 cap Steptronic', '4 banh', 4);
INSERT INTO ThongSoKyThuat VALUES ('TSKT003', 'X000003','300/6500, 350/6500', '380/2050 - 4500, 380/2150 - 4500, 420/1900-4500, 420/1900 - 4500', 'PDK 7 cap, 6MT', 'Banh sau', 2);
INSERT INTO ThongSoKyThuat VALUES ('TSKT004', 'X000004','98/6200', '128/4400', 'Tu ding vo cap - CVT', 'Cau truoc - FWD', 5);
commit;
delete from ThongSoKyThuat;
select * from ThongSoKyThuat;
-----------------------------------------------------------------------------------------------------------------------------
-- Noi Lan Banh
INSERT INTO NoiLanBanh (NLB_Ma, NLB_Ten) VALUES ('NLB0001', 'Ha Noi');
INSERT INTO NoiLanBanh (NLB_Ma, NLB_Ten) VALUES ('NLB0002', 'TP HCM');
INSERT INTO NoiLanBanh (NLB_Ma, NLB_Ten) VALUES ('NLB0003', 'Ha Tinh');
INSERT INTO NoiLanBanh (NLB_Ma, NLB_Ten) VALUES ('NLB0004', 'Cac tinh thanh khac');
UPDATE NoiLanBanh
    SET NLB_GiaTri = 0.12
    WHERE NLB_Ma = 'NLB0001';
UPDATE NoiLanBanh
    SET NLB_GiaTri = 0.1
    WHERE NLB_Ma = 'NLB0002';
UPDATE NoiLanBanh
    SET NLB_GiaTri = 0.11
    WHERE NLB_Ma = 'NLB0003';
UPDATE NoiLanBanh
    SET NLB_GiaTri = 0.1
    WHERE NLB_Ma = 'NLB0004';
select * from noilanbanh;
commit;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Gia Lan Banh
INSERT INTO GiaLanBanh VALUES ('GLB0001', 'X000001','NLB0001', NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, NULL);
INSERT INTO GiaLanBanh VALUES ('GLB0002', 'X000002','NLB0001', NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, NULL);
commit;
select * from GiaLanBanh;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Cau 2 Viet thu tuc cho phep nhap mot xe moi ---------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE Insert_Xe(
                    p_x_ma IN Xe.x_ma%TYPE,
                    p_pb_ma IN Xe.pb_ma%TYPE,
                    p_pkx_ma IN Xe.pkx_ma%TYPE,
                    p_dc_ma IN Xe.dc_ma%TYPE,
                    p_dp_ma IN Xe.dp_ma%TYPE,
                    p_x_gianiemyet IN Xe.x_gianiemyet%TYPE)
IS
BEGIN
    INSERT INTO Xe (X_Ma, PB_Ma, PKX_Ma, DC_Ma, DP_Ma, X_GiaNiemYet)
        VALUES (p_x_ma,  p_pb_ma,  p_pkx_ma, p_dc_ma, p_dp_ma, p_x_gianiemyet);
    COMMIT;
END;
-- Cau 3 Goi thu tuc nhap
select * from Xe ORDER BY Xe.X_Ma;
EXECUTE Insert_Xe ('X000005', 'PB00007','PKX0003', 'DC00004', 'DP00000', 18000000000);
commit;
-- Cau 4 Viet thu tuc cho phep cap nhat gia niem yet va gia dam phan cua mo xe nao do. Tat ca ham, thu tuc deu phai co lenh test thu.
--- ??? Viet duoc thu tuc cap nhat gia niem yet. Khong viet duoc thu tuc cap nhat gia dam phan

--- Thu tuc cap nhat gia niem yet ---------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE Update_GiaNiemYet (
                    p_x_ma IN Xe.x_ma%TYPE,
                    p_x_gianiemyet IN Xe.x_gianiemyet%TYPE
)
IS
BEGIN
    UPDATE Xe SET X_GiaNiemYet = p_x_gianiemyet where X_Ma = p_x_ma;
    COMMIT;
END;

--- Thuc thi thu tuc -------------------------------------------------------------------------------------------------------------------------------------------------
EXECUTE Update_GiaNiemYet('X000005', 180000000000);
select * from Xe;

--- Thu tuc cap nhat gia dam phan -----------------------------------------------------------------------------------------------------------------------------
/*CREATE OR REPLACE PROCEDURE  Update_GiaDamPhan(
                    p_x_ma IN Xe.x_ma%TYPE,
                    p_dp_giatri IN DamPhan.dp_giatri%TYPE
)
IS
BEGIN
    UPDATE DamPhan SET DP_GiaTri = p_dp_giatri WHERE p_x_ma in(select x_ma from Xe x join DamPhan d on x.DP_Ma = d.DP_Ma);
    COMMIT;
END;

select * from DamPhan;
select * from Xe;
EXECUTE Update_GiaDamPhan('X000002', 10000001);
*/

commit;

-- Cau 5 Viet ham tra ve gia dam phan cua mot xe nao do
-- Select tra ve noi dung dam phan cua 1 xe
select X_Ma, DP_Ten
    from Xe x join DamPhan d on x.DP_Ma = d.DP_Ma
    where x_Ma = 'X000002';
    
-- Ham tra ve ten dam phan cua 1 xe
CREATE OR REPLACE FUNCTION Get_TenDamPhan(f_x_ma char)
RETURN varchar
IS
    temp varchar(300);
BEGIN
    select DP_Ten INTO temp
        from Xe x join DamPhan d on x.DP_Ma = d.DP_Ma
        where x_Ma = f_x_ma;
    RETURN temp;
END;
-- 
Select Get_TenDamPhan ('X000002') from dual;
-------------
-- Cap nhat gia tri dam phan
UPDATE DamPhan
    SET DP_GiaTri = 10000000
    WHERE DP_Ma = 'DP00002';
-- Select gia dam phan cua 1 xe
Select X_Ma, DP_Ten, (X_GiaNiemYet - DP_GiaTri) AS GiaDamPhan
    from Xe x join DamPhan d on x.DP_Ma = d.DP_Ma
    where X_Ma = 'X000002';-- Gia niem yet - Gia tri dam phan
-- Select gia niem yet cua 1 xe
select X_Ma, X_GiaNiemYet from Xe where X_Ma = 'X000002';

-- Ham tra ve gia dam phan cua 1 xe --------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION Get_GiaDamPhan(f_x_ma char)
RETURN varchar
IS
    temp float(15);
BEGIN
    select (X_GiaNiemYet - DP_GiaTri) INTO temp
        from Xe x join DamPhan d on x.DP_Ma = d.DP_Ma
        where x_Ma = f_x_ma;
    RETURN temp;
END;

drop function Get_GiaDamPhan;
-- Thuc thi ham ------------------------------------------------------------------------------------------------------------------------------------------------------
Select Get_GiaDamPhan ('X000002') as GiaDamPhan from dual;
Select Get_GiaDamPhan ('X000003') as GiaDamPhan from dual;
select * from xe;
-- Cau 6 Viet ham tra ve loai xe, hang xe co gia cao nhat
--- ??? select nhung khong viet duoc ham
-- select gia niem yet cao nhat
select Max(X_GiaNiemYet) from Xe;
-- select ma xe co gia cao nhat
select X_Ma from Xe where X_GiaNiemYet in (select Max(X_GiaNiemYet) from Xe);

select * from Xe;

-- select hang xe, dong xe, phien ban cua xe co gia niem yet cao nhat
select HX_Ten, DX_Ten, PB_Ten, X_Ma, X_GiaNiemYet
    from HangXe h join DongXe d on h.HX_Ma = d.HX_Ma
        join PhienBan p on d.DX_Ma = p.DX_Ma
        join Xe x on p.PB_Ma = x.PB_Ma
        where X_GiaNiemYet in (select Max(X_GiaNiemYet) from Xe);

-- Ham tra ve loai xe, hang xe có gia cao nhat----------------------------------------------------------------------------------
/*CREATE  TYPE x_type as object(
    HX_Ten varchar(100),
    DX_Ten varchar(100),
    PB_Ten varchar(100),
    X_Ma char(7),
    X_GiaNiemYet float(20)
);
CREATE OR REPLACE FUNCTION Get_MaxGia(loc in number)
RETURN x_type
AS
    x_record x_type;
BEGIN
    select HX_Ten, DX_Ten, PB_Ten, X_Ma, X_GiaNiemYet INTO x_record
    from HangXe h join DongXe d on h.HX_Ma = d.HX_Ma
        join PhienBan p on d.DX_Ma = p.DX_Ma
        join Xe x on p.PB_Ma = x.PB_Ma
        where X_GiaNiemYet in (select Max(X_GiaNiemYet) from Xe);
    RETURN(x_record);
END;*/
-- Cau 7 Viet thu tuc de xoa mot xe nao do
-- Thu tuc xoa 1 xe --------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE Delete_Xe (
                    p_x_ma IN Xe.x_ma%TYPE
)
IS
BEGIN
    DELETE Xe WHERE X_Ma = p_x_ma;
    COMMIT;
END;

-- Thuc thi thu tuc xoa 1 xe --------------------------------------------------------------------------------------------------------
EXECUTE Delete_Xe ('X000005');
select * from Xe;
commit;
-- Cau 8 Viet ham tra ve gia lan banh o Can Tho cua mot xe nao do, biet rang gia lan banh duoc tinh theo cong thuc sau
--- ??? Select ket qua dung, ham tra ve sai ket qua

-- Select gia lan banh cua mot xe
select X_GiaNiemYet + (X_GiaNiemYet * NLB_GiaTri) + GLB_PhiSDDuongBo + GLB_BaoHiem + GLB_PhiDKBienSo + GLB_PhiDangKiem as GiaLanBanh
    from Xe x join GiaLanBanh g on x.X_Ma = g.X_Ma
                        join NoiLanBanh n on n.NLB_Ma = g.NLB_Ma
    where g.X_Ma = 'X000001';
select * from xe;
select * from gialanbanh;
select * from noilanbanh;

-- Ham tra ve gia lan banh cua 1 xe ------------------------------------------------------------------------------------------------------------
----- select dung - ham khong dung
CREATE OR REPLACE FUNCTION Get_GiaLanBanh(f_x_ma char)
RETURN varchar
IS
    temp float(20);
BEGIN
    select (X_GiaNiemYet + (X_GiaNiemYet * NLB_GiaTri) + GLB_PhiSDDuongBo + GLB_BaoHiem + GLB_PhiDKBienSo + GLB_PhiDangKiem) INTO temp
    from Xe x join GiaLanBanh g on x.X_Ma = g.X_Ma
                        join NoiLanBanh n on n.NLB_Ma = g.NLB_Ma
    where g.X_Ma = f_x_ma;
    RETURN temp;
END;
--drop function Get_GiaLanBanh;
-- Thuc thi ham ---------------------------------------------------------------------------------------------------------------
Select Get_GiaLanBanh ('X000001') as GiaLanBanh from dual;


-- Cau 9 Viet trigger de theo doi viec sua gia trong bang xe
--- Tao bang luu thong tin khi du lieu duoc sua doi
CREATE TABLE Change_Gia(
    UserName VARCHAR2(20),
    MODIFY_TIME DATE,
    X_Ma char(7),
    Old_Gia float(20),
    New_Gia float(20)
);

-- Tao trigger theo doi sua gia trong bang xe --------------------------------------------------------
CREATE OR REPLACE TRIGGER store_change_Gia
AFTER UPDATE OF X_GiaNiemYet on Xe
FOR EACH ROW
BEGIN
-- User la mot ham co san trong he thong cho biet ai ket noi CSDL
    INSERT INTO Change_Gia(UserName, MODIFY_TIME, X_Ma, Old_Gia, New_Gia)
        VALUES (User, Sysdate,:new.X_Ma,:old.X_GiaNiemYet,:new.X_GiaNiemYet);
END;

select * from change_gia;
select * from Xe;
-- Cap nhat gia xe de kiem tra thu trigger
update Xe set X_GiaNiemYet = 426000000 where X_Ma = 'X000004';
update Xe set X_GiaNiemYet = 425000000 where X_Ma = 'X000004';
-- Cau 10 Viet trigger de theo doi viec xoa du lieu trong bang xe

--- Tao bang luu thong tin khi du lieu duoc sua doi-------------------------
CREATE TABLE Trigger_Delete_Xe(
    UserName VARCHAR2(20),
    MODIFY_TIME DATE,
    X_Ma char(7),
    PB_Ma char(7),
    PKX_Ma char(7),
    DC_Ma char(7),
    DP_Ma char(7),
    X_GiaNiemYet float(20)
);

-- Tao trigger theo doi xoa du lieu trong bang xe --------------------------------------------------------
CREATE OR REPLACE TRIGGER store_delete_Xe
AFTER DELETE on Xe
FOR EACH ROW
BEGIN
-- User la mot ham co san trong he thong cho biet ai ket noi CSDL
    INSERT INTO Trigger_Delete_Xe(UserName, MODIFY_TIME, X_Ma, PB_Ma, PKX_Ma, DC_Ma, DP_Ma, X_GiaNiemYet)
        VALUES (User, Sysdate,:old.X_Ma,:old.PB_Ma,:old.PKX_Ma,:old.DC_Ma,:old.DP_Ma,:old.X_GiaNiemYet);
END;

commit;

select * from Xe;
-- Select bang theo doi xoa xe
select * from trigger_delete_xe;
-- Xoa 1 xe de kiem tra thu trigger
delete from Xe where X_Ma = 'X000005';


-- Cau 11 Xoa tat ca cac nguoi dung Test1, Test2, Test3,... ma ban da tao (Luu y KHONG XOA NHAM cua nguoi khac)
DROP USER B1906586_Test1 CASCADE;
DROP USER B1906586_Test2 CASCADE;
DROP USER B1906586_Test3 CASCADE;
-- Cau 12 Tao nguoi dung moi de quan ly CSDL O to tren, cap quyen tuong ung
-- Tao nguoi dung B1906586_Test1-------------------------------------------------------------------------
create user B1906586_Test1 identified by "B1906586@Test1";
GRANT CREATE SESSION TO B1906586_Test1;
GRANT SELECT, INSERT, UPDATE, DELETE ON HangXe TO B1906586_Test1;
GRANT SELECT, INSERT, UPDATE, DELETE ON DongCo TO B1906586_Test1;
GRANT SELECT, INSERT, UPDATE, DELETE ON DongXe TO B1906586_Test1;
GRANT SELECT, INSERT, UPDATE, DELETE ON PhienBan TO B1906586_Test1;
GRANT SELECT, INSERT, UPDATE, DELETE ON PhanKhucXe TO B1906586_Test1;
GRANT SELECT, INSERT, UPDATE, DELETE ON DamPhan TO B1906586_Test1;
GRANT SELECT, INSERT, UPDATE, DELETE ON Xe TO B1906586_Test1;
GRANT SELECT, INSERT, UPDATE, DELETE ON ThongSoKyThuat TO B1906586_Test1;
GRANT SELECT, INSERT, UPDATE, DELETE ON NoiLanBanh TO B1906586_Test1;
GRANT SELECT, INSERT, UPDATE, DELETE ON GiaLanBanh TO B1906586_Test1;
--revoke select, insert, update, delete on Xe from B1906586_Test1;
ROLLBACK;
commit;--
--