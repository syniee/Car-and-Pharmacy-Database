-- Le Thai Giao Tien B1906586 --

select sysdate from dual;

-- Mo ta va thiet ke CSDL ve mot linh vuc nao do (ban hang, ql sinh vien, quan ly quan cafe, du lich,...) gom it nhat 5 bang.
-- Moi cot trong bang phai co cac rang buoc (Khoa chinh, khoa ngoai, RB duy nhat, RB kiem tra, not null, mac dinh, bieu thuc chinh quy - vd Ma hang: MH01,...)
-- Nhap du lieu cho bang (it nhat 5 dong)
-- Ten bang (cac doi tuong khac) bat dau la "BT_..."
-- Viet it nhat 3 ham, 3 thu tuc, 3 trigger de quan y du lieu tren
--

drop table BT_KhachHang CASCADE CONSTRAINTS;
drop table BT_DuocSi CASCADE CONSTRAINTS;
drop table BT_DanhMuc CASCADE CONSTRAINTS;
drop table BT_DuocPham CASCADE CONSTRAINTS;
drop table BT_DonThuoc CASCADE CONSTRAINTS;
drop table BT_ChiTietDonThuoc CASCADE CONSTRAINTS;
-- Mo ta va thiet ke CSDL ve mot linh vuc quan ly hieu thuoc
-- Khach Hang
CREATE TABLE BT_KhachHang(
	KH_Ma char(7) NOT NULL check (regexp_like (KH_Ma, 'KH\d{5}')),
	KH_SoDienThoai varchar(11) check (regexp_like (KH_SoDienThoai, '0\d{9,10}')),-- Bat dau so 0 tiep theo la 9 hoac 10 so
	KH_Ten varchar(30) NOT NULL,
	KH_DiaChi varchar(300),
	PRIMARY KEY(KH_Ma)
);
-- Duoc Si
CREATE TABLE BT_DuocSi(
	DS_Ma char(7) NOT NULL check (regexp_like (DS_Ma, 'DS\d{5}')),
	DS_ten varchar(30) NOT NULL,
	DS_DiaChi varchar(300),
    DS_Email varchar(100) check (regexp_like (DS_Email, '^[A-Za-z]+[A-Za-z0-9.]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$')),
	DS_MatKhau varchar(30),
	PRIMARY KEY(DS_Ma)
);
-- Danh Muc
CREATE TABLE BT_DanhMuc(
	DM_Ma char(7) NOT NULL check (regexp_like (DM_Ma, 'DM\d{5}')),
	DM_Ten varchar(200) NOT NULL,
	PRIMARY KEY(DM_Ma)
);
-- Duoc Pham
CREATE TABLE BT_DuocPham(
	DP_Ma char(7) NOT NULL check (regexp_like (DP_Ma, 'DP\d{5}')),
	DM_Ma char(7),
	DP_Ten varchar(200) NOT NULL,
	DP_MoTa varchar(300),
	DP_Gia float(15) CHECK(DP_Gia > 0),
	PRIMARY KEY (DP_Ma),
	CONSTRAINT FK_DP_DM FOREIGN KEY (DM_Ma) REFERENCES BT_DanhMuc(DM_Ma)
);
-- Don Thuoc
CREATE TABLE BT_DonThuoc(
	DT_Ma char(7) NOT NULL check (regexp_like (DT_Ma, 'DT\d{5}')),
	KH_Ma char(7),
	DS_Ma char(7),
	DT_SoLuong int CHECK(DT_SoLuong > 0),
	DT_Ngay date,
	DT_ThanhTien float(15) DEFAULT NULL,
	PRIMARY KEY (DT_Ma),
	CONSTRAINT FK1_DT_KH FOREIGN KEY (KH_Ma) REFERENCES BT_KhachHang(KH_Ma),
	CONSTRAINT FK2_DT_DS FOREIGN KEY (DS_Ma) REFERENCES BT_DuocSi(DS_Ma)
);
-- Chi Tiet Don Thuoc
CREATE TABLE BT_ChiTietDonThuoc(
    DT_Ma char(7),
	DP_Ma char(7),
	CTDT_SoLuong int CHECK(CTDT_SoLuong > 0),
	CTDT_Gia float(15) DEFAULT NULL,
	CONSTRAINT PK_CTDT PRIMARY KEY(DT_Ma, DP_Ma),
	CONSTRAINT FK1_CTDT_DT FOREIGN KEY (DT_Ma) REFERENCES BT_DonThuoc(DT_Ma),
	CONSTRAINT FK2_CTDT_DP FOREIGN KEY (DP_Ma) REFERENCES BT_DuocPham(DP_Ma)
);
commit;--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Nhap du lieu cho bang (it nhat 5 dong)
-- Khach Hang
INSERT INTO BT_KhachHang (KH_Ma, KH_SoDienThoai, KH_Ten, KH_DiaChi) VALUES ('KH00001', '0101010101', 'Bui Anh Tuan', 'Ha Noi');
INSERT INTO BT_KhachHang (KH_Ma, KH_SoDienThoai, KH_Ten, KH_DiaChi) VALUES ('KH00002', '0202020202', 'Bui Nguyen Trung Quan', 'Da Lat');
INSERT INTO BT_KhachHang (KH_Ma, KH_SoDienThoai, KH_Ten, KH_DiaChi) VALUES ('KH00003', '0303030303', 'Truc Nhan', 'Binh Dinh');
INSERT INTO BT_KhachHang (KH_Ma, KH_SoDienThoai, KH_Ten, KH_DiaChi) VALUES ('KH00004', '0404040404', 'Giao', 'Soc Trang');
INSERT INTO BT_KhachHang (KH_Ma, KH_SoDienThoai, KH_Ten, KH_DiaChi) VALUES ('KH00005', '0505050505', 'Tien', 'Vinh Long');
select * from BT_KhachHang;
commit;
---------------------------------------------------------------------------------------------------------------------------------------
-- Duoc Si
INSERT INTO BT_DuocSi (DS_Ma, DS_Ten, DS_DiaChi, DS_Email, DS_MatKhau) VALUES ('DS00001', 'Vo Hoang Due', 'Can Tho', 'due@gmail.com', 'ds00001');
INSERT INTO BT_DuocSi (DS_Ma, DS_Ten, DS_DiaChi, DS_Email, DS_MatKhau) VALUES ('DS00002', 'Trinh Duc Toan', 'Can Tho', 'toan@gmail.com', 'ds00002');
INSERT INTO BT_DuocSi (DS_Ma, DS_Ten, DS_DiaChi, DS_Email, DS_MatKhau) VALUES ('DS00003', 'Moc Minh Ngoc', 'Vinh Long', 'ngoc@gmail.com', 'ds00003');
INSERT INTO BT_DuocSi (DS_Ma, DS_Ten, DS_DiaChi, DS_Email, DS_MatKhau) VALUES ('DS00004', 'Phan Tuy Anh', 'Soc Trang', 'anh@gmail.com', 'ds00004');
INSERT INTO BT_DuocSi (DS_Ma, DS_Ten, DS_DiaChi, DS_Email, DS_MatKhau) VALUES ('DS00005', 'Yen Xuan Van', 'Vinh Long', 'van@gmail.com', 'ds00005');
select * from BT_DuocSi;
commit;
---------------------------------------------------------------------------------------------------------------------------------------
-- Danh Muc
INSERT INTO BT_DanhMuc (DM_Ma, DM_Ten) VALUES ('DM00001', 'Khang Viem');
INSERT INTO BT_DanhMuc (DM_Ma, DM_Ten) VALUES ('DM00002', 'Da lieu');
INSERT INTO BT_DanhMuc (DM_Ma, DM_Ten) VALUES ('DM00003', 'Tieu hoa');
INSERT INTO BT_DanhMuc (DM_Ma, DM_Ten) VALUES ('DM00004', 'Ha sot');
INSERT INTO BT_DanhMuc (DM_Ma, DM_Ten) VALUES ('DM00005', 'Co xuong khop');
select * from BT_DanhMuc;
commit;
---------------------------------------------------------------------------------------------------------------------------------------
-- Duoc Pham
INSERT INTO BT_DuocPham (DP_Ma, DM_Ma, DP_Ten, DP_MoTa, DP_Gia) VALUES ('DP00001', 'DM00001', 'Amcinol-Paste', 'Dung ngoai: cac chung viem dau o mieng, loi va moi.', 10000);
INSERT INTO BT_DuocPham (DP_Ma, DM_Ma, DP_Ten, DP_MoTa, DP_Gia) VALUES ('DP00002', 'DM00001', 'Axcel Diphenhydramine Paediatric Syrup', 'Giam ho, giam viem mui di ung va viem phe quan di ung', 26500);
INSERT INTO BT_DuocPham (DP_Ma, DM_Ma, DP_Ten, DP_MoTa, DP_Gia) VALUES ('DP00003', 'DM00002', 'Avircrem', 'Cac truong hop nhiem virus Herpes simplex tren da', 25000);
INSERT INTO BT_DuocPham (DP_Ma, DM_Ma, DP_Ten, DP_MoTa, DP_Gia) VALUES ('DP00004', 'DM00002', 'Axcel Fungicort Cream', 'Dieu tri viem da do nam, ton thuong do con trung dot', 32000);
INSERT INTO BT_DuocPham (DP_Ma, DM_Ma, DP_Ten, DP_MoTa, DP_Gia) VALUES ('DP00005', 'DM00003', 'Agimoti Agimexpharm', 'Buon non va non nang, cam giac chuong va nang vung thuong vi', 32000);
select * from BT_DuocPham;
commit;
---------------------------------------------------------------------------------------------------------------------------------------
-- Don thuoc
INSERT INTO BT_DonThuoc (DT_Ma, KH_Ma, DS_Ma, DT_SoLuong, DT_Ngay, DT_ThanhTien) VALUES ('DT00001', 'KH00001', 'DS00001', 1, '2022-10-04', NULL);
INSERT INTO BT_DonThuoc (DT_Ma, KH_Ma, DS_Ma, DT_SoLuong, DT_Ngay, DT_ThanhTien) VALUES ('DT00002', 'KH00002', 'DS00002', 2, '2022-10-04', NULL);
INSERT INTO BT_DonThuoc (DT_Ma, KH_Ma, DS_Ma, DT_SoLuong, DT_Ngay, DT_ThanhTien) VALUES ('DT00003', 'KH00003', 'DS00002', 1, '2022-10-05', NULL);
INSERT INTO BT_DonThuoc (DT_Ma, KH_Ma, DS_Ma, DT_SoLuong, DT_Ngay, DT_ThanhTien) VALUES ('DT00004', 'KH00004', 'DS00003', 2, '2022-10-05', NULL);
INSERT INTO BT_DonThuoc (DT_Ma, KH_Ma, DS_Ma, DT_SoLuong, DT_Ngay, DT_ThanhTien) VALUES ('DT00005', 'KH00005', 'DS00003', 3, '2022-10-06', NULL);
select * from BT_DonThuoc;
commit;
---------------------------------------------------------------------------------------------------------------------------------------
-- Chi Tiet Don Thuoc
INSERT INTO BT_ChiTietDonThuoc (DT_Ma, DP_Ma, CTDT_SoLuong, CTDT_Gia) VALUES ('DT00001', 'DP00001', 1, NULL);
INSERT INTO BT_ChiTietDonThuoc (DT_Ma, DP_Ma, CTDT_SoLuong, CTDT_Gia) VALUES ('DT00002', 'DP00001', 2, NULL);
INSERT INTO BT_ChiTietDonThuoc (DT_Ma, DP_Ma, CTDT_SoLuong, CTDT_Gia) VALUES ('DT00002', 'DP00002', 1, NULL);
INSERT INTO BT_ChiTietDonThuoc (DT_Ma, DP_Ma, CTDT_SoLuong, CTDT_Gia) VALUES ('DT00003', 'DP00002', 2, NULL);
INSERT INTO BT_ChiTietDonThuoc (DT_Ma, DP_Ma, CTDT_SoLuong, CTDT_Gia) VALUES ('DT00003', 'DP00003', 3, NULL);
select * from BT_ChiTietDonThuoc;
commit;

