use QLNhaSach
go

/*************************************** STORED - FUNCTION CÁC CHỨC NĂNG ****************************************/
---	Ngày giao hàng phải sau ngày đặt hàng và không trễ quá 1 ngày kể từ ngày đặt hàng.
go 
Create trigger trg_NgayGH_DH 
On DON_HANG
For update, insert
As
Begin
	If exists(select *
			  from Inserted I, DON_HANG P
			  Where P.SoDonHang = I.SoDonHang And
			  (P.NgayGiaoHang < I.NgayDatHang Or Datediff (DD, I.NgayDatHang, P.NgayGiaoHang) > 1))
	Begin
		Raiserror('Ngay khong hop le',16,1)
		Rollback transaction
	End
End
------------------------------------ STORED CHỨC NĂNG CHUNG CHO CẢ KH VÀ NV ---------------------------------------------------
go
/************ ĐĂNG KÝ TÀI KHOẢN ************/
create proc DangKyTaiKhoan
	@ten nvarchar(50),
	@ngaysinh datetime,
	@gioitinh bit,
	@sdtNV char(10),
	@email varchar(50),
	@pass varchar(50),
	@loaitk bit,
	@kq int out
as
begin
	if CHARINDEX('@',@email) = 0
	begin
		set @kq = 0
		return
	end
	begin try
		insert into TAI_KHOAN(Email, MatKhau, LoaiTaiKhoan)
		values(@email, @pass,@loaitk)

		declare @taikhoan int
		select @taikhoan = SCOPE_IDENTITY()			--taikhoan from TAI_KHOAN where Email = @email		
		if @loaitk = 1
		begin
			insert into KHACH_HANG(TenKH, NgaySinh, TaiKhoan_KH, GioiTinh)
			values(@ten, @ngaySinh, @taikhoan, @gioitinh)
		end

		if @loaitk = 0
		begin
			insert into NHAN_VIEN(TenNV, TaiKhoan_NV, SDT_NV)
			values(@ten,@taikhoan,@sdtNV)
		end
		set @kq = 1
	end try
	begin catch
		set @kq = 0
		return
	end catch
end

/*declare @kqout int
exec DangKyTaiKhoan N'Nguyễn Tất Thanh','1982-01-02', 1, '0188942513','ntthanh@gmail.com', '123456', 0, @kqout out
print cast(@kqout as varchar(50))
go

declare @kqout int
exec DangKyTaiKhoan N'Nguyễn Văn Thanh','1990-01-23', 1, NULL,'nvthanh@gmail.com', '112233', 1, @kqout out
print cast(@kqout as varchar(50))
go 
*/

-------- BẢNG SÁCH -----------
--Tìm kiếm các sách theo tên sách
go
create proc TKiemSach_TheoTenSach
	@tensach nvarchar(50)
as
begin
	select S.MaSach, S.TenSach, TG.TenTacGia,S.MoTaSach, DM.TenDM, TL.TenLoai, S.NXB, S.GiaTien, S.SoLuongTon 
	from (DANH_MUC_SACH as DM join THE_LOAI as TL on DM.MaDM = TL.MaDM) join (SACH as S join TAC_GIA as TG on S.TacGia = TG.MaTacGia)
																		on S.MaLoai = TL.MaLoai
	where TenSach LIKE '%' + @tensach + '%'
end

--execute TKiemSach_TheoTenSach N'THE'

--Tìm kiếm các sách theo tên tác giả
go
create proc TKiemSach_TheoTenTacGia
	@tentacgia nvarchar(50)
as
begin
	select S.MaSach, S.TenSach, TG.TenTacGia,S.MoTaSach, DM.TenDM, TL.TenLoai, S.NXB, S.GiaTien, S.SoLuongTon 
	from (DANH_MUC_SACH as DM join THE_LOAI as TL on DM.MaDM = TL.MaDM) join (SACH as S join TAC_GIA as TG on S.TacGia = TG.MaTacGia)
																		on S.MaLoai = TL.MaLoai
	where TG.TenTacGia LIKE '%' + @tentacgia + '%'
end

--execute TKiemSach_TheoTenTacGia N'Bộ Tài Chính'

--Tìm kiếm các sách theo danh mục 
go
create proc TKiemSach_TheoDanhMuc
	@tendm nvarchar(50)
