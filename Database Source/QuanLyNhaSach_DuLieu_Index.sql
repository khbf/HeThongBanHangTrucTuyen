create database QLNhaSach
go

use QLNhaSach
go

/*---------------------------------------------- THIẾT KẾ CƠ SỞ DỮ LIỆU ------------------------------------------- */

/* Bảng TAI_KHOAN */
create table TAI_KHOAN
(
	MaTaiKhoan int not null identity(1,1),
	Email varchar(50) not null,
	MatKhau varchar(50) not null,
	LoaiTaiKhoan bit not null		--True (1): Khách hàng, False (0): Nhân viên
	primary key (MaTaiKhoan)
)

/* Bảng KHACH_HANG */
create table KHACH_HANG
(
	MaKH int not null identity(100,1),
	TenKH nvarchar(50) not null,
	NgaySinh datetime,
	TaiKhoan_KH int not null,		-- là duy nhất để phân biệt
	GioiTinh bit					-- True (1): nam, False (0): nữ
	primary key (MaKH)
)

/* Bảng NHAN_VIEN */
create table NHAN_VIEN
(
	MaNV int not null identity(1000,1),
	TenNV nvarchar(50) not null,
	TaiKhoan_NV int not null,		-- là duy nhất để phân biệt
	SDT_NV char(10) not null
	primary key (MaNV)
)

/* Bảng THE_LOAI */
create table THE_LOAI
(
	MaLoai int not null identity(100,1),
	TenLoai nvarchar(50) not null,
	MaDM INT not null					--cho biết thể loại thuộc ở danh mục nào
	primary key (MaLoai)
)

/* Bảng DANH_MUC_SACH */
create table DANH_MUC_SACH
(
	MaDM int not null identity(100,1),
	TenDM nvarchar(50) not null
	primary key (MaDM)
)

/* Bảng TAC_GIA */
create table TAC_GIA
(
	MaTacGia int not null identity(100,1),
	TenTacGia nvarchar(50) not null,
	GioiThieu nvarchar(100)			--có thể giới thiệu 1 vài thông tin về tác giả
	primary key (MaTacGia)
)

/* Bảng SACH */
create table SACH
(
	MaSach int not null identity(100,1),
	TenSach nvarchar(100) not null,
	TacGia INT not null,
	NguoiDich nvarchar(50),
	MoTaSach nvarchar(200),
	MaDM int not null,								--cho biết thuộc ở danh mục nào
	MaLoai int not null,							--cho biết thuộc ở thể loại nào
	NXB nvarchar(50),
	NhaPhatHanh nvarchar(50) not null,
	NgayPhatHanh datetime not null,
	KhoiLuong float,
	SoTrang int,
	GiaTien money not null,
	SoLuongTon int not null							--số lượng sách đang còn trong kho ở hiện tại
	primary key (MaSach)
)

/* Bảng DANH_GIA_SAN_PHAM */
create table DANH_GIA_SAN_PHAM
(
	MaSach_DanhGia int not null,					--cho biết cuốn sách đang được đánh giá
	MaKH_DanhGia int not null,						--cho biết khách hàng nào đánh giá
	NgayDanhGia datetime not null,					--cho biết ngày khách hàng đánh giá sản phẩm
	TieuDe nvarchar(50),							--tiêu đề có thể góp ý kiến (comment)
	DanhGia int not null,							--đánh giá sao từ 1 đến 5 (1 - nhỏ nhất, 5 - lớn nhất)
	NoiDung nvarchar(100)							--nội dung khách hàng góp ý (comment) cho sản phẩm
	primary key (MaSach_DanhGia,MaKH_DanhGia,NgayDanhGia)
)

/* Bảng DON_HANG */
create table DON_HANG
(
	SoDonHang int not null identity(1000,1),
	MaKH_DatHang int not null,						--cho biết đơn hàng của khách nào
	NgayDatHang datetime not null,					--cho biết ngày khách hàng đặt đơn hàng
	NgayGiaoHang datetime not null,					--Phai sau thoi gian don hang it nhat 1 ngày
	SDT_KH char(10) not null,
	SoNha varchar(20) not null,
	Duong nvarchar(100) not null,
	PhuongXa nvarchar(100) not null,
	QuanHuyen nvarchar(100) not null,
	TinhThanh nvarchar(100) not null,
	NVPhuTrach int not null,						--cho biết nhân viên sẽ phụ trách giao đơn hàng này
	TongTien_DonHang money not null,				-- tổng tiền của các CTDH
	SoTaiKhoan char(14),	 						--cho biết số tài khoản của khách hàng để giao dịch (khi hình thức thanh toán là bằng thẻ)
	HinhThucThanhToan int not null,					-- (0 - trực tiếp, 1 - qua thẻ)
	PhiVanChuyen money not null,					-- nếu đơn hàng >= 250k trở lên thì miễn phí, nếu < 250k thì tính phí = 30.000 cho 1 lần giao
	TrangThai int not null		-- (0 – Đã xác nhận, 1 – Đã thanh toán, 2 – Đang chuyển hàng, 3 – Giao dịch thành công, 4 - Giao dịch thất bại, Hủy đơn hàng)
	primary key (SoDonHang)
)

/* Bảng CHI_TIET_DON_HANG */
create table CHI_TIET_DON_HANG
(
	SoDH int not null,
	MaSach_CTDH int not null,				--cho biết sản phẩm khách hàng đang chọn
	SoLuong int not null,					--số lượng của sản phẩm đó là bao nhiêu
	DonGia money not null					--so luong * gia cua 1 sach
	primary key (SoDH,MaSach_CTDH)
)

/* Bảng GIO_HANG 
create table GIO_HANG
(
	MaGioHang char(5) not null,
	MaKH char(5),

	NgayTaoGioHang datetime,
	MaSach_GioHang char(5),
	SoLuong int
	primary key (MaGioHang)
) 
*/

/* Bảng PHIEU_GIAO_HANG */
create table PHIEU_GIAO_HANG
(
	SoPhieuGiaoHang int not null identity(1000,1),
	SoDH_DuocGiao int not null,								--cho biết số đơn hàng đang được giao
	TenKHNhan nvarchar(50) not null,						--cho biết tên khách hàng nhận hàng
	TongTien_PGH money not null,							--cho biết tổng sổ tiền của phiếu giao hàng (= tổng tiền từ các CTPGH)
	GhiChu nvarchar(100)									--có thể ghi chú vài thông tin nếu cần
	primary key (SoPhieuGiaoHang)
)

/* Bảng CHI_TIET_PHIEU_GIAO_HANG */
create table CHI_TIET_PHIEU_GIAO_HANG
(
	SoPGH int not null,
	MaSach_CTPGH int not null,					--cho biết chi tiết 1 sản phẩm khách hàng đã chọn và đang được giao
	SoLuongGiao int not null,					--số lượng giao	của sản phẩm đó
	DonGia money not null						--đơn giá của 1 chi tiết sản phẩm đó
	primary key (SoPGH,MaSach_CTPGH)
)

/***** CHECK - DEFAULT *****/

--đánh giá rating phải nằm trong khoảng từ [1,5]
alter table DANH_GIA_SAN_PHAM
add constraint CK_DGSP check (DanhGia between 1 and 5 ) 
--Giá tiền sách >= 0
alter table SACH
add constraint CK_GiaTien_Sach check (GiaTien >= 0) 
--Khối lượng sách >= 0
alter table SACH
add constraint CK_KL_Sach check (KhoiLuong >= 0) 
--Số trang của sách > 10
alter table SACH
add constraint CK_SoTrang_Sach check (SoTrang > 10) 
--Số lượng tồn của sách > 0
alter table SACH
add constraint CK_SLTon_Sach check (SoLuongTon > 0) 
--Phí vận chuyển của đơn hàng >= 0
alter table DON_HANG 
add constraint CK_PhiVC_DH check (PhiVanChuyen >= 0) 
--Tổng tiền của đơn hàng >= 0
alter table DON_HANG 
add constraint CK_TongTien_DH check (TongTien_DonHang >= 0) 
--Hình thức thanh toán trong bảng DON_HANG phải có giá trị nằm trong khoảng [0,1]
alter table DON_HANG 
add constraint CK_HTTT_DH check (HinhThucThanhToan between 0 and 1) 
--TrangThai trong bảng DON_HANG phải có giá trị nằm trong khoảng [0,4] 
alter table DON_HANG 
add constraint CK_TrangThai_DH check (TrangThai between 0 and 4) 
--Số lượng của 1 sản phẩm trong CTDH >= 0
alter table CHI_TIET_DON_HANG  
add constraint CK_SL_CTDH check (SoLuong >= 0) 
--Đơn giá của 1 CTDH >= 0
alter table CHI_TIET_DON_HANG  
add constraint CK_DonGia_CTDH check (DonGia >= 0) 
--Tổng tiền của 1 phiếu giao hàng >= 0
alter table PHIEU_GIAO_HANG   
add constraint CK_TongTien_PGH check (TongTien_PGH >= 0) 
--Số lượng giao của 1 sản phẩm trong CTPGH >= 0
alter table CHI_TIET_PHIEU_GIAO_HANG   
add constraint CK_SLGiao_CTPGH check (SoLuongGiao >= 0) 
--Đơn giá của 1 CTPGH >= 0
alter table CHI_TIET_PHIEU_GIAO_HANG   
add constraint CK_DonGia_CTPGH check (DonGia >= 0) 

alter table DON_HANG add constraint df_SDTKH default '0000000000' for SDT_KH
alter table DON_HANG add constraint df_SoNha default 'Chua cap nhat' for SoNha
alter table DON_HANG add constraint df_Duong default 'Chua cap nhat' for Duong
alter table DON_HANG add constraint df_PhuongXa default 'Chua cap nhat' for PhuongXa
alter table DON_HANG add constraint df_QuanHuyen default 'Chua cap nhat' for QuanHuyen
alter table DON_HANG add constraint df_TinhThanh default 'Chua cap nhat' for TinhThanh
alter table DON_HANG add constraint df_NVPT default '0' for NVPhuTrach
alter table DON_HANG add constraint df_HinhThucThanhToan default '2' for HinhThucThanhToan
alter table DON_HANG add constraint df_PhiVanChuyen default '0' for PhiVanChuyen
alter table DON_HANG add constraint df_TrangThai default '5' for TrangThai	-- 5 là ở trạng thái mới tạo đơn hàng khi chọn mua sp nhưng chưa xác nhận đơn hàng

--tổng tiền trong đơn hàng được đặt default là 0
alter table DON_HANG add constraint df_TongTien default '0' for TongTien_DonHang
alter table DON_HANG add constraint df_NgayDatHang default '00-00-0000 00:00:00.000' for NgayDatHang
alter table DON_HANG add constraint df_NgayGiaoHang default '00-00-0000 00:00:00.000' for NgayGiaoHang

