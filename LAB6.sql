------------cau1-------------------
go
create function fn_thongtinsanphamtheohang(@masp nvarchar(30))
returns nvarchar(40)
as
begin
declare @thongtinsanpham nvarchar(20)
set @thongtinsanpham =
(
select tbHANGSX.tenhang from tbHANGSX inner join tbSANPHAM on tbHANGSX.mahangsx = tbSANPHAM.mahangsx where tbSANPHAM.MaSP = @masp
)
return @thongtinsanpham
end
go
------------cau4------------------
go
create function thongtinnhanvein (@Phong nvarchar(30))
returns table
return
select tbNHANVIEN.tennv from tbNHANVIEN
where tbNHANVIEN.Phong = @Phong
go
-----------cau3----------
create function LuaChon(@luachon int)
returns @bang table (tensp nvarchar(20), masp nvarchar(10),tenhang nvarchar(20), Soluong int)
as
begin
if @luachon = 0
begin
insert into @bang 
select tbSANPHAM.tensp, tbSANPHAM.masp, tbHANGSX.tenhang, tbSANPHAM.Soluong 
from tbSANPHAM inner join tbHANGSX on tbSANPHAM.mahangsx = tbHANGSX.mahangsx
where tbSANPHAM.soluong < 0
end
if @luachon = 1
begin
insert into @bang
select tbSANPHAM.tensp, tbSANPHAM.masp, tbHANGSX.tenhang, tbSANPHAM.Soluong 
from tbSANPHAM inner join tbHANGSX on tbSANPHAM.mahangsx = tbHANGSX.mahangsx
where tbSANPHAM.soluong > 0
end
return
end
go
-------------cau2---------
create function fn_danhsachsanphamtheongay(@tensp nvarchar(30),@x int,@y int)
returns int
as
begin 
declare @dssanphamtheongay nvarchar(20) =
(select tbSANPHAM.MaSP,tbSANPHAM.tenSP, tbHANGSX.mahangsx,tbHANGSX.tenhang
from tbSANPHAM 
join tbNHAP on tbNHAP.masp = tbSANPHAM.masp
join tbHANGSX on tbHANGSX.mahangsx = tbSANPHAM.mahangsx
where tbSANPHAM.tensp = @tensp and day(tbNHAP.Ngaynhap) between @x and @y
)
return @dssanphamtheongay
end
go
----------cau6-------------
create function danhsachxuat (@x int, @y int)
returns table 
return
select tbHANGSX.tenhang, tbSANPHAM.tensp, tbXUAT.soluongX
from tbXUAT
inner join tbSANPHAM on tbXUAT.Masp = tbSANPHAM.masp 
inner join tbHANGSX on tbSANPHAM.mahangsx = tbHANGSX.Mahangsx
where year(tbXUAT.Ngayxuat) BETWEEN @x AND @y
go
-----------cau8----------
create function nhanviennhap (@x int)
returns table
return
select tbNHANVIEN.Manv, tbNHANVIEN.Tennv, tbNHANVIEN.Phong
from tbNHANVIEN inner join tbNHAP on tbNHANVIEN.Manv = tbNHAP.Manv
where day(tbNHAP.Ngaynhap) = @x
go
----------cau7-----------
create function fn_luachon(@luachon1 int)
returns @bang table (tensp nvarchar(20), masp nvarchar(10), Soluong int)
as
begin
if @luachon1 = 0
begin
insert into @bang 
select tbSANPHAM.tensp, tbSANPHAM.masp,tbSANPHAM.Soluong 
from tbSANPHAM inner join tbNHAP on tbSANPHAM.MaSP = tbNHAP.masp
end
if @luachon1 = 1
begin
insert into @bang
select tbSANPHAM.tensp, tbSANPHAM.masp,tbSANPHAM.Soluong 
from tbSANPHAM inner join tbXUAT on tbSANPHAM.MaSP = tbXUAT.masp 
end
return
end
go
-------------cau9-----------
create function sanphamcogiaban (@x int, @y int, @z nvarchar(20))
returns table
return
select tbSANPHAM.MaSP,tbSANPHAM.tenSP,tbSANPHAM.giaban
from tbSANPHAM 
inner join tbHANGSX on tbSANPHAM.mahangsx =tbHANGSX.mahangsx
where tbSANPHAM.giaban = @x 
and tbHANGSX.tenhang = @z
go

