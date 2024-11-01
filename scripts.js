document.getElementById('loginForm').addEventListener('submit', function(event) {
    event.preventDefault();
    var username = document.getElementById('username').value;
    var password = document.getElementById('password').value;

    if(username === 'admin' && password === 'admin123') {
        document.querySelector('.admin-login').style.display = 'none';
        document.querySelector('.admin-dashboard').style.display = 'block';
    } else {
        alert('Invalid username or password');
    }
});

function showSection(sectionId) {
    var sections = document.querySelectorAll('.admin-dashboard section');
    sections.forEach(function(section) {
        section.style.display = 'none';
    });
    document.getElementById(sectionId).style.display = 'block';
}

const users = JSON.parse(localStorage.getItem('users')) || [];

document.getElementById('addUserForm').addEventListener('submit', function(event) {
    event.preventDefault();
    const username = document.getElementById('addUsername').value;
    const password = document.getElementById('addPassword').value;
    addUser(username, password);
});

document.getElementById('editUserForm').addEventListener('submit', function(event) {
    event.preventDefault();
    const username = document.getElementById('editUsername').value;
    const password = document.getElementById('editPassword').value;
    saveUserChanges(currentEditIndex, username, password);
});

let currentEditIndex = null;

function addUser(username, password) {
    const user = { username, password, locked: false };
    users.push(user);
    updateLocalStorage();
    displayUsers();
    document.getElementById('addUsername').value = '';
    document.getElementById('addPassword').value = '';
}

function editUser(index) {
    if (index >= 0 && index < users.length) {
        currentEditIndex = index;
        document.getElementById('editUserForm').style.display = 'block';
        const user = users[index];
        document.getElementById('editUsername').value = user.username;
        document.getElementById('editPassword').value = user.password;
    } else {
        console.error('Invalid user index');
    }
}

function saveUserChanges(index, username, password) {
    if (index >= 0 && index < users.length) {
        users[index].username = username;
        users[index].password = password;
        updateLocalStorage();
        displayUsers();
        document.getElementById('editUserForm').style.display = 'none';
    } else {
        console.error('Invalid user index');
    }
}

function lockUser(index) {
    if (index >= 0 && index < users.length) {
        users[index].locked = !users[index].locked;
        updateLocalStorage();
        displayUsers();
    } else {
        console.error('Invalid user index');
    }
}

function deleteUser(index) {
    if (index >= 0 && index < users.length) {
        users.splice(index, 1);
        updateLocalStorage();
        displayUsers();
    } else {
        console.error('Invalid user index');
    }
}

function updateLocalStorage() {
    localStorage.setItem('users', JSON.stringify(users));
}

function displayUsers() {
    const userList = document.getElementById('userList');
    userList.innerHTML = '';
    users.forEach((user, index) => {
        const li = document.createElement('li');
        li.textContent = `${user.username} - ${user.locked ? 'Locked' : 'Active'}`;
        
        const editButton = document.createElement('button');
        editButton.textContent = 'Edit';
        editButton.onclick = () => editUser(index);
        
        const lockButton = document.createElement('button');
        lockButton.textContent = user.locked ? 'Unlock' : 'Lock';
        lockButton.onclick = () => lockUser(index);
        
        const deleteButton = document.createElement('button');
        deleteButton.textContent = 'Delete';
        deleteButton.onclick = () => {
            if (confirm('Are you sure you want to delete this user?')) {
                deleteUser(index);
            }
        };

        li.append(editButton, lockButton, deleteButton);
        userList.appendChild(li);
    });
}

displayUsers();