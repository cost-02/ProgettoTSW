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

@WebServlet(name = "AddCartSession", value = "/AddCartSession")
public class AddCartSessionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        ProdottoDAO pDAO = new ProdottoDAO();
        Prodotto p = pDAO.doRetrieveById(id);
        if(p!=null){
            CarrelloDAO cDAO = new CarrelloDAO();
            HttpSession session = request.getSession();
            ArrayList<Carrello> carts = (ArrayList<Carrello>) session.getAttribute("carts");
            if(carts!=null){
                boolean check = false;
                for(Carrello c : carts)
                    if(c.getProducts().getId()==id) {
                        int total = c.getQuantity() + quantity;
                        c.setQuantity(total);
                        check=true;
                        break;
                    }
                if(!check) {
                    Carrello c = new Carrello();
                    c.setQuantity(quantity);
                    c.setProducts(p);
                    carts.add(c);
                }
            }else {
                Carrello c = new Carrello();
                c.setQuantity(quantity);
                c.setProducts(p);
                carts = new ArrayList<Carrello>();
                carts.add(c);
            }
            ArrayList<Prodotto> products = new ArrayList<Prodotto>();
            products = (ArrayList<Prodotto>) pDAO.doRetrieveAll();
            request.setAttribute("product", products);
            CategoriaDAO catDAO = new CategoriaDAO();
            ArrayList<Categoria> categories = catDAO.doRetrieveAll();
            request.setAttribute("categories", categories);
            session.setAttribute("carts", carts);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/results/products.jsp");
            dispatcher.forward(request, response);
        }
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
