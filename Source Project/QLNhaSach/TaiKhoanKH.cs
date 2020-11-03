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
    public partial class TaiKhoanKH : Form
    {
        public TaiKhoanKH()
        {
            InitializeComponent();
        }

        Connect cn = new Connect();

        private void TaiKhoanKH_Load(object sender, EventArgs e)            
        {
            HienThongTin();
        }
        public void HienThongTin()                              //xuất dữ liệu thông tin khách hàng vào từng textbox,...
        {
            string query = "SELECT KH.MaKH, KH.TenKH, TK.Email, TK.MatKhau, KH.GioiTinh, KH.NgaySinh " +
                         " FROM KHACH_HANG KH join TAI_KHOAN TK on KH.TaiKhoan_KH = TK.MaTaiKhoan where TK.Email = " + "'" + DangNhap.Email_DN + "'";
            SqlConnection con = cn.KetNoi();
            con.Open();
            SqlCommand cmd = new SqlCommand(query, con);
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                //read data from select query to text box
                MaKH.Text = (dr["MaKH"].ToString());
                ten.Text = (dr["TenKH"].ToString());
                email.Text = (dr["Email"].ToString());
                pass.Text = (dr["MatKhau"].ToString());

                bool sex = (bool.Parse(dr["GioiTinh"].ToString()));
                if (sex == true)
                    checkBoxNam.Checked = true;
                else
                    checkBoxNu.Checked = true;

                dateTimePickerNgaySinh.Text = (dr["NgaySinh"].ToString());    
            }      
        }
        private void buttonThoat_Click(object sender, EventArgs e)                  //thoát form xem thông tin cá nhân
        {
            this.Close();
        }

        private void buttonChinhSua_Click(object sender, EventArgs e)                   //chỉnh sửa thông tin khách hàng
        {
            email.Enabled = false;
            MaKH.Enabled = false;

            SqlConnection con = cn.KetNoi();
            string procName = "KhachHang_SuaThongTinCaNhan";                     //goi store KhachHang_SuaThongTinCaNhan trong sql server
            SqlCommand cmd = new SqlCommand(procName, con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            //truyen tham so vao stored proc
            cmd.Parameters.AddWithValue("@email", DangNhap.Email_DN);                          //du lieu nhap tu text box
            cmd.Parameters.AddWithValue("@ten", ten.Text);                                   //du lieu nhap tu text box
            cmd.Parameters.AddWithValue("@pass", pass.Text);
            if(checkBoxNam.Checked == true)
            {
                cmd.Parameters.AddWithValue("@gioitinh", 1);
                checkBoxNu.Enabled = false; ;
            }
            if (checkBoxNu.Checked == true)
            {
                cmd.Parameters.AddWithValue("@gioitinh", 0);
                checkBoxNam.Enabled = false;
            }
            cmd.Parameters.AddWithValue("@ngaysinh",DateTime.Parse(dateTimePickerNgaySinh.Text.ToString()));
            cmd.Parameters.AddWithValue("@loaitk", DangNhap.Loaitk);

            //get value form out put parameter in stored proc
            SqlParameter outputParameter = new SqlParameter();
            outputParameter.ParameterName = "@kq";
            outputParameter.SqlDbType = System.Data.SqlDbType.Int;
            outputParameter.Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add(outputParameter);
            //doan code tren de nhan gia tri tra ve tu sp

            con.Open();
            cmd.ExecuteNonQuery();
            SqlDataReader dr = cmd.ExecuteReader();
            int frag = int.Parse(outputParameter.Value.ToString());

            //kiểm tra sửa thành công
            if (frag == 1)
            {
                HienThongTin();
                MessageBox.Show("Chỉnh sửa thông tin thành công!");
                con.Close();
            }
            else
            {
                MessageBox.Show("Chỉnh sửa thông tin không thành công!\nVui lòng thử lại", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                con.Close();
            }
        }
    }
}
