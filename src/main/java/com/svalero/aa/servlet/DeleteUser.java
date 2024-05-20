package com.svalero.aa.servlet;

import com.svalero.aa.dao.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/DeleteUserServlet")

public class DeleteUser extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        try {
            Database.connect();
            Database.jdbi.withExtension((AdoptDao.class), dao -> dao.removeAdoptbyuser(id));
            Database.jdbi.withExtension((FavDao.class), dao -> dao.removeFavbyuser(id));
            Database.jdbi.withExtension(RequestDao.class, dao -> dao.removeRequestbyUser(id));
            Database.jdbi.withExtension(UserDao.class, dao -> dao.removeUser(id));

            response.sendRedirect("userlist.jsp");

        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();


        } catch (SQLException sqle) {
            sqle.printStackTrace();

        }
    }


}
