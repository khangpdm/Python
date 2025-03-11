const users = [
  {username:"hongtham", password:"12345"},
  {username:"ngocphuong", password:"12345"},
  {username:"hoangphuc", password:"12345"},
  {username:"minhkhang", password:"12345"}
];


function showLoginForm() {
  document.getElementById("loginForm").classList.remove("hidden");
  document.getElementById("loginForm").style.display = "flex";  
}

function closeLoginForm() {
  document.getElementById("loginForm").classList.add("hidden");
  document.getElementById("loginForm").style.display = "none";  
}


function btn_login(){
  const username = document.getElementById("username").value;
  const password = document.getElementById("password").value;
   if(!username){
    alert("Vui lòng nhập tên đăng nhập!");
    document.getElementById("username").focus();
    return;
   }
   else if(!password){
    alert("Vui lòng nhập mật khẩu!");
    document.getElementById("password").focus();
    return;
   }
   const user = users.find(user => user.username === username && user.password === password);
    if(user){
    alert("Đăng nhập thành công!");
    document.getElementById("username").value = "";
    document.getElementById("password").value = "";
    
    closeLoginForm();
    updateLoginStatus(user.username);
   }
}
function updateLoginStatus(username) {
  const loginItem = document.getElementById("loginItem");
  if (loginItem) {
    loginItem.innerHTML = `<a href="#" onclick="logout()">Đăng xuất </a>`;
  }
}


function logout() {
  alert("Bạn đã đăng xuất!");
  const loginItem = document.getElementById("loginItem");
  if (loginItem) {
    loginItem.innerHTML = `<a href="#" onclick="showLoginForm()">Đăng nhập</a>`; // Trở lại trạng thái đăng nhập
  }
}


