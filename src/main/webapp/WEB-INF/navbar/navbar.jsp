<%@ page import="model.Utente" %>
<%@ page import="java.util.Random" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
  <title>Navbar</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
  <link rel="stylesheet" type="text/css" href="css/navbar.css?=<%=new Random().nextInt()%>"/>
  <link rel="stylesheet" type="text/css" href="css/home.css?=<%=new Random().nextInt()%>"/>
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

</head>
<body>
<% Utente utente = (Utente) session.getAttribute("login");%>

<header class="header">

  <div class="logo"><a href="HomePage">Forneria Del Cilento</a></div>
  <ul class="links">
    <li><a href="InitServlet?action=product">Prodotti</a></li>
    <li><a href="InitServlet?action=specialita">Specialità</a></li>
    <li><a href="InitServlet?action=contatti">Contatti</a></li>
    <%
      if(utente!=null){
    %>
    <li><a href="InitServlet?action=account">Account</a></li>
    <%}%>
    <li><a href="CartServlet" ><i class="fa-solid fa-cart-shopping" style="color: #38271E;"></i></a></li>

  </ul>
  <%

    if(utente!=null){
  %>
  <ul class="menu">
    <li class="has-children"><a class="action_btn"> Ciao <%=utente.getName().toUpperCase(java.util.Locale.ROOT)%><i class="fa fa-caret-down" aria-hidden="true"></i></a>
      <ul class="sub-menu">
        <li><a href="InitServlet?action=orders"> Ordini</a></li>
        <li><a href="LogoutServlet"> Logout </a></li>
      </ul>
    </li>
  </ul>


  <%}else{%>
  <a href="InitServlet?action=login" class="action_btn">Login</a>
  <%}%>
  <div class="toggle_btn">
    <i class="fa-solid fa-bars"></i>
  </div>

</header>

<div class="dropdown_menu">
  <li><a href="InitServlet?action=product">Prodotti</a></li>
  <li><a href="InitServlet?action=specialita">Specialità</a></li>
  <li><a href="InitServlet?action=contatti">Contatti</a></li>
  <li><a href="InitServlet?action=orders">Ordini</a></li>
  <%
    if(utente!=null){
  %>
  <li><a href="InitServlet?action=account">Account</a></li>
  <%}%>
  <li><a href="CartServlet"><i class="fa-solid fa-cart-shopping" style="color: #38271E;"></i></a></li>
  <%
    if(utente!=null){
  %>
  <li><a class="action_btn"> Ciao <%=utente.getName().toUpperCase(java.util.Locale.ROOT)%> </a></li>
  <li><a href="LogoutServlet"> Logout </a></li>
  <%}else{%>
  <li><a href="InitServlet?action=login" class="action_btn">Login</a></li>
  <%}%>
</div>


<script>

  $(document).ready(function() {
    $('.toggle_btn').click(function() {
      $('.dropdown_menu').toggleClass('open');
    });

    $(window).resize(function() {
      if ($(window).width() > 992) {
        $('.dropdown_menu').removeClass('open');
      }
    });
  });

</script>
</body>
</html>