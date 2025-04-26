
function submitExam() {
    document.getElementById('uploadSection').style.display = 'block';
    document.getElementById('submitExamBtn').style.display = 'none';
}
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