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
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void register_sam(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["TicketSystem"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String name_sam_str = name_sam.Text;
            String username_sam_str = username_sam.Text;
            String password_same_str = password_sam.Text;

            SqlCommand reg_sam = new SqlCommand("addAssociationManager", conn);
            reg_sam.CommandType = CommandType.StoredProcedure;
            reg_sam.Parameters.Add(new SqlParameter("@name", name_sam_str));
            reg_sam.Parameters.Add(new SqlParameter("@username", username_sam_str));
            reg_sam.Parameters.Add(new SqlParameter("@password", password_same_str));

            conn.Open();
            reg_sam.ExecuteNonQuery();
            conn.Close();

            SqlCommand loginproc = new SqlCommand("userLogin", conn);
            loginproc.CommandType = CommandType.StoredProcedure;
            loginproc.Parameters.Add(new SqlParameter("@username", username_sam_str));
            loginproc.Parameters.Add(new SqlParameter("@password", password_same_str));

            SqlParameter success = loginproc.Parameters.Add("@success", SqlDbType.Int);
            SqlParameter type = loginproc.Parameters.Add("@type", SqlDbType.Int);

            success.Direction = ParameterDirection.Output;
            type.Direction = ParameterDirection.Output;

            conn.Open();
            loginproc.ExecuteNonQuery();
            conn.Close();

            if (success.Value.ToString() == "1")
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void register_cr(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["TicketSystem"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String name_cr_str = name_cr.Text;
            String username_cr_str = username_cr.Text;
            String password_cr_str = password_cr.Text;
            String club_str = clubname.Text;

            SqlCommand reg_cr = new SqlCommand("addRepresentative", conn);
            reg_cr.CommandType = CommandType.StoredProcedure;
            reg_cr.Parameters.Add(new SqlParameter("@name", name_cr_str));
            reg_cr.Parameters.Add(new SqlParameter("@clubname", club_str));
            reg_cr.Parameters.Add(new SqlParameter("@username", username_cr_str));
            reg_cr.Parameters.Add(new SqlParameter("@password", password_cr_str));

            conn.Open();
            reg_cr.ExecuteNonQuery();
            conn.Close();

            SqlCommand loginproc = new SqlCommand("userLogin", conn);
            loginproc.CommandType = CommandType.StoredProcedure;
            loginproc.Parameters.Add(new SqlParameter("@username", username_cr_str));
            loginproc.Parameters.Add(new SqlParameter("@password", password_cr_str));

            SqlParameter success = loginproc.Parameters.Add("@success", SqlDbType.Int);
            SqlParameter type = loginproc.Parameters.Add("@type", SqlDbType.Int);

            success.Direction = ParameterDirection.Output;
            type.Direction = ParameterDirection.Output;

            conn.Open();
            loginproc.ExecuteNonQuery();
            conn.Close();

            if (success.Value.ToString() == "1")
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void register_sm(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["TicketSystem"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String name_sm_str = name_sm.Text;
            String username_sm_str = username_sm.Text;
            String password_sm_str = password_sm.Text;
            String stadium_str = stadiumname.Text;

            SqlCommand reg_sm = new SqlCommand("addStadiumManager", conn);
            reg_sm.CommandType = CommandType.StoredProcedure;
            reg_sm.Parameters.Add(new SqlParameter("@name", name_sm_str));
            reg_sm.Parameters.Add(new SqlParameter("@stadiumName", stadium_str));
            reg_sm.Parameters.Add(new SqlParameter("@username", username_sm_str));
            reg_sm.Parameters.Add(new SqlParameter("@password", password_sm_str));

            conn.Open();
            reg_sm.ExecuteNonQuery();
            conn.Close();

            SqlCommand loginproc = new SqlCommand("userLogin", conn);
            loginproc.CommandType = CommandType.StoredProcedure;
            loginproc.Parameters.Add(new SqlParameter("@username", username_sm_str));
            loginproc.Parameters.Add(new SqlParameter("@password", password_sm_str));

            SqlParameter success = loginproc.Parameters.Add("@success", SqlDbType.Int);
            SqlParameter type = loginproc.Parameters.Add("@type", SqlDbType.Int);

            success.Direction = ParameterDirection.Output;
            type.Direction = ParameterDirection.Output;

            conn.Open();
            loginproc.ExecuteNonQuery();
            conn.Close();

            if (success.Value.ToString() == "1")
            {
                Response.Redirect("Login.aspx");
            }

        }

        protected void register_fan(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["TicketSystem"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String name_fan_str = name_sm.Text;
            String username_fan_str = username_sm.Text;
            String password_fan_str = password_sm.Text;
            String nationalid_str = nationalid.Text;
            String birthdate_str = birthdate.Text;
            String address_str = address.Text;
            //String phone_str = phonenumber.Text;
            int phone_int = Int32.Parse(phonenumber.Text);

            SqlCommand reg_fan = new SqlCommand("addFan", conn);
            reg_fan.CommandType = CommandType.StoredProcedure;
            reg_fan.Parameters.Add(new SqlParameter("@name", name_fan_str));
            reg_fan.Parameters.Add(new SqlParameter("@username", username_fan_str));
            reg_fan.Parameters.Add(new SqlParameter("@password", password_fan_str));
            reg_fan.Parameters.Add(new SqlParameter("@nationalID", nationalid_str));
            reg_fan.Parameters.Add(new SqlParameter("@birthDate", birthdate_str));
            reg_fan.Parameters.Add(new SqlParameter("@address", address_str));
            reg_fan.Parameters.Add(new SqlParameter("@phone", phone_int));

            conn.Open();
            reg_fan.ExecuteNonQuery();
            conn.Close();

            SqlCommand loginproc = new SqlCommand("userLogin", conn);
            loginproc.CommandType = CommandType.StoredProcedure;
            loginproc.Parameters.Add(new SqlParameter("@username", username_fan_str));
            loginproc.Parameters.Add(new SqlParameter("@password", password_fan_str));

            SqlParameter success = loginproc.Parameters.Add("@success", SqlDbType.Int);
            SqlParameter type = loginproc.Parameters.Add("@type", SqlDbType.Int);

            success.Direction = ParameterDirection.Output;
            type.Direction = ParameterDirection.Output;

            conn.Open();
            loginproc.ExecuteNonQuery();
            conn.Close();

            if (success.Value.ToString() == "1")
            {
                Response.Redirect("Login.aspx");
            }
        }
    }
}