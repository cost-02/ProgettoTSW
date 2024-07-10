package controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@WebServlet(name = "OrderServlet", value = "/OrderServlet")
public class OrderServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");
        String address = null;
        String email = request.getParameter("email");
        if(action.equals("checkout")){
            CarrelloDAO cDAO = new CarrelloDAO();
            ArrayList<Carrello> carts = cDAO.doRetrieveAll();
            PagamentoDAO pDAO = new PagamentoDAO();
            ArrayList<Pagamento> creditCards = pDAO.doRetriveByEmail(email);
            request.setAttribute("carts", carts);
            request.setAttribute("creditCards", creditCards);
            address = "./WEB-INF/results/checkout.jsp";

            RequestDispatcher ds = request.getRequestDispatcher(address);
            ds.forward(request, response);
        }
        if(action.equals("inserisci")){

            PagamentoDAO pDAO = new PagamentoDAO();
            int id = Integer.parseInt((request.getParameter("id")));
            Pagamento p = pDAO.doRetriveById(id);

            ObjectMapper objectMapper = new ObjectMapper();
            String jsonData = objectMapper.writeValueAsString(p);

            //Imposta la risposta
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(jsonData);

        }
        if(action.equals("Acquista")){
            Ordine o = new Ordine();

            o.setPhone_number(request.getParameter("phone_number"));
            o.setCity(request.getParameter("city"));
            o.setProvince(request.getParameter("province"));
            o.setVia(request.getParameter("street"));
            o.setHouse_number(request.getParameter("street_number"));
            o.setCap(request.getParameter("cap"));
            o.setTotal(Double.parseDouble(request.getParameter("total")));

            String check = null;

            if(this.checkParametresAddress(o)){
                o.setEmail_user(email);

                Pagamento p = new Pagamento();

                CarrelloDAO cDAO = new CarrelloDAO();
                ArrayList<Carrello> carts = cDAO.doRetrieveByEmail(email);

                PagamentoDAO pDAO = new PagamentoDAO();
                String result = null;

                if(request.getParameter("cardId").equals("insert")){
                    p.setCvv(Integer.parseInt(request.getParameter("cvv")));
                    p.setHolder(request.getParameter("holder"));
                    p.setExpYear(Integer.parseInt(request.getParameter("expMonth")));
                    p.setExpYear(Integer.parseInt(request.getParameter("expYear")));
                    p.setId(pDAO.doInsert(p));
                    if(p.getId()!=0){
                        p.setNumber(Long.parseLong(request.getParameter("creditCardNumber")));

                        OrdineDAO oDAO = new OrdineDAO();
                        if(oDAO.doInsert(o, p.getId(), carts)!=1) {
                            check = "L'ordine non è andato a buon fine!";
                            request.setAttribute("check", check);
                            carts = cDAO.doRetrieveAll();
                            ArrayList<Pagamento> creditCards = pDAO.doRetriveByEmail(email);
                            request.setAttribute("carts", carts);
                            request.setAttribute("creditCards", creditCards);
                            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/results/checkout.jsp");
                            rd.include(request, response);
                        }else{
                            //Ordine avvenuto con successo!
                            cDAO.doDeleteByEmail(email);
                            response.sendRedirect(request.getContextPath() + "/index.jsp");
                        }

                    }else{
                        check = "L'ordine non è andato a buon fine!";
                        request.setAttribute("check", check);
                        carts = cDAO.doRetrieveAll();
                        ArrayList<Pagamento> creditCards = pDAO.doRetriveByEmail(email);
                        request.setAttribute("carts", carts);
                        request.setAttribute("creditCards", creditCards);
                        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/results/checkout.jsp");
                        rd.include(request, response);
                    }
                }else{
                    p.setId(Integer.parseInt(request.getParameter("cardId")));
                    OrdineDAO oDAO = new OrdineDAO();
                    if(oDAO.doInsert(o, p.getId(), carts)!=1) {
                        check = "L'ordine non è andato a buon fine!";
                        request.setAttribute("check", check);
                        carts = cDAO.doRetrieveAll();
                        ArrayList<Pagamento> creditCards = pDAO.doRetriveByEmail(email);
                        request.setAttribute("carts", carts);
                        request.setAttribute("creditCards", creditCards);
                        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/results/checkout.jsp");
                        rd.include(request, response);
                    }else {
                        //Ordine avvenuto con successo!
                        cDAO.doDeleteByEmail(email);
                        response.sendRedirect(request.getContextPath() + "/index.jsp");
                    }
                }

            }else{
                check = "Parametri Indirizzo errati!";
                request.setAttribute("check", check);
                CarrelloDAO cDAO = new CarrelloDAO();
                ArrayList<Carrello> carts = cDAO.doRetrieveAll();
                PagamentoDAO pDAO = new PagamentoDAO();
                ArrayList<Pagamento> creditCards = pDAO.doRetriveByEmail(email);
                request.setAttribute("carts", carts);
                request.setAttribute("creditCards", creditCards);
                RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/results/checkout.jsp");
                rd.include(request, response);
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    private boolean checkParametresAddress(Ordine o){

        // Creare il pattern utilizzando la regex
        Pattern pPhoneNumber = Pattern.compile("^((00|\\+)\\d{2}[\\. ]??)??3\\d{2}[\\. ]??\\d{6,7}([\\,\\;]((00|\\+)\\d{2}[\\. ]??)??3\\d{2}[\\. ]??\\d{6,7})*$");
        Pattern pCity = Pattern.compile("^[a-zA-Z' ']*$");
        Pattern pProvince = Pattern.compile("^[a-zA-Z]{2}$");
        Pattern pStreet = Pattern.compile("^[a-zA-Z' ']*$");
        Pattern pStreetNumber = Pattern.compile("^[0-9]*$");
        Pattern pCap = Pattern.compile("^[0-9]{5}$");

        // Verifica la stringa data con il pattern
        Matcher mPhoneNumber = pPhoneNumber.matcher(o.getPhone_number());
        Matcher mCity = pCity.matcher(o.getCity());
        Matcher mProvince = pProvince.matcher(o.getProvince());
        Matcher mStreet = pStreet.matcher(o.getVia());
        Matcher mStreetNumber = pStreetNumber.matcher(o.getHouse_number());
        Matcher mCap = pCap.matcher(o.getCap());

        // controlla se è stata trovata una corrispondenza
        boolean matchFound = mPhoneNumber.matches() && mCity.matches() && mProvince.matches() && mStreet.matches() && mStreetNumber.matches() && mCap.matches();

        // convalida
        if (matchFound && o.getVia().length() <= 50 && o.getCity().length() <= 50 && String.valueOf(o.getHouse_number()).length() <= 3  ) {
            return true;
        } else {
            return false;
        }
    }
}