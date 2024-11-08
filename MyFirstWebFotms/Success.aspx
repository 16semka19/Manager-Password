<%@ Page Title="Успішна авторизація" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Success.aspx.cs" Inherits="MyFirstWebFotms.Success" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div class="mar">
        <!-- Кнопка для відкриття модального вікна створення сайту -->
        <button type="button" class="button-style" onclick="openCreateModal();">Створити пароль</button>

        <!-- Модальне Вікно для Додавання Сайту -->
        <div id="createSiteModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeCreateModal();">&times;</span>
                <h2>Додати Новий Сайт</h2>
                <asp:Panel ID="pnlAddSite" runat="server">
                    <p>Сайт:</p>
                    <div class="input-with-button">
                        <asp:TextBox ID="txtSiteName" runat="server" CssClass="marg"></asp:TextBox>
                        <button type="button" class="small-button" onclick="generateSiteName();">Генерувати Назву</button>
                    </div>
                    <asp:RequiredFieldValidator ID="rfvSiteName" runat="server" ControlToValidate="txtSiteName"
                        ErrorMessage="Поле є обов'язковим!" ForeColor="Red" />

                    <p>Логін:</p>
                    <div class="input-with-button">
                        <asp:TextBox ID="txtSiteLogin" runat="server" CssClass="marg"></asp:TextBox>
                        <button type="button" class="small-button" onclick="generateSiteLogin();">Генерувати Логін</button>
                    </div>
                    <asp:RequiredFieldValidator ID="rfvSiteLogin" runat="server" ControlToValidate="txtSiteLogin"
                        ErrorMessage="Поле є обов'язковим!" ForeColor="Red" />

                    <p>Пароль:</p>
                       <span class="toggle-password" onclick="togglePasswordVisibility('<%= txtSitePasswordEdit.ClientID %>');">&#128065;</span>
                    <div class="password-container">
                       

                        <asp:TextBox ID="txtSitePassword" runat="server" CssClass="marg password-field" TextMode="Password"></asp:TextBox>

                        
                        <button type="button" class="small-button" onclick="generatePassword();">Згенерувати</button>
                    </div>
                    <asp:RequiredFieldValidator ID="rfvSitePassword" runat="server" ControlToValidate="txtSitePassword"
                        ErrorMessage="Поле є обов'язковим!" ForeColor="Red" />

                    <!-- Опції для генератора паролів -->
                    <div class="password-generator-options">
                        <p>Опції генератора паролів:</p>
                        <label><input type="checkbox" id="includeNumbers" checked /> Цифри</label><br />
                        <label><input type="checkbox" id="includeLowercase" checked /> Маленькі букви</label><br />
                        <label><input type="checkbox" id="includeUppercase" checked /> Великі букви</label><br />
                        <label><input type="checkbox" id="includeSymbols" /> Спеціальні символи</label><br />
                        <label><input type="checkbox" id="excludeSimilar" /> Виключати схожі символи</label><br />
                        <label>Довжина паролю:
                            <input type="number" id="passwordLength" value="12" min="4" max="32" />
                        </label><br />
                    </div>

                    <br />
                    <asp:Button ID="btnSubmitSite" runat="server" Text="Додати" CssClass="button-style" OnClick="btnSubmitSite_Click" />
                    <asp:Button ID="btnCancelCreate" runat="server" Text="Скасувати" CssClass="button-style" OnClientClick="closeCreateModal(); return false;" />

                    <br />
                    <asp:Label ID="lblSiteMessage" runat="server" ForeColor="Red"></asp:Label>
                </asp:Panel>
            </div>
        </div>

        <!-- Список Сайтів -->
        <asp:ListView ID="lvSites" runat="server" OnItemCommand="lvSites_ItemCommand">
            <LayoutTemplate>
                <div class="sites-container">
                    <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>

                </div>
                 <footer>
 <p>Copyright (c) 2024 1PassManager. Всі права належать студенту Семисюку Дмитру 541</p>
 </footer>
            </LayoutTemplate>
            <ItemTemplate>
                <div class="card">
                    <h3><%# Eval("site_name") %></h3>
                    <p>Логін: <%# Eval("site_login") %></p>
                    
                    <!-- Кнопки для редагування/видалення -->
                    <asp:Button ID="btnEdit" runat="server" Text="Редагувати" CommandName="EditItem" CommandArgument='<%# Eval("id") %>' CssClass="button-style" />
                    <asp:Button ID="btnDelete" runat="server" Text="Видалити" CommandName="DeleteItem" CommandArgument='<%# Eval("id") %>' CssClass="button-style" OnClientClick="return confirm('Ви впевнені, що хочете видалити цей сайт?');" />
                </div>
            </ItemTemplate>
            <EmptyDataTemplate>
                <p>Немає доданих сайтів.</p>

            </EmptyDataTemplate>

        </asp:ListView>

        <!-- Модальне Вікно для Деталей Сайту -->
        <div id="detailsSiteModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeDetailsModal();">&times;</span>
                <h2>Редагувати Сайт</h2>
                <asp:Panel ID="pnlEditSite" runat="server">
                    <asp:HiddenField ID="hfSiteId" runat="server" />
                  <p>Сайт:</p>