/*---------------------------------------------- CÀI ĐẶT KHÓA NGOẠI ------------------------------------------- */
go
alter table KHACH_HANG add constraint FK_KhachHang_TaiKhoan foreign key(TaiKhoan_KH) REFERENCES TAI_KHOAN(MaTaiKhoan)

alter table NHAN_VIEN add constraint FK_NhanVien_TaiKhoan foreign key(TaiKhoan_NV) REFERENCES TAI_KHOAN(MaTaiKhoan)

alter table THE_LOAI add constraint FK_TheLoai_DanhMucSach foreign key(MaDM) REFERENCES DANH_MUC_SACH(MaDM)

alter table SACH add constraint FK_Sach_DanhMucSach foreign key(MaDM) REFERENCES DANH_MUC_SACH(MaDM)
alter table SACH add constraint FK_Sach_TheLoai foreign key(MaLoai) REFERENCES THE_LOAI(MaLoai)
alter table SACH add constraint FK_Sach_TacGia foreign key(TacGia) REFERENCES TAC_GIA(MaTacGia)

alter table DANH_GIA_SAN_PHAM add constraint FK_DGSP_Sach foreign key(MaSach_DanhGia) REFERENCES SACH(MaSach)
alter table DANH_GIA_SAN_PHAM add constraint FK_DGSP_KhachHang foreign key(MaKH_DanhGia) REFERENCES KHACH_HANG(MaKH)

alter table DON_HANG add constraint FK_DonHang_KhachHang foreign key(MaKH_DatHang) REFERENCES KHACH_HANG(MaKH)
alter table DON_HANG add constraint FK_DonHang_NhanVien foreign key(NVPhuTrach) REFERENCES NHAN_VIEN(MaNV)

alter table CHI_TIET_DON_HANG add constraint FK_CTDH_DonHang foreign key(SoDH) REFERENCES DON_HANG(SoDonHang)
alter table CHI_TIET_DON_HANG add constraint FK_CTDH_Sach foreign key(MaSach_CTDH) REFERENCES SACH(MaSach)

alter table PHIEU_GIAO_HANG add constraint FK_PhieuGiaoHang_DonHang foreign key(SoDH_DuocGiao) REFERENCES DON_HANG(SoDonHang)

alter table CHI_TIET_PHIEU_GIAO_HANG add constraint FK_CTPGH_PhieuGiaoHang foreign key(SoPGH) REFERENCES PHIEU_GIAO_HANG(SoPhieuGiaoHang)
alter table CHI_TIET_PHIEU_GIAO_HANG add constraint FK_CTPGH_Sach foreign key(MaSach_CTPGH) REFERENCES SACH(MaSach)

/*************************************** NHẬP DỮ LIỆU ****************************************/

/* --- INSERT DANH MỤC SÁCH ---*/
insert into DANH_MUC_SACH values (N'Sách Bán Chạy')
insert into DANH_MUC_SACH values (N'Theo đánh giá sản phẩm cao')
insert into DANH_MUC_SACH values (N'Sách Ngoại Văn')
insert into DANH_MUC_SACH values (N'Sách Kinh Tế')
insert into DANH_MUC_SACH values (N'Sách Văn Học Trong Nước') 
insert into DANH_MUC_SACH values (N'Sách Văn Học Nước Ngoài') 
insert into DANH_MUC_SACH values (N'Sách Thiếu Nhi') 
insert into DANH_MUC_SACH values (N'Sách Tin Học – Ngoại Ngữ') 
insert into DANH_MUC_SACH values (N'Sách Chuyên Ngành') 
insert into DANH_MUC_SACH values (N'Sách Phát Triển Bản Thân') 
insert into DANH_MUC_SACH values (N'Giá trị từ cao - thấp')
insert into DANH_MUC_SACH values (N'Giá trị từ thấp - cao')

/* --- INSERT TAI KHOAN ---*/
insert into TAI_KHOAN values ('bppkhanh@gmail.com','admin1',0)
insert into TAI_KHOAN values ('hmnghi@gmail.com','admin2',0)
insert into TAI_KHOAN values ('pdhuy@gmail.com','admin3',0)
insert into TAI_KHOAN values ('dtdung@gmail.com','client1',1)
insert into TAI_KHOAN values ('ltpnam@gmail.com','client2',1)
insert into TAI_KHOAN values ('ptdung@gmail.com','client3',1)
insert into TAI_KHOAN values ('nvan@gmail.com','client4',1)
insert into TAI_KHOAN values ('nvhiep@gmail.com','client5',1)
insert into TAI_KHOAN values ('nttien@gmail.com','client6',1)
insert into TAI_KHOAN values ('dqnhu@gmail.com','client7',1)

insert into TAI_KHOAN(Email, MatKhau, LoaiTaiKhoan)
values  ('nguyenvn@gmail.com', '1234',1),
		('nguyenthl@gmail.com', '1235',1),
		('caodd@gmail.com', '1236',1),
		('nguyencqkh@gmail.com', '1237',1),
		('markwls@gmail.com', '1238',1),
		('jshouler0@bloglovin.com', 'ukcoPEOW8fHg', 1),
		('fgabits1@paginegialle.it', '9uiJEJb', 1),
		('evasser2@multiply.com', '7WcQUqYFT', 1),
		('ttook3@taobao.com', 'OgLJpvtdl89', 1),
		('mray4@themeforest.net', 'pOiLkE0U7Nvi', 1),
		('chowsam5@slideshare.net', 'ZhORTLvGiQSL', 1),
		('sballard6@technorati.com', 'sydJyO', 1),
		('lcotillard7@constantcontact.com', 'zBQ1gj7O', 1),
		('mclulee8@cnet.com', 'MWBsOLb', 1)

insert into TAI_KHOAN(Email, MatKhau, LoaiTaiKhoan)
values 	('khowerd5e@liveinternet.ru', 'admin4',0),
		('cgrzelak5f@theglobeandmail.com', 'admin5', 0),
		('afarncombe5g@drupal.org', 'admin6', 0),
		('thorsted5h@globo.com', 'admin7', 0),
		('mwittier5i@4shared.com', 'admin8', 0),
		('tstickney5j@weibo.com', 'admin9', 0)


/* --- INSERT KHACH_HANG ---*/
insert into KHACH_HANG values (N'Đỗ Tiến Dũng','1995-09-05','4',1)
insert into KHACH_HANG values (N'Lê Trần Phương Nam','1997-01-31','5',1)
insert into KHACH_HANG values (N'Phạm Thị Dung','1998-02-27','6',0)
insert into KHACH_HANG values (N'Nguyễn Văn An','1997-01-31','7',0)
insert into KHACH_HANG values (N'Nguyễn Văn Hiệp','1995-05-05','8',1)
insert into KHACH_HANG values (N'Ngô Thị Tiên','1993-04-20','9',0)
insert into KHACH_HANG values (N'Đặng Quỳnh Như','1997-10-31','10',0)

insert into KHACH_HANG(TenKH, NgaySinh, TaiKhoan_KH,GioiTinh)
VALUES(N'Nguyễn Văn Ni', '1996-01-02', 11,1),
	  (N'Nguyễn Thành Long', '1998-12-02', 12,1),
	  (N'Cao Đăng Dũng', '1997-08-09', 13,1),
	  (N'Nguyễn Cao Quốc Khang', '2000-09-11',14,1),
	  (N'Mark Williams', '1991-12-12', 15,1),
	  	('Brook Laxston', '1998-11-14', 16,0),
		('Aldo Corssen', '1996-08-26', 17,0),
		('Albert Lindop', '2000-04-21', 18,0),
		('Roland Kellough', '1999-07-23', 19,1),
		('Klement Bramah', '1997-01-08', 20,0),
		('Josephine Boobyer', '1998-03-05', 21,0),
		('Jaime Sarjant', '1998-07-21', 22,0),
		('Thorn Newdick', '1996-12-29', 23,1),
		('Leigh Westby', '2000-10-18', 24,0)

/* --- INSERT NHAN_VIEN ---*/
insert into NHAN_VIEN values (N'Bùi Phạm Phương Khanh','1','090806767')
insert into NHAN_VIEN values (N'Hứa Mỹ Nghi','2','0353226434')
insert into NHAN_VIEN values (N'Phạm Đình Huy','3','0909155266')

insert into NHAN_VIEN (TenNV, TaiKhoan_NV, SDT_NV)
values	('Vince Bomfield', 25, '7089255321'),
		('Dennet Turpey', 26,'8935957977'),
		('Elyssa Taggerty', 27, '6431693940'),
		('Susann Vallance', 28, '5152678012'),
		('Jillie Van der Linde', 29, '6791992878'),
		('George Beadles', 30, '2038372874')

/* --- INSERT THE_LOAI --- */
insert into THE_LOAI values (N'Romance','102')
insert into THE_LOAI values (N'History','102')
insert into THE_LOAI values (N'Humor & Satire','102')
insert into THE_LOAI values (N'Action & Adventure','102')
insert into THE_LOAI values (N'Classics','102')
insert into THE_LOAI values (N'Marketing – Bán hàng','103')
insert into THE_LOAI values (N'Ngoại thương','103')
insert into THE_LOAI values (N'Quản trị - Lãnh Đạo','103')
insert into THE_LOAI values (N'Tài chính & tiền tệ','103')
insert into THE_LOAI values (N'Tài chính – Kế toán','103')
insert into THE_LOAI values (N'Phê bình văn học','104')
insert into THE_LOAI values (N'Truyện Dài','104')
insert into THE_LOAI values (N'Truyện ngắn – Tản văn','104')
insert into THE_LOAI values (N'Tự truyện - Hồi Ký','104')
insert into THE_LOAI values (N'Truyện giả tưởng – thần bí','104')
insert into THE_LOAI values (N'Cổ tích & thần thoại','105')
insert into THE_LOAI values (N'Truyện viễn tưởng - Kinh dị','105')
insert into THE_LOAI values (N'Tiểu Thuyết Ngôn Tình','105')
insert into THE_LOAI values (N'Truyện kiếm hiệp - Phiêu lưu','105')
insert into THE_LOAI values (N'Truyện trinh thám, vụ án','105')
insert into THE_LOAI values (N'Truyện tranh','106')
insert into THE_LOAI values (N'Khoa học tự nhiên','106')
insert into THE_LOAI values (N'Khoa học xã hội','106')
insert into THE_LOAI values (N'Ngoại ngữ','106')
insert into THE_LOAI values (N'Tiếng Anh','107')
insert into THE_LOAI values (N'Từ điển','107')
insert into THE_LOAI values (N'Tin học cơ bản','107')
insert into THE_LOAI values (N'Đồ họa','107')
insert into THE_LOAI values (N'Internet & Mạng','107')
insert into THE_LOAI values (N'Âm nhạc','108')
insert into THE_LOAI values (N'Chính trị, triết học','108')
insert into THE_LOAI values (N'Pháp luật','108')
insert into THE_LOAI values (N'Y học','108')
insert into THE_LOAI values (N'Thể thao','108')
insert into THE_LOAI values (N'Học làm người','109')
insert into THE_LOAI values (N'Nhà khoa học','109')
insert into THE_LOAI values (N'Triết gia, chính trị gia, nhà quân sự','109')
insert into THE_LOAI values (N'Danh nhân văn hóa','109')

