package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Prodotto;
import model.ProdottoDAO;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet(name="ManageProduct", value="/ManageProduct")
public class ManageProduct extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        int product = Integer.parseInt(request.getParameter("action"));
//        ProdottoDAO pDAO = new ProdottoDAO();
//        Prodotto p = pDAO.doRetrieveByIdImage(product);
//        Blob blob = (Blob) p.getImage();
//        try {
//            byte byteArray[] = blob.getBytes(1, (int) blob.length());
//
//            response.setContentType("image/gif");
//
//            OutputStream os = response.getOutputStream();
//            os.write(byteArray);
//            os.flush();
//            os.close();
//            request.setAttribute("image", byteArray);
//        } catch (SQLException e) {
//            throw new RuntimeException(e);
//        }
//
//        request.setAttribute("prodotto", p);
//
//        RequestDispatcher ds = request.getRequestDispatcher("/WEB-INF/administrator/products.jsp");
//        ds.forward(request, response);

        int idProduct = Integer.parseInt(request.getParameter("action"));
        ProdottoDAO pDAO = new ProdottoDAO();
        ArrayList<String> categories = pDAO.getCategories();
        request.setAttribute("categories", categories);
        Prodotto p = pDAO.doRetrieveById(idProduct);
        request.setAttribute("product", p);
        RequestDispatcher ds = request.getRequestDispatcher("/WEB-INF/administrator/product.jsp");
        ds.forward(request, response);
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}