as
begin
	select S.MaSach, S.TenSach, TG.TenTacGia,S.MoTaSach, DM.TenDM, TL.TenLoai, S.NXB, S.GiaTien, S.SoLuongTon 
	from (DANH_MUC_SACH as DM join THE_LOAI as TL on DM.MaDM = TL.MaDM) join (SACH as S join TAC_GIA as TG on S.TacGia = TG.MaTacGia)
																		on S.MaLoai = TL.MaLoai
	where DM.TenDM LIKE '%' + @tendm + '%'
end

--execute TKiemSach_TheoDanhMuc N'Sách Văn học'

--Tìm kiếm các sách theo thể loại
go
create proc TKiemSach_TheoTheLoai
	@tentheloai nvarchar(50)
as
begin
	select S.MaSach, S.TenSach, TG.TenTacGia,S.MoTaSach, DM.TenDM, TL.TenLoai, S.NXB, S.GiaTien, S.SoLuongTon 
	from (DANH_MUC_SACH as DM join THE_LOAI as TL on DM.MaDM = TL.MaDM) join (SACH as S join TAC_GIA as TG on S.TacGia = TG.MaTacGia)
																		on S.MaLoai = TL.MaLoai
	where TL.TenLoai LIKE '%' + @tentheloai + '%'
end

--execute TKiemSach_TheoTheLoai N'Classics'

--Tìm kiếm sách theo danh mục + thể loại
go
create proc TKiemSach_TheoTheLoai_DanhMuc
	@tentheloai nvarchar(50),
	@tendm nvarchar(50)
as
begin
	select S.MaSach, S.TenSach, TG.TenTacGia,S.MoTaSach, DM.TenDM, TL.TenLoai, S.NXB, S.GiaTien, S.SoLuongTon 
	from (DANH_MUC_SACH as DM join THE_LOAI as TL on DM.MaDM = TL.MaDM) join (SACH as S join TAC_GIA as TG on S.TacGia = TG.MaTacGia)
																		on S.MaLoai = TL.MaLoai
	where (TL.TenLoai LIKE '%' + @tentheloai + '%') and (DM.TenDM LIKE '%' + @tendm + '%')
end

--execute TKiemSach_TheoTheLoai_DanhMuc N'History',N''

--Tìm kiếm sách bán chạy nhất
go
create proc TKiemSach_BanChayNhat
as
begin
	select S.MaSach, S.TenSach, TG.TenTacGia,S.MoTaSach, DM.TenDM, TL.TenLoai, S.NXB, S.GiaTien, S.SoLuongTon 
	from (DANH_MUC_SACH as DM join THE_LOAI as TL on DM.MaDM = TL.MaDM) join (SACH as S join TAC_GIA as TG on S.TacGia = TG.MaTacGia)
																		on S.MaLoai = TL.MaLoai
	where SoLuongTon < 10				--số lượng tồn của sách nếu < 10 thì sẽ thuộc loại sách bán chạy
end

--execute TKiemSach_BanChayNhat 

-- Khách hàng tìm kiếm sách theo thị trường (Sách bán chạy, giá từ thấp - cao, giá từ cao - thấp, theo đánh giá SP cao)
GO
create proc TimKiemSach_GiaTuThapDenCao        
as
begin
	--select theo giá từ thấp - cao
	select S.MaSach, S.TenSach, TG.TenTacGia,S.MoTaSach, DM.TenDM, TL.TenLoai, S.NXB, S.GiaTien, S.SoLuongTon 
	from (DANH_MUC_SACH as DM join THE_LOAI as TL on DM.MaDM = TL.MaDM) join (SACH as S join TAC_GIA as TG on S.TacGia = TG.MaTacGia)
																		on S.MaLoai = TL.MaLoai
	order by S.GiaTien asc
end

--execute TimKiemSach_GiaTuThapDenCao

go
create proc TimKiemSach_GiaTuCaoDenThap        
as
	--select theo giá từ cao - thấp
begin
	select S.MaSach, S.TenSach, TG.TenTacGia,S.MoTaSach, DM.TenDM, TL.TenLoai, S.NXB, S.GiaTien, S.SoLuongTon 
	from (DANH_MUC_SACH as DM join THE_LOAI as TL on DM.MaDM = TL.MaDM) join (SACH as S join TAC_GIA as TG on S.TacGia = TG.MaTacGia)
																		on S.MaLoai = TL.MaLoai
	order by S.GiaTien desc
end

go
create proc TimKiemSach_DanhGiaSPCao
as
	--select theo dánh giá SP cao
