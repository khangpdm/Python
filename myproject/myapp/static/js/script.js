const users = [
  { username: "hongtham", password: "12345" },
  { username: "ngocphuong", password: "12345" },
  { username: "hoangphuc", password: "12345" },
  { username: "minhkhang", password: "12345" }
];

const gv = [
  { username: "hongtham1", password: "12345" },
  { username: "ngocphuong1", password: "12345" },
  { username: "hoangphuc1", password: "12345" },
  { username: "minhkhang1", password: "12345" }
];

let currentUser = null; 

function showLoginForm() {
  document.getElementById("loginForm").style.display = "flex";
}

function closeLoginForm() {
  const loginForm = document.getElementById("loginForm");
  if (loginForm) {
    loginForm.style.display = "none";
  }
}

function btn_login() {
  const usernameInput = document.getElementById("username");
  const passwordInput = document.getElementById("password");

  const username = usernameInput.value.trim();
  const password = passwordInput.value.trim();

  if (!username || !password) {
    alert("Vui lòng nhập đầy đủ thông tin!");
    return;
  }

  const teacher = gv.find(u => u.username === username && u.password === password);
  const student = users.find(u => u.username === username && u.password === password);

  if (teacher) {
    currentUser = teacher;
    alert(`Đăng nhập thành công (Giáo viên: ${teacher.username})`);
    updateLoginStatus(teacher.username, "teacher");
  } else if (student) {
    currentUser = student;
    alert(`Đăng nhập thành công (Học sinh: ${student.username})`);
    updateLoginStatus(student.username, "student");
  } else {
    alert("Sai tên đăng nhập hoặc mật khẩu!");
    return;
  }
  usernameInput.value = "";
  passwordInput.value = "";
  closeLoginForm();
}


function updateLoginStatus(username, role) {
  const loginItem = document.getElementById("loginItem");
  if (loginItem) {
    loginItem.innerHTML = `<a href="#" onclick="logout()">Đăng xuất (${username})</a>`;
  }
  showUserInterface(role);
}


function logout() {
  if (!currentUser) return;

  alert(`Đăng xuất khỏi tài khoản (${currentUser.username})`);
  currentUser = null;
  const loginItem = document.getElementById("loginItem");
  if (loginItem) {
    loginItem.innerHTML = `<a href="#" onclick="showLoginForm()">Đăng nhập</a>`;
  }
  resetInterface();

  const loginForm = document.getElementById("loginForm");
  if (loginForm) {
    loginForm.style.display = "none";
  }

  const showForm = document.getElementById("showForm");
  if (showForm) {
    showForm.style.display = "block";
  }
}




function showUserInterface(role) {
  const teacherSection = document.getElementById("teacherSection");
  const studentSection = document.getElementById("studentSection");
  const showForm = document.getElementById("showForm");

  if (role === "teacher") {
    teacherSection.style.display = "block";
    studentSection.style.display = "none";
    showForm.style.display="none";
  } else if (role === "student") {
    teacherSection.style.display = "none";
    studentSection.style.display = "block";
    showForm.style.display="none";
  }
}


function resetInterface() {
  const teacherSection = document.getElementById("teacherSection");
  const studentSection = document.getElementById("studentSection");

  if (teacherSection) teacherSection.style.display = "none";
  if (studentSection) studentSection.style.display = "none";
}



document.addEventListener("DOMContentLoaded", function() {
  document.body.addEventListener('click', function(event) {
    if (event.target.classList.contains('btn-login')) {
      btn_login();
    }
  });
});


document.addEventListener("DOMContentLoaded", function () {
  const submitExamBtn = document.getElementById("submitExamBtn");
  const uploadSection = document.getElementById("uploadSection");
  const uploadExamBtn = document.getElementById("uploadExamBtn");

  if (submitExamBtn) {
    submitExamBtn.addEventListener("click", function () {
      if (!currentUser) {
        alert("Bạn phải đăng nhập trước khi nộp bài thi!");
        return;
      }
      uploadSection.style.display = "block";
    });
  }

  if (uploadExamBtn) {
    uploadExamBtn.addEventListener("click", function () {
      const fileInput = document.getElementById("examImage");
      const file = fileInput.files[0];

      if (!file) {
        alert("Vui lòng chọn hình ảnh bài thi!");
        return;
      }

      const formData = new FormData();
      formData.append("student", currentUser.username);
      formData.append("examImage", file);

      fetch("/submit-exam/", {
        method: "POST",
        body: formData
      })
      .then(response => response.json())
      .then(data => {
        alert(data.message);
        fileInput.value = "";
      })
      .catch(error => {
        console.error("Lỗi khi nộp bài:", error);
        alert("Nộp bài thất bại! Vui lòng thử lại.");
      }); 
    });
  }
});


  
document.getElementById("darkModeToggle").addEventListener("click", function() {
  document.body.classList.toggle("dark-mode");
});