/* --- INSERT TAC_GIA --- */
insert into TAC_GIA values (N'John Green','')
insert into TAC_GIA values (N'Jojo Moyes','')
insert into TAC_GIA values (N'Nicholas Sparks','')
insert into TAC_GIA values (N'Graham Greene','')
insert into TAC_GIA values (N'Bảo Ninh','')
insert into TAC_GIA values (N'Jules Feiffer','')
insert into TAC_GIA values (N'Sir Arthur Conan Doyle','')
insert into TAC_GIA values (N'Mark Twain','')
insert into TAC_GIA values (N'William Shakespeare','')
insert into TAC_GIA values (N'David Vinjamuri','')
insert into TAC_GIA values (N'Jeanette McMurtry','')
insert into TAC_GIA values (N'Hồng Lan','')
insert into TAC_GIA values (N'Mohammed bin Rashid Al Maktoum','')
insert into TAC_GIA values (N'Song Hong Bing','')
insert into TAC_GIA values (N'Bộ Tài Chính','')
insert into TAC_GIA values (N'Cao Xuân Hạo','')
insert into TAC_GIA values (N'Thạch Lam','')
insert into TAC_GIA values (N'Nguyễn Nhật Ánh','')
insert into TAC_GIA values (N'Trần Huy Minh Phương','')
insert into TAC_GIA values (N'Hà Thanh Phúc','')
insert into TAC_GIA values (N'Hoàng Thị Diệu Thuần','')
insert into TAC_GIA values (N'Phạm Công Luận','')
insert into TAC_GIA values (N'Quang Vinh','')
insert into TAC_GIA values (N'Phan Cuồng','')
insert into TAC_GIA values (N'Nguyễn Văn Khỏa','')
insert into TAC_GIA values (N'Peter Andreas Munch','')
insert into TAC_GIA values (N'Jonathan Stroud','')
insert into TAC_GIA values (N'Hạ Long Hà','')
insert into TAC_GIA values (N'Cửu Nguyệt Hi','')
insert into TAC_GIA values (N'Ôn Thụy An','')
insert into TAC_GIA values (N'Phương Bạch Vũ','')
insert into TAC_GIA values (N'Donato Carrisi','')
insert into TAC_GIA values (N'Cornell Woolrich','')
insert into TAC_GIA values (N'Quentin Gréban','')
insert into TAC_GIA values (N'Sarah Andersen','')
insert into TAC_GIA values (N'Lee Cosgrove','')
insert into TAC_GIA values (N'Đăng Khôi','')
insert into TAC_GIA values (N'Liesbet Slegers','')
insert into TAC_GIA values (N'Thu Dương','')
insert into TAC_GIA values (N'Linh Chi','')
insert into TAC_GIA values (N'Hackers Language Research Institue, Inc.','')
insert into TAC_GIA values (N'Khang Việt','')
insert into TAC_GIA values (N'Thái Thanh Sơn','')
insert into TAC_GIA values (N'Nguyễn Công Minh','')
insert into TAC_GIA values (N'Phạm Quang Huy','')
insert into TAC_GIA values (N'Steven Levy','')
insert into TAC_GIA values (N'Kevin Mitnick','')
insert into TAC_GIA values (N'F. Carulli','')
insert into TAC_GIA values (N'Trương Tuyết Mai','')
insert into TAC_GIA values (N'Max Tegmark','')
insert into TAC_GIA values (N'Peter Worley','')
insert into TAC_GIA values (N'Nguyễn Hữu Phước','')
insert into TAC_GIA values (N'DK','')
insert into TAC_GIA values (N'Kim Long','')
insert into TAC_GIA values (N'Nhiều tác giả','')
insert into TAC_GIA values (N'Walter Isaacson','')
insert into TAC_GIA values (N'Khánh Linh','')
insert into TAC_GIA values (N'Paulo Coelho','')
insert into TAC_GIA values (N'Ellen Crosby','')
insert into TAC_GIA values (N'Nora Roberts','')
insert into TAC_GIA values (N'Cecelia Ahern','')
insert into TAC_GIA values (N'Tim Obrien','')
insert into TAC_GIA values (N'Thomas A. Bass','')
insert into TAC_GIA values (N'Vũ Trọng Phụng','')

