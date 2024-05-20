package com.svalero.aa.servlet;

import com.svalero.aa.dao.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/DeleteRequestServlet")

public class DeleteRequest extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("req_id"));

        try {
            Database.connect();
            Database.jdbi.withExtension(RequestDao.class, dao -> dao.removeRequest(id));

            response.sendRedirect("requestlist.jsp");

        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();


        } catch (SQLException sqle) {
            sqle.printStackTrace();

        }
    }


}
