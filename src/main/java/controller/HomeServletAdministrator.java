package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.*;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "HomeServletAdministrator", value = "/HomeServletAdministrator")
public class HomeServletAdministrator extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if(action.equals("homeAdmin")){
            RequestDispatcher ds = request.getRequestDispatcher("/WEB-INF/administrator/homeAdmin.jsp");
            ds.forward(request, response);
        }
        if(action.equals("add_category")){
            RequestDispatcher ds = request.getRequestDispatcher("/WEB-INF/administrator/addCategory.jsp");
            ds.forward(request, response);
        }
        if(action.equals("orders")){
            OrdineDAO oDAO = new OrdineDAO();
            ArrayList<Ordine> orders = new ArrayList<>();
            orders = (ArrayList<Ordine>) oDAO.doRetrieveAll();
            request.setAttribute("orders", orders);
            RequestDispatcher ds = request.getRequestDispatcher("/WEB-INF/administrator/manageOrders.jsp");
            ds.forward(request, response);
        }
        if(action.equals("users")){
            UtenteDAO uDAO = new UtenteDAO();
            ArrayList<Utente> users = new ArrayList<>();
            users = uDAO.doRetrieveAll();
            request.setAttribute("users", users);
            RequestDispatcher ds = request.getRequestDispatcher("/WEB-INF/administrator/manageUsers.jsp");
            ds.forward(request, response);
        }
        if(action.equals("add_product")){
            CategoriaDAO cDAO = new CategoriaDAO();
            ArrayList<String> categories = cDAO.getCategoryName();
            request.setAttribute("categories", categories);
            RequestDispatcher ds = request.getRequestDispatcher("/WEB-INF/administrator/addProduct.jsp");
            ds.forward(request, response);
        }
        if(action.equals("manage_product")){
            ProdottoDAO pDAO = new ProdottoDAO();
            ArrayList<Prodotto> products = new ArrayList<Prodotto>();
            products = (ArrayList<Prodotto>) pDAO.doRetrieveAll();
            request.setAttribute("products", products);
            CategoriaDAO cDAO = new CategoriaDAO();
            ArrayList<Categoria> categories = (ArrayList<Categoria>) cDAO.doRetrieveAll();
            request.setAttribute("categories", categories);
            RequestDispatcher ds = request.getRequestDispatcher("/WEB-INF/administrator/manageProduct.jsp");
            ds.forward(request, response);
        }
        if(action.equals("manage_category")){
            CategoriaDAO cDAO = new CategoriaDAO();
            ArrayList<Categoria> categories = (ArrayList<Categoria>) cDAO.doRetrieveAll();
            request.setAttribute("categories", categories);
            RequestDispatcher ds = request.getRequestDispatcher("/WEB-INF/administrator/manageCategory.jsp");
            ds.forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