/* --- INSERT SACH --- */
insert into SACH values (N'The Fault in Our Stars','100',N'John Green','','102','100',N'NXB Speak',N'Speak','2014-04-01 00:00:00.000','396.00','352','280000','60')
insert into SACH values (N'Me Before You','101',N'Jojo Moyes','','102','100',N'NULL',N'ArtBook','2016-06-01 00:00:00.000','374.00','512','250000','40')
insert into SACH values (N'The Longest Ride','102',N'Nicholas Sparks','','102','100',N'NXB Grand Central Publishing',N'Grand Central Publishing','2014-05-01 00:00:00.000','341.00','416','290000','55')
insert into SACH values (N'The Alchemist','157','','','102','100','',N'ArtBook','2015-05-05 00:00:00.000','286.00','192','220000','44')
insert into SACH values (N'The Sauvignon Secret','158','','','102','100',N'Scribner',N'Scribner','2011-08-01 00:00:00.000','250.00','400','530000','70')
insert into SACH values (N'The Witness','159','','','102','100',N'Putnam Adult',N'Putnam Adult','2012-04-07 00:00:00.000','726.00','500','600000','9')
insert into SACH values (N'The Time of My Life','160','','','102','100',N'HarperCollins Publishers Ltd',N'HarperCollins Publishers Ltd','2012-05-15 00:00:00.000','281.00','512','280000','30')
insert into SACH values (N'The Quiet American','103',N'Graham Greene','','102','101',N'NXB Vintage Classics',N'Vintage Classics','2019-06-11 00:00:00.000','159.00','192','300000','35')
insert into SACH values (N'The Sorrow Of War','104',N'Bảo Ninh','','102','101',N'NBX London: Minerva/Mandarin Paperbacks',N'London: Minerva/Mandarin Paperbacks','1997-01-01 00:00:00.000','159.00','272','300000','70')
insert into SACH values (N'The Things They Carried','161','','','102','101',N'Mariner Books',N'Mariner Books','2019-10-22 00:00:00.000','205.00','233','300000','50')
insert into SACH values (N'The Spy Who Loved Us','162','','','102','101',N'PublicAffairs',N'PublicAffairs','2009-02-22 00:00:00.000','499.00','440','600000','50')
insert into SACH values (N'Backing Into Forward','105',N'Jules Feiffer','','102','102',N'NBX Nan A. Talese',N'Nan A. Talese','2010-12-01 00:00:00.000','817.00','853','660000','60')
insert into SACH values (N'BDumb Luck','163',N'Nguyen Nguyet Cam','','102','102',N'University of Michigan Press',N'University of Michigan Press','2015-01-01 00:00:00.000','264.00','190','100000','60')
insert into SACH values (N'Sherlock Holmes: The Complete Stories','106',N'Sir Arthur Conan Doyle','','102','103',N'NBX Wordsworth Editions Ltd.',N'Wordsworth Editions Ltd.','2008-03-01 00:00:00.000','1497.00','1852','450000','70')
insert into SACH values (N'The Innocents Abroad','107',N'Mark Twain','','102','103',N'NBX Wordsworth Editions Ltd.',N'Wordsworth Editions Ltd.','2010-04-01 00:00:00.000','301.00','464','75000','54')
insert into SACH values (N'Shadows of Sherlock Holmes','106','','','102','103',N'NBX Wordsworth Editions Ltd.',N'Wordsworth Editions Ltd.','2008-12-12 00:00:00.000','286.00','384','150000','44')
insert into SACH values (N'Death in the Afternoon','107','','','102','103',N'Vintage Books',N'Vintage Books','2000-10-24 00:00:00.000','341.00','352','250000','68')
insert into SACH values (N'The Winter`s Tale','108',N'William Shakespeare','','102','104',N'NBX Wordsworth Editions Ltd.',N'Wordsworth Editions Ltd.','2005-06-13 00:00:00.000','120.00','160','75000','80')
insert into SACH values (N'A Midsummer Night`s Dream','108',N'William Shakespeare','','102','104',N'NBX Wordsworth Editions Ltd.',N'Wordsworth Editions Ltd.','1998-01-01 00:00:00.000','69.00','128','75000','50')
insert into SACH values (N'Vanity Fair','108','','','102','104',N'Wordsworth Editions Ltd.',N'Wordsworth Editions Ltd.','1998-01-04 00:00:00.000','499.00','720','1500000','50')
insert into SACH values (N'Macbeth','108','','','102','104',N'NBX Wordsworth Editions Ltd.',N'Wordsworth Editions Ltd.','1997-08-28 00:00:00.000','83.00','128','199000','51')
insert into SACH values (N'The Complete Novels of Kafka','108','','','102','104',N'Vintage Classics',N'Vintage Classics','2000-08-07 00:00:00.000','545.00','464','500000','41')
insert into SACH values (N'Tay Ngang Làm Nên Thương Hiệu','119',N'David Vinjamuri','','103','105',N'NBX Thế giới',N'Phương Nam','2019-06-01 00:00:00.000','352.00','292','133000','77')
insert into SACH values (N'Marketing For Dummies','110',N'Jeanette McMurtry','','103','105',N'NXB Công Thương',N'Thái Hà','2019-11-15 00:00:00.000','1100.00','590','322000','70')
insert into SACH values (N'Branding For Dummies','110',N'Khánh Trang','','103','105',N'NXB Công Thương',N'Thái Hà','2019-12-05 00:00:00.000','990.00','550','250000','59')
insert into SACH values (N'Marketing Online 4.0','119','','','103','105',N'NXB Hồng Đức',N'Tri Thức Trẻ','2019-10-10 00:00:00.000','792.00','504','350000','36')
insert into SACH values (N'Inbound Marketing','110',N'Huỳnh Hữu Tài','','103','105',N'NXB Tổng hợp TP.HCM',N'Trí Việt','2019-02-21 00:00:00.000','330.00','304','175000','67')
insert into SACH values (N'Biểu Thuế Suất Hàng Hóa Xuất Khẩu - Nhập Khẩu 2017','111',N'Hồng Lan','','103','106',N'NBX Lao động',N'Thông Tin Việt','2016-12-01 00:00:00.000','1496.00','768','396000','55')
insert into SACH values (N'Biểu Thuế Xuất Khẩu - Nhập Khẩu TAX 2017','111',N'Hồng Lan','','103','106',N'NBX Lao động',N'Thông Tin Việt','2016-12-01 00:00:00.000','1980.00','1020','478000','64')
insert into SACH values (N'Thuế - Tax 2015','111','','','103','106',N'NXB Tổng hợp TP.HCM',N'Bảo Khôi','2015-01-12 00:00:00.000','2244.00','1144','550000','77')
insert into SACH values (N'Nghiệp Vụ Ngân Hàng Quốc Tế','111','','','103','106',N'NXB Thanh Niên',N'Kinh Tế','2009-09-11 00:00:00.000','','608','115000','55')
insert into SACH values (N'Tầm Nhìn Thay Đổi Quốc Gia','112',N'Mohammed bin Rashid Al Maktoum','','103','107',N'NBX Thế giới',N'Trí Việt','2019-06-01 00:00:00.000','682.00','280','198000','80')
insert into SACH values (N'Lập Chiến Lược Kinh Doanh Tối Giản','112','Nguyễn Tư Thắng','','103','107',N'NBX Thế giới',N'Saigon Books','2019-11-13 00:00:00.000','264.00','224','88000','80')
insert into SACH values (N'Quản Lý Chuỗi Cung Ứng For Dummies','112','Khánh Trang','','103','107',N'NBX Công Thương',N'Thái Hà','2019-12-05 00:00:00.000','880.00','472','151000','74')
insert into SACH values (N'Nghệ Thuật Tư Duy Chiến Lược','112',N'Kim Phúc','','103','107',N'NBX Lao động',N'Alpha books','2019-03-26 00:00:00.000','836.00','560','143000','80')
insert into SACH values (N'Chiến Tranh Tiền Tệ - Sự Thống Trị Của Quyền Lực Tài Chính','113',N'Song Hong Bing','','103','108',N'NBX Lao động',N'BachvietBooks','2019-06-10 00:00:00.000','462.00','368','124000','8')
insert into SACH values (N'How Money Works - Hiểu Hết Về Tiền','152',N'Bùi Thị Quỳnh Chi','','103','108',N'NBX Thế giới',N'Nhã Nam','2019-08-20 00:00:00.000','1034.00','256','340000','22')
insert into SACH values (N'Bùng Nổ Bitcoin','152',N'Chu Nhất Minh Vương','','103','108',N'NBX Kinh Tế TP.HCM',N'Bookshop Loc','2018-01-15 00:00:00.000','726.00','242','248000','50')
insert into SACH values (N'Phương Pháp Mới Để Giao Dịch Kiếm Sống','152',N'Trương Minh Huy','','103','108',N'NBX Kinh Tế TP.HCM',N'Bookshop Loc','2018-06-24 00:00:00.000','836.00','358','400000','44')
insert into SACH values (N'Tài Chính Doanh Nghiệp','154',N'Nhiều dịch giả','','103','108',N'NBX Kinh Tế TP.HCM',N'Bookshop Loc','2017-07-20 00:00:00.000','1958.00','1096','700000','60')
insert into SACH values (N'Bài Tập Và Bài Giải Kế Toán Tài Chính','154','','','103','108',N'NBX Thống kê',N'KT Tuấn Minh','2009-06-06 00:00:00.000','792.00','640','70000','77')
insert into SACH values (N'Phân Tích Báo Cáo Tài Chính - Hướng Dẫn Thực Hành','154',N'Nhiều dịch giả','','103','108',N'NBX Kinh Tế TP.HCM',N'Bookshop Loc','2013-09-28 00:00:00.000','792.00','536','160000','66')
insert into SACH values (N'Sách Ngày Doanh Nhân Việt Nam','154','','','103','108','',N'Vinabook','2010-05-23 00:00:00.000','2200.00','1565','320000','8')
insert into SACH values (N'Dự Báo Và Phân Tích Dữ Liệu Trong Kinh Tế Và Tài Chính','154','','','103','108',N'NBX Thống kê',N'KT Tuấn Minh','2009-12-12 00:00:00.000','720.00','582','62000','25')
insert into SACH values (N'Chế Độ Kế Toán Doanh Nghiệp ','114',N'Bộ Tài Chính','','103','109',N'NBX Văn Học',N'Phúc Minh','2019-06-10 00:00:00.000','462.00','368','98000','5')
insert into SACH values (N'Chế Độ Kế Toán Hành Chính Sự Nghiệp','114',N'Lê Đình Chi','','103','109',N'NBX Văn Học',N'Phúc Minh','2019-06-10 00:00:00.000','462.00','368','98000','22')
insert into SACH values (N'Nghiên Cứu Định Lượng Trong Kế Toán - Kiểm Toán','154','','','103','109',N'NBX Tài Chính',N'Kinh Tế','2018-09-15 00:00:00.000','594.00','302','250000','40')
insert into SACH values (N'Kế Toán Chi Phí Giá Thành','114','','','103','109',N'NBX Thống kê',N'KT Tuấn Minh','2007-11-11 00:00:00.000','770.00','550','50000','80')
insert into SACH values (N'Tài Liệu Bồi Dưỡng Kế Toán Trưởng Doanh Nghiệp','114','','','103','109',N'NBX Tài Chính',N'Kinh Đô 2','2013-03-27 00:00:00.000','946.00','576','240000','55')
insert into SACH values (N'Kế Toán Tài Chính','114','','','103','109',N'NBX Lao động - Xã hội',N'KT Tuấn Minh','2012-06-30 00:00:00.000','1320.00','1216','158000','60')
insert into SACH values (N'Tiếng Việt - Văn Việt - Người Việt','115',N'Cao Xuân Hạo','','104','110',N'NBX Trẻ',N'Phương Nam','2018-12-10 00:00:00.000','452.00','335','137000','6')
insert into SACH values (N'Thạch Lam - Tác Phẩm & Lời Bình','116',N'Thạch Lam','','104','110',N'NBX Văn Học',N'Minh Long','2019-06-10 00:00:00.000','330.00','344','44000','40')
insert into SACH values (N'Giá Trị Trong Di Chúc Của Chủ Tịch Hồ Chí Minh','154','','','104','110',N'NBX Văn hóa - Văn nghệ',N'NXB Văn Hóa Văn Nghệ','2019-06-29 00:00:00.000','264.00','212','63000','55')
insert into SACH values (N'Thế Kỷ XXI Nhìn Về Trương Vĩnh Ký','154','','','104','110',N'NBX Hồng Đức',N'Phương Nam','2017-10-22 00:00:00.000','396.00','280','98000','50')
insert into SACH values (N'Vũ Trọng Phụng - Tác Phẩm & Lời Bình','163','','','104','110',N'NBX Văn Học',N'Minh Long','2011-05-25 00:00:00.000','286.00','308','40000','50')
insert into SACH values (N'Vũ Trọng Phụng - Tác Phẩm & Lời Bình','163','','','104','110',N'NBX Văn Học',N'Minh Long','2011-05-25 00:00:00.000','286.00','308','40000','50')
insert into SACH values (N'Làm Bạn Với Bầu Trời','117',N'Lê Đình Chi','','104','111',N'NBX Văn Học',N'Phúc Minh','2019-06-10 00:00:00.000','462.00','368','98000','3')
insert into SACH values (N'Mắt Biếc','117',N'Nguyễn Nhật Ánh','','104','111',N'NBX Trẻ',N'Trẻ','2019-08-02 00:00:00.000','594.00','300','176000','17')
insert into SACH values (N'Bảy Bước Tới Mùa Hè','117','','','104','111',N'NBX Trẻ',N'Trẻ','2019-03-27 00:00:00.000','330.00','288','92000','5')
insert into SACH values (N'Còn Chút Gì Để Nhớ','117','','','104','111',N'NBX Trẻ',N'Trẻ','2019-02-02 00:00:00.000','242.00','212','52000','20')
insert into SACH values (N'I See Yellow Flowers In The Green Grass','117',N'Nhã Thuyên','','104','111',N'NBX Trẻ',N'Trẻ','2018-10-14 00:00:00.000','418.00','376','200000','33')
insert into SACH values (N'Mở Lòng Thì Được Tất Cả','118',N'Trần Huy Minh Phương','','104','112',N'NBX Lao động',N'ChiBooks','2019-11-05 00:00:00.000','264.00','208','74000','43')
insert into SACH values (N'Chúng Ta Không Có Sau Này','119',N'Hà Thanh Phúc','','104','112',N'NBX Phụ Nữ',N'Skybooks','2019-10-02 00:00:00.000','308.00','262','78000','57')
insert into SACH values (N'Kẻ Ly Hương','154','','','104','112',N'NBX Hội Nhà Văn',N'Phương Nam','2019-11-12 00:00:00.000','308.00','232','125000','45')
insert into SACH values (N'Muôn Ánh Mặt Trời','120',N'Hoàng Thị Diệu Thuần','','104','113',N'NBX Thế giới',N'Alpha books','2019-06-10 00:00:00.000','242.00','196','64000','10')
insert into SACH values (N'Những Bức Tranh Phù Thế','121',N'Phạm Công Luận','','104','113',N'NBX Văn hóa - Văn nghệ',N'Phương Nam','2019-06-10 00:00:00.000','440.00','200','179000','7')
insert into SACH values (N'Muôn Ánh Mặt Trời 2','120',N'Hoàng Thị Diệu Thuần','','104','113',N'NBX Thế giới',N'Alpha books','2019-06-10 00:00:00.000','242.00','196','64000','40')
insert into SACH values (N'Những Bức Tranh Phù Thế 2','121',N'Phạm Công Luận','','104','113',N'NBX Văn hóa - Văn nghệ',N'Phương Nam','2019-06-10 00:00:00.000','440.00','200','179000','22')
insert into SACH values (N'Muôn Ánh Mặt Trời 3','120',N'Hoàng Thị Diệu Thuần','','104','113',N'NBX Thế giới',N'Alpha books','2019-06-10 00:00:00.000','242.00','196','64000','50')
insert into SACH values (N'Những Bức Tranh Phù Thế 3','121',N'Phạm Công Luận','','104','113',N'NBX Văn hóa - Văn nghệ',N'Phương Nam','2019-06-10 00:00:00.000','440.00','200','179000','40')
insert into SACH values (N'Muôn Ánh Mặt Trời 4','120',N'Hoàng Thị Diệu Thuần','','104','113',N'NBX Thế giới',N'Alpha books','2019-06-10 00:00:00.000','242.00','196','64000','70')
insert into SACH values (N'Những Bức Tranh Phù Thế 4','121',N'Phạm Công Luận','','104','113',N'NBX Văn hóa - Văn nghệ',N'Phương Nam','2019-06-10 00:00:00.000','440.00','200','179000','60')
insert into SACH values (N'Biến Mất','122',N'Lê Đình Chi','','104','114',N'NBX Văn Học',N'Phúc Minh','2019-06-10 00:00:00.000','462.00','368','98000','16')
insert into SACH values (N'Lý Triều Dị Truyện','123',N'Phan Cuồng','','104','114',N'NBX Hội Nhà Văn',N'Nhã Nam','2017-09-10 00:00:00.000','704.00','480','239000','27')
insert into SACH values (N'Biến Mất 2','122',N'Lê Đình Chi','','104','114',N'NBX Văn Học',N'Phúc Minh','2019-06-10 00:00:00.000','462.00','368','98000','10')
insert into SACH values (N'Lý Triều Dị Truyện 2','123',N'Phan Cuồng','','104','114',N'NBX Hội Nhà Văn',N'Nhã Nam','2017-09-10 00:00:00.000','704.00','480','239000','8')
insert into SACH values (N'Biến Mất 3','122',N'Lê Đình Chi','','104','114',N'NBX Văn Học',N'Phúc Minh','2019-06-10 00:00:00.000','462.00','368','98000','55')
insert into SACH values (N'Lý Triều Dị Truyện 3','123',N'Phan Cuồng','','104','114',N'NBX Hội Nhà Văn',N'Nhã Nam','2017-09-10 00:00:00.000','704.00','480','239000','70')
insert into SACH values (N'Biến Mất 4','122',N'Lê Đình Chi','','104','114',N'NBX Văn Học',N'Phúc Minh','2019-06-10 00:00:00.000','462.00','368','98000','55')
insert into SACH values (N'Lý Triều Dị Truyện 4','123',N'Phan Cuồng','','104','114',N'NBX Hội Nhà Văn',N'Nhã Nam','2017-09-10 00:00:00.000','704.00','480','239000','45')
insert into SACH values (N'Thần Thoại Hy Lạp','124',N'Nguyễn Văn Khỏa','','105','115',N'NBX Phụ Nữ',N'Phụ Nữ','2018-09-10 00:00:00.000','1672.00','900','239000','30')
insert into SACH values (N'Thần Thoại Bắc Âu','125',N'Peter Andreas Munch','','105','115',N'NBX Văn Học',N'Văn Chương','2017-07-10 00:00:00.000','594.00','372','86000','24')
insert into SACH values (N'Thần Thoại Hy Lạp 2','124',N'Nguyễn Văn Khỏa','','105','115',N'NBX Phụ Nữ',N'Phụ Nữ','2018-09-10 00:00:00.000','1672.00','900','239000','30')
insert into SACH values (N'Thần Thoại Bắc Âu 2','125',N'Peter Andreas Munch','','105','115',N'NBX Văn Học',N'Văn Chương','2017-07-10 00:00:00.000','594.00','372','86000','24')
insert into SACH values (N'Thần Thoại Hy Lạp 3','124',N'Nguyễn Văn Khỏa','','105','115',N'NBX Phụ Nữ',N'Phụ Nữ','2018-09-10 00:00:00.000','1672.00','900','239000','30')
insert into SACH values (N'Thần Thoại Bắc Âu 3','125',N'Peter Andreas Munch','','105','115',N'NBX Văn Học',N'Văn Chương','2017-07-10 00:00:00.000','594.00','372','86000','24')
insert into SACH values (N'Cầu Thang Gào Thét','126',N'Jonathan Stroud','','105','116',N'NBX Hội Nhà Văn',N'Nhã Nam','2019-09-03 00:00:00.000','572.00','360','116000','8')
insert into SACH values (N'Độc Chú','127',N'Hạ Long Hà','','105','116',N'NBX Văn Học',N'Huy Hoàng','2015-03-27 00:00:00.000','594.00','684','112000','22')
insert into SACH values (N'Cầu Thang Gào Thét 2','126',N'Jonathan Stroud','','105','116',N'NBX Hội Nhà Văn',N'Nhã Nam','2019-09-03 00:00:00.000','572.00','360','116000','33')
insert into SACH values (N'Độc Chú 2','127',N'Hạ Long Hà','','105','116',N'NBX Văn Học',N'Huy Hoàng','2015-03-27 00:00:00.000','594.00','684','112000','44')
insert into SACH values (N'Cầu Thang Gào Thét 3','126',N'Jonathan Stroud','','105','116',N'NBX Hội Nhà Văn',N'Nhã Nam','2019-09-03 00:00:00.000','572.00','360','116000','80')
insert into SACH values (N'Độc Chú 3','127',N'Hạ Long Hà','','105','116',N'NBX Văn Học',N'Huy Hoàng','2015-03-27 00:00:00.000','594.00','684','112000','100')
insert into SACH values (N'Cầu Thang Gào Thét 4','126',N'Jonathan Stroud','','105','116',N'NBX Hội Nhà Văn',N'Nhã Nam','2019-09-03 00:00:00.000','572.00','360','116000','50')
insert into SACH values (N'Độc Chú 4','127',N'Hạ Long Hà','','105','116',N'NBX Văn Học',N'Huy Hoàng','2015-03-27 00:00:00.000','594.00','684','112000','45')
insert into SACH values (N'Một Tòa Thành Đang Chờ Anh','128',N'Cửu Nguyệt Hi','','105','117',N'NBX Thanh Niên',N'Văn Việt','2018-06-10 00:00:00.000','1056.00','680','135000','69')
insert into SACH values (N'Tần Cảnh Ký','128',N'Cửu Nguyệt Hi','','105','117',N'NBX Dân Trí',N'BachvietBooks','2019-12-10 00:00:00.000','638.00','524','103000','70')
insert into SACH values (N'Một Tòa Thành Đang Chờ Anh 2','128',N'Cửu Nguyệt Hi','','105','117',N'NBX Thanh Niên',N'Văn Việt','2018-06-10 00:00:00.000','1056.00','680','135000','55')
insert into SACH values (N'Tần Cảnh Ký 2','128',N'Cửu Nguyệt Hi','','105','117',N'NBX Dân Trí',N'BachvietBooks','2019-12-10 00:00:00.000','638.00','524','103000','80')
insert into SACH values (N'Một Tòa Thành Đang Chờ Anh 3','128',N'Cửu Nguyệt Hi','','105','117',N'NBX Thanh Niên',N'Văn Việt','2018-06-10 00:00:00.000','1056.00','680','135000','65')
insert into SACH values (N'Tần Cảnh Ký 3','128',N'Cửu Nguyệt Hi','','105','117',N'NBX Dân Trí',N'BachvietBooks','2019-12-10 00:00:00.000','638.00','524','103000','70')
insert into SACH values (N'Kinh Diễm Nhất Thương','129',N'Ôn Thụy An','','105','118',N'NBX Văn Học',N'Nhã Nam','2013-08-10 00:00:00.000','726.00','504','104000','53')
insert into SACH values (N'Thiên Môn Chi Tâm','130',N'Phương Bạch Vũ','','105','118',N'NBX Văn Học',N'Nhã Nam','2017-11-10 00:00:00.000','308.00','256','62000','77')
insert into SACH values (N'Kinh Diễm Nhất Thương 2','129',N'Ôn Thụy An','','105','118',N'NBX Văn Học',N'Nhã Nam','2013-08-10 00:00:00.000','726.00','504','104000','55')
insert into SACH values (N'Thiên Môn Chi Tâm 2','130',N'Phương Bạch Vũ','','105','118',N'NBX Văn Học',N'Nhã Nam','2017-11-10 00:00:00.000','308.00','256','62000','66')
insert into SACH values (N'Kinh Diễm Nhất Thương 3','129',N'Ôn Thụy An','','105','118',N'NBX Văn Học',N'Nhã Nam','2013-08-10 00:00:00.000','726.00','504','104000','77')
insert into SACH values (N'Thiên Môn Chi Tâm 3','130',N'Phương Bạch Vũ','','105','118',N'NBX Văn Học',N'Nhã Nam','2017-11-10 00:00:00.000','308.00','256','62000','88')
insert into SACH values (N'Cô Gái Trong Sương Mù','131',N'Donato Carrisi','','105','119',N'NBX Phụ Nữ',N'Phụ Nữ','2019-06-10 00:00:00.000','484.00','308','108000','20')
insert into SACH values (N'Hạn Chót Lúc Bình Minh','132',N'Lê Đình Chi','','105','119',N'NBX Văn Học',N'Phúc Minh','2019-06-10 00:00:00.000','462.00','368','98000','10')
insert into SACH values (N'Cô Gái Trong Sương Mù 2','131',N'Donato Carrisi','','105','119',N'NBX Phụ Nữ',N'Phụ Nữ','2019-06-10 00:00:00.000','484.00','308','108000','55')
insert into SACH values (N'Hạn Chót Lúc Bình Minh 2','132',N'Lê Đình Chi','','105','119',N'NBX Văn Học',N'Phúc Minh','2019-06-10 00:00:00.000','462.00','368','98000','40')
insert into SACH values (N'Cô Gái Trong Sương Mù 3','131',N'Donato Carrisi','','105','119',N'NBX Phụ Nữ',N'Phụ Nữ','2019-06-10 00:00:00.000','484.00','308','108000','5')
insert into SACH values (N'Hạn Chót Lúc Bình Minh 3','132',N'Lê Đình Chi','','105','119',N'NBX Văn Học',N'Phúc Minh','2019-06-10 00:00:00.000','462.00','368','98000','8')
insert into SACH values (N'Cô Gái Trong Sương Mù 4','131',N'Donato Carrisi','','105','119',N'NBX Phụ Nữ',N'Phụ Nữ','2019-06-10 00:00:00.000','484.00','308','108000','99')
insert into SACH values (N'Hạn Chót Lúc Bình Minh 4','132',N'Lê Đình Chi','','105','119',N'NBX Văn Học',N'Phúc Minh','2019-06-10 00:00:00.000','462.00','368','98000','20')
insert into SACH values (N'Khi Mình Lớn Lên!','133',N'Cẩm Xuân','','106','120',N'NXB Tổng Hợp TPHCM',N'Trí Việt','2019-08-23 00:00:00.000','132.00','28','22000','11')
insert into SACH values (N'Khó Khăn Như Chăn Mèo','134',N'Hà Thu','','106','120',N'NXB Hội Nhà Văn',N'Nhã Nam','2019-07-17 00:00:00.000','220.00','112','55000','111')
insert into SACH values (N'Khi Mình Lớn Lên! 2','133',N'Cẩm Xuân','','106','120',N'NXB Tổng Hợp TPHCM',N'Trí Việt','2019-08-23 00:00:00.000','132.00','28','22000','8')
insert into SACH values (N'Khó Khăn Như Chăn Mèo 2','134',N'Hà Thu','','106','120',N'NXB Hội Nhà Văn',N'Nhã Nam','2019-07-17 00:00:00.000','220.00','112','55000','100')
insert into SACH values (N'Khi Mình Lớn Lên! 3','133',N'Cẩm Xuân','','106','120',N'NXB Tổng Hợp TPHCM',N'Trí Việt','2019-08-23 00:00:00.000','132.00','28','22000','77')
insert into SACH values (N'Khó Khăn Như Chăn Mèo 3','134',N'Hà Thu','','106','120',N'NXB Hội Nhà Văn',N'Nhã Nam','2019-07-17 00:00:00.000','220.00','112','55000','70')
insert into SACH values (N'Bách Khoa Thư Đầu Đời Về Khủng Long','135',N'Bảo Bình','','106','121',N'NXB Thế Giới',N'Nhã Nam','2019-06-18 00:00:00.000','682.00','30','71000','51')
insert into SACH values (N'Thế Giới Khủng Long','136',N'','','106','121',N'NXB Văn Học',N'Văn Chương','2018-09-01 00:00:00.000','352.00','64','57000','120')
insert into SACH values (N'Bách Khoa Thư Đầu Đời Về Khủng Long 2','135',N'Bảo Bình','','106','121',N'NXB Thế Giới',N'Nhã Nam','2019-06-18 00:00:00.000','682.00','30','71000','45')
insert into SACH values (N'Thế Giới Khủng Long 2','136',N'','','106','121',N'NXB Văn Học',N'Văn Chương','2018-09-01 00:00:00.000','352.00','64','57000','100')
insert into SACH values (N'Bách Khoa Thư Đầu Đời Về Khủng Long 3','135',N'Bảo Bình','','106','121',N'NXB Thế Giới',N'Nhã Nam','2019-06-18 00:00:00.000','682.00','30','71000','44')
insert into SACH values (N'Thế Giới Khủng Long 3','136',N'','','106','121',N'NXB Văn Học',N'Văn Chương','2018-09-01 00:00:00.000','352.00','64','57000','46')
insert into SACH values (N'Cuốn Sách Lớn Rực Rỡ Về Lính Cứu Hỏa','137',N'Bảo Bình','','106','122',N'NXB Hội Nhà Văn',N'Nhã Nam','2019-07-08 00:00:00.000','198.00','28','38000','100')
insert into SACH values (N'Bách Khoa Thư Đầu Đời Về Thế Giới','135',N'Bảo Bình','','106','122',N'NXB Thế Giới',N'Nhã Nam','2019-06-18 00:00:00.000','682.00','30','71000','150')
insert into SACH values (N'Cuốn Sách Lớn Rực Rỡ Về Lính Cứu Hỏa 2','137',N'Bảo Bình','','106','122',N'NXB Hội Nhà Văn',N'Nhã Nam','2019-07-08 00:00:00.000','198.00','28','38000','55')
insert into SACH values (N'Bách Khoa Thư Đầu Đời Về Thế Giới 2','135',N'Bảo Bình','','106','122',N'NXB Thế Giới',N'Nhã Nam','2019-06-18 00:00:00.000','682.00','30','71000','57')
insert into SACH values (N'Cuốn Sách Lớn Rực Rỡ Về Lính Cứu Hỏa 3','137',N'Bảo Bình','','106','122',N'NXB Hội Nhà Văn',N'Nhã Nam','2019-07-08 00:00:00.000','198.00','28','38000','84')
insert into SACH values (N'Bách Khoa Thư Đầu Đời Về Thế Giới 3','135',N'Bảo Bình','','106','122',N'NXB Thế Giới',N'Nhã Nam','2019-06-18 00:00:00.000','682.00','30','71000','41')
insert into SACH values (N'1000 Từ Tiếng Anh Theo Chủ Đề','138',N'','','106','123',N'NXB Mỹ Thuật',N'Tân Việt','2018-10-01 00:00:00.000','880.00','64','96000','200')
insert into SACH values (N'First 100 Trucks And Things That Go','139',N'','','106','123',N'NXB Thanh Niên',N'Đinh Tị','2017-08-01 00:00:00.000','902.00','14','120000','100')
insert into SACH values (N'1000 Từ Tiếng Anh Theo Chủ Đề 2','138',N'','','106','123',N'NXB Mỹ Thuật',N'Tân Việt','2018-10-01 00:00:00.000','880.00','64','96000','200')
insert into SACH values (N'First 100 Trucks And Things That Go 2','139',N'','','106','123',N'NXB Thanh Niên',N'Đinh Tị','2017-08-01 00:00:00.000','902.00','14','120000','100')
insert into SACH values (N'1000 Từ Tiếng Anh Theo Chủ Đề 3','138',N'','','106','123',N'NXB Mỹ Thuật',N'Tân Việt','2018-10-01 00:00:00.000','880.00','64','96000','200')
insert into SACH values (N'First 100 Trucks And Things That Go 3','139',N'','','106','123',N'NXB Thanh Niên',N'Đinh Tị','2017-08-01 00:00:00.000','902.00','14','120000','100')
insert into SACH values (N'Grammar Gateway Intermediate','140',N'Hồ Thị Thanh Trà','','107','124',N'NXB Thế Giới',N'Alpha books','2019-09-26 00:00:00.000','506.00','336','151000','5')
insert into SACH values (N'Hackers IELTS Listening','140',N'Nguyễn Thanh Tùng','','107','124',N'NXB Thế Giới',N'Alpha books','2019-09-03 00:00:00.000','462.00','300','143000','100')
insert into SACH values (N'Grammar Gateway Intermediate 2','140',N'Hồ Thị Thanh Trà','','107','124',N'NXB Thế Giới',N'Alpha books','2019-09-26 00:00:00.000','506.00','336','151000','7')
insert into SACH values (N'Hackers IELTS Listening 2','140',N'Nguyễn Thanh Tùng','','107','124',N'NXB Thế Giới',N'Alpha books','2019-09-03 00:00:00.000','462.00','300','143000','150')
insert into SACH values (N'Grammar Gateway Intermediate 3','140',N'Hồ Thị Thanh Trà','','107','124',N'NXB Thế Giới',N'Alpha books','2019-09-26 00:00:00.000','506.00','336','151000','15')
insert into SACH values (N'Hackers IELTS Listening 3','140',N'Nguyễn Thanh Tùng','','107','124',N'NXB Thế Giới',N'Alpha books','2019-09-03 00:00:00.000','462.00','300','143000','40')
insert into SACH values (N'Từ Điển Đồng Nghĩa Phản Nghĩa','141',N'Khang Việt','','107','125',N'NXB Từ Điển Bách Khoa',N'Khang Việt','2011-06-30 00:00:00.000','440.00','800','50000','150')
insert into SACH values (N'Từ Điển Anh - Việt (Khoảng 360.000 Từ)','141',N'Khang Việt','','107','125',N'NXB Thanh Niên',N'Khang Việt','2017-06-30 00:00:00.000','682.00','1128','84000','20')
insert into SACH values (N'Từ Điển Đồng Nghĩa Phản Nghĩa 2','141',N'Khang Việt','','107','125',N'NXB Từ Điển Bách Khoa',N'Khang Việt','2011-06-30 00:00:00.000','440.00','800','50000','88')
insert into SACH values (N'Từ Điển Anh - Việt (Khoảng 360.000 Từ) 2','141',N'Khang Việt','','107','125',N'NXB Thanh Niên',N'Khang Việt','2017-06-30 00:00:00.000','682.00','1128','84000','57')
insert into SACH values (N'Từ Điển Đồng Nghĩa Phản Nghĩa 3','141',N'Khang Việt','','107','125',N'NXB Từ Điển Bách Khoa',N'Khang Việt','2011-06-30 00:00:00.000','440.00','800','50000','99')
insert into SACH values (N'Từ Điển Anh - Việt (Khoảng 360.000 Từ) 3','141',N'Khang Việt','','107','125',N'NXB Thanh Niên',N'Khang Việt','2017-06-30 00:00:00.000','682.00','1128','84000','150')
insert into SACH values (N'Tin Học Cơ Bản Ứng Dụng Trong Đời Sống','142',N'','','107','126',N'',N'','2014-12-31 00:00:00.000','440.00','336','76500','100')
insert into SACH values (N'Microsoft Project 2007 - 2010 Cho Người Mới Sử Dụng','143',N'','','107','126',N'NXB Hồng Đức',N'Nhân Văn','2010-03-31 00:00:00.000','500.00','384','52000','40')
insert into SACH values (N'Tin Học Cơ Bản Ứng Dụng Trong Đời Sống 2','142',N'','','107','126',N'',N'','2014-12-31 00:00:00.000','440.00','336','76500','100')
insert into SACH values (N'Microsoft Project 2007 - 2010 Cho Người Mới Sử Dụng 2','143',N'','','107','126',N'NXB Hồng Đức',N'Nhân Văn','2010-03-31 00:00:00.000','500.00','384','52000','40')
insert into SACH values (N'Tự Học Photoshop CC Toàn Tập','144',N'','','107','127',N'NXB Thanh Niên',N'STK','2017-09-30 00:00:00.000','506.00','384','86000','150')
insert into SACH values (N'Giáo Trình Thiết Kế Cơ Khí Với Solidworks','144',N'','','107','127',N'NXB Thanh Niên',N'STK','2019-06-30 00:00:00.000','550.00','416','112000','11')
insert into SACH values (N'Tự Học Photoshop CC Toàn Tập 2','144',N'','','107','127',N'NXB Thanh Niên',N'STK','2017-09-30 00:00:00.000','506.00','384','86000','56')
insert into SACH values (N'Giáo Trình Thiết Kế Cơ Khí Với Solidworks 2','144',N'','','107','127',N'NXB Thanh Niên',N'STK','2019-06-30 00:00:00.000','550.00','416','112000','69')
insert into SACH values (N'Hacker Lược Sử','145',N'Phan Anh Vũ','','107','128',N'NXB Công Thương',N'Alpha books','2018-12-01 00:00:00.000','990.00','640','239000','100')
insert into SACH values (N'Nghệ Thuật Ẩn Mình','146',N'Thu Giang','','107','128',N'NXB Công Thương',N'Alpha books','2018-12-01 00:00:00.000','484.00','344','183000','55')
insert into SACH values (N'Hacker Lược Sử 2','145',N'Phan Anh Vũ','','107','128',N'NXB Công Thương',N'Alpha books','2018-12-01 00:00:00.000','990.00','640','239000','66')
insert into SACH values (N'Nghệ Thuật Ẩn Mình 2','146',N'Thu Giang','','107','128',N'NXB Công Thương',N'Alpha books','2018-12-01 00:00:00.000','484.00','344','183000','100')
insert into SACH values (N'Phương Pháp Học Guitare','147',N'Trịnh Minh Thanh','','108','129',N'NXB Dân Trí',N'Huy Hoàng','2019-08-01 00:00:00.000','440.00','160','83000','37')
insert into SACH values (N'Tình Yêu Của Tôi','148',N'','','108','129',N'NXB Hội Nhà Văn',N'Trương Tuyết Mai','2014-03-01 00:00:00.000','1320.00','456','333000','46')
insert into SACH values (N'Phương Pháp Học Guitare 2','147',N'Trịnh Minh Thanh','','108','129',N'NXB Dân Trí',N'Huy Hoàng','2019-08-01 00:00:00.000','440.00','160','83000','22')
insert into SACH values (N'Tình Yêu Của Tôi 2','148',N'','','108','129',N'NXB Hội Nhà Văn',N'Trương Tuyết Mai','2014-03-01 00:00:00.000','1320.00','456','333000','66')
insert into SACH values (N'Life 3.0','149',N'Thảo Trần, Hiếu Trần','','108','130',N'NXB Thế Giới',N'Alpha books','2019-08-14 00:00:00.000','704.00','460','143000','100')
insert into SACH values (N'Cửa Hiệu Triết Học','150',N'Mai Sơn','','108','130',N'NXB Tổng Hợp TPHCM',N'Trí Việt','2019-10-09 00:00:00.000','682.00','448','158000','66')
insert into SACH values (N'Life 3.0 p.2','149',N'Thảo Trần, Hiếu Trần','','108','130',N'NXB Thế Giới',N'Alpha books','2019-08-14 00:00:00.000','704.00','460','143000','44')
insert into SACH values (N'Cửa Hiệu Triết Học p.2','150',N'Mai Sơn','','108','130',N'NXB Tổng Hợp TPHCM',N'Trí Việt','2019-10-09 00:00:00.000','682.00','448','158000','25')
insert into SACH values (N'Cẩm Nang Pháp Luật Cá Nhân & Gia Đình','151',N'','','108','131',N'NXB Tổng Hợp TPHCM',N'Nguyễn Hữu Phước','2018-06-01 00:00:00.000','946.00','632','224000','77')
insert into SACH values (N'Các Câu Hỏi Thường Gặp Trong Pháp Luật Lao Động','151',N'','','108','131',N'NXB Tổng Hợp TPHCM',N'Nguyễn Hữu Phước','2018-09-30 00:00:00.000','704.00','480','160000','250')
insert into SACH values (N'Cẩm Nang Pháp Luật Cá Nhân & Gia Đình 2','151',N'','','108','131',N'NXB Tổng Hợp TPHCM',N'Nguyễn Hữu Phước','2018-06-01 00:00:00.000','946.00','632','224000','77')
insert into SACH values (N'Các Câu Hỏi Thường Gặp Trong Pháp Luật Lao Động 2','151',N'','','108','131',N'NXB Tổng Hợp TPHCM',N'Nguyễn Hữu Phước','2018-09-30 00:00:00.000','704.00','480','160000','250')
insert into SACH values (N'Cẩm Nang Sơ Cấp Cứu Thường Thức','152',N'Tổ chức Giáo dục Y khoa Wellbeing','','108','132',N'NXB Dân Trí',N'Alpha books','2019-09-26 00:00:00.000','616.00','288','239000','40')
insert into SACH values (N'How The Body Works - Hiểu Hết Về Cơ Thể','152',N'Phạm Hằng Nguyên','','108','132',N'NXB Thế Giới',N'Nhã Nam','2019-07-26 00:00:00.000','1100.00','256','240000','8')
insert into SACH values (N'Cẩm Nang Sơ Cấp Cứu Thường Thức 2','152',N'Tổ chức Giáo dục Y khoa Wellbeing','','108','132',N'NXB Dân Trí',N'Alpha books','2019-09-26 00:00:00.000','616.00','288','239000','40')
insert into SACH values (N'How The Body Works - Hiểu Hết Về Cơ Thể 2','152',N'Phạm Hằng Nguyên','','108','132',N'NXB Thế Giới',N'Nhã Nam','2019-07-26 00:00:00.000','1100.00','256','240000','8')
insert into SACH values (N'Karate - Kỹ Thuật Công Phá','153',N'','','108','133',N'NXB Mũi Cà Mau',N'Nhà sách Hoa Sen','2005-10-10 00:00:00.000','198.00','216','16000','50')
insert into SACH values (N'Sổ Tay Võ Thuật - Kỹ Thuật Đánh Đòn Chân','153',N'','','108','133',N'NXB Phương Đông',N'Nhà sách Hoa Sen','2007-07-01 00:00:00.000','220.00','252','24000','50')
insert into SACH values (N'Karate - Kỹ Thuật Công Phá 2','153',N'','','108','133',N'NXB Mũi Cà Mau',N'Nhà sách Hoa Sen','2005-10-10 00:00:00.000','198.00','216','16000','50')
insert into SACH values (N'Sổ Tay Võ Thuật - Kỹ Thuật Đánh Đòn Chân 2','153',N'','','108','133',N'NXB Phương Đông',N'Nhà sách Hoa Sen','2007-07-01 00:00:00.000','220.00','252','24000','50')
insert into SACH values (N'Ánh Lửa Tình Bạn','154',N'','','109','134',N'NXB Tổng Hợp TPHCM',N'Trí Việt','2017-03-01 00:00:00.000','176.00','152','35000','100')
insert into SACH values (N'Buổi Sáng Diệu Kỳ Dành Cho Sinh Viên','154',N'Huệ Linh','','109','134',N'NXB Lao Động',N'Alpha books','2019-10-07 00:00:00.000','418.00','384','95000','55')
insert into SACH values (N'Ánh Lửa Tình Bạn 2','154',N'','','109','134',N'NXB Tổng Hợp TPHCM',N'Trí Việt','2017-03-01 00:00:00.000','176.00','152','35000','68')
insert into SACH values (N'Buổi Sáng Diệu Kỳ Dành Cho Sinh Viên 2','154',N'Huệ Linh','','109','134',N'NXB Lao Động',N'Alpha books','2019-10-07 00:00:00.000','418.00','384','95000','83')
insert into SACH values (N'Stephen Hawking - Một Trí Tuệ Không Giới Hạn','154',N'Nguyễn Hữu Nhã','','109','135',N'NXB Tri Thức',N'Alpha books','2019-08-26 00:00:00.000','374.00','96','151000','4')
insert into SACH values (N'Einstein - Cuộc Đời Và Vũ Trụ','155',N'Vũ Minh Tân','','109','135',N'NXB Thế Giới',N'Alpha books','2018-07-01 00:00:00.000','1100.00','720','231000','5')
insert into SACH values (N'Stephen Hawking - Một Trí Tuệ Không Giới Hạn p.2','154',N'Nguyễn Hữu Nhã','','109','135',N'NXB Tri Thức',N'Alpha books','2019-08-26 00:00:00.000','374.00','96','151000','4')
insert into SACH values (N'Einstein - Cuộc Đời Và Vũ Trụ p.2','155',N'Vũ Minh Tân','','109','135',N'NXB Thế Giới',N'Alpha books','2018-07-01 00:00:00.000','1100.00','720','231000','5')
insert into SACH values (N'Huyền Thoại Che - Bản Lĩnh, Tính Cách, Tình Yêu Và Sự Bất Tử','154',N'','','109','136',N'NXB Tổng Hợp TPHCM',N'Trí Việt','2014-12-18 00:00:00.000','374.00','236','65000','150')
insert into SACH values (N'Nhân Vật Số Một - Vladimir Putin','154',N'','','109','136',N'NXB Tổng Hợp TPHCM',N'Trí Việt','2015-03-01 00:00:00.000','352.00','328','48000','100')
insert into SACH values (N'Huyền Thoại Che - Bản Lĩnh, Tính Cách, Tình Yêu Và Sự Bất Tử 2','154',N'','','109','136',N'NXB Tổng Hợp TPHCM',N'Trí Việt','2014-12-18 00:00:00.000','374.00','236','65000','150')
insert into SACH values (N'Nhân Vật Số Một - Vladimir Putin 2','154',N'','','109','136',N'NXB Tổng Hợp TPHCM',N'Trí Việt','2015-03-01 00:00:00.000','352.00','328','48000','100')
insert into SACH values (N'Kể Chuyện Bác Hồ','156',N'','','109','137',N'NXB Lao Động',N'Tân Việt','2018-08-01 00:00:00.000','220.00','212','40000','40')
insert into SACH values (N'Hồ Chí Minh - Tên Người Sống Mãi','156',N'','','109','137',N'NXB Lao Động',N'Tân Việt','2017-12-31 00:00:00.000','242.00','260','50000','55')
insert into SACH values (N'Kể Chuyện Bác Hồ 2','156',N'','','109','137',N'NXB Lao Động',N'Tân Việt','2018-08-01 00:00:00.000','220.00','212','40000','40')
insert into SACH values (N'Hồ Chí Minh - Tên Người Sống Mãi 2','156',N'','','109','137',N'NXB Lao Động',N'Tân Việt','2017-12-31 00:00:00.000','242.00','260','50000','55')
insert into SACH values (N'Ánh Lửa Tình Bạn 3','154',N'','','109','134',N'NXB Tổng Hợp TPHCM',N'Trí Việt','2017-03-01 00:00:00.000','176.00','152','35000','45')
insert into SACH values (N'Buổi Sáng Diệu Kỳ Dành Cho Sinh Viên 3','154',N'Huệ Linh','','109','134',N'NXB Lao Động',N'Alpha books','2019-10-07 00:00:00.000','418.00','384','95000','77')
insert into SACH values (N'Sổ Tay Võ Thuật - Kỹ Thuật Đánh Đòn Chân 3','153',N'','','108','133',N'NXB Phương Đông',N'Nhà sách Hoa Sen','2007-07-01 00:00:00.000','220.00','252','24000','22')

