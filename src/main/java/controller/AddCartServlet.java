package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "AddCartServlet", value = "/AddCartServlet")
public class AddCartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String email = request.getParameter("email");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        CarrelloDAO cDAO = new CarrelloDAO();
        cDAO.doInsert(email, id, quantity);
        ProdottoDAO pDAO = new ProdottoDAO();
        Prodotto p = pDAO.doRetrieveById(id);

        ArrayList<Prodotto> products = new ArrayList<Prodotto>();
        products = (ArrayList<Prodotto>) pDAO.doRetrieveAll();
        request.setAttribute("product", products);
        CategoriaDAO catDAO = new CategoriaDAO();
        ArrayList<Categoria> categories = catDAO.doRetrieveAll();
        request.setAttribute("categories", categories);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/results/products.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProdottoDAO pDAO = new ProdottoDAO();
        ArrayList<Prodotto> products = new ArrayList<Prodotto>();
        products = (ArrayList<Prodotto>) pDAO.doRetrieveAll();
        request.setAttribute("product", products);
        CategoriaDAO catDAO = new CategoriaDAO();
        ArrayList<Categoria> categories = catDAO.doRetrieveAll();
        request.setAttribute("categories", categories);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/results/products.jsp");
        dispatcher.forward(request, response);
    }
}
