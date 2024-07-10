<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Random" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="./css/admin/addProductAdmin.css?v=<%=new Random().nextInt()%>"/>
    <title>Inserisci prodotto</title>
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
                alert("Errore nella definizione del prezzo");
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

    <div class="container-info">
        <div class="add_product">
        <form action="InsertProduct" enctype="multipart/form-data" method="POST">
            <h3>Aggiungi Prodotto</h3>

                <label for="name"> Nome: </label>
                <input type="text" name="name" id="name" maxlength="50"  required>

                <label for="price"> Prezzo: </label>
                <input type="text" name="price" id="price" required>


            <input type="file" id="image" name="image" value="inserisci immagine">

            <label for="categories">Categoria: </label>
            <select id="categories" name="categories" required>
                <option value="Seleziona_categoria" disabled selected>Seleziona Categoria</option>
                <%
                    ArrayList<String> categories = (ArrayList<String>) request.getAttribute("categories");
                    for(String c : categories){
                %>
                <option value="<%=c%>"><%=c%></option>
                <%
                    }
                %>
            </select>

            <label for="description">Descrizione: </label>
            <textarea name="description" id="description" style="height:200px" maxlength="500"></textarea>

            <input class="btn_add" type="submit" name="action" value="AGGIUNGI PRODOTTO" onclick="return(validateInsert())">

        </form>
        </div>
    </div>


</body>
</html>
