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
    public partial class FormBaoCaoDS_SPHienCo : Form
    {
        public FormBaoCaoDS_SPHienCo()
        {
            InitializeComponent();
        }

        Connect cn = new Connect();

        private void FormBaoCaoThongKe_Load(object sender, EventArgs e)
        {

            this.reportViewerBC.RefreshReport();
        }

        private void buttonBC_DSSPHienCo_Click(object sender, EventArgs e)          //in báo cáo danh sách sách hiện có
        {
            string sql = "Select * from SACH";
            SqlConnection con = cn.KetNoi();
            SqlDataAdapter adp = new SqlDataAdapter(sql, con);
            DataSet ds = new DataSet();
            adp.Fill(ds);

            //Khai báo chế độ xử lý báo cáo, trong trường hợp này lấy báo cáo ở local
            reportViewerBC.ProcessingMode = Microsoft.Reporting.WinForms.ProcessingMode.Local;

            //Đường dẫn báo cáo
            reportViewerBC.LocalReport.ReportPath = "ReportDS_SachHienCo.rdlc";

            //Nếu có dữ liệu
            if (ds.Tables[0].Rows.Count > 0)
            {
                //Tạo nguồn dữ liệu cho báo cáo
                ReportDataSource rds = new ReportDataSource();
                rds.Name = "SACH";
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
