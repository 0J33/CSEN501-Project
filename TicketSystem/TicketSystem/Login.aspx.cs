using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TicketSystem
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void login(object sender, EventArgs e)
        {

            string connStr = WebConfigurationManager.ConnectionStrings["TicketSystem"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String user = username.Text;
            String pass = password.Text;

            SqlCommand loginproc = new SqlCommand("userLogin", conn);
            loginproc.CommandType = CommandType.StoredProcedure;
            loginproc.Parameters.Add(new SqlParameter("@username", user));
            loginproc.Parameters.Add(new SqlParameter("@password", pass));

            SqlParameter success = loginproc.Parameters.Add("@success", SqlDbType.Int);
            SqlParameter type = loginproc.Parameters.Add("@type", SqlDbType.Int);

            success.Direction = ParameterDirection.Output;
            type.Direction = ParameterDirection.Output;

            conn.Open();
            loginproc.ExecuteNonQuery();
            conn.Close();

            if (success.Value.ToString() == "1")
            {
                if(type.Value.ToString() == "1")
                {
                    Response.Redirect("Admin.aspx");
                }
                if (type.Value.ToString() == "2")
                {
                    Response.Redirect("SAM.aspx");
                }
                if (type.Value.ToString() == "3")
                {
                    Response.Redirect("ClubRep.aspx");
                }
                if (type.Value.ToString() == "4")
                {
                    Response.Redirect("StadMan.aspx");
                }
                if (type.Value.ToString() == "5")
                {
                    Response.Redirect("Fan.aspx");
                }
            }

        }

        protected void register(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        }

    }
}