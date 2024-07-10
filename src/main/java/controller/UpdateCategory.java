package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.*;
import java.io.IOException;

@WebServlet(name = "UpdateCategory", value = "/UpdateCategory")
public class UpdateCategory extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        CategoriaDAO cDAO = new CategoriaDAO();
        Categoria c = new Categoria();
        c.setName(request.getParameter("name"));
        String result = null;

        if(action.equals("AGGIORNA")){
            c.setDescription(request.getParameter("description"));

            if(cDAO.doUpdate(c)==0){
                result = "Problema aggiornamento!";
            }else{
                result = "Categoria aggiornato!";
            }

            request.setAttribute("result", result);

            RequestDispatcher ds = request.getRequestDispatcher("/WEB-INF/administrator/homeAdmin.jsp");
            ds.forward(request, response);
        }
        if(action.equals("ELIMINA")){
            ProdottoDAO pDAO = new ProdottoDAO();
            pDAO.doDeleteByCategory(c.getName());
            if(cDAO.doDelete(c.getName())!=0){
                result = "Categoria eliminato!";
            }else{
                result = "Problema eliminazione!";
            }

            //Imposta la risposta
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(result);
        }
        if(action.equals("AGGIUNGI CATEGORIA")){
            c.setDescription(request.getParameter("description"));

            try{
                cDAO.doInsert(c);
                result = "Categoria aggiornata!";
            }catch (Exception e){
                result = "Categoria già esistente!";
                request.setAttribute("result", result);

                RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/administrator/homeAdmin.jsp");
                requestDispatcher.forward(request, response);
            }

            request.setAttribute("result", result);

            RequestDispatcher ds = request.getRequestDispatcher("/WEB-INF/administrator/homeAdmin.jsp");
            ds.forward(request, response);
        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("HomeServletAdministrator?action=homeAdmin");
        requestDispatcher.forward(request, response);
    }
}
