<%@ page import="model.Prodotto" %>
<%@ page import="java.util.Random" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="./css/admin/productAdmin.css?v=<%=new Random().nextInt()%>"/>
    <%
        Prodotto p = (Prodotto) request.getAttribute("product");
    %>
    <title><%=p.getName()%></title>
    <script>
        function validateUpdate() {
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

            return true;
        }

        function confirmDelete(id){
            if(confirm("Sei sicuro di voler eliminare il prodotto??")){
                var xhr = new XMLHttpRequest();
                xhr.onreadystatechange = function (){
                    if(xhr.readyState == 4 && xhr.status == 200){
                        alert(xhr.responseText)
                        window.location.href="HomeServletAdministrator?action=homeAdmin";
                    }
                };
                xhr.open("POST", "UpdateProduct?action=ELIMINA&id=" + id, true);
                xhr.send();
            }else{
                alert("eliminazione annullata");

            }
        }
    </script>
</head>
<body>
<%@ include file="/WEB-INF/navbar/navbarAdmin.jsp" %>

<div class="update_product">
    <form action="UpdateProduct"  method="POST">

        <h3 class="add_prod_title">Modifica Prodotto</h3>

        <label for="id">id: </label>
        <input id="id" name="id" type="text" value="<%=p.getId()%>" readonly>

        <label for="name"> Nome: </label>
        <input id="name" name="name" type="text" value="<%=p.getName()%>" maxlength="50">

        <label for="price">prezzo: </label>
        <input id="price" name="price" type="text" value="<%=p.getPrice()%>">

        <label for="image">Immagine: (il nome del file deve essere di max 20 caratteri)</label>
        <input type="file" id="image" name="image" value="<%=p.getImage()%>"><br>

        <label for="categories">Nome categoria: </label>
        <select id="categories" name="categories">

            <%
                ArrayList<String> categories = (ArrayList<String>) request.getAttribute("categories");
                for(String c : categories){
                    if(c.equals(p.getNameCategory())){
            %>
            <option value="<%=c%>" selected><%=c%></option>
            <%      }else{
            %>
            <option value="<%=c%>"><%=c%></option>
            <%      }
            }
            %>
        </select><br>

        <label for="description">descrizione: </label>
        <textarea name="description" id="description" style="height:200px" maxlength="500"><%=p.getDescription()%></textarea>
        <div class="btnadd">
            <input class="btn_update" type="submit" name="action" value="AGGIORNA" onclick="return(validateUpdate())">
        </div>
    </form>
    <input class="btn_delete" type="submit" name="action" value="ELIMINA" onclick="return(confirmDelete(<%=p.getId()%>))">

</div>
</body>
</html>