begin
	select S.MaSach, S.TenSach, TG.TenTacGia,S.MoTaSach, DM.TenDM, TL.TenLoai, S.NXB, S.GiaTien, S.SoLuongTon 
	from (DANH_MUC_SACH as DM join THE_LOAI as TL on DM.MaDM = TL.MaDM) join (SACH as S join TAC_GIA as TG on S.TacGia = TG.MaTacGia)
																		on S.MaLoai = TL.MaLoai
	where	S.MaSach in (select DG.MaSach_DanhGia 
						 from DANH_GIA_SAN_PHAM DG join KHACH_HANG KH
												   on DG.MaKH_DanhGia = KH.MaKH
						 where DG.DanhGia >= 4)
end

-- Khách hàng hay nhân viên login 
GO
create proc DangNhap 
	@email varchar(50), 
	@pass varchar(50), 
	@loaitk bit,
	@kq int out
as
Begin
		if not exists (select * from TAI_KHOAN 
						where Email = @email and MatKhau = @pass and LoaiTaiKhoan = @loaitk)
		Begin
			set @kq = 0
			return
		End
		set @kq = 1
End

/************ THÊM ĐÁNH GIÁ SẢN PHẨM ************/
go
create proc KH_ThemDanhGiaSP
	@masach int,			 --khóa ngoại tới bảng SACH
	@makh int,				 --khóa ngoại tới bảng KHACH_HANG
	@ngaydanhgia datetime,
	@tieude nvarchar(50),
	@danhgia int,			 --đánh giá từ 1 đến 5
	@noidung nvarchar(100),
	@kq int out				 
as
begin
	begin try
		insert into DANH_GIA_SAN_PHAM values(@masach,@makh,@ngaydanhgia,@tieude,@danhgia,@noidung)
	end try
	begin catch
		set @kq = 0
		return
	end catch
	set @kq = 1
end

/************ XÓA ĐÁNH GIÁ SẢN PHẨM ************/
go
create proc KH_XoaDanhGiaSP
	@masach int,			 --khóa ngoại tới bảng SACH
	@makh int,				 --khóa ngoại tới bảng KHACH_HANG
	@ngaydanhgia datetime,
	@kq int out				 
as
begin
	begin try
		delete from DANH_GIA_SAN_PHAM where MaSach_DanhGia = @masach and MaKH_DanhGia = @makh and NgayDanhGia = @ngaydanhgia
	end try
	begin catch
		set @kq = 0
		return
	end catch
	set @kq = 1
end

/************ CẬP NHẬT ĐÁNH GIÁ SẢN PHẨM ************/
go
create proc KH_CapNhatDanhGiaSP
	@masach int,			 --khóa ngoại tới bảng SACH
	@makh int,				 --khóa ngoại tới bảng KHACH_HANG
	@ngaydanhgia datetime,
	@tieude nvarchar(50),
	@danhgia int,
	@noidung nvarchar(100),
	@kq int out				 
as
begin
	begin try
		update DANH_GIA_SAN_PHAM 
		set TieuDe = @tieude, DanhGia = @danhgia, NoiDung = @noidung
		where MaSach_DanhGia = @masach and MaKH_DanhGia = @makh and NgayDanhGia = @ngaydanhgia
	end try
	begin catch
		set @kq = 0
		return
	end catch
	set @kq = 1
end

------------------------------------ STORED CHỨC NĂNG CHUNG CHO NHÂN VIÊN ---------------------------------------------------

-- Báo cáo thống kê danh sách các đơn hàng được giao dịch thành công theo ngày
go
create proc Report_DanhSachDHThanhCongTheoNgay
	@ngay datetime
as
begin
	select *
	from DON_HANG 
	where NgayDatHang = @ngay and TrangThai = 3
end

--exec Report_DanhSachDHThanhCongTheoNgay '10/10/2019'

-- Nhân viên xóa Khách hàng theo mã
go
create proc NV_XoaKhachHangTheoMaKH
	@makh int,				 
	@kq int out				 
as
begin
	declare @matk int
	select @matk = MaTaiKhoan from TAI_KHOAN TK join KHACH_HANG KH 
												 on TK.MaTaiKhoan = KH.TaiKhoan_KH
	where KH.MaKH = @makh

	begin try
		delete from KHACH_HANG where MaKH = @makh			--xóa thông tin khách hàng
		delete from TAI_KHOAN where MaTaiKhoan = @matk		--xóa tài khoản khách hàng trong hệ thống
	end try
	begin catch
		set @kq = 0
		return
	end catch
	set @kq = 1
end

/*
declare @kqout int
exec NV_XoaKhachHangTheoMaKH '121', @kqout out
print cast(@kqout as varchar(50))
go
*/
-- Nhân viên cấp cao xóa nhân viên đang làm tại hệ thống theo mã
go
create proc XoaNhanVienKhoiHeThong
	@manv int,				 
	@kq int out				 
