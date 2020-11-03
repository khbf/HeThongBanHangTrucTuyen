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
    public partial class TaiKhoanNV : Form
    {
        public TaiKhoanNV()
        {
            InitializeComponent();
        }

        Connect cn = new Connect();

        private void TaiKhoanNV_Load(object sender, EventArgs e)             
        {
            HienThongTin();
        }

        public void HienThongTin()                                      //xuất dữ liệu thông tin nhân viên vào từng textbox,...
        {
            string query = "SELECT NV.MaNV, NV.TenNV, TK.Email, TK.MatKhau, NV.SDT_NV" +
                       " FROM NHAN_VIEN NV join TAI_KHOAN TK on NV.TaiKhoan_NV = TK.MaTaiKhoan where TK.Email = " + "'" + DangNhap.Email_DN + "'";
            SqlConnection con = cn.KetNoi();
            con.Open();
            SqlCommand cmd = new SqlCommand(query, con);
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                //read data from select query to text box
                MaNV.Text = (dr["MaNV"].ToString());
                ten.Text = (dr["TenNV"].ToString());
                email.Text = (dr["Email"].ToString());
                pass.Text = (dr["MatKhau"].ToString());
                SDT.Text = (dr["SDT_NV"].ToString());
            }
        }
        private void buttonThoat_Click(object sender, EventArgs e)                   //thoát form xem thông tin cá nhân
        {
            this.Close();
        }

        private void buttonChinhSua_Click(object sender, EventArgs e)               //nhân viên sửa thông tin cá nhân
        {
            email.Enabled = false;
            MaNV.Enabled = false;

            SqlConnection con = cn.KetNoi();
            string procName = "NhanVien_SuaThongTinCaNhan";                     //goi store NhanVien_SuaThongTinCaNhan trong sql server
            SqlCommand cmd = new SqlCommand(procName, con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            //truyen tham so vao stored proc
            cmd.Parameters.AddWithValue("@email", DangNhap.Email_DN);                          //du lieu nhap tu text box
            cmd.Parameters.AddWithValue("@ten", ten.Text);                                   //du lieu nhap tu text box
            cmd.Parameters.AddWithValue("@pass", pass.Text);
            cmd.Parameters.AddWithValue("@sdtNV",SDT.Text);
            cmd.Parameters.AddWithValue("@loaitk", DangNhap.Loaitk);

            //get value form out put parameter in stored proc
            SqlParameter outputParameter = new SqlParameter();
            outputParameter.ParameterName = "@frag";
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
