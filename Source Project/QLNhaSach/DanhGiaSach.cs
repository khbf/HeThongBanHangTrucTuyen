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
    public partial class DanhGiaSach : Form
    {
        public DanhGiaSach()
        {
            InitializeComponent();
        }

        Connect cn = new Connect();

        private void DanhGiaSach_Load(object sender, EventArgs e)      
        {
            SqlConnection con = cn.KetNoi();
            con.Open();
            HienThiDGSP();
            con.Close();
        }

        public void HienThiDGSP()                                           //đổ dữ liệu DANH_GIA_SAN_PHAM vào datagridview
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
        private void buttonThemDG_Click(object sender, EventArgs e)                                         //thêm đánh giá mới
        {
            SqlConnection con = cn.KetNoi();
            buttonXoaDG.Enabled = false;
            buttonUpdateDG.Enabled = false;

            string procName = "KH_ThemDanhGiaSP";                                                         //goi store KH_ThemDanhGiaSP trong sql server
            SqlCommand cmd = new SqlCommand(procName, con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            //truyen tham so vao stored proc
            cmd.Parameters.AddWithValue("@masach", int.Parse(textBoxMaSachDG.Text.ToString()));              //du lieu nhap tu text box
            cmd.Parameters.AddWithValue("@makh", int.Parse(textBoxMaKHDG.Text.ToString()));                  //du lieu nhap tu text box
            cmd.Parameters.AddWithValue("@ngaydanhgia", DateTime.Parse(dateTimePickerNgayDG.Text));        
            cmd.Parameters.AddWithValue("@tieude", textBoxTieuDeDG.Text);                                   //du lieu nhap tu text box

            if(checkBox1.Checked == true)
                cmd.Parameters.AddWithValue("@danhgia", int.Parse(checkBox1.Text.ToString()));           //du lieu nhap tu check box
            if (checkBox2.Checked == true)
                cmd.Parameters.AddWithValue("@danhgia", int.Parse(checkBox2.Text.ToString()));          
            if (checkBox3.Checked == true)
                cmd.Parameters.AddWithValue("@danhgia", int.Parse(checkBox3.Text.ToString()));          
            if (checkBox4.Checked == true)
                cmd.Parameters.AddWithValue("@danhgia", int.Parse(checkBox4.Text.ToString()));         
            if (checkBox5.Checked == true)
                cmd.Parameters.AddWithValue("@danhgia", int.Parse(checkBox5.Text.ToString()));         

            cmd.Parameters.AddWithValue("@noidung", textBoxNoiDungDG.Text);                               //du lieu nhap tu text box

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
                HienThiDGSP();                                                          //load lại danh sách đánh giá/bình luận sp vừa được thêm
                MessageBox.Show("Thêm đánh giá/bình luận sản phẩm thành công!");
                con.Close();
            }
            else
            {
                MessageBox.Show("Thêm đánh giá/bình luận sản phẩm không thành công!\nVui lòng nhập lại", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                con.Close();
            }
        }

        private void buttonXoaDG_Click(object sender, EventArgs e)                              //xóa một đánh giá sản phẩm
        {
            textBoxTieuDeDG.Enabled = false;                                            //khi nhấn nút Xóa thì một vài textbox sẽ bị ẩn ko lấy giá trị
            checkBox1.Enabled = false;
            checkBox2.Enabled = false;
            checkBox3.Enabled = false;
            checkBox4.Enabled = false;
            checkBox5.Enabled = false;
            textBoxNoiDungDG.Enabled = false;

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
                HienThiDGSP();                                                       //load lại danh sách đánh giá sp vừa được cập nhật
                MessageBox.Show("Xóa đánh giá/bình luận sản phẩm thành công!");
                con.Close();
            }
            else
            {
                MessageBox.Show("Xóa đánh giá/bình luận sản phẩm không thành công!\nVui lòng thử lại", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                con.Close();
            }
        }

        private void buttonUpdateDG_Click(object sender, EventArgs e)                   //cập nhật đánh giá/bình luận sản phẩm
        {
            SqlConnection con = cn.KetNoi();
            buttonXoaDG.Enabled = false;
            buttonThemDG.Enabled = false;

            string procName = "KH_CapNhatDanhGiaSP";                                                     //goi store KH_CapNhatDanhGiaSP trong sql server
            SqlCommand cmd = new SqlCommand(procName, con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            //truyen tham so vao stored proc
            cmd.Parameters.AddWithValue("@masach", int.Parse(textBoxMaSachDG.Text.ToString()));          //du lieu nhap tu text box
            cmd.Parameters.AddWithValue("@makh", int.Parse(textBoxMaKHDG.Text.ToString()));              //du lieu nhap tu text box
            cmd.Parameters.AddWithValue("@ngaydanhgia", DateTime.Parse(dateTimePickerNgayDG.Text));     //du lieu nhap tu text box

            if (checkBox1.Checked == true)
                cmd.Parameters.AddWithValue("@danhgia", int.Parse(checkBox1.Text.ToString()));           //du lieu nhap tu check box
            if (checkBox2.Checked == true)
                cmd.Parameters.AddWithValue("@danhgia", int.Parse(checkBox2.Text.ToString()));
            if (checkBox3.Checked == true)
                cmd.Parameters.AddWithValue("@danhgia", int.Parse(checkBox3.Text.ToString()));
            if (checkBox4.Checked == true)
                cmd.Parameters.AddWithValue("@danhgia", int.Parse(checkBox4.Text.ToString()));
            if (checkBox5.Checked == true)
                cmd.Parameters.AddWithValue("@danhgia", int.Parse(checkBox5.Text.ToString()));

            cmd.Parameters.AddWithValue("@tieude", textBoxTieuDeDG.Text);                                   //du lieu nhap tu text box
            cmd.Parameters.AddWithValue("@noidung", textBoxNoiDungDG.Text);                               //du lieu nhap tu text box

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
                HienThiDGSP();                                                          //load lại danh sách đánh giá sp vừa được cập nhật
                MessageBox.Show("Cập nhật đánh giá/bình luận sản phẩm thành công!");
                con.Close();
            }
            else
            {
                MessageBox.Show("Cập nhật đánh giá/bình luận sản phẩm không thành công!\nVui lòng thử lại", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                con.Close();
            }
        }

        private void buttonSearchByTenSach_Click(object sender, EventArgs e)                //tìm kiếm đánh giá sản phẩm theo tên sách
        {
            SqlConnection con = cn.KetNoi();
            con.Open();
            try
            {
                SqlCommand com = new SqlCommand("TKiemDGSP_TheoTenSP", con);
                DataTable dt = new DataTable();
                com.CommandType = CommandType.StoredProcedure;

                com.Parameters.Add(new SqlParameter("@tensp", SqlDbType.NVarChar)).Value = textBoxTenSach.Text;
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

        private void buttonReset_Click(object sender, EventArgs e)       //reset lại tất cả dữ liệu vừa được cập nhật, thêm, xóa ở trang đánh giá sản phẩm
        {
            SqlConnection con = cn.KetNoi();
            con.Open();
            HienThiDGSP();
            textBoxTieuDeDG.Enabled = true;                                            //khi nhấn nút Xóa thì một vài textbox sẽ bị ẩn ko lấy giá trị
            textBoxTieuDeDG.Text = String.Empty;
            checkBox1.Enabled = true;
            checkBox1.Checked = false;
            checkBox2.Enabled = true;
            checkBox2.Checked = false;
            checkBox3.Enabled = true;
            checkBox3.Checked = false;
            checkBox4.Enabled = true;
            checkBox4.Checked = false;
            checkBox5.Enabled = true;
            checkBox5.Checked = false;
            textBoxNoiDungDG.Enabled = true;
            textBoxNoiDungDG.Text = String.Empty;
            textBoxMaSachDG.Enabled = true;
            textBoxMaSachDG.Text = String.Empty;
            textBoxMaKHDG.Enabled = true;
            textBoxMaKHDG.Text = String.Empty;
            dateTimePickerNgayDG.Enabled = true;
            dateTimePickerNgayDG.Text = String.Empty;
            textBoxTenSach.Text = String.Empty;
            buttonXoaDG.Enabled = true;
            buttonThemDG.Enabled = true;
            buttonUpdateDG.Enabled = true;

            MessageBox.Show("Reset dữ liệu thành công!");
            con.Close();
        }
    }
}
