package com.svalero.aa.servlet;


import com.svalero.aa.dao.Database;
import com.svalero.aa.dao.FavDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/FavDogServlet")
@MultipartConfig
public class Fav extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession currentSession = request.getSession();
        if (currentSession.getAttribute("role") == null) {
            response.sendRedirect("/ActividadAprendizaje");
        }

        final int dog_id = Integer.parseInt(request.getParameter("dog_id"));
        final int user_id = (int) currentSession.getAttribute("id");


        try {
            Database.connect();
           Database.jdbi.withExtension(FavDao.class, dao -> dao.addFav(dog_id, user_id));

           if (request.getParameter("detail") != null){
               response.sendRedirect("/ActividadAprendizaje/dog-detail.jsp?id=" + dog_id );
           } else {
               response.sendRedirect("/ActividadAprendizaje");
           }



        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.getWriter().println("<div class='alert alert-warning' role='alert'>" + "Internal Server Error" + "</div>");
            return;

        } catch (SQLException sqle) {
            sqle.printStackTrace();
            response.getWriter().println("<div class='alert alert-warning' role='alert'>" + "Error conectando con la Base de Datos" + "</div>");
            return;
        }

    }
}
