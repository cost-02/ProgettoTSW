<%@ page import="model.Utente" %>
<%@ page import="java.util.Random" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <link rel="stylesheet" type="text/css" href="css/admin/navbarAdmin.css?=<%=new Random().nextInt()%>"/>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

</head>
<body>
<%
    Utente utente = (Utente) session.getAttribute("loginAdmin");
%>
<header class="header">

    <div class="logo"><a href="HomeServletAdministrator?action=homeAdmin">Forneria Del Cilento</a></div>
    <ul class="links">
        <li><a href="HomeServletAdministrator?action=add_product">Aggiungi Prodotti</a></li>
        <li><a href="HomeServletAdministrator?action=manage_product">Gestisci Prodotti</a></li>
        <li><a href="HomeServletAdministrator?action=manage_category">Gestisci Categorie</a></li>
        <li><a href="HomeServletAdministrator?action=add_category">Categorie</a></li>
        <li><a href="HomeServletAdministrator?action=orders">Ordini</a></li>
        <li><a href="HomeServletAdministrator?action=users">Utenti</a></li>

    </ul>

    <ul class="menu">
        <li class="has-children"> <a class="action_btn"> <%=utente.getName().toUpperCase(java.util.Locale.ROOT)%> <i class="fa fa-caret-down" aria-hidden="true"></i></a>
            <ul class="sub-menu">
                <li><a href="LogoutServlet"> Logout </a></li>
            </ul>
        </li>
    </ul>

    <div class="toggle_btn">
        <i class="fa-solid fa-bars"></i>
    </div>
    </div>
    <div class="dropdown_menu">
        <li><a class="btn_admin"> <%=utente.getName().toUpperCase(java.util.Locale.ROOT)%></a></li>
        <li><a href="HomeServletAdministrator?action=add_product">Aggiungi Prodotti</a></li>
        <li><a href="HomeServletAdministrator?action=manage_product">Gestisci Prodotti</a></li>
        <li><a href="HomeServletAdministrator?action=manage_category">Gestisci Categorie</a></li>
        <li><a href="HomeServletAdministrator?action=add_category">Categorie</a></li>
        <li><a href="HomeServletAdministrator?action=orders">Ordini</a></li>
        <li><a href="HomeServletAdministrator?action=users">Utenti</a></li>


        <li><a href="LogoutServlet"> Logout </a></li>

    </div>
</header>
<script>
    $(document).ready(function() {
        $('.toggle_btn').click(function() {
            $('.dropdown_menu').toggleClass('open');
        });

        $(window).resize(function() {
            if ($(window).width() > 1150) {
                $('.dropdown_menu').removeClass('open');
            }
        });
    });
</script>

</body>
</html>