select * from BT_KhachHang;

-------------------------------------------------------------------------------------
-- Thu tuc
-------------------------------------------------------------------------------------
--- Thu tuc 1. Them 1 duoc pham moi Insert_DuocPham ---------------
CREATE OR REPLACE PROCEDURE Insert_DuocPham(
                    p_dp_ma IN BT_DuocPham.dp_ma%TYPE,
                    p_dm_ma IN BT_DuocPham.dm_ma%TYPE,
                    p_dp_ten IN BT_DuocPham.dp_ten%TYPE,
                    p_dp_mota IN BT_DuocPham.dp_mota%TYPE,
                    p_dp_gia IN BT_DuocPham.dp_gia%TYPE)
IS
BEGIN
    INSERT INTO BT_DuocPham (DP_Ma, DM_Ma, DP_Ten, DP_MoTa, DP_Gia)
        VALUES (p_dp_ma,  p_dm_ma,  p_dp_ten, p_dp_mota, p_dp_gia);
    COMMIT;
END;

--- Thuc thi thu tuc ---------------------------------------------------------------------
select * from BT_DuocPham;
EXECUTE  Insert_DuocPham ('DP00006', 'DM00003', 'Akitykity-New', 'Nhiem mot loai hoac nhieu loai ki sinh trung duong ruot nhu giun dua, giun kim, san hat dua,…', 10000);

