package com.svalero.aa.servlet;

import com.svalero.aa.dao.Database;
import com.svalero.aa.dao.FavDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/RemoveFavServlet")

public class RemoveFav extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int fav_id = Integer.parseInt(request.getParameter("fav_id"));

        try {
            Database.connect();
            int affectedRows = Database.jdbi.withExtension(FavDao.class, dao -> dao.removeFavorite(fav_id));
            response.sendRedirect("index.jsp");


        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();


        } catch (SQLException sqle) {
            sqle.printStackTrace();

        }
    }


}