/* --- INSERT DON_HANG --- */
insert into DON_HANG values (100,'2019-10-10 00:00:00.000','2019-10-11 00:00:00.000','0909776899','130',N'Hoàng Hoa Thám',N'13',N'Tân Bình',N'TP.Hồ Chí Minh',1000,128000,NULL,0,30000,3)
insert into DON_HANG values (101,'2019-09-09 00:00:00.000','2019-09-10 00:00:00.000','0289346213','50',N'Mạc Đĩnh Chi',N'Đa Kao',N'1',N'TP.Hồ Chí Minh',1000,172000,NULL,0,30000,1)
insert into DON_HANG values (102,'2019-09-25 00:00:00.000','2019-09-26 00:00:00.000','0354881024','40',N'Cao Thắng',N'5',N'3',N'TP.Hồ Chí Minh',1000,258000,'11621632808019',1,0,3)
insert into DON_HANG values (103,'2019-10-20 00:00:00.000','2019-10-21 00:00:00.000','0908212811','306',N'Nguyễn Thị Minh Khai',N'5',N'3',N'TP.Hồ Chí Minh',1001,790000,'6380201008359',1,0,2)
insert into DON_HANG values (104,'2019-10-31 00:00:00.000','2019-11-01 00:00:00.000','0987771220','25',N'Lý Thường Kiệt',N'',N'12',N'TP.Hồ Chí Minh',1001,181000,'0531002223008',1,30000,3)
insert into DON_HANG values (105,'2019-08-30 00:00:00.000','2019-08-30 00:00:00.000','0973310089','271',N'Ba Tháng Hai',N'10',N'10',N'TP.Hồ Chí Minh',1002,254000,NULL,0,30000,1)
insert into DON_HANG values (106,'2019-12-05 00:00:00.000','2019-12-06 00:00:00.000','0281866099','25',N'Quang Trung',N'10',N'Gò Vấp',N'TP.Hồ Chí Minh',1002,85000,NULL,0,30000,2)
insert into DON_HANG values (107,'2019-12-07 00:00:00.000','2019-12-08 00:00:00.000','0281866045','26',N'Quang Trung',N'10',N'Gò Vấp',N'TP.Hồ Chí Minh',1003,600000,NULL,0,0,3)