as
begin
	declare @matk int
	select @matk = MaTaiKhoan from TAI_KHOAN TK join NHAN_VIEN NV 
												 on TK.MaTaiKhoan = NV.TaiKhoan_NV
	where NV.MaNV = @manv

	begin try
		delete from NHAN_VIEN where MaNV = @manv			--xóa thông tin nhân viên
		delete from TAI_KHOAN where MaTaiKhoan = @matk		--xóa tài khoản nhân viên trong hệ thống
	end try
	begin catch
		set @kq = 0
		return
	end catch
	set @kq = 1
end

-- Nhân viên tìm kiếm khách hàng theo mã
go
create proc TKiemKH_TheoMaKH
	@makh int
as
begin
	select TK.MaTaiKhoan, KH.MaKH, KH.TenKH, KH.NgaySinh, KH.GioiTinh
	from KHACH_HANG KH join TAI_KHOAN TK on KH.TaiKhoan_KH = TK.MaTaiKhoan 
	where KH.MaKH = @makh
end

--execute TKiemKH_TheoMaKH '100'

-- Nhân viên cấp cao tìm kiếm nhân viên thường theo mã
go
create proc TKiemNV_TheoMaNV
	@manv int
as
begin
	select TK.MaTaiKhoan, NV.MaNV, NV.TenNV, NV.SDT_NV
	from NHAN_VIEN NV join TAI_KHOAN TK on NV.TaiKhoan_NV= TK.MaTaiKhoan
	where NV.MaNV = @manv
end

-- Nhân viên cập nhật một số thông tin DON_HANG
go
create proc NV_CapNhatDonHang
	@sodh int,			 
	@nvphutrach int,				 --khóa ngoại tới bảng NHAN_VIEN
	@trangthaidh int,
	@kq int out				 
as
begin
	begin try
		update DON_HANG 
		set NVPhuTrach = @nvphutrach, TrangThai = @trangthaidh
		where SoDonHang = @sodh
	end try
	begin catch
		set @kq = 0
		return
	end catch
	set @kq = 1
end

/************ THÊM DANH MỤC SÁCH ************/
go
create proc NV_ThemDanhMucSach
	@tendm nvarchar(50),
	@kq int out
as
begin
	begin try
			insert into DANH_MUC_SACH values(@tendm)
			set @kq = 1
	end try
	begin catch
		set @kq = 0
		return
	end catch
end

/************ CẬP NHẬT DANH MỤC SÁCH ************/
go
create proc NV_CapNhatDanhMucSach
	@madm int,
	@tendm nvarchar(50),
	@kq int out
as
begin
	begin try
			update DANH_MUC_SACH 
			set TenDM = @tendm
			where MaDM = @madm
	end try
	begin catch
		set @kq = 0
		return
	end catch
	set @kq = 1
end

/************ THÊM THỂ LOẠI ************/
go
create proc NV_ThemTheLoai
	@tenloai nvarchar(50),
	@madm int,
	@kq int out
as
begin
	begin try
		insert into THE_LOAI values(@tenloai,@madm)
	end try
	begin catch
		set @kq = 0
		return
	end catch
        set @kq = 1
end

/************ CẬP NHẬT THỂ LOẠI ************/
go
create proc NV_CapNhatTheLoai
	@maloai int,
	@tenloai nvarchar(50),
	@madm int,
	@kq int out
as
begin
	begin try
		update THE_LOAI 
		set TenLoai = @tenloai, MaDM = @madm
		where MaLoai = @maloai
	end try
	begin catch
		set @kq = 0
		return
	end catch
        set @kq = 1
end

/************ THÊM TÁC GIẢ ************/
go
create proc NV_ThemTacGia
	@tentacgia nvarchar(50),
	@gioithieu nvarchar(100),
	@kq int out
as
begin
	begin try
		insert into TAC_GIA(TenTacGia,GioiThieu) values(@tentacgia,@gioithieu)
	end try
	begin catch
		set @kq = 0
		return
	end catch
	set @kq = 1
end

/************ CẬP NHẬT TÁC GIẢ ************/
go
create proc NV_CapNhatTacGia
	@matacgia int,
	@tentacgia nvarchar(50),
	@gioithieu nvarchar(100),
	@kq int out
as
begin
	begin try
		update TAC_GIA
		set TenTacGia = @tentacgia, GioiThieu = @gioithieu
		where MaTacGia =@matacgia
	end try
	begin catch
		set @kq = 0
		return
	end catch
	set @kq = 1
