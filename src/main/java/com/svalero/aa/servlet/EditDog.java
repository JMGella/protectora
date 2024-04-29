package com.svalero.aa.servlet;

import com.svalero.aa.dao.Database;
import com.svalero.aa.dao.DogDao;
import com.svalero.aa.util.DateUtils;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.UUID;

@WebServlet("/EditDogServlet")
@MultipartConfig

public class EditDog extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");

        HttpSession currentSession = request.getSession();
        if (currentSession.getAttribute("role") != null) {
            if (!currentSession.getAttribute("role").equals("admin")) {
                response.sendRedirect("/ActividadAprendizaje");
            }
        }

        try {

            int id = 0;
            if (request.getParameter("id") != null) {
                id = Integer.parseInt(request.getParameter("id"));
            }


            String name = request.getParameter("name");
            if(name.isEmpty()){
                response.getWriter().println("<div class='alert alert-warning' role='alert'>" + "El nombre no puede estar vacío." + "</div>");
                return;
            }
            Date birth = DateUtils.parse(request.getParameter("birth"));
            String sex = request.getParameter("sex");
            if(sex.isEmpty()){
                response.getWriter().println("<div class='alert alert-warning' role='alert'>" + "Es obligatorio elegir un sexo." + "</div>");
                return;
            }
            String breed = request.getParameter("breed");
            String weight = request.getParameter("weight");
            String description = request.getParameter("description");
            if (description.isEmpty()) {
                response.getWriter().println("<div class='alert alert-warning' role='alert'>" + "La descripción no puede estar vacía." + "</div>");
                return;
            }
            Part picturePart = request.getPart("picture");

            String imagePath = request.getServletContext().getInitParameter("image-path");
            String filename = null;

            if (picturePart.getSize() == 0) {
                filename = "no-image.jpg";
            } else {
                filename = UUID.randomUUID() + ".jpg";
                InputStream input = picturePart.getInputStream();
              Files.copy(input, Path.of(imagePath + File.separator + filename));

            }

            Database.connect();
            final String finalfilename = filename;
            if (id == 0) {

                int affectedRows = Database.jdbi.withExtension(DogDao.class, dao -> dao.addDog(name, birth, sex, breed, weight, description, finalfilename));
                response.getWriter().println("<div class='alert alert-success' role='alert'>" + "El perro se ha registrado correctamente" + "</div>");

            } else {
                final int finalid = id;
                int affectedRows = Database.jdbi.withExtension(DogDao.class, dao -> dao.updateDog(name, birth, sex, breed, weight, description, finalfilename, finalid));
                response.getWriter().println("<div class='alert alert-success' role='alert'>" + "El perro se ha actualizado correctamente" + "</div>");
            }

        } catch (ParseException pe) {
            pe.printStackTrace();
            response.getWriter().println("<div class='alert alert-warning' role='alert'>" + "El formato de fecha no es correcto." + "</div>");
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
            response.getWriter().println("<div class='alert alert-warning' role='alert'>" + "Error." + "</div>");
        } catch (SQLException sqle){
            sqle.printStackTrace();
            response.getWriter().println("<div class='alert alert-warning' role='alert'>" + "Error en la base de datos." + "</div>");

        }
    }
}