insert into DON_HANG values (108,'2019-12-23 00:00:00.000','2019-12-24 00:00:00.000','0281867895','60',N'Quang Trung',N'10',N'Gò Vấp',N'TP.Hồ Chí Minh',1003,280000,'6355781009959',1,0,3)
insert into DON_HANG values (109,'2019-12-11 00:00:00.000','2019-12-12 00:00:00.000','0214636045','233',N'Ba Tháng Hai',N'10',N'10',N'TP.Hồ Chí Minh',1004,250000,NULL,0,0,3)
insert into DON_HANG values (110,'2019-12-08 00:00:00.000','2019-12-09 00:00:00.000','0281009045','78',N'Quang Trung',N'10',N'Gò Vấp',N'TP.Hồ Chí Minh',1005,290000,NULL,0,0,2)
insert into DON_HANG values (111,'2019-12-14 00:00:00.000','2019-12-15 00:00:00.000','0281861234','300',N'Nguyễn Thị Minh Khai',N'5',N'3',N'TP.Hồ Chí Minh',1006,250000,NULL,0,30000,3)
insert into DON_HANG values (112,'2019-11-07 00:00:00.000','2019-11-08 00:00:00.000','0090966045','111',N'Quang Trung',N'10',N'Gò Vấp',N'TP.Hồ Chí Minh',1003,530000,'6445281484959',1,0,3)

