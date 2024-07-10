<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Random" %>

<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" type="text/css" href="./css/admin/manageUsers.css?v=<%=new Random().nextInt()%>"/>
  <title>Utenti</title>
</head>
<body>
<%@ include file="/WEB-INF/navbar/navbarAdmin.jsp" %>

<div>
  <div class="home_ord">
    <h3> UTENTI </h3>
  </div>
  <h1 class="main-title"> Ecco la lista di tutti gli utenti  </h1>
  <div class="tabular--wrapper">
    <div class="table-container">
      <%
        ArrayList<Utente> users = (ArrayList<Utente>) request.getAttribute("users");

      %>
      <table>
        <thead>
        <tr>
          <th>Nome</th>
          <th>Cognome</th>
          <th>Email</th>
          <th>Admin</th>
          <th></th>
          <th></th>

        </tr>
        </thead>
        <br>
        <% for(Utente u : users){ %>
        <tbody>
        <tr>
          <td><%=u.getName()%></td>
          <td><%=u.getSurname()%></td>
          <td class="emailUser" id="<%=u.getEmail()%>"><%=u.getEmail()%></td>
          <td class="isAdmin"><%=u.isAdmin()%></td>
          <%if(utente.getEmail().equals(u.getEmail())){%>
          <td><button class="btn-user"><a class="link-user-disabled">Rendi Admin</a></button></td>
          <td><button class="btn-user"><a class="link-user-disabled">Rimuovi Admin</a></button></td>
          <%}else{%>
          <td><button class="btn-user"><a class="link-user-rendi" onclick="addAdmin('<%=u.getEmail()%>')" id="btn-add">Rendi Admin</a></button></td>
          <td><button class="btn-user"><a class="link-user-remove" onclick="removeAdmin('<%=u.getEmail()%>')">Rimuovi Admin</a></button></td>
          <%}%>
        </tr>

        </tbody>
        <%
          }   %>
      </table>
      <p id="bodyResponse"></p>
    </div>
  </div>
</div>

<script>

  function addAdmin(email){
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function (){
      if(xhr.readyState == 4 && xhr.status == 200){
        var users = document.getElementsByClassName("isAdmin");
        var object = JSON.parse(xhr.responseText);
        for (var i = 0; i < users.length; i++) {
          var user = users[i];
          var valueAdmin = object[i].admin;
          user.innerHTML = valueAdmin;
        }
      }
    };
    xhr.open("POST", "ManageAdministrator?action=addAdmin" + email, true);
    xhr.send();
  }

  function removeAdmin(email){
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function (){
      if(xhr.readyState == 4 && xhr.status == 200){

        var users = document.getElementsByClassName("isAdmin");
        var object = JSON.parse(xhr.responseText);
        for (var i = 0; i < users.length; i++) {
          var user = users[i];
          var valueAdmin = object[i].admin;
          user.innerHTML = valueAdmin;
        }
      }
    };
    xhr.open("POST", "ManageAdministrator?action=removeAdmin" + email, true);
    xhr.send();
  }
</script>

</body>
</html>