--- Thu tuc 2. Cap nhat gia cua 1 duoc pham Update_GiaDuocPham ---------------
CREATE OR REPLACE PROCEDURE Update_GiaDuocPham(
                    p_dp_ma IN BT_DuocPham.dp_ma%TYPE,
                    p_dp_gia IN BT_DuocPham.dp_gia%TYPE
)
IS
BEGIN
    UPDATE BT_DuocPham SET dp_gia = p_dp_gia where DP_Ma = p_dp_ma;
    COMMIT;
END;
commit;
--- Thuc thi thu tuc ---------------------------------------------------------------------
EXECUTE Update_GiaDuocPham('DP00006', 100000);
select * from BT_DuocPham;
commit;

--- Thu tuc 3. Xoa 1 duoc pham Delete_DuocPham ---------------
CREATE OR REPLACE PROCEDURE Delete_DuocPham (
                    p_dp_ma IN BT_DuocPham.dp_ma%TYPE
)
IS
BEGIN
    DELETE BT_DuocPham WHERE DP_Ma = p_dp_ma;
    COMMIT;
END;
rollback;
-- Thuc thi thu tuc xoa 1 duoc pham --------------------------------------------------------------------------------------------------------
EXECUTE Delete_DuocPham ('DP00006');
select * from BT_DuocPham;
commit;
--------------------------------------------------------------
-- Ham
--------------------------------------------------------------
--- Ham 1. Tra ve don gia cua 1 duoc pham Get_GiaDuocPham---------------
select DP_Gia from BT_DuocPham where DP_Ma = 'DP00001';
CREATE OR REPLACE FUNCTION Get_GiaDuocPham(f_dp_ma char)
RETURN varchar
IS
    temp float(15);
