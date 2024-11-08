using System;
using System.Security.Cryptography;
using System.Text;
using MySql.Data.MySqlClient;

namespace MyFirstWebFotms
{
    public partial class Register : System.Web.UI.Page
    {
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                lblMessage.Text = "Будь ласка, заповніть всі поля!";
                return;
            }

            // Хешування пароля
            string hashedPassword = HashPassword(password);

            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MySqlConnection"].ConnectionString;

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    // Перевірка наявності користувача
                    string checkQuery = "SELECT COUNT(*) FROM users WHERE email = @Email";
                    MySqlCommand checkCmd = new MySqlCommand(checkQuery, conn);
                    checkCmd.Parameters.AddWithValue("@Email", email);

                    int userExists = Convert.ToInt32(checkCmd.ExecuteScalar());

                    if (userExists > 0)
                    {
                        lblMessage.Text = "Користувач з таким email вже існує!";
                    }
                    else
                    {
                        // Додавання користувача з хешованим паролем
                        string insertQuery = "INSERT INTO users (name_users, email, password_users) VALUES (@Name, @Email, @Password)";
                        MySqlCommand cmd = new MySqlCommand(insertQuery, conn);
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Password", hashedPassword); // Зберігаємо хешований пароль

                        cmd.ExecuteNonQuery();
                        lblMessage.ForeColor = System.Drawing.Color.Green;
                        lblMessage.Text = "Реєстрація успішна! Ви можете увійти.";

                        Response.Redirect("Autorization.aspx");
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Помилка підключення: " + ex.Message;
                }
            }
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
                    builder.Append(b.ToString("x2")); // Конвертуємо байти в hex рядок
                }
                return builder.ToString();
            }
        }
    }
}
