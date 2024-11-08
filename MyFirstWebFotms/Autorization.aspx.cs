using System;
using System.Security.Cryptography;
using System.Text;
using MySql.Data.MySqlClient;

namespace MyFirstWebFotms
{
    public partial class Autorization : System.Web.UI.Page
    {
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                lblMessage.Text = "Будь ласка, заповніть всі поля!";
                return;
            }

            // Хеширование введенного пароля
            string hashedPassword = HashPassword(password);

            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MySqlConnection"].ConnectionString;

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    // Обновленный запрос, чтобы получить `id` пользователя
                    string query = "SELECT id FROM users WHERE email = @Email AND password_users = @Password";

                    MySqlCommand cmd = new MySqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Password", hashedPassword);

                    object result = cmd.ExecuteScalar();

                    if (result != null)
                    {
                        // Получаем user_id из результата запроса и сохраняем в сессии
                        int userId = Convert.ToInt32(result);
                        Session["user_id"] = userId;
                        Session["email"] = email; // Дополнительно, если нужно сохранить email

                        // Перенаправление на страницу успешного входа
                        Response.Redirect("Success.aspx");
                    }
                    else
                    {
                        lblMessage.Text = "Неправильний email або пароль!";
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Помилка підключення: " + ex.Message;
                }
            }
        }


        protected void btnRegister_Click(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        }

        // Метод для хешування пароля з використанням SHA256
        private string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder builder = new StringBuilder();
                foreach (var b in bytes)
                {
                    builder.Append(b.ToString("x2"));
                }
                return builder.ToString();
            }
        }
    }
}
