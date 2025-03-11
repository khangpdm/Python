
  
  function showLoginForm() {
    var loginform = document.getElementById("loginForm");
    var container = document.getElementById("container");
  
    if (loginform) {
      loginform.style.display = "block";
      container.style.display = "none";
    }

  }
  function CloseFormLogin(){
    var loginform =document.getElementById("loginForm");
    if (loginform) {
      loginform.style.display = "none";
    }
  }
  