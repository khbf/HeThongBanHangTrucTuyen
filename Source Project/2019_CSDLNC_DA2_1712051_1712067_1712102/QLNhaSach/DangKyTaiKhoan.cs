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
    public partial class DangKyTaiKhoan : Form
    {
        public DangKyTaiKhoan()
        {
            InitializeComponent();
        }

        Connect cn = new Connect();

        //Đi vào màn hình đăng nhập hệ thống
        private void buttonDangNhap_Click(object sender, EventArgs e)           
        {
            DangNhap dangnhap = new DangNhap();
            dangnhap.StartPosition = FormStartPosition.CenterScreen;
            dangnhap.Show();
        }

        //Đăng ký tài khoản
        private void buttonDangKy_Click(object sender, EventArgs e)
        {
            SqlConnection con = cn.KetNoi();

            string procName = "DangKyTaiKhoan";                                     //goi store DangKyTaiKhoan trong sql server
            SqlCommand cmd = new SqlCommand(procName, con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            //truyen tham so vao stored proc
            cmd.Parameters.AddWithValue("@ten", ten.Text);                                                  //du lieu nhap tu text box
            cmd.Parameters.AddWithValue("@ngaysinh", Convert.ToDateTime(dateTimePickerNgaySinh.Text));      //du lieu nhap tu text box

            if (checkBoxNam.Checked == true)                                                                //dữ liệu nhập từ checkbox
                cmd.Parameters.AddWithValue("@gioitinh", 1);
            if (checkBoxNu.Checked == true)
                cmd.Parameters.AddWithValue("@gioitinh", 0);

            cmd.Parameters.AddWithValue("@sdtNV", SDT.Text);         //du lieu nhap tu text box
            cmd.Parameters.AddWithValue("@email", email.Text);      //du lieu nhap tu text box
            cmd.Parameters.AddWithValue("@pass", pass.Text);        //du lieu nhap tu text box   
            if(checkBoxKH.Checked == true)
            {
                cmd.Parameters.AddWithValue("@loaitk", 1);
                SDT.Enabled = false;
            }
            if (checkBoxNV.Checked==true)
            {
                cmd.Parameters.AddWithValue("@loaitk", 0);
                dateTimePickerNgaySinh.Enabled = false;
                checkBoxNam.Enabled = false;
                checkBoxNu.Enabled = false;
            }

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

            //kiểm tra đăng ký thành công
            if (frag == 1)
            {
                MessageBox.Show("Đăng ký tài khoản thành công!");

                //chuyen qua form TrangChu 
                this.Hide();
                DangNhap f = new DangNhap();
                f.Show();
            }
            else
            {
                MessageBox.Show("Thông tin nhập vào không hợp lê!\nVui lòng nhập lại", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                con.Close();
            }
        }

        private void checkBoxKH_CheckedChanged(object sender, EventArgs e)      //khi chọn khách hàng thì textbox SDT sẽ bị ẩn ko nhận giá trị
        {
            SDT.Enabled = checkBoxKH.Checked;
        }

        private void checkBoxNV_CheckedChanged(object sender, EventArgs e)    //khi chọn nhân viên thì một vài textbox sẽ bị ẩn ko nhận giá trị
        {
            dateTimePickerNgaySinh.Enabled = checkBoxNV.Checked;
            checkBoxNam.Enabled = checkBoxNV.Checked;
            checkBoxNu.Enabled = checkBoxNV.Checked;
        }
    }
}
