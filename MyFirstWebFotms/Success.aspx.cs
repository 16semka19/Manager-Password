using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Web; // Для HttpUtility

namespace MyFirstWebFotms
{
    public partial class Success : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["user_id"] == null)
                {
                    Response.Redirect("Autorization.aspx");
                    return;
                }

                BindSites();
            }

            // Встановлюємо атрибут type="password" для полів паролів
            txtSitePasswordEdit.Attributes.Add("type", "password");
            txtSitePassword.Attributes.Add("type", "password");
        }



        private void BindSites()
        {
            int currentUserId = (int)Session["user_id"];
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MySqlConnection"].ConnectionString;

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();

                string selectQuery = "SELECT id, site_name, site_login, site_password FROM sites WHERE user_id = @UserId";
                MySqlCommand cmd = new MySqlCommand(selectQuery, conn);
                cmd.Parameters.AddWithValue("@UserId", currentUserId);

                MySqlDataAdapter adapter = new MySqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);

                lvSites.DataSource = dt;
                lvSites.DataBind();
            }
        }

        protected void lvSites_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            int siteId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "EditItem")
            {
                LoadSiteDetails(siteId);
                ScriptManager.RegisterStartupScript(this, GetType(), "OpenEditModal", "openDetailsModal();", true);
            }
            else if (e.CommandName == "DeleteItem")
            {
                DeleteSite(siteId);

                // Перенаправляємо користувача на ту ж сторінку, щоб оновити дані
                Response.Redirect(Request.RawUrl);
            }
        }



        protected void LoadSiteDetails(int siteId)
        {
            int currentUserId = (int)Session["user_id"];
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MySqlConnection"].ConnectionString;

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();

                string selectQuery = "SELECT site_name, site_login, site_password FROM sites WHERE id = @SiteId AND user_id = @UserId";
                MySqlCommand cmd = new MySqlCommand(selectQuery, conn);
                cmd.Parameters.AddWithValue("@SiteId", siteId);
                cmd.Parameters.AddWithValue("@UserId", currentUserId);

                using (MySqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        hfSiteId.Value = siteId.ToString();
                        txtSiteNameEdit.Text = reader["site_name"].ToString();
                        txtSiteLoginEdit.Text = reader["site_login"].ToString();
                        txtSitePasswordEdit.Text = reader["site_password"].ToString();
                    }
                    else
                    {
                        lblSiteOptionsMessage.Text = "Сайт не знайдено або у вас немає доступу.";
                    }
                }
            }
        }


        protected void btnSaveChanges_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(hfSiteId.Value))
            {
                lblSiteOptionsMessage.Text = "Не вдалося отримати ідентифікатор сайту.";
                return;
            }

            int siteId = int.Parse(hfSiteId.Value);
            int currentUserId = (int)Session["user_id"];

            string siteName = txtSiteNameEdit.Text.Trim();
            string siteLogin = txtSiteLoginEdit.Text.Trim();
            string sitePassword = txtSitePasswordEdit.Text.Trim();

            if (string.IsNullOrEmpty(siteName) || string.IsNullOrEmpty(siteLogin) || string.IsNullOrEmpty(sitePassword))
            {
                lblSiteOptionsMessage.Text = "Будь ласка, заповніть всі поля!";
                return;
            }

            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MySqlConnection"].ConnectionString;

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();

                string updateQuery = "UPDATE sites SET site_name = @SiteName, site_login = @SiteLogin, site_password = @SitePassword WHERE id = @SiteId AND user_id = @UserId";
                MySqlCommand cmd = new MySqlCommand(updateQuery, conn);
                cmd.Parameters.AddWithValue("@SiteName", siteName);
                cmd.Parameters.AddWithValue("@SiteLogin", siteLogin);
                cmd.Parameters.AddWithValue("@SitePassword", sitePassword);
                cmd.Parameters.AddWithValue("@SiteId", siteId);
                cmd.Parameters.AddWithValue("@UserId", currentUserId);

                cmd.ExecuteNonQuery();
            }

            // Закриваємо модальне вікно та оновлюємо список
            ScriptManager.RegisterStartupScript(this, GetType(), "CloseEditModal", "closeDetailsModal();", true);
            BindSites();
        }

        protected void btnDeleteSite_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(hfSiteId.Value))
            {
                lblSiteOptionsMessage.Text = "Не вдалося отримати ідентифікатор сайту.";
                return;
            }

            int siteId = int.Parse(hfSiteId.Value);

            DeleteSite(siteId);

            // Закриваємо модальне вікно та оновлюємо список
            ScriptManager.RegisterStartupScript(this, GetType(), "CloseEditModal", "closeDetailsModal();", true);
            BindSites();
        }

        private void DeleteSite(int siteId)
        {
            int currentUserId = (int)Session["user_id"];
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MySqlConnection"].ConnectionString;

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();

                string deleteQuery = "DELETE FROM sites WHERE id = @SiteId AND user_id = @UserId";
                MySqlCommand cmd = new MySqlCommand(deleteQuery, conn);
                cmd.Parameters.AddWithValue("@SiteId", siteId);
                cmd.Parameters.AddWithValue("@UserId", currentUserId);

                cmd.ExecuteNonQuery();
            }
        }

        protected void btnSubmitSite_Click(object sender, EventArgs e)
        {
            if (Session["user_id"] == null)
            {
                lblSiteMessage.Text = "Ви не авторизовані. Будь ласка, увійдіть в систему.";
                return;
            }

            int currentUserId = (int)Session["user_id"];
            string siteName = txtSiteName.Text.Trim();
            string siteLogin = txtSiteLogin.Text.Trim();
            string sitePassword = txtSitePassword.Text.Trim();

            if (string.IsNullOrEmpty(siteName) || string.IsNullOrEmpty(siteLogin) || string.IsNullOrEmpty(sitePassword))
            {
                lblSiteMessage.Text = "Будь ласка, заповніть всі поля!";
                return;
            }

            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MySqlConnection"].ConnectionString;

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();

                string insertQuery = "INSERT INTO sites (user_id, site_name, site_login, site_password) VALUES (@UserId, @SiteName, @SiteLogin, @SitePassword)";
                MySqlCommand cmd = new MySqlCommand(insertQuery, conn);
                cmd.Parameters.AddWithValue("@UserId", currentUserId);
                cmd.Parameters.AddWithValue("@SiteName", siteName);
                cmd.Parameters.AddWithValue("@SiteLogin", siteLogin);
                cmd.Parameters.AddWithValue("@SitePassword", sitePassword);

                cmd.ExecuteNonQuery();
            }

            lblSiteMessage.ForeColor = System.Drawing.Color.Green;
            lblSiteMessage.Text = "Сайт успішно додано!";
            txtSiteName.Text = "";
            txtSiteLogin.Text = "";
            txtSitePassword.Text = "";

            BindSites();

            // Закриваємо модальне вікно створення сайту
            ScriptManager.RegisterStartupScript(this, GetType(), "CloseCreateModal", "closeCreateModal();", true);
        }
    }
}
