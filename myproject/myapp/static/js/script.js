
const users = [
  { username: "hongtham", password: "12345" },
  { username: "ngocphuong", password: "12345" },
  { username: "hoangphuc", password: "12345" },
  { username: "minhkhang", password: "12345" }
];

let currentUser = null; 

function showLoginForm() {
  const loginForm = document.getElementById("loginForm");
  if (loginForm) {
    loginForm.style.display = "flex";
  }
}

function closeLoginForm() {
  const loginForm = document.getElementById("loginForm");
  if (loginForm) {
    loginForm.style.display = "none";
  }
}

function btn_login() {
  const username = document.getElementById("username").value.trim();
  const password = document.getElementById("password").value.trim();

  if (!username || !password) {
    alert("Vui lòng nhập đầy đủ thông tin!");
    return;
  }

  const user = users.find(u => u.username === username && u.password === password);

  if (user) {
    currentUser = user;
    alert(`Đăng nhập thành công (${user.username})`);
    closeLoginForm();
    updateLoginStatus(user.username);
  } else {
    alert("Sai tên đăng nhập hoặc mật khẩu!");
  }
}

function updateLoginStatus(username) {
  const loginItem = document.getElementById("loginItem");
  if (loginItem) {
    loginItem.innerHTML = `<a href="#" onclick="logout()">Đăng xuất (${username})</a>`;
  }
}

function logout() {
  if (!currentUser) return;

  alert(`Đăng xuất khỏi tài khoản (${currentUser.username})`);
  currentUser = null;

  const loginItem = document.getElementById("loginItem");
  if (loginItem) {
    loginItem.innerHTML = `<a href="#" onclick="showLoginForm()">Đăng nhập</a>`;
  }

  hideUpload();
}

function showUpload() {
  if (!currentUser) {
    alert("Vui lòng đăng nhập trước khi sử dụng chức năng này!");
    showLoginForm();
    return;
  }

  const uploadSection = document.getElementById("uploadSection");
  if (uploadSection) {
    uploadSection.style.display = "block";
  }
}

function hideUpload() {
  const uploadSection = document.getElementById("uploadSection");
  if (uploadSection) {
    uploadSection.style.display = "none";
  }
}

document.addEventListener("DOMContentLoaded", function() {
  const loginBtn = document.querySelector('.btn-login');
  if (loginBtn) {
    loginBtn.addEventListener('click', btn_login);
  }

  const startNowBtn = document.getElementById('startNowButton');
  if (startNowBtn) {
    startNowBtn.addEventListener('click', function() {
      showUpload();
    });
  }

  hideUpload();
});
