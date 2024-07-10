<%@ page import="java.util.Random" %>
<html>
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" type="text/css" href="./css/account.css?v=<%=new Random().nextInt()%>"/>
  <title>Informazioni</title>
</head>
<body>
<%@ include file="/WEB-INF/navbar/navbar.jsp" %>
<div class="container">
  <h2 style="text-align: center;">Informazioni di <%=utente.getName()%></h2>
      <div class="form-group">
        <label for="nome">Nome:</label>
        <input type="text" id="nome" name="nome" value="<%=utente.getName()%>" disabled>
      </div>
      <div class="form-group">
        <label for="cognome">Cognome:</label>
        <input type="text" id="cognome" name="cognome" value="<%=utente.getSurname()%>" disabled>
      </div>
      <div class="form-group">
        <label for="email">Email:</label>
        <input type="email" id="email" name="email"  value="<%=utente.getEmail()%>" disabled>
      </div>
      <div class="form-group">
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" value="********" disabled>
      </div>
</div>
<%@ include file="/WEB-INF/navbar/footer.jsp" %>
</body>
</html>


