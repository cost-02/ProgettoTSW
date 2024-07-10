package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Categoria;
import model.CategoriaDAO;
import java.io.IOException;

@WebServlet(name="ManageCategory", value="/ManageCategory")
public class ManageCategory extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("action");
        CategoriaDAO cDAO = new CategoriaDAO();
        Categoria c = cDAO.doRetrieveByName(name);
        request.setAttribute("categories", c);
        RequestDispatcher ds = request.getRequestDispatcher("/WEB-INF/administrator/category.jsp");
        ds.forward(request, response);

        request.setAttribute("category", c);
        RequestDispatcher ds1 = request.getRequestDispatcher("/WEB-INF/administrator/category.jsp");
        ds.forward(request, response);
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}