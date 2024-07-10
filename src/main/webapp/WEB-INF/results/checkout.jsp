<%@ page import="java.util.Random" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" type="text/css" href="./css/checkout.css?v=<%=new Random().nextInt()%>"/>

</head>
<body>
<%@ include file="/WEB-INF/navbar/navbar.jsp" %>
<%
  ArrayList<Carrello> carts = (ArrayList<Carrello>) request.getAttribute("carts");
  ArrayList<Pagamento> creditCards = (ArrayList<Pagamento>) request.getAttribute("creditCards");
%>
<div class="container">

  <div class="col-metod">
    <h3 class="title">METODO DI PAGAMENTO</h3>

    <div class="tabular--wrapper">
      <div class="table-container">
        <table>
          <tr>
            <th> Numero </th>
            <th> Titolare carta </th>
            <th> Data di scadenza </th>
            <th> </th>
          </tr>
          <%
            int i=0;
            for(Pagamento p : creditCards){
              String number = String.valueOf(p.getNumber()).substring(String.valueOf(p.getNumber()).length()-4);
          %>
          <tr>
            <td>termina con <%=number%></td>
            <td><%=p.getHolder()%></td>
            <td><%=p.getExpMonth()%>/<%=p.getExpYear()%></td>
            <td><button class="btn-user"><a class="link-user-rendi" onclick="insertCard(<%=p.getId()%>)">Seleziona metodo</a></button></td>
          </tr>
          <%
              i++;
            }
          %>
        </table>
      </div>
    </div>
  </div><br><br>

  <form action="OrderServlet" method="post">

    <div class="row">
      <div class="col">
        <h3 class="title">indirizzo</h3>
        <div class="inputBox">
          <span>telefono :</span>
          <input type="text" name="phone_number" id="phone_number" maxlength="10" <%if(utente.getPhone_number()!=null){%>value="<%=utente.getPhone_number()%>"<%}%> placeholder="3333333333">
        </div>
        <div class="inputBox">
          <span>citta' :</span>
          <input type="text" name="city" id="city" maxlength="50" <%if(utente.getCity()!=null){%>value="<%=utente.getCity()%>"<%}%> placeholder="Agropoli">
        </div>
        <div class="inputBox">
          <span>provincia :</span>
          <input type="province" name="province" id="province" maxlength="2" <%if(utente.getProvince()!=null){%>value="<%=utente.getProvince()%>"<%}%> placeholder="SA">
        </div>
        <div class="inputBox">
          <span>Indirizzo :</span>
          <input type="text" name="street" id="street" maxlength="50" <%if(utente.getStreet()!=null){%>value="<%=utente.getStreet()%>"<%}%> placeholder="Via Rossi">
        </div>

        <div class="flex">
          <div class="inputBox">
            <span>Num. civico</span>
            <input type="text" name="street_number" id="street_number" maxlength="3" <%if(utente.getStreet()!=null){%>value="<%=utente.getStreet_number()%>"<%}%> placeholder="15">
          </div>
          <div class="inputBox">
            <span>CAP :</span>
            <input type="text" name="cap" id="cap" maxlength="5" <%if(utente.getCap()!=null){%>value="<%=utente.getCap()%>"<%}%> placeholder="84070">
          </div>
        </div>
      </div>

      <div class="col">
        <h3 class="title">pagamento</h3>
          <input type="hidden" name="cardId" id="cardId" value="insert">
        <div class="inputBox">
          <span>carte accettate :</span>
          <img src="./images/card_img.png" alt="mastercard - visa - paypal">
        </div>
        <div class="inputBox">
          <span>titolare della carta :</span>
          <input type="text" name="holder" id="holder" placeholder="Mario Rossi">
        </div>
        <div class="inputBox">
          <span>numero carta di credito :</span>
          <input type="text" name="creditCardNumber" id="creditCardNumber"  maxlength="16" placeholder="1111 2222 3333 4444">
        </div>
        <div class="inputBox">
          <span>CVV :</span>
          <input type="text" name="cvv" id="cvv" maxlength="3" placeholder="123">
        </div>

        <span>Data di scadenza</span>
        <div class="flex">
          <div class="inputBox">
            <span>mese :</span>
            <input  type="text" name="expMonth" id="expMonth"  maxlength="2" placeholder="01">
          </div>
          <div class="inputBox">
            <span>anno :</span>
            <input type="text" name="expYear" id="expYear" maxlength="4" placeholder="2035">
          </div>
        </div>
      </div>

      <div class="col">
        <h3 class="title">prodotti</h3>

        <div class="tabular--wrapper">
          <div class="table-container">
            <table>
              <tr>
                <th> Prodotto </th>
                <th> Quantita' </th>
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
                      <small id="price<%=p.getId()%>"><%=p.getPrice()%></small>
                      <a class="link-user" onclick="remove(<%=p.getId()%>)">Rimuovi</a>
                      <%total+=(p.getPrice()*c.getQuantity());%>
                    </div>
                  </div>
                </td>
                <td><input type="number" id="num_<%=p.getId()%>" name="quantity" min=1 value="<%=c.getQuantity()%>" onchange="changeQuantity('<%=p.getId()%>')"></td>
                <td><%=p.getPrice()*c.getQuantity()%></td>
              </tr>
              <%
                  }
                }
              %>
            </table>

            <div class="total-price">
              <table>
                <tr>
                  <td> Total </td>
                  <td><input type="text" name="total" id="total" value="<%=total%>" readonly/></td>
                </tr>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
    <input type="hidden" id="email" name="email" value="<%=utente.getEmail()%>"/>
    <%if(total==0){
    %>
    <div class="return">
      <a class="return-prod" href="InitServlet?action=product">RITORNA AI PRODOTTI</a>
    </div>
    <%
      }else{
    %>
    <input type="submit" name="action" onclick="return(validateOperation())" value="Acquista" class="submit-btn"/>
    <%}%>
  </form>
  <%if(request.getAttribute("check")!=null){%>
  <input type="hidden" id="check" value="<%=request.getAttribute("check")%>">
  <%}%>
