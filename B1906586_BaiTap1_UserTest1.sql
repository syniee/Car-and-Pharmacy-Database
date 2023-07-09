-- Le Thai Giao Tien B1906586 --

-- Nguoi dung B1906586_Test1
select * from B1906586.Xe;
commit;--
-- Thu xoa 1 xe de kiem tra trigger cau 10
delete from B1906586.Xe where X_Ma = 'X000005';
--