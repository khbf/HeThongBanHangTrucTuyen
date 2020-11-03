use QLNhaSach
go

/*************************************** CÁC CÂU TRUY VẤN GIẢ ĐỊNH ****************************************/

--Cho biết thông tin của những sách bán chạy (số lượng sách tồn trong kho < 10)
select S.MaSach, S.TenSach, TG.TenTacGia,S.MoTaSach, DM.TenDM, TL.TenLoai, S.NXB, S.GiaTien, S.SoLuongTon 
from (DANH_MUC_SACH as DM join THE_LOAI as TL on DM.MaDM = TL.MaDM) join (SACH as S join TAC_GIA as TG on S.TacGia = TG.MaTacGia)
																		on S.MaLoai = TL.MaLoai
where SoLuongTon < 10	

--Tìm các sách có thể loại là "Danh nhân văn hóa"
select S.MaSach, S.TenSach,S.TacGia, S.NguoiDich, S.MoTaSach,S.MaDM, S.MaLoai, S.NXB,S.NhaPhatHanh,
		   S.NgayPhatHanh,S.KhoiLuong, S.SoTrang,S.GiaTien,S.SoLuongTon
from SACH as S join THE_LOAI as L
				on S.MaLoai = L.MaLoai
where L.TenLoai = N'Danh nhân văn hóa'

--Tìm các đánh giá sản phẩm lớn hơn hoặc bằng 4 trong khoảng ngày 09/09/2019 đến 01/11/2019 
select S.MaSach, S.TenSach, DG.NgayDanhGia, DG.DanhGia
from SACH as S join DANH_GIA_SAN_PHAM DG 
				on DG.MaSach_DanhGia = S.MaSach															
where DG.DanhGia >= 4 and (DG.NgayDanhGia between '2019-09-09' and '2019-11-01')


-- Cho biết thông tin phiếu giao hàng của các đơn hàng có số đơn hàng > 1005
select *
from PHIEU_GIAO_HANG 														
where SoDH_DuocGiao > 1005

--Tìm các tài khoản khách hàng là nữ và có ngày sinh trước năm 1997
select *
from KHACH_HANG 														
where GioiTinh = '0' and year(NgaySinh) < 1997 

--Tìm các sách có thể loại là ‘Truyện Dài’ và thuộc danh mục ‘Sách Văn Học Trong Nước’ có số lượng tồn ít hơn 20.
select  S.TenSach
from (DANH_MUC_SACH as DM join THE_LOAI as TL on DM.MaDM = TL.MaDM) join SACH as S 
																	on S.MaLoai = TL.MaLoai
where TL.TenLoai = N'Truyện Dài' and DM.TenDM = N'Sách Văn Học Trong Nước' and S.SoLuongTon < 20

--Tìm các đơn hàng của các khách hàng có họ là ‘Nguyễn” và có tổng tiền lớn hơn 500.000đ
select dh.SoDonHang, kh.TenKH
from DON_HANG dh join KHACH_HANG kh on dh.MaKH_DatHang = kh.MaKH
where kh.TenKH LIKE N'Nguyễn %' and dh.TongTien_DonHang > 500000

