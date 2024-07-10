<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="./css/login.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
    <title>Login - Forneria Del Cilento</title>

    <script>
        $(document).ready(function(){
            if ( window.history.replaceState ) { // lo stato precedente (con requisiti) viene resettato
                window.history.replaceState( null, null, window.location.href );
            }
        });
    </script>

</head>
<body>

<%if(request.getAttribute("check")!=null){%>
<div class="alert" id="alert">
    <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span>
    <%=request.getAttribute("check")%>
</div>
<%}%>

<div class="wrapper">
    <h1> Login </h1>
    <form action="loginServlet" method="post">
        <input type="text" placeholder="E-mail" name="email" id="email" required>
        <input type="password" placeholder="Password" name="password" id="password" required>
    <button class="btn_login" type="submit" onclick="return(validateLogin())"> Login </button>
    </form>

    <div class="user">
        Sei nuovo? <a href="Register"> Registrati Qui! </a>
    </div>
</div>

<script>
    function validateLogin() {
        var password = document.getElementById('password').value;
        var emailRGX = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
        var passwordRGX=/^[a-zA-Z0-9!@#$%^&*]*$/;
        var resultPassword=passwordRGX.test(password);
        if (password.length < 8) {
            alert("La password non rispetta il numero minimo di caratteri");
            return false;
        }
        if (resultPassword == false) {
            alert("La password non rispecchia il formato corretto.Riprovare");
            return false;
        }

        var email = document.getElementById('email').value;
        var resultEmail = emailRGX.test(email);
        if (resultEmail == false) {
            alert("L'email non rispecchia il formato corretto.Riprovare");
            return false;
        }
        return true;
    }
</script>
</body>
</html>