end

/************ NV THÊM SÁCH ************/
go
create proc NV_ThemSach
	@tensach nvarchar(100),
	@tacgia int,				 --khóa ngoại tới bảng TAC_GIA
	@nguoidich nvarchar(50),
	@mota nvarchar(200),
	@madm int,					 --khóa ngoại tới bảng DANH_MUC_SACH
	@maloai int,				 --khóa ngoại tới bảng THE_LOAI
	@nxb nvarchar(50),
	@nhaphathanh nvarchar(50),
	@ngayphathanh datetime,
	@khoiluong float,
	@sotrang int,
	@giatien money,
	@soluongton int,
	@kq int out		 
as
begin
	begin try
		insert into SACH values(@tensach,@tacgia,@nguoidich,@mota,@madm,@maloai,@nxb,@nhaphathanh,
								@ngayphathanh,@khoiluong,@sotrang,@giatien,@soluongton)
	end try
	begin catch
		set @kq = 0
		return
	end catch
	set @kq = 1
end

/************ NV XÓA SÁCH ************/
go
create proc NV_XoaSach
	@masach int,
	@kq int out		 
as
begin
	begin try
		delete from SACH where MaSach = @masach
	end try
	begin catch
		set @kq = 0
		return
	end catch
	set @kq = 1
end

/************ CẬP NHẬT SÁCH ************/					
go
create proc NV_CapNhatSach
	@masach int,
	@tensach nvarchar(50),
	@tacgia int,				 --khóa ngoại tới bảng TAC_GIA
	@nguoidich nvarchar(50),
	@mota nvarchar(200),
	@madm int,					 --khóa ngoại tới bảng DANH_MUC_SACH
	@maloai int,				 --khóa ngoại tới bảng THE_LOAI
	@nxb nvarchar(50),
	@nhaphathanh nvarchar(50),
	@ngayphathanh datetime,
	@khoiluong float,
	@sotrang int,
	@giatien money,
	@soluongton int,
	@kq int out		 
as
begin
	begin try
		update SACH 
		set TenSach = @tensach, TacGia = @tacgia,NguoiDich = @nguoidich,MoTaSach =  @mota,MaDM = @madm,MaLoai = @maloai,
			NXB = @nxb,NhaPhatHanh = @nhaphathanh,NgayPhatHanh = @ngayphathanh,KhoiLuong = @khoiluong,SoTrang = @sotrang,
			GiaTien = @giatien,SoLuongTon = @soluongton
		where MaSach = @masach
	end try
	begin catch
		set @kq = 0
		return
	end catch
	set @kq = 1
end

-- nhân viên sửa thông tin cá nhân
GO
create proc NhanVien_SuaThongTinCaNhan 
	@email varchar(50), 
	@ten nvarchar(50), 
	@pass varchar(50), 
	@sdtNV char(10), 
	@loaitk bit, 
	@frag int out
as
begin
	Begin try
		declare @taikhoan int
		select @taikhoan = MaTaiKhoan from TAI_KHOAN where Email = @email

		update TAI_KHOAN
		set MatKhau = @pass
		where Email = @email

		begin
			update NHAN_VIEN
			set TenNV = @ten, SDT_NV = @sdtNV
			where TaiKhoan_NV = @taikhoan
		end
		set @frag = 1
	End try
	Begin catch
		set @frag = 0
		return
	End catch
end
go

/************ THÊM PHIẾU GIAO HÀNG ************/
create proc NV_ThemPhieuGiaoHang
	@sodh int,					--khóa ngoại tới bảng DON_HANG
	@tenkhnhan nvarchar(50),
	@tongtien money,
	@ghichu nvarchar(100)				 
as
begin
	insert into PHIEU_GIAO_HANG values(@sodh,@tenkhnhan,@tongtien,@ghichu)
end

/************ THÊM CHI TIẾT PHIẾU GIAO HÀNG ************/
go
create proc NV_ThemCTPGH
	@sopgh int,				--khóa ngoại tới bảng PHIEU_GIAO_HANG
	@masach int,			--khóa ngoại tới bảng SACH
	@soluonggiao int,
	@dongia money				 
as
begin
	insert into CHI_TIET_PHIEU_GIAO_HANG values(@sopgh,@masach,@soluonggiao,@dongia)
end



