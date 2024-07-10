<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Random" %>
<%@ page import="model.Categoria" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="./css/admin/manageCategory.css?v=<%=new Random().nextInt()%>"/>
    <title>Categorie</title>
</head>
<body>
<%@ include file="/WEB-INF/navbar/navbarAdmin.jsp" %>

<%  ArrayList<Categoria> categories = (ArrayList<Categoria>) request.getAttribute("categories");%>

<div class="tabular--wrapper">
    <div class="table-container">
        <table id="categories">
            <thead>
            <tr>
                <th>NOME</th>
                <th>DESCRIZIONE</th>
            </tr>
            </thead>
            <br>
            <%
                for(Categoria c : categories){
            %>
            <tbody>
            <tr>
                <td><%=c.getName()%><button class="btn_mod_cat" value=" " onclick="location.href='ManageCategory?action=<%=c.getName()%>'">Modifica categoria</button></td>
                <td><%=c.getDescription()%></td>

            </tr>
            </tbody>
            <%
                }
            %>
        </table>
    </div>
</div>



</body>
</html>