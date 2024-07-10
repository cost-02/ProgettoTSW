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

@WebServlet(name="ManageCart", value="/ManageCart")
public class ManageCart extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        CarrelloDAO cDAO = new CarrelloDAO();
        if(action.equals("removeProduct")){
            int id = Integer.parseInt(request.getParameter("id"));
            String email = request.getParameter("email");
            cDAO.doDelete(id, email);
            ArrayList<Carrello> c = cDAO.doRetrieveAll();
            request.setAttribute("carts", c);
        }else if(action.equals("removeProductSession")){
            int id = Integer.parseInt(request.getParameter("id"));
            HttpSession session = request.getSession();
            ArrayList<Carrello> carts = (ArrayList<Carrello>) session.getAttribute("carts");
            int i=0;
            for(Carrello c : carts) {
                if (c.getProducts().getId() == id) {
                    carts.remove(i);
                    break;
                }
                i++;
            }
            session.setAttribute("carts", carts);
        }else if(action.equals("changeQuantity")){
            int id = Integer.parseInt(request.getParameter("id"));
            String email = request.getParameter("email");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            cDAO.changeQuantity(id, email, quantity);
            int updatedQuantity = cDAO.getQuantity(email, id);
        }else if(action.equals("changeQuantitySession")){
            int id = Integer.parseInt(request.getParameter("id"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            HttpSession session = request.getSession();
            ArrayList<Carrello> carts = (ArrayList<Carrello>) session.getAttribute("carts");
            int i=0;
            for(Carrello c : carts) {
                if (c.getProducts().getId() == id) {
                    c.setQuantity(quantity);
                    break;
                }
                i++;
            }
            session.setAttribute("carts", carts);
        }
        RequestDispatcher ds = request.getRequestDispatcher("/WEB-INF/results/cart.jsp");
        ds.forward(request, response);
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}