<%@ page import="model.Carrello" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Prodotto" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" type="text/css" href="./css/cart.css?v=<%=new Random().nextInt()%>"/>

  <title>Carrello</title>
</head>
<body>
<%@ include file="/WEB-INF/navbar/navbar.jsp" %>
<div>
  <div class="home_ord">
    <h3> CARRELLO </h3>
  </div>

    <%
//loggato
  if(utente!=null){
    ArrayList<Carrello> carts = (ArrayList<Carrello>) request.getAttribute("carts");
    if(carts!=null && !carts.isEmpty()){
  %>
  <h1 class="main-title"> <%=utente.getName()%>, ecco il tuo carrello:  </h1>
  <div class="tabular--wrapper">
    <div class="table-container">
      <table>
        <tr>
          <th> Prodotto </th>
          <th> Quantità </th>
          <th> SubTotale </th>
        </tr>
        <%
          double total=0;
          for(Carrello c : carts){
            if(c.getEmail().equals(utente.getEmail())){
              Prodotto p = c.getProducts();
        %>
        <tr>
          <td>
            <div class="cart-info">
              <img class="ord-img" src="upload/<%=p.getImage()%>">
              <div>
                <p><%=p.getName()%></p>
                <small id="price<%=p.getId()%>">€<%=p.getPrice()%></small>
                <a class="remove_prod"  href="ManageCart?action=removeProduct&id=<%=p.getId()%>&email=<%=utente.getEmail()%>">Rimuovi</a>
                <%total+=(p.getPrice()*c.getQuantity());%>
              </div>
            </div>
          </td>
          <td><input type="number" id="num_<%=p.getId()%>" name="quantity" min=1 value="<%=c.getQuantity()%>" onchange="changeQuantity('<%=p.getId()%>')"></td>
          <td>€<%=p.getPrice()*c.getQuantity()%></td>
        </tr>
        <%
            }
          }
        %>
      </table>
      <input type="hidden" id="email" value="<%=utente.getEmail()%>">
      <div class="total-price">
        <table>
          <tr>
            <td> Total </td>
            <td>€<%=total%></td>
          </tr>
          <tr>
            <td><button class="submit-ord" onclick="location.href='OrderServlet?action=checkout&email=<%=utente.getEmail()%>'">Procedi all'ordine</button></td>
          </tr>
        </table>
      </div>
    </div>

  </div>
    <%
    }else{
//loggato senza prodotti
    %>
  <h1 class="main-title"> <%=utente.getName()%> il tuo carrello è vuoto!  </h1>
  <h3 class="main-title"> <button class="send_prod" onclick="location.href='InitServlet?action=product'"> Vai allo Shop </button></h3>

<%
    }
//non loggato
    }else{
      ArrayList<Carrello> carts = (ArrayList<Carrello>) session.getAttribute("carts");
      if(carts!=null && !carts.isEmpty()){
    %>
  <h1 class="main-title"> Ecco il tuo carrello: </h1>
  <div class="tabular--wrapper">
    <div class="table-container">
      <table>
        <tr>
          <th> Prodotto </th>
          <th> Quantità </th>
          <th> SubTotale </th>
        </tr>
        <%
          double total=0;
          for(Carrello c : carts){
            Prodotto p = c.getProducts();
        %>
        <tr>
          <td>
            <div class="cart-info">
              <img class="ord-img" src="upload/<%=p.getImage()%>">
              <div>
                <p><%=p.getName()%></p>
                <small><%=p.getPrice()%></small>
                <a class="remove_prod" href="ManageCart?action=removeProductSession&id=<%=p.getId()%>">Rimuovi</a>
                <%total+=(p.getPrice()*c.getQuantity());%>
              </div>
            </div>
          </td>
          <td><input type="number" id="num_<%=p.getId()%>" name="quantity" min=1 value="<%=c.getQuantity()%>" onchange="changeQuantitySession('<%=p.getId()%>')"></td>
          <td><%=p.getPrice()*c.getQuantity()%></td>
        </tr>
        <%
          }
        %>
      </table>

      <div class="total-price">
        <table>
          <tr>
            <td> Total </td>
            <td><%=total%></td>
          </tr>
          <tr>
            <td><button class="submit-ord" onclick="location.href='InitServlet?action=login'">Procedi all'ordine</button></td>
          </tr>
        </table>
      </div>
    </div>
  </div>
    <%
  //non loggato senza prodotti
    }else{
%>

    <div class="main-prod"> Il tuo carrello è vuoto!</div>
      <h3 class="main-title"> <button class="send_prod" onclick="location.href='InitServlet?action=product'"> Vai allo Shop </button></h3>

    <%
    }
  }
  %>
</body>

<script>
  function changeQuantity(id){
    var email = document.getElementById("email").value;
    var inputElement = document.getElementById('num_' + id);
    var quantity = inputElement.value;

    var xhr = new XMLHttpRequest();
    xhr.open("POST", "ManageCart", true); //richiesta asincrona
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"); //necessario nella post, non indispensabile nel get

    var params = "action=changeQuantity&id=" + encodeURIComponent(id) +
            "&email=" + encodeURIComponent(email) +
            "&quantity=" + encodeURIComponent(quantity);

    xhr.send(params);
    setTimeout(function() {
      location.reload();
    }, 100);
  }

  function changeQuantitySession(id){
    var inputElement = document.getElementById('num_' + id);
    var quantity = inputElement.value;

    var xhr = new XMLHttpRequest();
    xhr.open("POST", "ManageCart", true); //richiesta asincrona
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

    var params = "action=changeQuantitySession&id=" + encodeURIComponent(id) +
            "&quantity=" + encodeURIComponent(quantity);

    xhr.send(params);
    setTimeout(function() {
      location.reload();
    }, 100);
  }

  function remove(id){
    var email = document.getElementById("email").value;
    var xhr = new XMLHttpRequest();

    xhr.open("POST", "ManageCart", true); //richiesta asincrona
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

    var params = "action=removeProduct&id=" + encodeURIComponent(id) +
            "&email=" + encodeURIComponent(email);
    xhr.send(params);
    setTimeout(function() {
      location.reload();
    }, 100);
  }
</script>

</html>