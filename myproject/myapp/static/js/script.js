// Chuyển đổi chế độ tối
document.getElementById('themeToggle').addEventListener('click', function() {
    document.body.classList.toggle('dark-mode');
    const isDarkMode = document.body.classList.contains('dark-mode');
    this.innerHTML = isDarkMode ? '<i class="fas fa-sun"></i>' : '<i class="fas fa-moon"></i>';
});

// Hiển thị upload section
document.getElementById('submitExamBtn')?.addEventListener('click', function() {
    document.getElementById('uploadSection').style.display = 'block';
    document.getElementById('submitExamBtn').style.display = 'none';
});

function showLoginForm(event) {
    event.preventDefault();
    document.getElementById('loginForm').style.display = 'block';
}

function closeLoginForm() {
    document.getElementById('loginForm').style.display = 'none';
}