<div class="input-with-button">
  
    <asp:TextBox ID="txtSiteNameEdit" runat="server" CssClass="marg" Style="flex: 1; margin-left: 10px;"></asp:TextBox>
</div>
<asp:RequiredFieldValidator ID="rfvSiteNameEdit" runat="server" ControlToValidate="txtSiteNameEdit"
    ForeColor="Red" />

<!-- Поле для логіну -->
<p>Логін:</p>
<div class="input-with-button">

    <asp:TextBox ID="txtSiteLoginEdit" runat="server" CssClass="marg" Style="flex: 1; margin-left: 10px;"></asp:TextBox>
</div>
<asp:RequiredFieldValidator ID="rfvSiteLoginEdit" runat="server" ControlToValidate="txtSiteLoginEdit"
     ForeColor="Red" />

                    <p>Пароль:</p>
                 <div class="password-container">
    <button type="button" class="small-button" onclick="generatePasswordEdit();">Згенерувати</button>
    <asp:TextBox ID="txtSitePasswordEdit" runat="server" CssClass="marg password-field" TextMode="Password"></asp:TextBox>
    <span class="toggle-password" onclick="togglePasswordVisibility('<%= txtSitePasswordEdit.ClientID %>');">&#128065;</span>
</div>

                    <asp:RequiredFieldValidator ID="rfvSitePasswordEdit" runat="server" ControlToValidate="txtSitePasswordEdit"
                         ForeColor="Red" />

                    <!-- Опції для генератора паролів -->
                    <div class="password-generator-options">
                        <p>Опції генератора паролів:</p>
                        <label><input type="checkbox" id="includeNumbersEdit" checked /> Цифри</label><br />
                        <label><input type="checkbox" id="includeLowercaseEdit" checked /> Маленькі букви</label><br />
                        <label><input type="checkbox" id="includeUppercaseEdit" checked /> Великі букви</label><br />
                        <label><input type="checkbox" id="includeSymbolsEdit" /> Спеціальні символи</label><br />
                        <label><input type="checkbox" id="excludeSimilarEdit" /> Виключати схожі символи</label><br />
                        <label>Довжина паролю:
                            <input type="number" id="passwordLengthEdit" value="12" min="4" max="32" />
                        </label><br />
                    </div>

                    <br />
                    <asp:Button ID="btnSaveChanges" runat="server" Text="Зберегти" CssClass="button-style" OnClick="btnSaveChanges_Click" />
                    <asp:Button ID="btnCancelEdit" runat="server" Text="Скасувати" CssClass="button-style" OnClientClick="closeDetailsModal(); return false;" />

                    <br />
                    <asp:Label ID="lblSiteOptionsMessage" runat="server" ForeColor="Red"></asp:Label>
                </asp:Panel>
            </div>
        </div>

    </div>

    <!-- CSS -->
    <style>
        /* Стиль для модального фона */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
            padding-top: 60px;
        }

        /* Стиль для вмісту модального вікна */
        .modal-content {
            background-color: grey;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 40%;
            border-radius: 5px;
            position: relative;
        }

        /* Стиль для кнопки закриття */
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            position: absolute;
            right: 20px;
            top: 10px;
            cursor: pointer;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
        }

        /* Стиль для контейнера пароля */
       .password-container {
    display: flex;
    align-items: center;
}

.password-field {
    flex: 1;
    margin-left: 10px;
    margin-right: 30px; /* Space for the toggle icon */
}