/* --- INSERT CHI_TIET_DON_HANG --- */
insert into CHI_TIET_DON_HANG values ('1000','137',1,98000)
insert into CHI_TIET_DON_HANG values ('1001','140',2,71000)
insert into CHI_TIET_DON_HANG values ('1002','152',3,86000)
insert into CHI_TIET_DON_HANG values ('1003','159',5,158000)
insert into CHI_TIET_DON_HANG values ('1004','146',1,151000)
insert into CHI_TIET_DON_HANG values ('1005','160',1,224000)
insert into CHI_TIET_DON_HANG values ('1006','139',1,55000)
insert into CHI_TIET_DON_HANG values ('1007','103',1,300000)
insert into CHI_TIET_DON_HANG values ('1007','104',1,300000)

insert into CHI_TIET_DON_HANG values ('1008','100',1,280000)
insert into CHI_TIET_DON_HANG values ('1009','101',1,250000)
insert into CHI_TIET_DON_HANG values ('1010','102',1,290000)
insert into CHI_TIET_DON_HANG values ('1011','103',1,220000)
insert into CHI_TIET_DON_HANG values ('1012','104',1,530000)

/* --- INSERT PHIEU_GIAO_HANG --- */
insert into PHIEU_GIAO_HANG values ('1000',N'Đỗ Tiến Dũng',98000,'')
insert into PHIEU_GIAO_HANG values ('1001',N'Lê Trần Phương Nam',142000,'')
insert into PHIEU_GIAO_HANG values ('1002',N'Phạm Thị Dung',258000,'')
insert into PHIEU_GIAO_HANG values ('1003',N'Nguyễn Văn An',790000,'')
insert into PHIEU_GIAO_HANG values ('1004',N'Nguyễn Văn Hiệp',151000,'')
insert into PHIEU_GIAO_HANG values ('1005',N'Ngô Thị Tiên',224000,'')
insert into PHIEU_GIAO_HANG values ('1006',N'Đặng Quỳnh Như',55000,'')
insert into PHIEU_GIAO_HANG values ('1007',N'Nguyễn Văn Ni',600000,'')

