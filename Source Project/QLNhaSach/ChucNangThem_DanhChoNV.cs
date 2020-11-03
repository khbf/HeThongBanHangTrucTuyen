using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace QLNhaSach
{
    public partial class ChucNangThem_DanhChoNV : Form
    {
        public ChucNangThem_DanhChoNV()
        {
            InitializeComponent();
        }

        Connect cn = new Connect();

        public void loaddsKhachHang()                               //đổ dữ liệu thông tin khách hàng vào datagridview
        {
            SqlConnection con = cn.KetNoi();

            string query = "SELECT TK.MaTaiKhoan, KH.MaKH, KH.TenKH, KH.NgaySinh, KH.GioiTinh " +
                           " FROM KHACH_HANG KH join TAI_KHOAN TK on KH.TaiKhoan_KH = TK.MaTaiKhoan";

            DataTable dt = new DataTable();

            SqlDataAdapter adapter = new SqlDataAdapter(query, con);
            con.Open();
            adapter.Fill(dt);
            dsKhachHang.DataSource = dt;
            con.Close();
        }
        public void loaddsNhanVien()                                //đổ dữ liệu thông tin nhân viên vào datagridview
        {
            SqlConnection con = cn.KetNoi();

            string query = "SELECT TK.MaTaiKhoan, NV.MaNV, NV.TenNV, NV.SDT_NV " +
                           " FROM NHAN_VIEN NV join TAI_KHOAN TK on NV.TaiKhoan_NV= TK.MaTaiKhoan";

            DataTable dt = new DataTable();

            SqlDataAdapter adapter = new SqlDataAdapter(query, con);
            con.Open();
            adapter.Fill(dt);
            dsNhanVien.DataSource = dt;
            con.Close();
        }

        public void loaddsDonHang()                                //đổ dữ liệu đơn hàng vào datagridview
        {
            SqlConnection con = cn.KetNoi();

            string query = "SELECT * FROM DON_HANG";

            DataTable dt = new DataTable();

            SqlDataAdapter adapter = new SqlDataAdapter(query, con);
            con.Open();
            adapter.Fill(dt);
            dsDonHang.DataSource = dt;
            con.Close();
        }

        public void loaddsCTDonHang()                                //đổ dữ liệu CT đơn hàng vào datagridview
        {
            SqlConnection con = cn.KetNoi();

            string query = "SELECT SoDH, MaSach_CTDH, SoLuong, DonGia FROM CHI_TIET_DON_HANG";

            DataTable dt = new DataTable();

            SqlDataAdapter adapter = new SqlDataAdapter(query, con);
            con.Open();
            adapter.Fill(dt);
            dsCTDH.DataSource = dt;
            con.Close();
        }

        public void loaddsSach()                        //đổ dữ liệu SÁch vào
        {
            SqlConnection con = cn.KetNoi();

            string query = "SELECT * FROM SACH";

            DataTable dt = new DataTable();

            SqlDataAdapter adapter = new SqlDataAdapter(query, con);
            con.Open();
            adapter.Fill(dt);
            dsBook.DataSource = dt;
            con.Close();
        }

        public void loaddsDanhMuc()                         //đổ dữ liệu Danh mục vào 
        {
            SqlConnection con = cn.KetNoi();

            string query = "SELECT * FROM DANH_MUC_SACH";

            DataTable dt = new DataTable();

            SqlDataAdapter adapter = new SqlDataAdapter(query, con);
            con.Open();
            adapter.Fill(dt);
            dsDanhMuc.DataSource = dt;
            con.Close();
        }
        public void loaddsTheLoai()                                 //đổ dữ liệu Thể loại vào
        {
            SqlConnection con = cn.KetNoi();

            string query = "SELECT * FROM THE_LOAI";

            DataTable dt = new DataTable();

            SqlDataAdapter adapter = new SqlDataAdapter(query, con);
            con.Open();
            adapter.Fill(dt);
            dsTheLoai.DataSource = dt;
            con.Close();
        }
        public void loaddsTacGia()                                  //đổ dữ liệu Tác giả vào
        {
            SqlConnection con = cn.KetNoi();

            string query = "SELECT * FROM TAC_GIA";

            DataTable dt = new DataTable();

            SqlDataAdapter adapter = new SqlDataAdapter(query, con);
            con.Open();
            adapter.Fill(dt);
            dsTacGia.DataSource = dt;
            con.Close();
        }
        public void loaddsDGSP()                                           //đổ dữ liệu DANH_GIA_SAN_PHAM vào datagridview
        {
            SqlConnection con = cn.KetNoi();

            string query = "SELECT dg.MaSach_DanhGia, s.TenSach,dg.MaKH_DanhGia,dg.NgayDanhGia,dg.TieuDe, dg.DanhGia,dg.NoiDung " +
                            "FROM DANH_GIA_SAN_PHAM dg join SACH s on dg.MaSach_DanhGia = s.MaSach";

            DataTable dt = new DataTable();

            SqlDataAdapter adapter = new SqlDataAdapter(query, con);
            con.Open();
            adapter.Fill(dt);
            dsDanhGiaSP.DataSource = dt;
            con.Close();
        }
        private void ChucNangThem_DanhChoNV_Load(object sender, EventArgs e)            //đổ dữ liệu của các bảng vào form khi form hiện ra
        {     
            loaddsSach();
            loaddsDanhMuc();
            loaddsTheLoai();
            loaddsTacGia();
            loaddsKhachHang();
            loaddsNhanVien();
            loaddsDonHang();
            loaddsCTDonHang();
            loaddsDGSP();
            FillMaKH();
            FillMaNV();
            FillSoDH();
        }

        private void buttonThemDM_Click(object sender, EventArgs e)                     //button thêm danh mục mới
        {
            SqlConnection con = cn.KetNoi();
            textBoxMaDMUpdate.Enabled = false;
            buttonXoaDM.Enabled = false;
            buttonUpdateDM.Enabled = false;

            string procName = "NV_ThemDanhMucSach";                                      //goi store NV_ThemDanhMucSach trong sql server
            SqlCommand cmd = new SqlCommand(procName, con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            //truyen tham so vao stored proc
            cmd.Parameters.AddWithValue("@tendm", textBoxTenDM.Text);                //du lieu nhap tu text box

            //get value form out put parameter in stored proc
            SqlParameter outputParameter = new SqlParameter();
            outputParameter.ParameterName = "@kq";
            outputParameter.SqlDbType = System.Data.SqlDbType.Int;
            outputParameter.Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add(outputParameter);
            //doan code tren de nhan gia tri tra ve tu sp

            con.Open();
            cmd.ExecuteNonQuery();
            int frag = int.Parse(outputParameter.Value.ToString());

            //kiểm tra thêm thành công
            if (frag == 1)
            {
                loaddsDanhMuc();                                                     //load lại danh sách Danh Mục vừa được thêm
                MessageBox.Show("Thêm danh mục sách mới thành công!");
                con.Close();
            }
            else
            {
                MessageBox.Show("Thêm danh mục sách mới không thành công!\nVui lòng nhập lại", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                con.Close();
            }
        }

        private void buttonThemTL_Click(object sender, EventArgs e)                           //button thêm thể loại mới
        {
            SqlConnection con = cn.KetNoi();
            textBoxMaTLUpdate.Enabled = false;
            buttonXoaTL.Enabled = false;
            buttonUpdateTL.Enabled = false;

            string procName = "NV_ThemTheLoai";                                                //goi store NV_ThemTheLoai trong sql server
            SqlCommand cmd = new SqlCommand(procName, con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            //truyen tham so vao stored proc
            cmd.Parameters.AddWithValue("@tenloai", textBoxTenTL.Text);                                  //du lieu nhap tu text box
            cmd.Parameters.AddWithValue("@madm", int.Parse(textBoxMaDanhMuc.Text.ToString()));          //du lieu nhap tu text box

            //get value form out put parameter in stored proc
            SqlParameter outputParameter = new SqlParameter();
            outputParameter.ParameterName = "@kq";
            outputParameter.SqlDbType = System.Data.SqlDbType.Int;
            outputParameter.Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add(outputParameter);
            //doan code tren de nhan gia tri tra ve tu sp

            con.Open();
            cmd.ExecuteNonQuery();
            int frag = int.Parse(outputParameter.Value.ToString());

            //kiểm tra thêm thành công
            if (frag == 1)
            {
                loaddsTheLoai();                                                                    //load lại danh sách Thể loại vừa được thêm
                MessageBox.Show("Thêm thể loại sách mới thành công!");
                con.Close();
            }
            else
            {
                MessageBox.Show("Thêm thể loại sách mới không thành công!\nVui lòng nhập lại", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                con.Close();
            }  
         }

        private void buttonThemTG_Click(object sender, EventArgs e)                      //button thêm tac giả
        {
            SqlConnection con = cn.KetNoi();
            textBoxMaTGUpdate.Enabled = false;
            buttonXoaTG.Enabled = false;
            buttonUpdateTG.Enabled = false;

            string procName = "NV_ThemTacGia";                                            //goi store NV_ThemTacGia trong sql server
            SqlCommand cmd = new SqlCommand(procName, con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            //truyen tham so vao stored proc
            cmd.Parameters.AddWithValue("@tentacgia", textBoxTenTG.Text);                //du lieu nhap tu text box
            cmd.Parameters.AddWithValue("@gioithieu", textBoxGioiThieuTG.Text);          //du lieu nhap tu text box

            //get value form out put parameter in stored proc
            SqlParameter outputParameter = new SqlParameter();
            outputParameter.ParameterName = "@kq";
            outputParameter.SqlDbType = System.Data.SqlDbType.Int;
            outputParameter.Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add(outputParameter);
            //doan code tren de nhan gia tri tra ve tu sp

            con.Open();
            cmd.ExecuteNonQuery();
            int frag = int.Parse(outputParameter.Value.ToString());

            //kiểm tra thêm thành công
            if (frag == 1)
            {
                loaddsTacGia();                                                           //load lại danh sách tác giả vừa được thêm
                MessageBox.Show("Thêm tác giả mới thành công!");
                con.Close();
            }
            else
            {
                MessageBox.Show("Thêm tác giả mới không thành công!\nVui lòng nhập lại", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                con.Close();
            }
        }

        private void buttonThemSach_Click(object sender, EventArgs e)                            //button thêm sách mới
        {
            SqlConnection con = cn.KetNoi();
            textBoxMaSachXoa.Enabled = false;
            buttonXoaSach.Enabled = false;
            textBoxMaSachUpdate.Enabled = false;
            buttonUpdateSach.Enabled = false;

            string procName = "NV_ThemSach";                                                     //goi store NV_ThemSach trong sql server
            SqlCommand cmd = new SqlCommand(procName, con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            //truyen tham so vao stored proc
            cmd.Parameters.AddWithValue("@tensach", textBoxTenSach.Text);                             //du lieu nhap tu text box
            cmd.Parameters.AddWithValue("@tacgia", int.Parse(textBoxMatg.Text.ToString()));          //du lieu nhap tu text box
            cmd.Parameters.AddWithValue("@nguoidich", textBoxNguoiDich.Text);                         //du lieu nhap tu text box
            cmd.Parameters.AddWithValue("@mota", textBoxMoTa.Text);                                  //du lieu nhap tu text box
            cmd.Parameters.AddWithValue("@madm", int.Parse(textBoxMaDM.Text.ToString()));          //du lieu nhap tu text box
            cmd.Parameters.AddWithValue("@maloai", int.Parse(textBoxMaTL.Text.ToString()));          //du lieu nhap tu text box
            cmd.Parameters.AddWithValue("@nxb", textBoxNXB.Text);                                   //du lieu nhap tu text box
            cmd.Parameters.AddWithValue("@nhaphathanh", textBoxNhaPH.Text);                              //du lieu nhap tu text box
            cmd.Parameters.AddWithValue("@ngayphathanh", DateTime.Parse(dateTimePickerNPH.Text));         
            cmd.Parameters.AddWithValue("@khoiluong", Double.Parse(textBoxKLuong.Text.ToString()));          //du lieu nhap tu text box
            cmd.Parameters.AddWithValue("@sotrang", int.Parse(textBoxSoTrang.Text.ToString()));          //du lieu nhap tu text box
            cmd.Parameters.AddWithValue("@giatien", Decimal.Parse(textBoxGiaTien.Text.ToString()));          //du lieu nhap tu text box
            cmd.Parameters.AddWithValue("@soluongton", int.Parse(textBoxSL.Text.ToString()));          //du lieu nhap tu text box

            //get value form out put parameter in stored proc
            SqlParameter outputParameter = new SqlParameter();
            outputParameter.ParameterName = "@kq";
            outputParameter.SqlDbType = System.Data.SqlDbType.Int;
            outputParameter.Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add(outputParameter);
            //doan code tren de nhan gia tri tra ve tu sp

            con.Open();
            cmd.ExecuteNonQuery();
            int frag = int.Parse(outputParameter.Value.ToString());

            //kiểm tra thêm thành công
            if (frag == 1)
            {
                loaddsSach();                                                                         //load lại danh sách Sách vừa được thêm
                MessageBox.Show("Thêm sách mới thành công!");
                con.Close();
            }
            else
            {
                MessageBox.Show("Thêm sách mới không thành công!\nVui lòng nhập lại", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                con.Close();
            }
        }

        private void buttonXoaSach_Click(object sender, EventArgs e)                             //NV xóa sách có trong hệ thống
        {            
            SqlConnection con = cn.KetNoi();
            textBoxMaSachUpdate.Enabled = false;
            buttonUpdateSach.Enabled = false;
            buttonThemSach.Enabled = false;

            string procName = "NV_XoaSach";                                                       //goi store NV_XoaSach trong sql server
            SqlCommand cmd = new SqlCommand(procName, con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            //truyen tham so vao stored proc
            cmd.Parameters.AddWithValue("@masach",int.Parse(textBoxMaSachXoa.Text.ToString()));        //du lieu nhap tu text box

            //get value form out put parameter in stored proc
            SqlParameter outputParameter = new SqlParameter();
            outputParameter.ParameterName = "@kq";
            outputParameter.SqlDbType = System.Data.SqlDbType.Int;
            outputParameter.Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add(outputParameter);
            //doan code tren de nhan gia tri tra ve tu sp

            con.Open();
            cmd.ExecuteNonQuery();
            int frag = int.Parse(outputParameter.Value.ToString());

            //kiểm tra thêm thành công
            if (frag == 1)
            {
                loaddsSach();                                                             //load lại danh sách Sách sau khi bị xóa
                MessageBox.Show("Xóa sách thành công!");
                con.Close();
            }
            else
            {
                MessageBox.Show("Xóa sách không thành công!\nVui lòng thử lại", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                con.Close();
            }
        }


        private void buttonUpdateSach_Click(object sender, EventArgs e)               //cập nhật thông tin sách    
        {
            SqlConnection con = cn.KetNoi();
            textBoxMaSachXoa.Enabled = false;
            buttonXoaSach.Enabled = false;
            buttonThemSach.Enabled = false;

            string procName = "NV_CapNhatSach";                                       //goi store NV_CapNhatSach trong sql server
            SqlCommand cmd = new SqlCommand(procName, con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            //truyen tham so vao stored proc
            cmd.Parameters.AddWithValue("@masach", int.Parse(textBoxMaSachUpdate.Text.ToString()));         //du lieu nhap tu text box
            cmd.Parameters.AddWithValue("@tensach", textBoxTenSach.Text);                            
            cmd.Parameters.AddWithValue("@tacgia", int.Parse(textBoxMatg.Text.ToString()));          
            cmd.Parameters.AddWithValue("@nguoidich", textBoxNguoiDich.Text);                       
            cmd.Parameters.AddWithValue("@mota", textBoxMoTa.Text);                                 
            cmd.Parameters.AddWithValue("@madm", int.Parse(textBoxMaDM.Text.ToString()));            
            cmd.Parameters.AddWithValue("@maloai", int.Parse(textBoxMaTL.Text.ToString()));          
            cmd.Parameters.AddWithValue("@nxb", textBoxNXB.Text);                                   
            cmd.Parameters.AddWithValue("@nhaphathanh", textBoxNhaPH.Text);                         
            cmd.Parameters.AddWithValue("@ngayphathanh", DateTime.Parse(dateTimePickerNPH.Text));         
            cmd.Parameters.AddWithValue("@khoiluong", Double.Parse(textBoxKLuong.Text.ToString()));        
            cmd.Parameters.AddWithValue("@sotrang", int.Parse(textBoxSoTrang.Text.ToString()));         
            cmd.Parameters.AddWithValue("@giatien", float.Parse(textBoxGiaTien.Text.ToString()));          
            cmd.Parameters.AddWithValue("@soluongton", int.Parse(textBoxSL.Text.ToString()));             

            //get value form out put parameter in stored proc
            SqlParameter outputParameter = new SqlParameter();
            outputParameter.ParameterName = "@kq";
            outputParameter.SqlDbType = System.Data.SqlDbType.Int;
            outputParameter.Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add(outputParameter);
            //doan code tren de nhan gia tri tra ve tu sp

            con.Open();
            cmd.ExecuteNonQuery();
            int frag = int.Parse(outputParameter.Value.ToString());

            //kiểm tra thêm thành công
            if (frag == 1)
            {
                loaddsSach();                                        //load lại danh sách sách vừa được cập nhật
                MessageBox.Show("Cập nhật sách thành công!");
                con.Close();
            }
            else
            {
                MessageBox.Show("Cập nhật sách không thành công!\nVui lòng thử lại", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                con.Close();
            }
        }

        private void buttonUpdateDM_Click(object sender, EventArgs e)                                //cập nhật thông tin danh mục
        {
            SqlConnection con = cn.KetNoi();
            buttonThemDM.Enabled = false;
            buttonXoaDM.Enabled = false;

            string procName = "NV_CapNhatDanhMucSach";                                               //goi store NV_CapNhatDanhMucSach trong sql server
            SqlCommand cmd = new SqlCommand(procName, con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            //truyen tham so vao stored proc
            cmd.Parameters.AddWithValue("@madm", int.Parse(textBoxMaDMUpdate.Text.ToString()));          //du lieu nhap tu text box
            cmd.Parameters.AddWithValue("@tendm", textBoxTenDM.Text);                                   //du lieu nhap tu text box

            //get value form out put parameter in stored proc
            SqlParameter outputParameter = new SqlParameter();
            outputParameter.ParameterName = "@kq";
            outputParameter.SqlDbType = System.Data.SqlDbType.Int;
            outputParameter.Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add(outputParameter);
            //doan code tren de nhan gia tri tra ve tu sp

            con.Open();
            cmd.ExecuteNonQuery();
            int frag = int.Parse(outputParameter.Value.ToString());

            //kiểm tra thêm thành công
            if (frag == 1)
            {
                loaddsDanhMuc();                                                              //load lại danh sách Danh mục vừa được cập nhật
                MessageBox.Show("Cập nhật danh mục sách thành công!");
                con.Close();
            }
            else
            {
                MessageBox.Show("Cập nhật danh mục sách không thành công!\nVui lòng thử lại", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                con.Close();
            }
        }

        private void buttonUpdateTL_Click(object sender, EventArgs e)                           //cập nhật thông tin thể loại sách
        {
            SqlConnection con = cn.KetNoi();
            buttonThemTL.Enabled = false;
            buttonXoaTL.Enabled = false;

            string procName = "NV_CapNhatTheLoai";                                            //goi store NV_CapNhatTheLoai trong sql server
            SqlCommand cmd = new SqlCommand(procName, con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            //truyen tham so vao stored proc
            cmd.Parameters.AddWithValue("@maloai", int.Parse(textBoxMaTLUpdate.Text.ToString()));          //du lieu nhap tu text box
            cmd.Parameters.AddWithValue("@tenloai", textBoxTenTL.Text);                                   //du lieu nhap tu text box
            cmd.Parameters.AddWithValue("@madm", int.Parse(textBoxMaDanhMuc.Text.ToString()));            //du lieu nhap tu text box

            //get value form out put parameter in stored proc
            SqlParameter outputParameter = new SqlParameter();
            outputParameter.ParameterName = "@kq";
            outputParameter.SqlDbType = System.Data.SqlDbType.Int;
            outputParameter.Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add(outputParameter);
            //doan code tren de nhan gia tri tra ve tu sp

            con.Open();
            cmd.ExecuteNonQuery();
            int frag = int.Parse(outputParameter.Value.ToString());

            //kiểm tra thêm thành công
            if (frag == 1)
            {
                loaddsTheLoai();                                                         //load lại danh sách thể loại vừa được cập nhật
                MessageBox.Show("Cập nhật thể loại sách thành công!");
                con.Close();
            }
            else
            {
                MessageBox.Show("Cập nhật thể loại sách không thành công!\nVui lòng thử lại", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                con.Close();
            }
        }

        private void buttonUpdateTG_Click(object sender, EventArgs e)                                  //cập nhật thông tin tác giả
        {
            SqlConnection con = cn.KetNoi();
            buttonThemTG.Enabled = false;
            buttonXoaTG.Enabled = false;

            string procName = "NV_CapNhatTacGia";                                                     //goi store NV_CapNhatTacGia trong sql server
            SqlCommand cmd = new SqlCommand(procName, con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            //truyen tham so vao stored proc
            cmd.Parameters.AddWithValue("@matacgia", int.Parse(textBoxMaTGUpdate.Text.ToString()));          //du lieu nhap tu text box
            cmd.Parameters.AddWithValue("@tentacgia", textBoxTenTG.Text);                                   //du lieu nhap tu text box
            cmd.Parameters.AddWithValue("@gioithieu", textBoxGioiThieuTG.Text);                            //du lieu nhap tu text box

            //get value form out put parameter in stored proc
            SqlParameter outputParameter = new SqlParameter();
            outputParameter.ParameterName = "@kq";
            outputParameter.SqlDbType = System.Data.SqlDbType.Int;
            outputParameter.Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add(outputParameter);
            //doan code tren de nhan gia tri tra ve tu sp

            con.Open();
            cmd.ExecuteNonQuery();
            int frag = int.Parse(outputParameter.Value.ToString());

            //kiểm tra thêm thành công
            if (frag == 1)
            {
                loaddsTacGia();                                                          //load lại danh sách tác giả vừa được cập nhật
                MessageBox.Show("Cập nhật thông tin tác giả thành công!");
                con.Close();
            }
            else
            {
                MessageBox.Show("Cập nhật thông tin tác giả không thành công!\nVui lòng thử lại", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                con.Close();
            }
        }

        public void FillMaKH()                                                       //đổ danh sách MaKH vào combobox
        {
            comboBoxMaKH.Items.Clear();
            comBoxMaKH.Items.Clear();
            comboBoxMaKH_DH.Items.Clear();
            comboBoxMaKH_CTDH.Items.Clear();

            SqlConnection con = cn.KetNoi();
            SqlCommand cmd;
            cmd = con.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT MaKH FROM KHACH_HANG";
            con.Open();
            cmd.ExecuteNonQuery();
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            foreach (DataRow dr in dt.Rows)
            {
                comboBoxMaKH.Items.Add(dr["MaKH"].ToString());
                comBoxMaKH.Items.Add(dr["MaKH"].ToString());
                comboBoxMaKH_DH.Items.Add(dr["MaKH"].ToString());
                comboBoxMaKH_CTDH.Items.Add(dr["MaKH"].ToString());

            }
            foreach (Control ctl in this.Controls)
            {
                ctl.ResetBindings();
            }
        }

        private void comboBoxMaKH_SelectedIndexChanged(object sender, EventArgs e)       //tìm kiếm đánh giá sản phẩm theo MAKH
        {
            SqlConnection con = cn.KetNoi();
            string item = comboBoxMaKH.SelectedItem.ToString();
            DataTable dt = new DataTable();
            try
            {
                SqlCommand cmd = new SqlCommand("TKiemDGSP_TheoMaKH", con);             //gọi stored TKiemDGSP_TheoMaKH
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@makh", item);
                SqlDataAdapter adt = new SqlDataAdapter(cmd);
                adt.Fill(dt);
                con.Close();
                dsDanhGiaSP.DataSource = dt;

            }
            catch
            {
                MessageBox.Show("Chương trình bị lỗi", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                con.Close();
            }
        }

        private void buttonReset_Click(object sender, EventArgs e)      //reset lại tất cả dữ liệu vừa được cập nhật, thêm, xóa ở trang đánh giá sản phẩm
        {
            SqlConnection con = cn.KetNoi();
            con.Open();
            FillMaKH();
            loaddsDGSP();
            textBoxTenSach_DGSP.Text = String.Empty;
            textBoxMaSachDG.Text = String.Empty;
            textBoxMaKHDG.Text = String.Empty;
            dateTimePickerNgayDG.Text = String.Empty;

            MessageBox.Show("Reset dữ liệu thành công!");
            con.Close();
        }

        private void buttonXoaDG_Click(object sender, EventArgs e)            //xóa một đánh giá sản phẩm của khách hàng
        {
            SqlConnection con = cn.KetNoi();
            string procName = "KH_XoaDanhGiaSP";                                                     //goi store KH_XoaDanhGiaSP trong sql server
            SqlCommand cmd = new SqlCommand(procName, con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            //truyen tham so vao stored proc
            cmd.Parameters.AddWithValue("@masach", int.Parse(textBoxMaSachDG.Text.ToString()));          //du lieu nhap tu text box
            cmd.Parameters.AddWithValue("@makh", int.Parse(textBoxMaKHDG.Text.ToString()));              //du lieu nhap tu text box
            cmd.Parameters.AddWithValue("@ngaydanhgia", DateTime.Parse(dateTimePickerNgayDG.Text));     //du lieu nhap tu text box

            //get value form out put parameter in stored proc
            SqlParameter outputParameter = new SqlParameter();
            outputParameter.ParameterName = "@kq";
            outputParameter.SqlDbType = System.Data.SqlDbType.Int;
            outputParameter.Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add(outputParameter);
            //doan code tren de nhan gia tri tra ve tu sp

            con.Open();
            cmd.ExecuteNonQuery();
            int frag = int.Parse(outputParameter.Value.ToString());

            //kiểm tra thêm thành công
            if (frag == 1)
            {
                loaddsDGSP();                                                            //load lại danh sách đánh giá sp vừa được cập nhật
                MessageBox.Show("Xóa đánh giá/bình luận sản phẩm thành công!");
                con.Close();
            }
            else
            {
                MessageBox.Show("Xóa đánh giá/bình luận sản phẩm không thành công!\nVui lòng thử lại", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                con.Close();
            }
        }

        private void buttonSearchByTenSach_Click(object sender, EventArgs e)                 //tìm kiếm đánh giá sản phẩm theo tên sách
        {
            SqlConnection con = cn.KetNoi();
            con.Open();
            try
            {
                SqlCommand com = new SqlCommand("TKiemDGSP_TheoTenSP", con);            //gọi stored TKiemDGSP_TheoTenSP
                DataTable dt = new DataTable();
                com.CommandType = CommandType.StoredProcedure;

                com.Parameters.Add(new SqlParameter("@tensp", SqlDbType.NVarChar)).Value = textBoxTenSach_DGSP.Text;
                SqlDataAdapter da = new SqlDataAdapter(com);
                da.Fill(dt);
                dsDanhGiaSP.DataSource = dt;
                con.Close();
            }
            catch
            {
                MessageBox.Show("Chương trình bị lỗi", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                con.Close();
            }
        }

        private void buttonXoaTL_Click(object sender, EventArgs e)          //không cho nhân viên xóa thể loại sách
        {
            MessageBox.Show("Nhân viên không được phép xóa Thể Loại Sách!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }

        private void buttonXoaDM_Click(object sender, EventArgs e)          //không cho nhân viên xóa danh mục sách
        {
            MessageBox.Show("Nhân viên không được phép xóa Danh Mục Sách!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }

        private void buttonXoaTG_Click(object sender, EventArgs e)           //không cho nhân viên xóa tác giả
        {
            MessageBox.Show("Nhân viên không được phép xóa Tác Giả!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }

        private void tabControlChucNangNV_Selecting(object sender, TabControlCancelEventArgs e)     //chỉ cho phép NV cấp cao hơn vào tabPageNV
        {
            if ((DangNhap.Email_DN != "bppkhanh@gmail.com" && DangNhap.Pass_DN != "admin1"))       //nếu email và pass đúng điều kiện
            {
                if (e.TabPage == tabPageNV)
                {
                    e.Cancel = true;                                                              //không cho phép vào trang
                    MessageBox.Show("Nhân viên không có quyền không được phép vào trang này!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }

        private void comBoxMaKH_SelectedIndexChanged(object sender, EventArgs e)        //NV tìm kiếm thông tin khách hàng theo MaKH
        {
            SqlConnection con = cn.KetNoi();
            string item = comBoxMaKH.SelectedItem.ToString();
            DataTable dt = new DataTable();
            try
            {
                SqlCommand cmd = new SqlCommand("TKiemKH_TheoMaKH", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@makh", item);
                SqlDataAdapter adt = new SqlDataAdapter(cmd);
                adt.Fill(dt);
                con.Close();
                dsKhachHang.DataSource = dt;

            }
            catch
            {
                MessageBox.Show("Chương trình bị lỗi", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                con.Close();
            }
        }

        private void buttonReserDL_Click(object sender, EventArgs e)                  //reset dữ liệu của bảng thông tin Khách hàng
        {
            SqlConnection con = cn.KetNoi();
            con.Open();
            FillMaKH();
            loaddsKhachHang();
            textBoxMaKHXoa.Text = String.Empty;
            MessageBox.Show("Reset dữ liệu thành công!");
            con.Close();
        }

        private void buttonXoaKH_Click(object sender, EventArgs e)                              //NV xóa khách hàng theo mã
        {
            SqlConnection con = cn.KetNoi();
            string procName = "NV_XoaKhachHangTheoMaKH";                                         //goi store NV_XoaKhachHangTheoMaKH trong sql server
            SqlCommand cmd = new SqlCommand(procName, con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            //truyen tham so vao stored proc
            cmd.Parameters.AddWithValue("@makh", int.Parse(textBoxMaKHXoa.Text.ToString()));        //du lieu nhap tu text box

            //get value form out put parameter in stored proc
            SqlParameter outputParameter = new SqlParameter();
            outputParameter.ParameterName = "@kq";
            outputParameter.SqlDbType = System.Data.SqlDbType.Int;
            outputParameter.Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add(outputParameter);
            //doan code tren de nhan gia tri tra ve tu sp

            con.Open();
            cmd.ExecuteNonQuery();
            int frag = int.Parse(outputParameter.Value.ToString());

            //kiểm tra xóa thành công
            if (frag == 1)
            {
                loaddsKhachHang();                                                   //load lại danh sách Khách hàng sau khi bị xóa
                MessageBox.Show("Xóa Khách hàng thành công!");
                con.Close();
            }
            else
            {
                MessageBox.Show("Xóa Khách hàng không thành công!\nVui lòng thử lại", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                con.Close();
            }
        }
        public void FillMaNV()                                                       //đổ danh sách MaNV vào combobox
        {
            comBoxNV.Items.Clear();
            SqlConnection con = cn.KetNoi();
            SqlCommand cmd;
            cmd = con.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT MaNV FROM NHAN_VIEN";
            con.Open();
            cmd.ExecuteNonQuery();
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            foreach (DataRow dr in dt.Rows)
            {
                comBoxNV.Items.Add(dr["MaNV"].ToString());
            }
            foreach (Control ctl in this.Controls)
            {
                ctl.ResetBindings();
            }
        }

        private void comBoxNV_SelectedIndexChanged(object sender, EventArgs e)           //NV cấp cao tìm kiếm thông tin nhân viên thường theo MaNV
        {
            SqlConnection con = cn.KetNoi();
            string item = comBoxNV.SelectedItem.ToString();
            DataTable dt = new DataTable();
            try
            {
                SqlCommand cmd = new SqlCommand("TKiemNV_TheoMaNV", con);           //gọi stored TKiemNV_TheoMaNV
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@manv", item);
                SqlDataAdapter adt = new SqlDataAdapter(cmd);
                adt.Fill(dt);
                con.Close();
                dsNhanVien.DataSource = dt;

            }
            catch
            {
                MessageBox.Show("Chương trình bị lỗi", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                con.Close();
            }
        }

        private void buttonXoaNV_Click(object sender, EventArgs e)                    //NV cấp cao xóa nhân viên thường ra khỏi hệ thống bằng MaNV
        {
            SqlConnection con = cn.KetNoi();
            string procName = "XoaNhanVienKhoiHeThong";                                             //goi store XoaNhanVienKhoiHeThong trong sql server
            SqlCommand cmd = new SqlCommand(procName, con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            //truyen tham so vao stored proc
            cmd.Parameters.AddWithValue("@manv", int.Parse(textBoxNVXoa.Text.ToString()));          //du lieu nhap tu text box

            //get value form out put parameter in stored proc
            SqlParameter outputParameter = new SqlParameter();
            outputParameter.ParameterName = "@kq";
            outputParameter.SqlDbType = System.Data.SqlDbType.Int;
            outputParameter.Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add(outputParameter);
            //doan code tren de nhan gia tri tra ve tu sp

            con.Open();
            cmd.ExecuteNonQuery();
            int frag = int.Parse(outputParameter.Value.ToString());

            //kiểm tra xóa thành công
            if (frag == 1)
            {
                loaddsNhanVien();                                                   //load lại danh sách nhân viên sau khi bị xóa
                MessageBox.Show("Xóa Nhân viên thành công!");
                con.Close();
            }
            else
            {
                MessageBox.Show("Xóa Nhân viên không thành công!\nVui lòng thử lại", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                con.Close();
            }
        }

        private void buttonResetDLNV_Click(object sender, EventArgs e)               //reset lại dữ liệu bảng nhân viên
        {
            SqlConnection con = cn.KetNoi();
            con.Open();
            FillMaNV();
            loaddsNhanVien();
            textBoxNVXoa.Text = String.Empty;
            MessageBox.Show("Reset dữ liệu thành công!");
            con.Close();
        }

        public void FillSoDH()                                                       //đổ danh sách SoDonHang vào combobox
        {
            comboBoxSoDH_DH.Items.Clear();
            comboBoxSoDH_CTDH.Items.Clear();

            SqlConnection con = cn.KetNoi();
            SqlCommand cmd;
            cmd = con.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT SoDonHang FROM DON_HANG";
            con.Open();
            cmd.ExecuteNonQuery();
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            foreach (DataRow dr in dt.Rows)
            {
                comboBoxSoDH_DH.Items.Add(dr["SoDonHang"].ToString());
                comboBoxSoDH_CTDH.Items.Add(dr["SoDonHang"].ToString());

            }
            foreach (Control ctl in this.Controls)
            {
                ctl.ResetBindings();
            }
        }
        private void comboBoxSoDH_SelectedIndexChanged(object sender, EventArgs e)       //tìm kiếm đơn hàng theo SoDonHang
        {
            SqlConnection con = cn.KetNoi();
            string item = comboBoxSoDH_DH.SelectedItem.ToString();
            DataTable dt = new DataTable();
            try
            {
                SqlCommand cmd = new SqlCommand("TKiemDonHang_TheoSoDH", con);            //gọi stored TKiemDonHang_TheoSoDH
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@sodh", item);
                SqlDataAdapter adt = new SqlDataAdapter(cmd);
                adt.Fill(dt);
                con.Close();
                dsDonHang.DataSource = dt; 
            }
            catch
            {
                MessageBox.Show("Chương trình bị lỗi", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                con.Close();
            }
        }

        private void comboBoxMaKH_DH_SelectedIndexChanged(object sender, EventArgs e)           //tìm kiếm đơn hàng theo mã khách hàng
        {
            SqlConnection con = cn.KetNoi();
            string item = comboBoxMaKH_DH.SelectedItem.ToString();
            DataTable dt = new DataTable();
            try
            {
                SqlCommand cmd = new SqlCommand("TKiemDonHang_TheoMaKH", con);           //gọi stored TKiemDonHang_TheoMaKH
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@makh", item);
                SqlDataAdapter adt = new SqlDataAdapter(cmd);
                adt.Fill(dt);
                con.Close();
                dsDonHang.DataSource = dt;
            }
            catch
            {
                MessageBox.Show("Chương trình bị lỗi", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                con.Close();
            }
        } 

        private void buttonResetDLDH_CTDH_Click(object sender, EventArgs e)      //reset lại dữ liệu bảng đơn hàng, CTDH
        {
            SqlConnection con = cn.KetNoi();
            con.Open();
            FillSoDH();
            loaddsDonHang();
            loaddsCTDonHang();
            FillMaKH();
            textBoxSoDH_Update.Text = String.Empty;
            textBoxNVPT_Update.Text = String.Empty;
            textBoxTrangThai_Update.Text = String.Empty;

            MessageBox.Show("Reset dữ liệu thành công!");
            con.Close();
        }

        private void comboBoxSoDH_CTDH_SelectedIndexChanged(object sender, EventArgs e)     //tìm kiếm CT đơn hàng theo số đơn hàng
        {
            SqlConnection con = cn.KetNoi();
            string item = comboBoxSoDH_CTDH.SelectedItem.ToString();
            DataTable dt = new DataTable();
            try
            {
                SqlCommand cmd = new SqlCommand("TKiemCTDH_TheoSoDH", con);            //gọi stored TKiemCTDH_TheoSoDH
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@sodh", item);
                SqlDataAdapter adt = new SqlDataAdapter(cmd);
                adt.Fill(dt);
                con.Close();
                dsCTDH.DataSource = dt;
            }
            catch
            {
                MessageBox.Show("Chương trình bị lỗi", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                con.Close();
            }
        }

        private void comboBoxMaKH_CTDH_SelectedIndexChanged(object sender, EventArgs e)         //tìm kiếm CT đơn hàng theo mã khách hàng
        {
            SqlConnection con = cn.KetNoi();
            string item = comboBoxMaKH_CTDH.SelectedItem.ToString();
            DataTable dt = new DataTable();
            try
            {
                SqlCommand cmd = new SqlCommand("TKiemCTDH_TheoMaKH", con);            //gọi stored TKiemCTDH_TheoMaKH
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@makh", item);
                SqlDataAdapter adt = new SqlDataAdapter(cmd);
                adt.Fill(dt);
                con.Close();
                dsCTDH.DataSource = dt;
            }
            catch
            {
                MessageBox.Show("Chương trình bị lỗi", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                con.Close();
            }
        }

        private void buttonUpdate_DH_Click(object sender, EventArgs e)                  //NV cập nhật một số thông tin đơn hàng của khách hàng
        {
            SqlConnection con = cn.KetNoi();
            string procName = "NV_CapNhatDonHang";                                                //goi store NV_CapNhatDonHang trong sql server
            SqlCommand cmd = new SqlCommand(procName, con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            //truyen tham so vao stored proc
            cmd.Parameters.AddWithValue("@sodh", int.Parse(textBoxSoDH_Update.Text.ToString()));                 //du lieu nhap tu text box
            cmd.Parameters.AddWithValue("@nvphutrach", int.Parse(textBoxNVPT_Update.Text.ToString()));           //du lieu nhap tu text box
            cmd.Parameters.AddWithValue("@trangthaidh", int.Parse(textBoxTrangThai_Update.Text.ToString()));     //du lieu nhap tu text box

            //get value form out put parameter in stored proc
            SqlParameter outputParameter = new SqlParameter();
            outputParameter.ParameterName = "@kq";
            outputParameter.SqlDbType = System.Data.SqlDbType.Int;
            outputParameter.Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add(outputParameter);
            //doan code tren de nhan gia tri tra ve tu sp

            con.Open();
            cmd.ExecuteNonQuery();
            int frag = int.Parse(outputParameter.Value.ToString());

            //kiểm tra cập nhật thành công
            if (frag == 1)
            {
                loaddsDonHang();                                                          //load lại danh sách đơn hàng vừa được cập nhật
                MessageBox.Show("Nhân viên cập nhật thông tin Đơn hàng thành công!");
                con.Close();
            }
            else
            {
                MessageBox.Show("Nhân viên cập nhật thông tin đơn hàng không thành công!\nVui lòng thử lại", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                con.Close();
            }
        }

        private void buttonReset_Sach_Click(object sender, EventArgs e)         //reset lại dữ liệu form SACH
        {
            SqlConnection con = cn.KetNoi();
            con.Open();
            loaddsSach();
            textBoxMaSachXoa.Enabled = true;
            textBoxMaSachXoa.Text = String.Empty;               //xóa text đang có sẵn trong textbox
            buttonXoaSach.Enabled = true;
            textBoxMaSachUpdate.Enabled = true;
            textBoxMaSachUpdate.Text = String.Empty;
            buttonUpdateSach.Enabled = true;
            buttonThemSach.Enabled = true;
    
            MessageBox.Show("Reset dữ liệu thành công!");
            con.Close();
        }

        private void buttonReset_DM_Click(object sender, EventArgs e)       //reset dữ liệu form DANH MUC
        {
            SqlConnection con = cn.KetNoi();
            con.Open();
            loaddsDanhMuc();
            textBoxTenDM.Enabled = true;
            textBoxTenDM.Text = String.Empty;               //xóa text đang có sẵn trong textbox
            buttonThemDM.Enabled = true;
            textBoxMaDMUpdate.Enabled = true;
            textBoxMaDMUpdate.Text = String.Empty;
            buttonXoaDM.Enabled = true;
            buttonUpdateDM.Enabled = true;

            MessageBox.Show("Reset dữ liệu thành công!");
            con.Close();
        }

        private void buttonReset_TL_Click(object sender, EventArgs e)           //reset dữ liệu form THE LOAI
        {
            SqlConnection con = cn.KetNoi();
            con.Open();
            loaddsTheLoai();
            textBoxTenTL.Enabled = true;
            textBoxTenTL.Text = String.Empty;               //xóa text đang có sẵn trong textbox
            textBoxMaDanhMuc.Enabled = true;
            textBoxMaDanhMuc.Text = String.Empty;
            textBoxMaTLUpdate.Enabled = true;
            textBoxMaTLUpdate.Text = String.Empty;
            buttonThemTL.Enabled = true;
            buttonXoaTL.Enabled = true;
            buttonUpdateTL.Enabled = true;

            MessageBox.Show("Reset dữ liệu thành công!");
            con.Close();
        }

        private void buttonReset_TG_Click(object sender, EventArgs e)       //reset dữ liệu form TAC GIA
        {
            SqlConnection con = cn.KetNoi();
            con.Open();
            loaddsTacGia();
            textBoxTenTG.Enabled = true;
            textBoxTenTG.Text = String.Empty;               //xóa text đang có sẵn trong textbox
            textBoxGioiThieuTG.Enabled = true;
            textBoxGioiThieuTG.Text = String.Empty;
            textBoxMaTGUpdate.Enabled = true;
            textBoxMaTGUpdate.Text = String.Empty;
            buttonThemTG.Enabled = true;
            buttonXoaTG.Enabled = true;
            buttonUpdateTG.Enabled = true;

            MessageBox.Show("Reset dữ liệu thành công!");
            con.Close();
        }

       
    }
}
