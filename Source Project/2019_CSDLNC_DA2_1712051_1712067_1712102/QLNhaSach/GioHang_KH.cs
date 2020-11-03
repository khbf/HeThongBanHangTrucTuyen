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
    public partial class GioHang_KH : Form
    {
        public GioHang_KH()
        {
            InitializeComponent();
        }
        Connect cn = new Connect();
        public static string bookID = "";
        public static int bookNO = 0;

        public void HienChiTietGioHang()
        {
            SqlConnection con = cn.KetNoi();

            string query = "SELECT CT.MaSach_CTDH, S.TenSach, CT.SoLuong, CT.DonGia " +
                            " FROM (SACH S join CHI_TIET_DON_HANG CT on S.MaSach = CT.MaSach_CTDH) join DON_HANG D " +
                            " on CT.SoDH = D.SoDonHang join KHACH_HANG KH on KH.MaKH = D.MaKH_DatHang join TAI_KHOAN TK on" +
                            " TK.MaTaiKhoan = KH.TaiKhoan_KH where TK.Email = " + "'" + DangNhap.Email_DN + "'";

            DataTable dt = new DataTable();

            SqlDataAdapter adapter = new SqlDataAdapter(query, con);
            con.Open();
            adapter.Fill(dt);
            dsCTDH.DataSource = dt;
            if (dsCTDH.RowCount > 0 && dsCTDH.ColumnCount > 0)
            {
                dsCTDH.CurrentCell = this.dsCTDH[0, 0];
                this.dsCTDH.CurrentCell.Selected = false;
            }
            infoSummary_Load();
            con.Close();
        }
        public void infoSummary_Load()
        {
            SqlConnection con = cn.KetNoi();

            SqlCommand cmd = new SqlCommand("tomTatThongTinDH", con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@email", DangNhap.Email_DN);

            SqlParameter outputParameter1 = new SqlParameter();
            outputParameter1.ParameterName = "@tongSoLuongSach";
            outputParameter1.SqlDbType = System.Data.SqlDbType.Int;
            outputParameter1.Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add(outputParameter1);

            SqlParameter outputParameter2 = new SqlParameter();
            outputParameter2.ParameterName = "@tongCong";
            outputParameter2.SqlDbType = System.Data.SqlDbType.Int;
            outputParameter2.Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add(outputParameter2);

            con.Open();
            cmd.ExecuteNonQuery();

            textBoxSLSP.Text = outputParameter1.Value.ToString();
            if (int.Parse(outputParameter2.Value.ToString()) >= 0)
            {
                if (int.Parse(outputParameter2.Value.ToString()) >= 250000)
                    textBoxPhi.Text = "Miễn phí";
                else
                    textBoxPhi.Text = "30000";
                textBoxTTien.Text = outputParameter2.Value.ToString();

            }
            else
            {
                textBoxPhi.Text = "0";
                textBoxTTien.Text = "0";
                textBoxSLSP.Text = "0";

            }
        }
        private void GioHang_KH_Load(object sender, EventArgs e)
        {
            HienChiTietGioHang();
        }
        public bool addBook(bool type_bt)                                               //CHƯA CHẠY ĐƯỢC!!
        {
            if (bookID != "")
            {
                SqlConnection con = cn.KetNoi();

                SqlCommand cmd = new SqlCommand("KHThemSachVaoGioHang", con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@masach", int.Parse(bookID));
                cmd.Parameters.AddWithValue("@maKH", DangNhap.MaKH);

                SqlParameter outputParameter = new SqlParameter();
                outputParameter.ParameterName = "@frag";
                outputParameter.SqlDbType = System.Data.SqlDbType.Int;
                outputParameter.Direction = System.Data.ParameterDirection.Output;
                cmd.Parameters.Add(outputParameter);

                con.Open();
                cmd.ExecuteNonQuery();

                int f = int.Parse(outputParameter.Value.ToString());
                if (f == 1)
                    return true;
                else
                    return false;
            }
            else
            {
                MessageBox.Show("Vui lòng chọn sách", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return false;
            }

        }
        public bool subBook(bool type_bt)                                               //CHƯA CHẠY ĐƯỢC!!
        {
            if (bookID != "")
            {
                SqlConnection con = cn.KetNoi();

                SqlCommand cmd = new SqlCommand("XoaSachTrongGio", con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@maKH", DangNhap.MaKH);
                cmd.Parameters.AddWithValue("@maSach", int.Parse(bookID));
                cmd.Parameters.AddWithValue("@kieuXoa", 1);


                SqlParameter outputParameter = new SqlParameter();
                outputParameter.ParameterName = "@frag";
                outputParameter.SqlDbType = System.Data.SqlDbType.Int;
                outputParameter.Direction = System.Data.ParameterDirection.Output;
                cmd.Parameters.Add(outputParameter);

                con.Open();
                cmd.ExecuteNonQuery();

                int f = int.Parse(outputParameter.Value.ToString());
                if (f == 1)
                    return true;
                else
                    return false;
            }
            else
            {
                MessageBox.Show("Vui lòng chọn sách", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return false;
            }

        }
        private void buttonAdd_Click(object sender, EventArgs e)                        //CHƯA CHẠY ĐƯỢC!!
        {
            if (addBook(true) == true)
            {
                HienChiTietGioHang();
                infoSummary_Load();
            }
            else
                MessageBox.Show("Không thêm được sách", "Thông báo", MessageBoxButtons.OK);
        }

        private void buttonSub_Click(object sender, EventArgs e)                            //CHƯA CHẠY ĐƯỢC!!
        {
            if (subBook(false) == true)
            {
                HienChiTietGioHang();
                infoSummary_Load();
            }
            else
                MessageBox.Show("Số lượng sách trong giỏ hàng đã đén mức tối thiểu", "Thông báo");
        }

        private void buttonXoaSP_Click(object sender, EventArgs e)          //xóa sách ra khỏi giỏ hàng                         //CHƯA CHẠY ĐƯỢC!!
        {
            SqlConnection con = cn.KetNoi();

            SqlCommand cmd = new SqlCommand("XoaSachTrongGio", con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@maKH", DangNhap.MaKH);
            cmd.Parameters.AddWithValue("@maSach", int.Parse(bookID));
            cmd.Parameters.AddWithValue("@kieuXoa", 0);


            SqlParameter outputParameter = new SqlParameter();
            outputParameter.ParameterName = "@frag";
            outputParameter.SqlDbType = System.Data.SqlDbType.Int;
            outputParameter.Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add(outputParameter);

            con.Open();
            cmd.ExecuteNonQuery();

            int f = int.Parse(outputParameter.Value.ToString());
            if (f == 1)
            {
                MessageBox.Show("Xóa sách thành công", "Thông báo");
            }
            else
                MessageBox.Show("Không xóa được sách hoặc chưa chọn sách", "Thông báo");
            HienChiTietGioHang();

            buttonAdd.Enabled = false;
            buttonSub.Enabled = false;
            buttonXoaSP.Enabled = false;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
