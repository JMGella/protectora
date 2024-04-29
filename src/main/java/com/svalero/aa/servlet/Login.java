package com.svalero.aa.servlet;

import com.svalero.aa.dao.Database;
import com.svalero.aa.dao.UserDao;
import com.svalero.aa.domain.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;


@WebServlet("/LoginServlet")
public class Login extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");


        try {
            Database.connect();
            User user = Database.jdbi.withExtension(UserDao.class, dao -> dao.getUser(username, password));
            if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("role", user.getRole());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("name", user.getName());
            session.setAttribute("id", user.getId());
            response.getWriter().print("ok");
            } else {
                response.getWriter().println("<div class='alert alert-warning' role='alert'>" + "Usuario o contraseña incorrectos" + "</div>");
            }

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.getWriter().println("<div class='alert alert-warning' role='alert'>" + "Internal Server Error" + "</div>");
            return;

        } catch (SQLException throwables) {
            throwables.printStackTrace();
            response.getWriter().println("<div class='alert alert-warning' role='alert'>" + "Error conectando con la Base de Datos" + "</div>");
            return;
        }

    }
}
