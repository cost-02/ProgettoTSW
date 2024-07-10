<%@ page import="java.util.Random" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" type="text/css" href="./css/admin/addCategory.css?v=<%=new Random().nextInt()%>"/>
  <title>Inserisci Categoria</title>
  <script>
    function validateInsert() {
      var nameRGX=/^[a-zA-Z' ']*$/;
      var name=document.getElementById('name').value;
      if((nameRGX.test(name))==false){
        alert("Nome non valido!");
        return false;
      }

      var price=document.getElementById('price').value;
      var priceRGX=/^[0-9'.']*$/;
      if(priceRGX.test(price)==false){
        alert("Errore nella definizione del prezzo: usare il '.' invece della ','");
        return false;
      }

      var filePart=document.getElementById('image').value;;
      if(filePart.length>32){
        alert("Nome immagine massimo 20 caratteri");
        return false;
      }

      return true;
    }
  </script>
</head>
<body>
<%@ include file="/WEB-INF/navbar/navbarAdmin.jsp" %>

<div class="category">
    <form action="UpdateCategory"  method="POST">

        <h3 class="add_prod_title">Aggiungi Categoria</h3>

        <label for="name"> Nome: </label>
        <input id="name" name="name" type="text" value="" maxlength="50">

        <label for="description">Descrizione: </label>
        <textarea class="box" name="description" id="description" style="height:200px" maxlength="200"></textarea>

        <input class="btn_add" type="submit" name="action" value="AGGIUNGI CATEGORIA" onclick="return(validateInsert())">

    </form>
</div>

</body>
</html>
