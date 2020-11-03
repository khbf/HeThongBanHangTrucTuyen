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
    public partial class XemThongTinSach_KH : Form
    {
        public XemThongTinSach_KH()
        {
            InitializeComponent();
        }

        Connect cn = new Connect();

        public string getBookID { get; set; }

        private void buttonThemVaoGH_Click(object sender, EventArgs e)              //thêm sách vào giỏ hàng    --BỊ LỖI CHƯA CHẠY ĐƯỢC!!!
        {
            SqlConnection con = cn.KetNoi();
            SqlCommand cmd = new SqlCommand("KHThemSachVaoGioHang", con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@masach", getBookID.ToString());
            cmd.Parameters.AddWithValue("@maKH", DangNhap.MaKH);

            SqlParameter outputParameter = new SqlParameter();
            outputParameter.ParameterName = "@frag";
            outputParameter.SqlDbType = System.Data.SqlDbType.Int;
            outputParameter.Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add(outputParameter);

            con.Open();
            cmd.ExecuteNonQuery();
            int f = 0;
            f = int.Parse(outputParameter.Value.ToString());
            if (f == 1)
            {
                MessageBox.Show("Sách đã được thêm vào trong giỏ hàng\n", "Thông báo");
                this.Close();
            }
            else
                MessageBox.Show("Sách tạm hết hàng", "Thông báo");
        }

        private void XemThongTinSach_KH_Load(object sender, EventArgs e)
        {
            SqlConnection con = cn.KetNoi();
            SqlCommand cmd = new SqlCommand("KHXemThongTinSach", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@maSach", int.Parse(getBookID));
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                textBoxTenSach.Text = (dr["TenSach"].ToString());
                textBoxTG.Text = (dr["TenTacGia"].ToString());
                textBoxNDich.Text = (dr["NguoiDich"].ToString());

                textBoxDM.Text = (dr["TenDM"].ToString());
                textBoxTL.Text = (dr["TenLoai"].ToString());
                textBoxNXB.Text = (dr["NXB"].ToString());
                textBoxNPH.Text = (dr["NhaPhatHanh"].ToString());
                dateTimePickerNgayPH.Text = (dr["NgayPhatHanh"].ToString());
                textBoxKL.Text = (dr["KhoiLuong"].ToString());
                textBoxST.Text = (dr["SoTrang"].ToString());
                textBoxGTien.Text = (dr["GiaTien"].ToString());
                textBoxMTS.Text = (dr["MoTaSach"].ToString());
           
                textBoxSLT.Text = (dr["SoLuongTon"].ToString());

          /*      if (int.Parse(bookNumbers_textBox5.Text.ToString()) == 0)
                    bookStatus_textBox4.Text = "Hết hàng";
                else if (int.Parse(bookNumbers_textBox5.Text.ToString()) < 20)
                    bookStatus_textBox4.Text = "Sắp hết hàng";
                else
                    bookStatus_textBox4.Text = "Còn hàng"; */

                //if book is out of stock then disable add to cart button
                if (int.Parse(textBoxSLT.Text) == 0)
                    buttonThemVaoGH.Enabled = false;

            }
            con.Close();
        }

        private void button1_Click(object sender, EventArgs e)      //thoát khỏi form xem thông tin sách
        {
            this.Close();
        }
    }
}