.toggle-password {
    position: absolute;
    right: 10px;
}
        /* Стиль для списка сайтов и карточек */
       .sites-container {
    display: grid;
    grid-template-columns: repeat(5, 1fr); /* 7 колонок, кожна займає рівну частину */
    gap: 10px; /* Відступи між картками */
   margin-left: -400px;
}

        .card {
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 15px;
            width: 200px;
            box-sizing: border-box;
            position: relative;
        }

        .card h3 {
            margin-top: 0;
        }

        .button-style {
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            margin: 5px 0;
        }

        .button-style:hover {
            background-color: #0056b3;
        }

        .small-button {
            margin-left: 10px;
            padding: 5px 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }

        .small-button:hover {
            background-color: #0056b3;
        }

        .marg {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
        }

        .input-with-button {
            display: flex;
            align-items: center;
        }

        .password-generator-options {
            margin-top: 20px;
        }
    </style>

    <!-- JavaScript -->
    <script type="text/javascript">
        // Функція для відкриття модального вікна створення сайту
        function openCreateModal() {
            document.getElementById('createSiteModal').style.display = 'block';
        }

        // Функція для закриття модального вікна створення сайту
        function closeCreateModal() {
            document.getElementById('createSiteModal').style.display = 'none';
            clearCreateForm();
        }

        // Функція для очищення форми створення сайту
        function clearCreateForm() {
            document.getElementById('<%= txtSiteName.ClientID %>').value = '';
            document.getElementById('<%= txtSiteLogin.ClientID %>').value = '';
            document.getElementById('<%= txtSitePassword.ClientID %>').value = '';
            // Скидання чекбоксів та довжини паролю
            document.getElementById('includeNumbers').checked = true;
            document.getElementById('includeLowercase').checked = true;
            document.getElementById('includeUppercase').checked = true;
            document.getElementById('includeSymbols').checked = false;
            document.getElementById('excludeSimilar').checked = false;
            document.getElementById('passwordLength').value = 12;
        }

        // Функція для перемикання видимості пароля
        function togglePasswordVisibility(textBoxClientID) {
            var passwordField = document.getElementById(textBoxClientID);
            var toggleIcon = event.currentTarget;
            if (passwordField.type === "password") {
                passwordField.type = "text";
                toggleIcon.innerHTML = "&#128064;"; // Показати очі
            } else {
                passwordField.type = "password";
                toggleIcon.innerHTML = "&#128065;"; // Приховати очі
            }
        }

        // Функція генерації назви сайту
        function generateSiteName() {
            var siteNames = ["ExampleSite", "MyWebsite", "CoolPortal", "BestPlatform", "SuperBlog"];
            var randomName = siteNames[Math.floor(Math.random() * siteNames.length)];
            document.getElementById('<%= txtSiteName.ClientID %>').value = randomName;
        }

        // Функція генерації логіну сайту
        function generateSiteLogin() {
            var prefixes = ["user", "admin", "member", "client", "guest"];
            var suffix = Math.floor(Math.random() * 1000);
            var randomLogin = prefixes[Math.floor(Math.random() * prefixes.length)] + suffix;
            document.getElementById('<%= txtSiteLogin.ClientID %>').value = randomLogin;
        }

        // Функція генерації паролю
        function generatePassword() {
            var length = parseInt(document.getElementById('passwordLength').value);
            var includeNumbers = document.getElementById('includeNumbers').checked;
            var includeLowercase = document.getElementById('includeLowercase').checked;
            var includeUppercase = document.getElementById('includeUppercase').checked;
            var includeSymbols = document.getElementById('includeSymbols').checked;
            var excludeSimilar = document.getElementById('excludeSimilar').checked;

            var numbers = '0123456789';
            var lowercase = 'abcdefghijklmnopqrstuvwxyz';
            var uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
            var symbols = '!@#$%^&*()_+~`|}{[]\\:;?><,./-=';
            var similarCharacters = /[ilLI|`oO0]/g;

            var allCharacters = '';
            var characterSets = [];

            if (includeNumbers) {
                allCharacters += numbers;
                characterSets.push(numbers);
            }
            if (includeLowercase) {
                allCharacters += lowercase;
                characterSets.push(lowercase);
            }
            if (includeUppercase) {
                allCharacters += uppercase;
                characterSets.push(uppercase);
            }
            if (includeSymbols) {
                allCharacters += symbols;
                characterSets.push(symbols);
            }

            if (excludeSimilar) {
                allCharacters = allCharacters.replace(similarCharacters, '');
                for (var i = 0; i < characterSets.length; i++) {
                    characterSets[i] = characterSets[i].replace(similarCharacters, '');
                }
            }

            if (allCharacters === '') {
                alert('Оберіть хоча б одну опцію для генерації паролю!');
                return;
            }

            var password = '';

            // Спочатку додаємо по одному символу з кожного набору, щоб гарантувати їх наявність
            for (var i = 0; i < characterSets.length; i++) {
                var set = characterSets[i];
                password += set.charAt(Math.floor(Math.random() * set.length));
            }

            // Заповнюємо решту паролю випадковими символами
            for (var i = password.length; i < length; i++) {
                password += allCharacters.charAt(Math.floor(Math.random() * allCharacters.length));
            }

            // Перемішуємо пароль
            password = shuffleString(password);

            // Встановлюємо згенерований пароль у поле паролю
            document.getElementById('<%= txtSitePassword.ClientID %>').value = password;
        }

        // Функція для перемішування рядка
        function shuffleString(str) {
            var arr = str.split('');
            for (var i = arr.length - 1; i > 0; i--) {
                var j = Math.floor(Math.random() * (i + 1));
                var temp = arr[i];
                arr[i] = arr[j];
                arr[j] = temp;
            }
            return arr.join('');
        }

        // Закриття модального вікна при натисканні поза ним
        window.onclick = function (event) {
            var createModal = document.getElementById('createSiteModal');
            var detailsModal = document.getElementById('detailsSiteModal');
            if (event.target == createModal) {
                closeCreateModal();
            }
            if (event.target == detailsModal) {
                closeDetailsModal();
            }
        }

        // Функція для відкриття модального вікна деталей сайту з серверної сторони
        function openDetailsModal() {
            document.getElementById('detailsSiteModal').style.display = 'block';
        }

        // Функція для закриття модального вікна деталей сайту
        function closeDetailsModal() {
            document.getElementById('detailsSiteModal').style.display = 'none';
            clearEditForm();
        }

        // Функція для очищення форми редагування сайту
        function clearEditForm() {
            document.getElementById('<%= txtSiteNameEdit.ClientID %>').value = '';
            document.getElementById('<%= txtSiteLoginEdit.ClientID %>').value = '';
            document.getElementById('<%= txtSitePasswordEdit.ClientID %>').value = '';
            document.getElementById('<%= hfSiteId.ClientID %>').value = '';
            // Скидання чекбоксів та довжини паролю, якщо потрібно
            document.getElementById('includeNumbersEdit').checked = true;
            document.getElementById('includeLowercaseEdit').checked = true;
            document.getElementById('includeUppercaseEdit').checked = true;
            document.getElementById('includeSymbolsEdit').checked = false;
            document.getElementById('excludeSimilarEdit').checked = false;
            document.getElementById('passwordLengthEdit').value = 12;
        }

        // Функція генерації паролю в модальному вікні редагування
        function generatePasswordEdit() {
            var length = parseInt(document.getElementById('passwordLengthEdit').value);
            var includeNumbers = document.getElementById('includeNumbersEdit').checked;
            var includeLowercase = document.getElementById('includeLowercaseEdit').checked;
            var includeUppercase = document.getElementById('includeUppercaseEdit').checked;
            var includeSymbols = document.getElementById('includeSymbolsEdit').checked;
            var excludeSimilar = document.getElementById('excludeSimilarEdit').checked;

            var numbers = '0123456789';
            var lowercase = 'abcdefghijklmnopqrstuvwxyz';
            var uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
            var symbols = '!@#$%^&*()_+~`|}{[]\\:;?><,./-=';
            var similarCharacters = /[ilLI|`oO0]/g;

            var allCharacters = '';
            var characterSets = [];

            if (includeNumbers) {
                allCharacters += numbers;
                characterSets.push(numbers);
            }
            if (includeLowercase) {
                allCharacters += lowercase;
                characterSets.push(lowercase);
            }
            if (includeUppercase) {
                allCharacters += uppercase;
                characterSets.push(uppercase);
            }
            if (includeSymbols) {
                allCharacters += symbols;
                characterSets.push(symbols);
            }

            if (excludeSimilar) {
                allCharacters = allCharacters.replace(similarCharacters, '');
                for (var i = 0; i < characterSets.length; i++) {
                    characterSets[i] = characterSets[i].replace(similarCharacters, '');
                }
            }

            if (allCharacters === '') {
                alert('Оберіть хоча б одну опцію для генерації паролю!');
                return;
            }

            var password = '';

            // Спочатку додаємо по одному символу з кожного набору, щоб гарантувати їх наявність
            for (var i = 0; i < characterSets.length; i++) {
                var set = characterSets[i];
                password += set.charAt(Math.floor(Math.random() * set.length));
            }

            // Заповнюємо решту паролю випадковими символами
            for (var i = password.length; i < length; i++) {
                password += allCharacters.charAt(Math.floor(Math.random() * allCharacters.length));
            }

            // Перемішуємо пароль
            password = shuffleString(password);

            // Встановлюємо згенерований пароль у поле паролю
            document.getElementById('<%= txtSitePasswordEdit.ClientID %>').value = password;
        }
    </script>
</asp:Content>
