package com.svalero.aa.servlet;

import com.svalero.aa.dao.Database;

import com.svalero.aa.dao.UserDao;
import com.svalero.aa.domain.User;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/RegisterServlet")
@MultipartConfig
public class Register extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        HttpSession currentSession = request.getSession();

        if (currentSession.getAttribute("role") != null) {
            if (!currentSession.getAttribute("role").equals("anonymous")) {
                response.sendRedirect("/ActividadAprendizaje");
            }
        }

        String username = request.getParameter("username");
        if(username.isEmpty()){
            response.getWriter().println("<div class='alert alert-warning' role='alert'>" + "El nombre no puede estar vacío." + "</div>");
            return;
        }
        String password = request.getParameter("password");
        if(password.isEmpty()){
            response.getWriter().println("<div class='alert alert-warning' role='alert'>" + "La contraseña no puede estar vacía." + "</div>");
            return;
        }
        String name = request.getParameter("name");
        if(name.isEmpty()){
            response.getWriter().println("<div class='alert alert-warning' role='alert'>" + "El nombre no puede estar vacío." + "</div>");
            return;
        }
        String role = "user";



        try {
            Database.connect();
            User userexist = Database.jdbi.withExtension(UserDao.class, dao -> dao.getUser(username, password));
            if (userexist != null) {
                response.getWriter().println("<div class='alert alert-warning' role='alert'>" + "El usuario ya existe." + "</div>");
                return;
            } else {

                int affectedRows = Database.jdbi.withExtension(UserDao.class, dao -> dao.addUser(name, username, password,role));

                if (affectedRows == 1) {
                    response.getWriter().println("<div class='alert alert-success' role='alert'>" + "Usuario registrado correctamente." + "</div><br><a class='btn btn-primary' href='/ActividadAprendizaje'>Volver al inicio</a>");
                } else {
                    response.getWriter().println("<div class='alert alert-warning' role='alert'>" + "Error al insertar el usuario." + "</div>");
                }

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
