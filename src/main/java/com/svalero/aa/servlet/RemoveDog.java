package com.svalero.aa.servlet;

import com.svalero.aa.dao.AdoptDao;
import com.svalero.aa.dao.Database;
import com.svalero.aa.dao.DogDao;
import com.svalero.aa.dao.FavDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/RemoveDogServlet")

public class RemoveDog extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        try {
            Database.connect();
            Database.jdbi.withExtension(FavDao.class, dao -> dao.removeFavoritebyDog(id));
            Database.jdbi.withExtension(AdoptDao.class, dao -> dao.removeAdoption(id));
            int affectedRows = Database.jdbi.withExtension(DogDao.class, dao -> dao.removeDog(id));
            response.sendRedirect("index.jsp");

        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();


        } catch (SQLException sqle) {
            sqle.printStackTrace();

        }
    }


}
