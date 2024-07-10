package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.*;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.SQLIntegrityConstraintViolationException;


@MultipartConfig
@WebServlet(name = "InsertProduct", value = "/InsertProduct")
public class InsertProduct extends HttpServlet {
    private static final String CARTELLA_UPLOAD = "upload";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        Double price = Double.valueOf(request.getParameter("price"));
        String description = request.getParameter("description");
        String category = request.getParameter("categories");

        Part filePart = request.getPart("image");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        Prodotto p = new Prodotto();
        p.setName(name);
        p.setPrice(price);
        p.setImage(fileName);
        p.setDescription(description);
        p.setNameCategory(category);

        String result = "";
        ProdottoDAO pDAO = new ProdottoDAO();
        try{
            pDAO.doInsert(p);
            result = "Prodotto inserito!";
        }catch (Exception e){
            result = "Prodotto già inserito!";
            request.setAttribute("result", result);

            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/administrator/homeAdmin.jsp");
            requestDispatcher.forward(request, response);
        }

        String destinazione = CARTELLA_UPLOAD + File.separator + fileName;
        Path pathDestinazione = Paths.get(getServletContext().getRealPath(destinazione));

        // se un file con quel nome esiste già, gli cambia nome
        for (int i = 2; Files.exists(pathDestinazione); i++) {
            destinazione = CARTELLA_UPLOAD + File.separator + i + "_" + fileName;
            pathDestinazione = Paths.get(getServletContext().getRealPath(destinazione));
        }

        InputStream fileInputStream = filePart.getInputStream();
        // crea CARTELLA_UPLOAD, se non esiste
        Files.createDirectories(pathDestinazione.getParent());
        // scrive il file
        Files.copy(fileInputStream, pathDestinazione);

        request.setAttribute("result", result);

        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/administrator/homeAdmin.jsp");
        requestDispatcher.forward(request, response);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("HomeServletAdministrator?action=homeAdmin");
        requestDispatcher.forward(request, response);
    }
}