</div>

<script>
  if(document.getElementById("check").value!=null)
    alert(document.getElementById("check").value);
  //REGEX VALIDA OPERAZIONI
  function validateOperation(){

  var phone_numberRGX = /^((00|\+)\d{2}[\. ]??)??3\d{2}[\. ]??\d{6,7}([\,\;]((00|\+)\d{2}[\. ]??)??3\d{2}[\. ]??\d{6,7})*$/;
  var phone_number = document.getElementById('phone_number').value;
  var resultPhone_number = phone_numberRGX.test(phone_number);
  if (resultPhone_number == false) {
    alert("Il numero di telefono non rispecchia il formato corretto. Riprovare");
    return false;
  }

  var cityRGX=/^[a-zA-Z' ']*$/;
  var city=document.getElementById('city').value;
  if((cityRGX.test(city))==false){
    alert("Citta' non valido!");
    return false;
  }
  if((city.length>50 ))
  {
    alert("Dimensione città non valida!");
    return false;
  }

  var streetRGX=/^[a-zA-Z' ']*$/;
  var street=document.getElementById('street').value;
  if((streetRGX.test(street))==false){
    alert("Indirizzo non valido!");
    return false;
  }
  if((street.length>50))
  {
    alert("Dimensione indirizzo non valida!");
    return false;
  }

  var street_numberRGX=/^[0-9]*$/;
  var street_number=document.getElementById('street_number').value;
  if((street_numberRGX.test(street_number))==false){
    alert("Numero civico non valido!");
    return false;
  }
  if((street_number.length>3))
  {
    alert("Dimensione numero civico non valida!");
    return false;
  }

  var provinceRGX=/^[a-zA-Z]{2}$/;
  var province=document.getElementById('province').value;
  if((provinceRGX.test(province))==false){
    alert("Provincia non valido!");
    return false;
  }

  var capRGX=/^[0-9]{5}$/;
  var cap=document.getElementById('cap').value;
  if((capRGX.test(cap))==false){
    alert("CAP non valido!");
    return false;
  }

  var holderRGX=/^[a-zA-Z' ']*$/;
  var holder=document.getElementById('holder').value;
  if((holderRGX.test(holder))==false){
    alert("Titolare non valido!");
    return false;
  }
  if((holder.length>50))
  {
    alert("Dimensione titolare non valida!");
    return false;
  }

  if(document.getElementById("cardId").value=="insert"){
    var number =document.getElementById('creditCardNumber').value;
    var numberRGX = /^[0-9]*$/;
    if((numberRGX.test(number)) == false){
      alert("Formato del numero carta non valido!");
      return false;
    }
    if(number.length != 16)
    {
      alert("Dimensione del numero di carta errato!");
      return false;
    }

    var cvvRGX=/^[0-9]{3}$/;
    var cvv=document.getElementById('cvv').value;
    if((cvvRGX.test(cvv))==false){
      alert("CVV non valido!");
      return false;
    }
    if(cvv.length != 3)
    {
      alert("Dimensione del numero di carta errato!");
      return false;
    }
  }

  var expMonthRGX=/^[0-9]{1,2}$/;
  var expMonth=document.getElementById('expMonth').value;
  if((expMonthRGX.test(expMonth))==false){
    alert("Mese di scadenza non valido!");
    return false;
  }

  var expYearRGX=/^[0-9]{4}$/;
  var expYear=document.getElementById('expYear').value;
  if((expYearRGX.test(expYear))==false){
    alert("Anno di scadenza non valido!");
    return false;
  }

  return true;
}


  function changeQuantity(id){
    var email = document.getElementById("email").value;
    var inputElement = document.getElementById('num_' + id); //elemento che contiene la quantità
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

  function remove(id){
    var email = document.getElementById("email").value;
    var xhr = new XMLHttpRequest();

    xhr.open("POST", "ManageCart", true); //richiesta asincrona
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"); //necessario nella post, non indispensabile nel get

    var params = "action=removeProduct&id=" + encodeURIComponent(id) +
                 "&email=" + encodeURIComponent(email);
    xhr.send(params);
    setTimeout(function() {
      location.reload();
    }, 100);
  }

  function insertCard(id){
    var email = document.getElementById("email").value;

    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function (){
      if(xhr.readyState == 4 && xhr.status == 200){

        var object = JSON.parse(xhr.responseText);
        document.getElementById("holder").value = object.holder;
        document.getElementById("creditCardNumber").value = "metodo selezionato";
        document.getElementById("cvv").value = "metodo selezionato";
        document.getElementById("expMonth").value = object.expMonth;
        document.getElementById("expYear").value = object.expYear;
        document.getElementById("cardId").value = object.id;
      }
    };
    xhr.open("POST", "OrderServlet?action=inserisci&email=" + email + "&id=" + id, true);
    xhr.send();
  }
</script>

</body>
</html>
