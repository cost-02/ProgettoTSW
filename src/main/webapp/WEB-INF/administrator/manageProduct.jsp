<%@ page import="model.Prodotto" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Random" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <link rel="stylesheet" type="text/css" href="./css/admin/manageProductAdmin.css?v=<%=new Random().nextInt()%>"/>
    <title>Gestione prodotti</title>
</head>
<body>
<%@ include file="/WEB-INF/navbar/navbarAdmin.jsp" %>

<div class="home_ord">
    <div class="cards-products">
        <%
            ArrayList<Prodotto> products = (ArrayList<Prodotto>) request.getAttribute("products");
            for(Prodotto p : products){
        %>

        <div class="card-product">
            <div class="card-body">
                <img class="card-img" src="upload/<%=p.getImage()%>" alt="Card image" width="600" height="400">
                <h4 class="card-title"><%=p.getName()%></h4>
                <div class="card-price"><%=p.getNameCategory()%></div>
                <div class="card-price">€<%=p.getPrice()%></div>
                <div class="div-btn">
                    <button class="btn-card" value=" " onclick="location.href='ManageProduct?action=<%=p.getId()%>'">Gestisci prodotto</button>
                </div>
            </div>
        </div>
        <%
            }
        %>
        <div class="clearfix"></div>
    </div>
</div>
</body>
</html>