------------------------------------ STORED CHỨC NĂNG CHUNG CHO KHÁCH HÀNG ---------------------------------------------------
/************ THÊM ĐƠN HÀNG ************/
/* create proc ThemDonHang
	@makh int,					--khóa ngoại tới bảng KHACH_HANG
	@ngaydathang datetime,
	@ngaygiaohang datetime,
	@sdtKH char(10),				 
	@sonha varchar(20),
	@duong nvarchar(100),
	@phuongxa nvarchar(100),
	@quanhuyen nvarchar(100),
	@tinhthanh nvarchar(100),
	@nvphutrach int,			--khóa ngoại tới bảng NHAN_VIEN 
	@tongtien money,
	@sotaikhoan	char(14),		
	@hinhthucthanhtoan int,		-- (0 - trực tiếp, 1 - qua thẻ)
	@phivanchuyen money,		-- nếu đơn hàng >= 250k trở lên thì miễn phí, nếu < 250k thì tính phí = 30.000 cho 1 lần giao
	@trangthai int				-- (0 – Đã xác nhận, 1 – Đã thanh toán, 2 – Đang chuyển hàng, 3 – Giao dịch thành công, 4 - Giao dịch thất bại, Hủy đơn hàng)
as
begin
	insert into DON_HANG values(@makh,@ngaydathang,@ngaygiaohang,@sdtKH,@sonha,@duong,@phuongxa,@quanhuyen,@tinhthanh,
								@nvphutrach,@tongtien,@sotaikhoan,@hinhthucthanhtoan,@phivanchuyen,@trangthai)
end 

/************ THÊM CHI TIẾT ĐƠN HÀNG ************/
create proc ThemCTDH
	@sodh int,				--khóa ngoại tới bảng DON_HANG
	@masach int,			--khóa ngoại tới bảng SACH
	@soluong int,
	@dongia money				 
as
begin
	insert into CHI_TIET_DON_HANG values(@sodh,@masach,@soluong,@dongia)
end */

-- Khách hàng  sửa thông tin cá nhân
GO
create proc KhachHang_SuaThongTinCaNhan 
	@email varchar(50), 
	@ten nvarchar(50), 
	@pass varchar(50), 
	@gioitinh bit, 
	@ngaysinh datetime,
	@loaitk bit, 
	@kq int out
as
begin
	Begin try
		declare @taikhoan int
		select @taikhoan = MaTaiKhoan from TAI_KHOAN where Email = @email

		update TAI_KHOAN
		set MatKhau = @pass
		where Email = @email

		begin
			update KHACH_HANG
			set TenKH = @ten, NgaySinh = @ngaySinh, GioiTinh = @gioitinh
			where TaiKhoan_KH = @taikhoan
		end
		set @kq = 1
	End try
	Begin catch
		set @kq = 0
		return
	End catch
end
go

-------- BẢNG ĐÁNH GIÁ SP  -----------
--Tìm kiếm đánh giá SP theo tên sản phẩm
go
create proc TKiemDGSP_TheoTenSP
	@tensp nvarchar(100)
as
begin
	select dg.MaSach_DanhGia, s.TenSach,dg.MaKH_DanhGia,dg.NgayDanhGia,dg.TieuDe, dg.DanhGia,dg.NoiDung
	from DANH_GIA_SAN_PHAM dg join SACH s on dg.MaSach_DanhGia = s.MaSach
	where s.TenSach LIKE '%' + @tensp + '%'
end

--execute TKiemDGSP_TheoTenSP N'Tầm nhìn'

--Tìm kiếm đánh giá SP theo mã khách hàng
go
create proc TKiemDGSP_TheoMaKH
	@makh int
as
begin
	select dg.MaSach_DanhGia, s.TenSach,dg.MaKH_DanhGia,dg.NgayDanhGia,dg.TieuDe, dg.DanhGia,dg.NoiDung
	FROM DANH_GIA_SAN_PHAM dg join SACH s on dg.MaSach_DanhGia = s.MaSach
	where dg.MaKH_DanhGia = @makh 
end

--execute TKiemDGSP_TheoMaKH '101'

-------- BẢNG ĐƠN HÀNG -----------
--Tìm kiếm đơn hàng theo SoDonHang
go
create proc TKiemDonHang_TheoSoDH
	@sodh int
as
begin
	select *
	from DON_HANG
	where SoDonHang = @sodh 
end

--exec TKiemDonHang_TheoSoDH '1000'

--Tìm kiếm CT đơn hàng theo SoDonHang
go
create proc TKiemCTDH_TheoSoDH
	@sodh int
as
begin
	select *
	from CHI_TIET_DON_HANG
	where SoDH = @sodh 