BEGIN
    select DP_Gia INTO temp
        from BT_DuocPham 
        where DP_Ma = f_dp_ma;
    RETURN temp;
END;
--- Thuc thi ham tra ve don gia cua mot duoc pham -------------------------------
Select Get_GiaDuocPham ('DP00001') as GiaDuocPham from dual;
select * from BT_DuocPham;
commit;

--- Ham 2.  Tra ve ngay ban cua mot don thuoc nao do---------------
-- select tra ve nhung don thuoc co chua 1 duoc pham cu the nao do
select DT_Ma 
    from BT_ChiTietDonThuoc c JOIN BT_DuocPham d ON c.DP_Ma = d.DP_Ma where d.DP_Ma = 'DP00001';
select DT_Ngay
    from BT_DonThuoc where DT_Ma = 'DT00003';
    
CREATE OR REPLACE FUNCTION Get_NgayDonThuoc(f_dt_ma char)
RETURN varchar
IS
    temp date;
BEGIN
    select DT_Ngay INTO temp
       from BT_DonThuoc where DT_Ma = f_dt_ma;
    RETURN temp;
END;
drop function get_donthuoc;
--- Thuc thi ham tra ve ngay ban cua 1 don thuoc -------------------------------
Select Get_NgayDonThuoc('DT00001') as NgayBanCuaDonThuoc from dual;
commit;
--- Ham 3. Tra ve thanh tien cua 1 don thuoc nao do Get_ThanhTienDonThuoc---------------
--select * from BT_DuocPham;
--select * from BT_ChiTietDonThuoc;
--select * from BT_DonThuoc;
select DP_Gia * CTDT_SoLuong * DT_SoLuong
    from BT_DuocPham d JOIN BT_ChiTietDonThuoc c ON d.DP_Ma = c.DP_Ma
                                            JOIN BT_DonThuoc e ON e.DT_Ma = c.DT_Ma
    where e.DT_Ma = 'DT00001';
    
CREATE OR REPLACE FUNCTION Get_ThanhTienDonThuoc(f_dt_ma char)
RETURN varchar
IS
    temp float(15);
