<%@ page import="model.Prodotto" %>
<%@ page import="java.util.Random" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" type="text/css" href="./css/product.css?v=<%=new Random().nextInt()%>"/>
  <%--    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>--%>
  <script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>

  <script type="text/javascript">

    $(document).ready(function(){
      $('.list').click(function(){
        const value = $(this).attr('data-filter');
        if(value == 'Speciali'){
          $('.product-container').show('1000');
        }
      })
      $('.list').click(function (){
        $(this).addClass('active').siblings().removeClass('active');
      })
    })

  </script>

  <%
    ArrayList<Prodotto> products = (ArrayList<Prodotto>) request.getAttribute("product");
  %>
  <title>Prodotti</title>


</head>
<body>
<%@ include file="/WEB-INF/navbar/navbar.jsp" %>
<section class="home_ord" id="home_prod">
  <div class="container_ord">
    <h3> Specialità </h3>
  </div>
</section>

<section>
  <ul>
    <li class="list active" data-filter="Speciali">Speciali</li>
  </ul>
</section>

<div class="container">
  <h3 class="title" align="center"></h3>
  <div class="product-container">

    <%
      for(Prodotto p : products)
        if(p.getNameCategory().equals("Speciale")){
    %>

    <div class="card">
      <%if(session.getAttribute("login")==null){%>
      <form action="AddCartSession" method="post">
          <%}else{%>
        <form action="AddCartServlet" method="post">
          <%}%>
          <div class="imgbox">
            <img src="upload/<%=p.getImage()%>" alt="Card 1">
          </div>
          <div class="content">
            <h2><%=p.getName()%></h2>
            <div class="price">€<%=p.getPrice()%></div>
            <input type="hidden" name="id" value="<%=p.getId()%>"/>
            <input type="hidden" name="quantity" min=1  value="1"/>
            <%if(session.getAttribute("login")!=null){%>
            <input type="hidden" name="email" value="<%=utente.getEmail()%>"/>
            <%}%>
            <p>
            <div class="buttons">
              <input class="add-to-cart" type="submit" value="Acquista"/>
              <a href="ProductServlet?id=<%=p.getId()%>" class="view-more" >Dettagli</a>
            </div>
            </p>
          </div>
        </form>
    </div>
    <%
        }
    %>
  </div>
  <br>
</div>

<%@ include file="/WEB-INF/navbar/footer.jsp" %>
</body>
</html>