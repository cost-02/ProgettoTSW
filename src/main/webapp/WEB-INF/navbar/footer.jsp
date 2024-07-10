<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <link rel="stylesheet" type="text/css" href="css/footer.css?=<%=new Random().nextInt()%>"/>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
  <title>Footer</title>
</head>
<body>


<footer class="footer">
  <div class="container-footer">
    <div class="row-footer">
      <div class="footer-col">
        <h4>Conosciamoci</h4>
        <ul>
          <li><a href="InitServlet?action=contatti">contatti</a></li>
          <li><a href="InitServlet?action=product">prodotti</a></li>
          <li><a href="InitServlet?action=specialita">specialità</a></li>
        </ul>
      </div>
      <div class="footer-col">
        <h4>Creato da</h4>
        <ul>
          <li><a>Andrea Salurso</a></li>
          <li><a>Costantino Paciello</a></li>
        </ul>
      </div>
      <div class="footer-col">
        <h4>I nostri social </h4>
        <div class="social">
          <a href="https://www.facebook.com/" target="_blank"><i class="fab fa-facebook-f"></i></a>
          <a href="https://twitter.com/i/flow/login?redirect_after_login=%2Fhome%3F" target="_blank"><i class="fab fa-twitter"></i></a>
          <a href="https://www.instagram.com/forneriadelcilento/?utm_medium=copy_link" target="_blank"><i class="fab fa-instagram"></i></a>
          <a href="https://it.linkedin.com/?original_referer=https%3A%2F%2Fwww.google.com%2F" target="_blank"><i class="fab fa-linkedin-in"></i></a>

        </div>
      </div>
    </div>
  </div>
</footer>


</body>
</html>
