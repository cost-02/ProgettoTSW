package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Utente;
import model.UtenteDAO;

import java.io.IOException;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@WebServlet(name = "RegistrationServlet", value = "/process_registration")
public class RegistrationServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String check;
        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String surname = request.getParameter("surname");
        String password = request.getParameter("password");

        Utente utente = new Utente();
        utente.setEmail(email);
        utente.setName(name);
        utente.setSurname(surname);
        utente.setPassword(password);

        // Creare il pattern utilizzando la regex
        Pattern pEmail = Pattern.compile(".+@.+\\.[a-z]+");
        Pattern pPass = Pattern.compile("^[a-zA-Z0-9!@#$%^&*]*$");
        Pattern pName = Pattern.compile("^[a-zA-Z' ']*$");
        Pattern pSurname = Pattern.compile("^[a-zA-Z' ']*$");
        // Verifica la stringa data con il pattern
        Matcher mEmail = pEmail.matcher(email);
        Matcher mPass = pPass.matcher(password);
        Matcher mName = pName.matcher(name);
        Matcher mSurname = pSurname.matcher(surname);
        // controlla se è stata trovata una corrispondenza
        boolean matchFound = mEmail.matches() && mPass.matches() && mName.matches() && mSurname.matches();

        StringTokenizer st = new StringTokenizer(email, ".");
        String lastToken = null;
        while (st.hasMoreTokens()) {
            lastToken = st.nextToken();
        }

        // convalida
        if (matchFound && lastToken.length() >= 2 && email.length() - 1 != lastToken.length() && password.length() >=8 ) {
            request.getSession().setAttribute("utente", utente);

            if (UtenteDAO.checkEmail(request.getParameter("email"))) {
                request.setAttribute("check", "E-mail già presente!");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/results/register.jsp");
                dispatcher.forward(request, response);
            } else {
                UtenteDAO.doRegistration(utente);
                check = "Registrazione andata a buon fine!";
                request.setAttribute("check", check);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/results/login.jsp");
                dispatcher.forward(request, response);
            }
        } else {
            check = "Registrazione non andata a buon fine!";
            request.setAttribute("check", check);
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/results/register.jsp");
            rd.include(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher ds = request.getRequestDispatcher("/WEB-INF/results/login.jsp");
        ds.forward(request, response);
//        doPost(request, response);
    }
}


