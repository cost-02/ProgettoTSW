<%@ page import="model.Prodotto" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
  <link rel="stylesheet" type="text/css" href="./css/infoProduct.css?v=<%=new Random().nextInt()%>"/>

  <%
    Prodotto p = (Prodotto) request.getAttribute("product");
  %>

    <title><%=p.getName()%> - <%=p.getNameCategory()%></title>
</head>
<body>

<%@ include file="/WEB-INF/navbar/navbar.jsp" %>


<div class="main-wrapper">
  <div class="container">
    <div class="product-div">
      <div class="product-div-left">
        <div class="img-container">
          <img src="upload/<%=p.getImage()%>">
        </div>
      </div>

      <div class="product-div-right">
        <span class="product-name"><%=p.getName()%></span>
        <span class="product-price">€<%=p.getPrice()%></span>


        <p class="product-description"> <%=p.getDescription()%></p>
        <div class="btn-groups">
          <%if(session.getAttribute("login")==null){%>
            <form action="AddCartSession" method="post">
          <%}else{%>
            <form action="AddCartServlet" method="post">
          <%}%>
              <input type="hidden" name="id" value="<%=p.getId()%>"/>
              <input class="quantity" type="number" name="quantity" min=1  value="1">
              <%if(session.getAttribute("login")!=null){%>
              <input type="hidden" name="email" value="<%=utente.getEmail()%>"/>
              <%}%>
              <input class="add-cart-btn" type="submit" value="Acquista"/>
            </form>
        </div>
      </div>
    </div>
  </div>
</div>
<%@ include file="/WEB-INF/navbar/footer.jsp" %>
</body>
</html>