end

--Tìm kiếm đơn hàng theo ngày đặt hàng (từ ngày … đến ngày) 

--Tìm kiếm các đơn hàng theo MaKH
go
create proc TKiemDonHang_TheoMaKH
	@makh int
as
begin
	select DH.SoDonHang, DH.MaKH_DatHang, DH.NgayDatHang, DH.NgayGiaoHang,DH.SDT_KH,DH.SoNha,DH.Duong,DH.PhuongXa,DH.QuanHuyen,DH.TinhThanh,
		   DH.NVPhuTrach, DH.TongTien_DonHang,DH.SoTaiKhoan,DH.HinhThucThanhToan,DH.PhiVanChuyen,DH.TrangThai
	from DON_HANG as DH join KHACH_HANG as KH
						on DH.MaKH_DatHang = KH.MaKH
	where DH.MaKH_DatHang = @makh 
end

--exec TKiemDonHang_TheoMaKH '101'

--Tìm kiếm các CT đơn hàng theo MaKH
go
create proc TKiemCTDH_TheoMaKH
	@makh int
as
begin
	select CT.SoDH, CT.MaSach_CTDH,CT.SoLuong,CT.DonGia
	from KHACH_HANG as KH join (CHI_TIET_DON_HANG as CT join DON_HANG as DH
													    on CT.SoDH = DH.SoDonHang) 
						  on DH.MaKH_DatHang = KH.MaKH
	where DH.MaKH_DatHang = @makh 
end

--exec TKiemCTDH_TheoMaKH '101'

-------- BẢNG CHI TIẾT ĐƠN HÀNG -----------
--Tìm kiếm CT đơn hàng theo SoDonHang

--Tìm kiếm CT đơn hàng theo ngày đặt hàng (từ ngày … đến ngày) 

--Tìm kiếm các CT đơn hàng theo MaKH

-------- BẢNG PHIẾU GIAO HÀNG -----------
--Tìm kiếm phiếu giao hàng theo SoDH_DuocGiao

--Tìm kiếm phiếu giao hàng theo ngày giao hàng (từ ngày … đến ngày) 

--Tìm kiếm các phiếu giao hàng theo MaKH

-------- BẢNG CHI TIẾT PHIẾU GIAO HÀNG -----------
--Tìm kiếm CT phiếu giao hàng theo SoDH_DuocGiao

--Tìm kiếm CT phiếu giao hàng theo ngày giao hàng (từ ngày … đến ngày) 

--Tìm kiếm các CT phiếu giao hàng theo MaKH



-- Khách hàng quản lý giỏ hàng (thêm sách vào giỏ hàng)							--CHƯA CHẠY ĐƯỢC!!!
GO
create proc KHThemSachVaoGioHang
	@masach int, 
	@maKH int, 
	@frag int out
as
begin
	--kiem tra so luong them sach ton tai voi so luong sach co trong stock
	if (select SoLuongTon from SACH where MaSach = @maSach) - 1 < 0
	Begin
		set @frag = 0;
	End
	Else
	Begin
		declare @thanhTien float
		set @thanhTien = (select GiaTien from SACH where MaSach = @maSach)
	
	--doi voi khach chua them sach nao vao gio thi tao gio cho khach
		If not exists (select * from DON_HANG where MaKH_DatHang = @maKH)
		begin

				insert into DON_HANG(MaKH_DatHang, NgayDatHang)
				values(@maKH, GETDATE())

				insert into CHI_TIET_DON_HANG(SoDH,MaSach_CTDH, SoLuong,DonGia)
				values(SCOPE_IDENTITY(), @masach, 1, @thanhTien)

		end
		Else		--neu khach da co gio hang thi update lai
		Begin
			if not exists (select * from DON_HANG gh
									where MaKH_DatHang = @maKH and SoDonHang not in( select SoDonHang from DON_HANG dh))
			Begin
				insert into DON_HANG(MaKH_DatHang, NgayDatHang)
				values(@maKH, GETDATE())

				insert into CHI_TIET_DON_HANG(SoDH,MaSach_CTDH, SoLuong,DonGia)
				values(SCOPE_IDENTITY(), @masach, 1, @thanhTien)
			End
			Else
			Begin
				declare @gioID int
				select @gioID = SoDonHang from DON_HANG where MaKH_DatHang = @maKH
				if not exists (select * from CHI_TIET_DON_HANG where SoDH = @gioID and MaSach_CTDH = @maSach)
				Begin
					insert into CHI_TIET_DON_HANG(SoDH,MaSach_CTDH, SoLuong,DonGia)
					values(@gioID, @masach, 1, @thanhTien)
				End
				else
				Begin
					update CHI_TIET_DON_HANG
					set SoLuong = SoLuong + 1,
					DonGia = DonGia + (select GiaTien from SACH where MaSach = @maSach)
					where MaSach_CTDH = @maSach and SoDH = @gioID
				End
			End
		End

		--lay gio id chua thanh toan
		--declare @gioIDTrongDonHang int
		--select @gioIDTrongDonHang = gh.gio_ID from tbl_DonHang dh join tbl_GioHang gh on gh.gio_ID = dh.gio_ID

		declare @newGioID int
		select @newGioID = max(SoDonHang) from DON_HANG
		
		--cap nhat lai tong tien trong gio hang khi da them sach vao chi tiet gio hang
		update DON_HANG
		set TongTien_DonHang = (select sum(DonGia)
								from CHI_TIET_DON_HANG
								where MaKH_DatHang = @maKH and SoDH = @newGioID
								group by SoDH)
		where MaKH_DatHang = @maKH and SoDonHang in (select max(SoDonHang) from DON_HANG)
		--cap nhat sach khi da duoc khach them vao gio
		update SACH
		set SoLuongTon = SoLuongTon - 1
		where MaSach = @maSach

		set @frag = 1
	End
