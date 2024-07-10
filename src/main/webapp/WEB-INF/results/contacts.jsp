<%@ page import="java.util.Random" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="./css/contacts.css?v=<%=new Random().nextInt()%>"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>

    <title>Contatti</title>

</head>
<body>
<%@ include file="/WEB-INF/navbar/navbar.jsp" %>

<div class="contactUs">
    <div class="title">
        <h2> Un po' di noi</h2>
    </div>
    <div class="box">

        <div class="contact form">

            <div class="img">
                <img src="./images/aboutimg.jpg">
            </div>

        </div>
        <div class="contact info">
            <h3> Contatti </h3>
            <div class="infoBox">
                <div>
                    <span><i class="fa-solid fa-map-pin"></i></span>
                    <p> Via Dante Alighieri, Agropoli <br> ITALY </p>
                </div>
                <div>
                    <span><i class="fa-regular fa-envelope"></i></span>
                    <a href="mailto:forneriadelcilento@gmail.com">forneriadelcilento@gmail.com</a>
                </div>
                <div>
                    <span><i class="fa-solid fa-phone"></i></span>
                    <a href="tel:0974 8466 63">0974 8466 63</a>
                </div>
                <ul class="sci">
                    <li><a href="https://it-it.facebook.com/"><i class="fa-brands fa-facebook"target="_blank"></i></a></li>
                    <li><a href="https://twitter.com/i/flow/login?redirect_after_login=%2Fhome%3F"target="_blank"><i class="fa-brands fa-twitter"></i></a></li>
                    <li><a href="https://it.linkedin.com/"target="_blank"><i class="fa-brands fa-linkedin-in"></i></a></li>
                    <li><a href="https://www.instagram.com/forneriadelcilento/" target="_blank"><i class="fa-brands fa-instagram"></i></a></li>
                </ul>
            </div>
        </div>
        <div class="contact map">
            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3040.699671422001!2d14.998644376480541!3d40.34900785975759!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x133bff930ea51f65%3A0x42f1a92494898c19!2spanificio%20Forneria%20del%20Cilento!5e0!3m2!1sit!2sit!4v1688395497202!5m2!1sit!2sit" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/navbar/footer.jsp" %>
</body>
</html>