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
    public partial class DangNhap : Form
    {
        public DangNhap()
        {
            InitializeComponent();
        }

        public static string Email_DN;
        public static string Pass_DN;
        public static Boolean Loaitk;
        public static int MaKH;

        Connect cn = new Connect();

        private void button2_Click(object sender, EventArgs e)          //thoát form ĐĂng nhập
        {
            this.Close();
        }

        //Đăng nhập vào hệ thống

        private void button1_Click(object sender, EventArgs e)
        {
               SqlConnection con = cn.KetNoi();

                string procName = "DangNhap";                                     //goi store DangNhap trong sql server
                SqlCommand cmd = new SqlCommand(procName, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                //truyen tham so vao stored proc
                cmd.Parameters.AddWithValue("@email", email.Text);                   //du lieu nhap tu text box
                cmd.Parameters.AddWithValue("@pass", pass.Text);                     //du lieu nhap tu text box
             

               if (checkBoxKH.Checked == true)                                       //dữ liệu nhập từ checkbox
                    cmd.Parameters.AddWithValue("@loaitk", 1);
                else
                    cmd.Parameters.AddWithValue("@loaitk", 0);

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

                //kiểm tra đăng nhập thành công
                if (frag == 1)
                {
                    MaKH = frag;
                    MessageBox.Show("Đăng nhập tài khoản thành công!");

                //Nếu email, pass và loại tk đúng thì mở form TrangChu
                    Email_DN = email.Text;
                    Pass_DN = pass.Text;
                    if (checkBoxKH.Checked == true)                              
                        Loaitk = true;
                    else
                        Loaitk = false;

                //chuyen qua form TrangChu 
                    this.Hide();
                    TrangChu f = new TrangChu();
                    f.Show();
                }
                else
                {
                    MessageBox.Show("Email hoặc mật khẩu hoặc chọn tài khoản không đúng\nVui lòng nhập lại", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    con.Close();
                }
        }
    }
}