insert into PHIEU_GIAO_HANG values ('1008',N'Nguyễn Thành Long',280000,'')
insert into PHIEU_GIAO_HANG values ('1009',N'Cao Đăng Dũng',250000,'')
insert into PHIEU_GIAO_HANG values ('1010',N'Nguyễn Cao Quốc Khang',290000,'')
insert into PHIEU_GIAO_HANG values ('1011',N'Mark Williams',250000,'')
insert into PHIEU_GIAO_HANG values ('1012',N'Brook Laxston',530000,'')

/* --- INSERT CHI_TIET_PHIEU_GIAO_HANG --- */
insert into CHI_TIET_PHIEU_GIAO_HANG values ('1000','137',1,98000)
insert into CHI_TIET_PHIEU_GIAO_HANG values ('1001','140',2,142000)
insert into CHI_TIET_PHIEU_GIAO_HANG values ('1002','152',3,258000)
insert into CHI_TIET_PHIEU_GIAO_HANG values ('1003','159',5,790000)
insert into CHI_TIET_PHIEU_GIAO_HANG values ('1004','146',1,151000)
insert into CHI_TIET_PHIEU_GIAO_HANG values ('1005','160',1,224000)
insert into CHI_TIET_PHIEU_GIAO_HANG values ('1006','139',1,55000)
insert into CHI_TIET_PHIEU_GIAO_HANG values ('1007','103',1,300000)
insert into CHI_TIET_PHIEU_GIAO_HANG values ('1007','104',1,300000)

insert into CHI_TIET_PHIEU_GIAO_HANG values ('1008','100',1,280000)
insert into CHI_TIET_PHIEU_GIAO_HANG values ('1009','101',1,250000)
insert into CHI_TIET_PHIEU_GIAO_HANG values ('1010','102',1,290000)
insert into CHI_TIET_PHIEU_GIAO_HANG values ('1011','103',1,220000)
insert into CHI_TIET_PHIEU_GIAO_HANG values ('1012','104',1,530000)

/* --- INSERT DANH_GIA_SAN_PHAM --- */
insert into DANH_GIA_SAN_PHAM values ('137','100','2019-11-01 00:00:00.000',N'',3,N'')
insert into DANH_GIA_SAN_PHAM values ('139','106','2019-10-25 00:00:00.000',N'',4,N'')
insert into DANH_GIA_SAN_PHAM values ('140','101','2019-10-17 00:00:00.000',N'',4,N'')
insert into DANH_GIA_SAN_PHAM values ('146','104','2019-11-05 00:00:00.000',N'',5,N'Hay')
insert into DANH_GIA_SAN_PHAM values ('152','102','2019-11-10 00:00:00.000',N'',3,N'')
insert into DANH_GIA_SAN_PHAM values ('159','103','2019-08-20 00:00:00.000',N'',4,N'')
insert into DANH_GIA_SAN_PHAM values ('160','105','2019-08-16 00:00:00.000',N'',5,N'Good')
insert into DANH_GIA_SAN_PHAM values ('173','104','2019-12-05 00:00:00.000',N'',1,N'Tệ')
insert into DANH_GIA_SAN_PHAM values ('131','118','2019-12-05 00:00:00.000',N'',1,N'')
insert into DANH_GIA_SAN_PHAM values ('131','117','2019-10-05 00:00:00.000',N'',5,N'')
insert into DANH_GIA_SAN_PHAM values ('150','120','2019-09-05 00:00:00.000',N'',4,N'')
insert into DANH_GIA_SAN_PHAM values ('150','109','2019-09-11 00:00:00.000',N'',5,N'')
insert into DANH_GIA_SAN_PHAM values ('100','120','2019-12-07 00:00:00.000',N'',4,N'')
insert into DANH_GIA_SAN_PHAM values ('120','119','2019-12-02 00:00:00.000',N'',5,N'')
insert into DANH_GIA_SAN_PHAM values ('121','119','2019-11-02 00:00:00.000',N'',3,N'')
insert into DANH_GIA_SAN_PHAM values ('139','113','2019-11-01 00:00:00.000',N'',2,N'')
insert into DANH_GIA_SAN_PHAM values ('139','104','2019-07-23 00:00:00.000',N'',1,N'')
insert into DANH_GIA_SAN_PHAM values ('142','100','2019-07-11 00:00:00.000',N'',4,N'')
insert into DANH_GIA_SAN_PHAM values ('200','114','2019-06-22 00:00:00.000',N'',5,N'')
insert into DANH_GIA_SAN_PHAM values ('256','119','2019-06-09 00:00:00.000',N'',1,N'')
insert into DANH_GIA_SAN_PHAM values ('260','110','2019-12-11 00:00:00.000',N'',3,N'')
insert into DANH_GIA_SAN_PHAM values ('299','115','2019-05-23 00:00:00.000',N'',4,N'')
insert into DANH_GIA_SAN_PHAM values ('150','117','2019-05-01 00:00:00.000',N'',5,N'')
insert into DANH_GIA_SAN_PHAM values ('277','107','2019-12-23 00:00:00.000',N'',5,N'')
insert into DANH_GIA_SAN_PHAM values ('152','111','2019-11-25 00:00:00.000',N'',3,N'')
insert into DANH_GIA_SAN_PHAM values ('222','101','2019-10-12 00:00:00.000',N'',1,N'')
insert into DANH_GIA_SAN_PHAM values ('101','104','2019-09-09 00:00:00.000',N'',5,N'')


------------------------------------------------------- INDEX -------------------------------------------------------------

--Cài đặt chỉ mục trên thuộc tính ‘TenKH’ của bảng KHACH_HANG
create nonClustered index index_TenKH
on KHACH_HANG(TenKH)

--Cài đặt chỉ mục trên thuộc tính ‘TenSach’ của bảng SACH
create nonClustered index index_Ten_Sach
on SACH(TenSach)

--Cài đặt chỉ mục trên thuộc tính ‘NgayDatHang’ của bảng DON_HANG
create nonClustered index index_NgayDatHang
on DON_HANG(NgayDatHang)






