package com.svalero.aa.servlet;


import com.svalero.aa.dao.AdoptDao;
import com.svalero.aa.dao.Database;
import com.svalero.aa.dao.DogDao;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;


@WebServlet("/AdoptDogServlet")
@MultipartConfig

public class AdoptDog extends HttpServlet {

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

            final int user_id = Integer.parseInt(request.getParameter("user_id"));
            final int dog_id = Integer.parseInt(request.getParameter("dog_id"));

            Database.connect();

                int affectedRows = Database.jdbi.withExtension(AdoptDao.class, dao -> dao.adoptDog(dog_id, user_id));
                int affectedRows2 = Database.jdbi.withExtension(DogDao.class, dao -> dao.adoptDog(dog_id));

                response.getWriter().println("Adopción realizada con éxito.");
                response.sendRedirect("/ActividadAprendizaje/adoptions.jsp");

        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
            response.getWriter().println( "Error.");
        } catch (SQLException sqle){
            sqle.printStackTrace();
            response.getWriter().println("Error en la base de datos");

        }
    }
}