end
go

--xóa sách khỏi giỏ hàng						--CHƯA CHẠY ĐƯỢC!!!
go
create proc XoaSachTrongGio 
	@maKH int, 
	@maSach int,
	@kieuXoa bit,
	@frag int out
as
begin
	if @kieuXoa = 0
	begin
		delete from CHI_TIET_DON_HANG
		where  MaSach_CTDH = @maSach and SoDH in (select gh.SoDonHang 
												from DON_HANG gh 
												where gh.MaKH_DatHang = @maKH)
		set @frag = 1
	end
	Else
	Begin
		declare @gioID int
		select @gioID = gh.SoDonHang from DON_HANG gh
									where gh.MaKH_DatHang = @maKH

		if (select SoLuong from CHI_TIET_DON_HANG where SoDH = @gioID and MaSach_CTDH = @maSach) - 1 < 1
		Begin
			set @frag = 0
		End
		
		Else
		Begin
			update CHI_TIET_DON_HANG
			set SoLuong = SoLuong - 1, DonGia = DonGia - (select GiaTien 
														  from SACH 
														  where MaSach = @maSach)
			where SoDH = @gioID and MaSach_CTDH = @maSach

			update SACH
			set SoLuongTon = SoLuongTon + 1
			where MaSach = @maSach

			update DON_HANG
			set TongTien_DonHang = (select sum(ctg.DonGia)
											from CHI_TIET_DON_HANG ctg
											where SoDH = @gioID
											group by SoDH)
			where SoDonHang = @gioID
			
			set @frag = 1
		End
	End
end
go

--Khách hàng xem thông tin sách
GO
create proc KHXemThongTinSach 
	@maSach int
as
begin
	select S.TenSach, TG.TenTacGia, S.NguoiDich,S.MoTaSach, DM.TenDM, TL.TenLoai, S.NXB, S.NhaPhatHanh, S.NgayPhatHanh, 
			S.KhoiLuong, S.SoTrang, S.GiaTien, S.SoLuongTon
	from (DANH_MUC_SACH as DM join THE_LOAI as TL
							  on DM.MaDM = TL.MaDM) join (SACH as S join TAC_GIA as TG
																	on S.TacGia = TG.MaTacGia)
													on S.MaLoai = TL.MaLoai
	where S.MaSach = @maSach
end
go

--Tóm tắt thông tin đơn hàng
go
create proc tomTatThongTinDH			
	@email varchar(50), 
	@tongSoLuongSach int out, 
	@tongCong float out 
as
begin

	declare @makh int
	select @makh = kh.MaKH 
	from KHACH_HANG kh join TAI_KHOAN tk
	on kh.TaiKhoan_KH= tk.MaTaiKhoan
	where tk.Email = @email

	select @tongSoLuongSach = sum(ctg.SoLuong)
	from CHI_TIET_DON_HANG ctg join DON_HANG gh
	on ctg.SoDH = gh.SoDonHang
	where gh.MaKH_DatHang = @makh
	group by gh.SoDonHang

	select @tongCong = TongTien_DonHang 
	from DON_HANG
	where MaKH_DatHang = @makh

	if @tongCong > 0
		return

	set @tongCong = -1

end
go