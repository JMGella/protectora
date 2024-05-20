package com.svalero.aa.servlet;

import com.svalero.aa.dao.Database;

import com.svalero.aa.dao.RequestDao;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/RequestServlet")
@MultipartConfig
public class Requests extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        HttpSession currentSession = request.getSession();


        int dog_id = Integer.parseInt(request.getParameter("dog_id"));
        int user_id = Integer.parseInt(currentSession.getAttribute("id").toString());

        String text = request.getParameter("req_text");
        if(text.isEmpty()){
            response.getWriter().println("<div class='alert alert-warning' role='alert'>" + "El texto no puede estar vacío." + "</div>");
            return;
        }

         try {
                Database.connect();
                int affectedRows = Database.jdbi.withExtension(RequestDao.class, dao -> dao.addRequest(dog_id, user_id, text));

                if (affectedRows == 1) {
                 response.getWriter().println("<div class='alert alert-success' role='alert'>" + "Solicitud enviada correctamente." + "</div><br><a class='btn btn-primary' href='/ActividadAprendizaje'>Volver al inicio</a>");
                } else {
                 response.getWriter().println("<div class='alert alert-warning' role='alert'>" + "Error al insertar la solicitud." + "</div>");
                }

          } catch (ClassNotFoundException cnfe) {
                cnfe.printStackTrace();
                response.getWriter().println("<div class='alert alert-warning' role='alert'>" + "Error en la base de datos." + "</div>");
          } catch (SQLException sqle){
                sqle.printStackTrace();
                response.getWriter().println("<div class='alert alert-warning' role='alert'>" + "Error en la base de datos." + "</div>");

          }


    }
}