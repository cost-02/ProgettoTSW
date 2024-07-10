package controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Utente;
import model.UtenteDAO;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name="ManageAdministrator", value="/ManageAdministrator")
public class ManageAdministrator extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        UtenteDAO uDAO = new UtenteDAO();

        if(action.contains("addAdmin")){
            String x[] = action.split("addAdmin");
            String email = x[1];
            uDAO.makeAdministrator(email);
            ArrayList<Utente> u = uDAO.doRetrieveAll();

            ObjectMapper objectMapper = new ObjectMapper();
            String jsonData = objectMapper.writeValueAsString(u);

//             Imposta la risposta
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(jsonData);
            request.setAttribute("users", u);
        }
        if(action.contains("removeAdmin")){
            String x[] = action.split("removeAdmin");
            String email = x[1];
            uDAO.removeAdministrator(email);
            ArrayList<Utente> u = uDAO.doRetrieveAll();

            ObjectMapper objectMapper = new ObjectMapper();
            String jsonData = objectMapper.writeValueAsString(u);

//             Imposta la risposta
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(jsonData);
            request.setAttribute("users", u);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}