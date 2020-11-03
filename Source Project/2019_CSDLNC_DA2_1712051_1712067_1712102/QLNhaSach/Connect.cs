using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

namespace QLNhaSach
{
    class Connect
    {
        //Tạo kết nối với cơ sở dữ liệu
      //  public static SqlConnection con;
        public static string conString = @"Data Source=Meo-PC;Initial Catalog = QLNhaSach; Integrated Security = True";
        public SqlConnection KetNoi()
        {
            return new SqlConnection(conString);
        }
    }
}
