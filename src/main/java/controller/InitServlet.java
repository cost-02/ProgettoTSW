package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "InitServlet", value = "/InitServlet")
public class InitServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        UtenteDAO uDAO = new UtenteDAO();
        Utente utente = UtenteDAO.doRetrieveByEmailPassword(request.getParameter("email"), request.getParameter("password"));
        if(action.equals("login")){
            RequestDispatcher ds = request.getRequestDispatcher("/WEB-INF/results/login.jsp");
            ds.forward(request, response);
        }
        if(action.equals("contatti")){
            RequestDispatcher ds = request.getRequestDispatcher("/WEB-INF/results/contacts.jsp");
            ds.forward(request, response);
        }
        if(action.equals("product")){
            ProdottoDAO pDAO = new ProdottoDAO();
            ArrayList<Prodotto> products = new ArrayList<Prodotto>();
            products = (ArrayList<Prodotto>) pDAO.doRetrieveAll();
            request.setAttribute("product", products);
            CategoriaDAO cDAO = new CategoriaDAO();
            ArrayList<Categoria> categories = cDAO.doRetrieveAll();
            request.setAttribute("categories", categories);
            RequestDispatcher ds = request.getRequestDispatcher("/WEB-INF/results/products.jsp");
            ds.forward(request, response);
        }
        if(action.equals("orders")){
            OrdineDAO oDAO = new OrdineDAO();
            ArrayList<Ordine> orders = new ArrayList<>();
            orders = (ArrayList<Ordine>) oDAO.doRetrieveAll();
            request.setAttribute("orders", orders);
            RequestDispatcher ds = request.getRequestDispatcher("/WEB-INF/results/orders.jsp");
            ds.forward(request, response);
        }
        if(action.equals("specialita")){
            ProdottoDAO pDAO = new ProdottoDAO();
            ArrayList<Prodotto> products = new ArrayList<Prodotto>();
            products = (ArrayList<Prodotto>) pDAO.doRetrieveAll();
            request.setAttribute("product", products);
            RequestDispatcher ds = request.getRequestDispatcher("/WEB-INF/results/specialita.jsp");
            ds.forward(request, response);
        }
        if(action.equals("account")){
            RequestDispatcher ds = request.getRequestDispatcher("/WEB-INF/results/account.jsp");
            ds.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
