const users = [
  { username: "hongtham", password: "12345" },
  { username: "ngocphuong", password: "12345" },
  { username: "hoangphuc", password: "12345" },
  { username: "minhkhang", password: "12345" }
];

function showLoginForm() {
  const loginForm = document.getElementById("loginForm");
  if (loginForm) {
    loginForm.classList.remove("hidden");
    loginForm.style.display = "flex";
  }
}
function closeLoginForm() {
  const loginForm = document.getElementById("loginForm");
  if (loginForm) {
    loginForm.classList.add("hidden");
    loginForm.style.display = "none";
  }
}
function btn_login(event) {
  event.preventDefault(); // Ngăn trang reload khi submit form

  const username = document.getElementById("username").value.trim();
  const password = document.getElementById("password").value.trim();

  if (!username) {
    alert("Vui lòng nhập tên đăng nhập!");
    document.getElementById("username").focus();
    return;
  } 
  if (!password) {
    alert("Vui lòng nhập mật khẩu!");
    document.getElementById("password").focus();
    return;
  }

  const user = users.find(user => user.username === username && user.password === password);

  if (user) {
    alert("Đăng nhập thành công!");
    document.getElementById("username").value = "";
    document.getElementById("password").value = "";
    closeLoginForm();
    updateLoginStatus(user.username);
  } else {
    alert("Tên đăng nhập hoặc mật khẩu không đúng!");
  }
}

function updateLoginStatus(username) {
  const loginItem = document.getElementById("loginItem");
  if (loginItem) {
    loginItem.innerHTML = `<a href="#" onclick="logout()">Đăng xuất (${username})</a>`;
  }
}

function logout() {
  alert("Bạn đã đăng xuất!");
  const loginItem = document.getElementById("loginItem");
  if (loginItem) {
    loginItem.innerHTML = `<a href="#" onclick="showLoginForm()">Đăng nhập</a>`;
  }
}

function showUpload() {
  const uploadSection = document.getElementById("uploadSection");
  if (uploadSection) {
    uploadSection.style.display = "block";
  }
}

// Gán sự kiện cho nút đăng nhập
document.addEventListener("DOMContentLoaded", function () {
  const loginButton = document.querySelector(".btn-login");
  if (loginButton) {
    loginButton.addEventListener("click", btn_login);
  }
});
