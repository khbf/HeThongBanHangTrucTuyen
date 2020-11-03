using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QLNhaSach
{
    public partial class frmMain : Form
    {
        public frmMain()
        {
            InitializeComponent();
        }

        private void button2_Click(object sender, EventArgs e)      //chuyển qua form Đăng nhập
        {
            DangNhap dangnhap = new DangNhap();
            dangnhap.StartPosition = FormStartPosition.CenterScreen;
            dangnhap.Show();
        }

        private void button1_Click(object sender, EventArgs e)      //chuyển qua form Đăng ký tài khoản
        {
            DangKyTaiKhoan dangky = new DangKyTaiKhoan();
            dangky.StartPosition = FormStartPosition.CenterScreen;
            dangky.Show();
        }
    }
}
