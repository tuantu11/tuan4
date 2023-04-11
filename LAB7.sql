--------------cau1--------------
CREATE PROC NhapHangSX(@mahangsx nvarchar(10), @tenhang nvarchar(20), @diachi nvarchar(20), @sodt nvarchar(10), @email nvarchar(20))
AS 
IF @tenhang NOT IN (SELECT tbHANGSX.Tenhang FROM tbHANGSX)
BEGIN
INSERT INTO tbHANGSX(mahangsx, Tenhang, Diachi, Sodt, email)
VALUES (@mahangsx, @tenhang, @diachi, @sodt, @email)
END
ELSE 
BEGIN
RAISERROR (N'tên hãng đã tồn tại',16,1)
ROLLBACK TRAN
END
GO
-------------cau2---------------
CREATE PROC NhapdulieuSPmoi(@masp nvarchar(10), @tenhangsx nvarchar(20), @tensp nvarchar(20), @soluong int, @mausac nvarchar(10), @giaban money, @donvitinh nvarchar(10), @mota nvarchar(10))
AS
IF @masp IN (SELECT tbSANPHAM.Masp FROM tbSANPHAM)
BEGIN 
UPDATE tbSANPHAM 
SET tensp = @tensp, mahangsx = @tenhangsx, soluong = @soluong, mausac = @mausac, giaban = @giaban, donvitinh = @donvitinh, mota = @mota
WHERE masp = @masp
END
ELSE 
BEGIN 
INSERT INTO tbSANPHAM (masp, mahangsx, tensp, soluong, mausac, giaban, donvitinh, mota)
VALUES (@masp, @tenhangsx, @tensp, @soluong, @mausac, @giaban, @donvitinh, @mota)
END
GO
-----------cau3--------------------
CREATE PROC XoaHang (@Tenhang nvarchar(20))
AS
IF @Tenhang IN (SELECT tbHANGSX.tenhang FROM tbHANGSX)
BEGIN
DELETE FROM tbHANGSX 
WHERE Tenhang = @Tenhang
END
ELSE
BEGIN
RAISERROR (N'Hàng không tồn tại', 16,2)
ROLLBACK TRAN
END
GO
---------cau4--------------------
CREATE PROC ChinhsuaNV(@manv nvarchar(10), @tennv nvarchar(20), @gioitinh nvarchar(10), @diachi nvarchar(20), @sodt nvarchar(10), @email nvarchar(20), @phong nvarchar(30), @Flag int)
AS
IF @Flag = 0
BEGIN
UPDATE tbNHANVIEN 
SET Tennv = @tennv, Gioitinh = @gioitinh, Diachi = @diachi, Sodt = @sodt, email = @email, Phong = @phong
WHERE manv = @manv
END
ELSE 
BEGIN
INSERT INTO tbNHANVIEN(manv, Tennv, Gioitinh, Diachi, Sodt, email, Phong)
VALUES (@manv, @tennv, @gioitinh, @diachi, @sodt, @email, @phong)
END
GO
-----------cau5-------------------
CREATE PROC Nhaphang(@shdn nvarchar(10), @masp nvarchar(10), @manv nvarchar (10), @ngaynhap date, @soluongN int, @dongiaN money)
AS
IF @masp IN (SELECT tbSANPHAM.masp FROM tbSANPHAM) AND @manv IN (SELECT tbNHANVIEN.Manv FROM tbNHANVIEN)
BEGIN
IF @shdn IN (SELECT tbNHAP.Sohdn FROM tbNHAP)
BEGIN
UPDATE tbNHAP 
SET masp = @masp, manv = @manv, Ngaynhap = @ngaynhap, soluongN = @soluongN, dongiaN = @dongiaN
WHERE Sohdn = @shdn
END
ELSE
BEGIN
INSERT INTO tbNHAP(Sohdn, masp, manv, Ngaynhap, soluongN, dongiaN)
VALUES (@shdn, @masp, @manv, @ngaynhap, @soluongN, @dongiaN)
END
END
ELSE
BEGIN
RAISERROR (N'Mã sản phẩm và mã nhân viên không tồn tại',16,2)
ROLLBACK TRAN
END
GO