BEGIN
    select (DP_Gia * CTDT_SoLuong * DT_SoLuong) INTO temp
    from BT_DuocPham d JOIN BT_ChiTietDonThuoc c ON d.DP_Ma = c.DP_Ma
                                            JOIN BT_DonThuoc e ON e.DT_Ma = c.DT_Ma
    where e.DT_Ma = f_dt_ma;
    RETURN temp;
END;
--- Thuc thi ham tra ve thanh tien cua 1 don thuoc nao do -------------------------------
Select Get_ThanhTienDonThuoc ('DT00001') as ThanhTien from dual;
commit;
--------------------------------------------------------------
-- Trigger
--------------------------------------------------------------

--- Trigger 1. Theo doi them duoc pham moi ---------------
--- Tao bang luu thong tin khi du lieu duoc sua doi
CREATE TABLE insert_NewDuocPham(
    UserName VARCHAR2(20),
    MODIFY_TIME DATE,
	New_DP_Ma char(7),
	New_DM_Ma char(7),
	New_DP_Ten varchar(200),
	New_DP_MoTa varchar(300),
	New_DP_Gia float(15)
);
-- Tao trigger theo doi them duoc pham moi --------------------------------------------------------
CREATE OR REPLACE TRIGGER store_insert_NewDuocPham
AFTER INSERT  ON BT_DuocPham
FOR EACH ROW
BEGIN
    INSERT INTO Insert_NewDuocPham(UserName, MODIFY_TIME, New_DP_Ma, New_DM_Ma, New_DP_Ten, New_DP_MoTa, New_DP_Gia)
        VALUES (User, Sysdate,:new.DP_Ma,:new.DM_Ma,:new.DP_Ten,:new.DP_MoTa,:new.DP_Gia);
END;
commit;

-- Them 1 duoc pham moi de kiem tra thu trigger
EXECUTE  Insert_DuocPham ('DP00006', 'DM00003', 'Akitykity-New', 'Nhiem mot loai hoac nhieu loai ki sinh trung duong ruot nhu giun dua, giun kim, san hat dua,…', 10000);
select * from insert_newduocpham;
commit;

--- Trigger 2. Theo doi sua gia duoc pham ---------------
--- Tao bang luu thong tin khi du lieu duoc sua doi
CREATE TABLE Change_GiaDuocPham(
    UserName VARCHAR2(20),
    MODIFY_TIME DATE,
    DP_Ma char(7),
    Old_Gia float(15),
    New_Gia float(15)
);

-- Tao trigger theo doi sua gia trong duoc pham --------------------------------------------------------
CREATE OR REPLACE TRIGGER store_change_GiaDuocPham
AFTER UPDATE OF DP_Gia on BT_DuocPham
FOR EACH ROW
BEGIN
    INSERT INTO Change_GiaDuocPham(UserName, MODIFY_TIME, DP_Ma, Old_Gia, New_Gia)
        VALUES (User, Sysdate,:new.DP_Ma,:old.DP_Gia,:new.DP_Gia);
END;
commit;


-- Cap nhat gia duoc pham de kiem tra thu trigger

EXECUTE Update_GiaDuocPham('DP00006', 100000);
select * from change_giaduocpham;
commit;


--- Trigger 3. Theo doi xoa du lieu trong duoc pham ---------------
--- Tao bang luu thong tin khi du lieu duoc sua doi
CREATE TABLE trigger_delete_DuocPham(
    UserName VARCHAR2(20),
    MODIFY_TIME DATE,
	DP_Ma char(7),
	DM_Ma char(7),
	DP_Ten varchar(200),
	DP_MoTa varchar(300),
	DP_Gia float(15)
);

-- Tao trigger theo doi xoa duoc pham --------------------------------------------------------
CREATE OR REPLACE TRIGGER store_delete_DuocPham
AFTER DELETE  ON BT_DuocPham
FOR EACH ROW
BEGIN
    INSERT INTO trigger_delete_DuocPham(UserName, MODIFY_TIME, DP_Ma, DM_Ma, DP_Ten, DP_MoTa, DP_Gia)
        VALUES (User, Sysdate,:old.DP_Ma,:old.DM_Ma,:old.DP_Ten,:old.DP_MoTa,:old.DP_Gia);
END;
commit;

-- Xoa duoc pham de kiem tra thu trigger

EXECUTE Delete_DuocPham ('DP00006');
select * from trigger_delete_duocpham;
commit;

ROLLBACK;
commit;--
--