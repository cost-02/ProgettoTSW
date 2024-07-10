package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.*;
import java.io.IOException;


@WebServlet(name = "UpdateProduct", value = "/UpdateProduct")
public class UpdateProduct extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        ProdottoDAO pDAO = new ProdottoDAO();

        if(action.equals("AGGIORNA")){
            Prodotto p = new Prodotto();
            p.setId(Integer.parseInt(request.getParameter("id")));
            p.setName(request.getParameter("name"));
            p.setPrice(Double.parseDouble(request.getParameter("price")));
            p.setDescription(request.getParameter("description"));
            p.setNameCategory(request.getParameter("categories"));

            String result = "";
            try{
                pDAO.doUpdate(p);
                result = "Prodotto aggiornato!";
            }catch (Exception e){
                result = "Prodotto già esistente!";
                request.setAttribute("result", result);

                RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/administrator/homeAdmin.jsp");
                requestDispatcher.forward(request, response);
            }


            request.setAttribute("result", result);

            RequestDispatcher ds = request.getRequestDispatcher("/WEB-INF/administrator/homeAdmin.jsp");
            ds.forward(request, response);
        }
        if(action.equals("ELIMINA")){
            int id = Integer.parseInt(request.getParameter("id"));
            String result;

            if(pDAO.doDelete(id)==0){
                result = "Problema eliminazione!";
            }else{
                result = "Prodotto eliminato!";
            }

            //Imposta la risposta
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(result);

        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("HomeServletAdministrator?action=homeAdmin");
        requestDispatcher.forward(request, response);
    }
}
