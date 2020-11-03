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
using Microsoft.Reporting.WinForms;

namespace QLNhaSach
{
    public partial class FormBaoCaoDS_DHThanhCongTheoNgay : Form
    {
        public FormBaoCaoDS_DHThanhCongTheoNgay()
        {
            InitializeComponent();
        }
        Connect cn = new Connect();

        private void buttonTaoBC_Click(object sender, EventArgs e)      //xuất báo cáo thống kê đơn hàng thành công theo ngày
        {
            SqlConnection con = cn.KetNoi();

            SqlCommand com = new SqlCommand("Report_DanhSachDHThanhCongTheoNgay", con);            //gọi stored Report_DanhSachDHThanhCongTheoNgay
            com.CommandType = CommandType.StoredProcedure;

            com.Parameters.Add(new SqlParameter("@ngay", dateTimePicker_NDH.Value.Date));
            DataSet ds = new DataSet();
            SqlDataAdapter da = new SqlDataAdapter(com);
            da.Fill(ds);

            //thiết lập báo cáo
            reportViewerBC.ProcessingMode = ProcessingMode.Local;

            //Đường dẫn báo cáo
            reportViewerBC.LocalReport.ReportPath = "ReportDS_DonHangThanhCongTheoNgay.rdlc";

            //Nếu có dữ liệu
            if (ds.Tables[0].Rows.Count > 0)
            {
                //Tạo nguồn dữ liệu cho báo cáo
                ReportDataSource rds = new ReportDataSource();
                rds.Name = "DON_HANG";
                rds.Value = ds.Tables[0];

                //Xóa dữ liệu của báo cáo cũ trong trường hợp người dùng thực hiện câu truy vấn khác
                reportViewerBC.LocalReport.DataSources.Clear();

                //Add dữ liệu vào báo cáo
                reportViewerBC.LocalReport.DataSources.Add(rds);

                //Refresh lại báo cáo
                reportViewerBC.RefreshReport();
            }

        }
    }
}
