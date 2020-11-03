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
    public partial class TrangChu : Form
    {
        public TrangChu()
        {
            InitializeComponent();
            FillDanhMuc();              //đổ danh sách DanhMuc vào combobox
            FillTheLoai();              //đổ danh sách TheLoai vào combobox
        }

        Connect cn = new Connect();

        private void TrangChu_Load(object sender, EventArgs e)             
        {
            SqlConnection con = cn.KetNoi();
            con.Open();
            HienThiSach();
            if (DangNhap.Loaitk == false)                                   //nếu là nhân viên thì ko vào được 
            {
                gIỎHÀNGToolStripMenuItem.Enabled = false;
                buttonDanhGiaSP.Enabled = false;
            }
            if (DangNhap.Loaitk == true)                                   //nếu là khách hàng thì ko vào được 
            {
                buttonKVNV.Enabled = false;
                tHỐNGKÊBÁOCÁOToolStripMenuItem.Enabled = false;
            }
            con.Close();
        }

        public void HienThiSach()                                           //đổ dữ liệu SACH vào datagridview
        {
            SqlConnection con = cn.KetNoi();

            string query = "select S.MaSach, S.TenSach, TG.TenTacGia,S.MoTaSach, DM.TenDM, TL.TenLoai, S.NXB, S.GiaTien, S.SoLuongTon " +
                           "from (DANH_MUC_SACH as DM join THE_LOAI as TL on DM.MaDM = TL.MaDM) join (SACH as S join TAC_GIA as TG on S.TacGia = TG.MaTacGia)" +
                           "on S.MaLoai = TL.MaLoai";

            DataTable dt = new DataTable();

            SqlDataAdapter adapter = new SqlDataAdapter(query, con);
            con.Open();
            adapter.Fill(dt);
            dsBook.DataSource = dt;
            con.Close();
        }

        private void buttonDanhGiaSP_Click(object sender, EventArgs e)                  //chuyển qua form đánh giá/bình luận sp
        {
            DanhGiaSach danhgia = new DanhGiaSach();
            danhgia.StartPosition = FormStartPosition.CenterScreen;
            danhgia.Show(); 
        }

        private void đĂNGXUÁTToolStripMenuItem_Click(object sender, EventArgs e)        //đăng xuất => chuyển qua form đăng nhập
        {
            this.Close();
            DangNhap gia = new DangNhap();
            gia.StartPosition = FormStartPosition.CenterScreen;
            gia.Show();
        }

        public void FillDanhMuc()                                                       //đổ danh sách DanhMuc vào combobox
        {
               comboBoxDanhMuc.Items.Clear();
               SqlConnection con = cn.KetNoi();
               SqlCommand cmd;
               cmd = con.CreateCommand();
               cmd.CommandType = CommandType.Text;
               cmd.CommandText = "SELECT TenDM FROM DANH_MUC_SACH";
               con.Open();
               cmd.ExecuteNonQuery();
               DataTable dt = new DataTable();
               SqlDataAdapter da = new SqlDataAdapter(cmd);
               da.Fill(dt);
               foreach (DataRow dr in dt.Rows)
               {
                   comboBoxDanhMuc.Items.Add(dr["TenDM"].ToString());
               }
               foreach (Control ctl in this.Controls)
               {
                   ctl.ResetBindings();
               } 
        }
       
        public void FillTheLoai()                                                 //đổ danh sách TheLoai vào combobox
        {
                  comboBoxTheLoai.Items.Clear();
                  SqlConnection con = cn.KetNoi();
                  SqlCommand cmd;
                  cmd = con.CreateCommand();
                  cmd.CommandType = CommandType.Text;
                  cmd.CommandText = "SELECT TenLoai FROM THE_LOAI";
                  con.Open();
                  cmd.ExecuteNonQuery();
                  DataTable dt = new DataTable();
                  SqlDataAdapter da = new SqlDataAdapter(cmd);
                  da.Fill(dt);
                  foreach (DataRow dr in dt.Rows)
                  {
                      comboBoxTheLoai.Items.Add(dr["TenLoai"].ToString());
                  }
                  foreach (Control ctl in this.Controls)
                  {
                      ctl.ResetBindings();
                  } 
        }
       
        private void comboBoxDanhMuc_SelectedIndexChanged(object sender, EventArgs e)           //tìm kiếm sách theo danh mục
        {
            SqlConnection con = cn.KetNoi();

            if (comboBoxTheLoai.SelectedIndex == -1)                                    //nếu ở ô TheLoai chưa được chọn                           
            {

                string item = comboBoxDanhMuc.SelectedItem.ToString();
                if(item == "Sách Bán Chạy")                                             //nếu chọn danh mục "Sách Bán Chạy"
                {
                    try
                    {
                        SqlCommand com = new SqlCommand("TKiemSach_BanChayNhat", con);
                        DataTable dt1 = new DataTable();
                        com.CommandType = CommandType.StoredProcedure;
                        SqlDataAdapter da = new SqlDataAdapter(com);
                        da.Fill(dt1);
                        dsBook.DataSource = dt1;
                        con.Close();
                    }
                    catch
                    {
                        MessageBox.Show("Chương trình bị lỗi", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        con.Close();
                    }
                }
                else if (item == "Giá trị từ thấp - cao")                                   //nếu chọn danh mục "Giá trị từ thấp - cao"
                {
                    try
                    {
                        SqlCommand com = new SqlCommand("TimKiemSach_GiaTuThapDenCao", con);
                        DataTable dt1 = new DataTable();
                        com.CommandType = CommandType.StoredProcedure;
                        SqlDataAdapter da = new SqlDataAdapter(com);
                        da.Fill(dt1);
                        dsBook.DataSource = dt1;
                        con.Close();
                    }
                    catch
                    {
                        MessageBox.Show("Chương trình bị lỗi", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        con.Close();
                    }
                }
                else if (item == "Giá trị từ cao - thấp")                                       //nếu chọn danh mục "Giá trị từ cao - thấp"
                {
                    try
                    {
                        SqlCommand com = new SqlCommand("TimKiemSach_GiaTuCaoDenThap", con);
                        DataTable dt1 = new DataTable();
                        com.CommandType = CommandType.StoredProcedure;
                        SqlDataAdapter da = new SqlDataAdapter(com);
                        da.Fill(dt1);
                        dsBook.DataSource = dt1;
                        con.Close();
                    }
                    catch
                    {
                        MessageBox.Show("Chương trình bị lỗi", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        con.Close();
                    }
                }
                else if (item == "Theo đánh giá sản phẩm cao")                                      //nếu chọn danh mục "Theo đánh giá sản phẩm cao"
                {
                    try
                    {
                        SqlCommand com = new SqlCommand("TimKiemSach_DanhGiaSPCao", con);
                        DataTable dt1 = new DataTable();
                        com.CommandType = CommandType.StoredProcedure;
                        SqlDataAdapter da = new SqlDataAdapter(com);
                        da.Fill(dt1);
                        dsBook.DataSource = dt1;
                        con.Close();
                    }
                    catch
                    {
                        MessageBox.Show("Chương trình bị lỗi", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        con.Close();
                    }
                }
                else                                                                            //trường hợp các danh mục còn lại
                {
                    DataTable dt = new DataTable();
                    try
                    {
                        SqlCommand cmd = new SqlCommand("TKiemSach_TheoDanhMuc", con);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@tendm", item);
                        SqlDataAdapter adt = new SqlDataAdapter(cmd);
                        adt.Fill(dt);
                        con.Close();
                        dsBook.DataSource = dt;

                    }
                    catch
                    {
                        MessageBox.Show("Chương trình bị lỗi", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        con.Close();
                    }
                }  
            }
            else                                                                        //tìm kiếm sách theo thể loại + danh mục
            {
                string itemTL = comboBoxTheLoai.SelectedItem.ToString();                //lấy giá trị ở combobox Thể loại
                string itemDM = comboBoxDanhMuc.SelectedItem.ToString();               // lấy giá trị ở combobox danh mục
                DataTable dt = new DataTable();
                try
                {
                    SqlCommand cmd = new SqlCommand("TKiemSach_TheoTheLoai_DanhMuc", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@tentheloai", itemTL);
                    cmd.Parameters.AddWithValue("@tendm", itemDM);
                    SqlDataAdapter adt = new SqlDataAdapter(cmd);
                    adt.Fill(dt);
                    con.Close();
                    dsBook.DataSource = dt;
                }
                catch
                {
                    MessageBox.Show("Chương trình bị lỗi", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    con.Close();
                }
            }

        }

        private void comboBoxTheLoai_SelectedIndexChanged(object sender, EventArgs e)           //tìm kiếm sách theo thể loại
        {
            SqlConnection con = cn.KetNoi();
            if (comboBoxDanhMuc.SelectedIndex == -1)                                    //nếu ở ô DanhMuc chưa được chọn                           
            {
                string item1 = comboBoxTheLoai.SelectedItem.ToString();
                DataTable dt1 = new DataTable();
                try
                {
                    SqlCommand cmd = new SqlCommand("TKiemSach_TheoTheLoai", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@tentheloai", item1);
                    SqlDataAdapter adt = new SqlDataAdapter(cmd);
                    adt.Fill(dt1);
                    con.Close();
                    dsBook.DataSource = dt1;
                }
                catch
                {
                    MessageBox.Show("Chương trình bị lỗi", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    con.Close();
                }
            }
            else                                                                        //tìm kiếm sách theo thể loại + danh mục
            {
                string itemTL = comboBoxTheLoai.SelectedItem.ToString();                //lấy giá trị ở combobox Thể loại
                string itemDM = comboBoxDanhMuc.SelectedItem.ToString();               // lấy giá trị ở combobox danh mục
                DataTable dt = new DataTable();
                try
                {
                    SqlCommand cmd = new SqlCommand("TKiemSach_TheoTheLoai_DanhMuc", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@tentheloai", itemTL);
                    cmd.Parameters.AddWithValue("@tendm", itemDM);
                    SqlDataAdapter adt = new SqlDataAdapter(cmd);
                    adt.Fill(dt);
                    con.Close();
                    dsBook.DataSource = dt;
                }
                catch
                {
                    MessageBox.Show("Chương trình bị lỗi", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    con.Close();
                }
            }   
        }

        private void buttonReset_Click(object sender, EventArgs e)              //reset lại tất cả dữ liệu vừa được cập nhật, thêm, xóa ở trang chủ
        {
            SqlConnection con = cn.KetNoi();
            con.Open();
            FillTheLoai();
            FillDanhMuc();
            HienThiSach();
            textBoxTenSach.Text = String.Empty;
            textBoxTenTG.Text = String.Empty;

            MessageBox.Show("Reset dữ liệu thành công!");
            con.Close();
        }

        private void buttonSearchByTenSach_Click(object sender, EventArgs e)                        //tìm kiếm sách theo tên sách
        {
            SqlConnection con = cn.KetNoi();
            con.Open();
            try
            {
                SqlCommand com = new SqlCommand("TKiemSach_TheoTenSach", con);
                DataTable dt = new DataTable();
                com.CommandType = CommandType.StoredProcedure;

                com.Parameters.Add(new SqlParameter("@tensach", SqlDbType.NVarChar)).Value = textBoxTenSach.Text;
                SqlDataAdapter da = new SqlDataAdapter(com);
                da.Fill(dt);
                dsBook.DataSource = dt;
                con.Close();
            }
            catch
            {
                MessageBox.Show("Chương trình bị lỗi", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                con.Close();
            }
        }

        private void buttonSearchByTenTG_Click(object sender, EventArgs e)                                  //tìm kiếm sách theo tên tác giả
        {
            SqlConnection con = cn.KetNoi();
            con.Open();
            try
            {
                SqlCommand com = new SqlCommand("TKiemSach_TheoTenTacGia", con);
                DataTable dt = new DataTable();
                com.CommandType = CommandType.StoredProcedure;

                com.Parameters.Add(new SqlParameter("@tentacgia", SqlDbType.NVarChar)).Value = textBoxTenTG.Text;
                SqlDataAdapter da = new SqlDataAdapter(com);
                da.Fill(dt);
                dsBook.DataSource = dt;
                con.Close();
            }
            catch
            {
                MessageBox.Show("Chương trình bị lỗi", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                con.Close();
            }
        }

        private void tÀIKHOẢNToolStripMenuItem_Click(object sender, EventArgs e)            //chuyển qua form xem thông tin tài khoản
        {
            if(DangNhap.Loaitk == true)                                         //nếu là khách hàng
            {
                TaiKhoanKH kh = new TaiKhoanKH();
                kh.StartPosition = FormStartPosition.CenterScreen;
                kh.Show();
            }
            else                                                                  //nếu là nhân viên
            {
                TaiKhoanNV nv = new TaiKhoanNV();
                nv.StartPosition = FormStartPosition.CenterScreen;
                nv.Show();
            }      
        }

        private void gIỎHÀNGToolStripMenuItem_Click(object sender, EventArgs e)                     //chuyển qua form xem Giỏ hàng
        {
                GioHang_KH kh = new GioHang_KH();
                kh.StartPosition = FormStartPosition.CenterScreen;
                kh.Show();
        }

        private void danhSáchSảnPhẩmHiệnCóToolStripMenuItem_Click(object sender, EventArgs e)       //chuyển qua form Báo cáo sản phẩm
        {
            if (DangNhap.Loaitk == false)
            {
                FormBaoCaoDS_SPHienCo bc = new FormBaoCaoDS_SPHienCo();
                bc.StartPosition = FormStartPosition.CenterScreen;
                bc.Show();
            }
            else
            {
                tHỐNGKÊBÁOCÁOToolStripMenuItem.Enabled = false;                                     //nếu là khách hàng thì không sử dụng được chức năng này
                MessageBox.Show("Chức năng này chỉ dành cho nhân viên!\nBạn không được quyền truy cập vào!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void danhSáchĐơnHàngGiaoDịchThànhCôngTheoNgàyToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (DangNhap.Loaitk == false)
            {
                FormBaoCaoDS_DHThanhCongTheoNgay bc = new FormBaoCaoDS_DHThanhCongTheoNgay();
                bc.StartPosition = FormStartPosition.CenterScreen;
                bc.Show();
            }
            else
            {
                tHỐNGKÊBÁOCÁOToolStripMenuItem.Enabled = false;                                     //nếu là khách hàng thì không sử dụng được chức năng này
                MessageBox.Show("Chức năng này chỉ dành cho nhân viên!\nBạn không được quyền truy cập vào!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void buttonKVNV_Click_1(object sender, EventArgs e)     //button chuyển qua form ChucNangThem_DanhChoNV
        {
                ChucNangThem_DanhChoNV chucnangNV = new ChucNangThem_DanhChoNV();
                chucnangNV.StartPosition = FormStartPosition.CenterScreen;
                chucnangNV.Show();
        }

        private void dsBook_CellMouseClick(object sender, DataGridViewCellMouseEventArgs e)     //khi nhấp chuột vào một trong những ô của dòng thông tin sách
        {
            //get book ID from current click cell
            string bookID = "";
            if (e.RowIndex >= 0)
            {
                DataGridViewRow row = this.dsBook.Rows[e.RowIndex];
                if (row.Cells["MaSach"].Value.ToString() == "")
                    return;
                bookID = row.Cells["MaSach"].Value.ToString();
            }

            XemThongTinSach_KH info = new XemThongTinSach_KH();     //chuyển qua form để Xem thông tin sách
            info.getBookID = bookID;
            info.StartPosition = FormStartPosition.CenterScreen;
            info.Show();
        }

      
    }
}
