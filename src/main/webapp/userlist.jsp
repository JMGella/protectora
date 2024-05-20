<%@ page import="com.svalero.aa.domain.User" %>
<%@ page import="com.svalero.aa.dao.UserDao" %>
<%@ page import="com.svalero.aa.dao.Database" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/header.jsp"%>>


<div class="container">
    <form class="row g-3 align-items-center" id="search-form" method="GET" >
        <div class="col"></div>
        <div class="col-6 align-items-center">
            <input type="text" class="form-control" placeholder="Buscar Usuario" name="search" id="search-input">



        </div>
        <div class="col justify-content-start"> <button type="submit" class="btn btn-primary mb-3" id="search-button">Buscar</button></div>
    </form>
</div>


<div class="album py-5">
    <div class="container">
        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
            <%
                String search = "";
                if (request.getParameter("search") != null)
                    search = request.getParameter("search");

                Database.connect();
                List<User> users = null;
                if (search.isEmpty()) {
                    users = Database.jdbi.withExtension(UserDao.class, dao -> dao.getAllUsers());
                } else {
                    final String searchTerm = search;
                    users = Database.jdbi.withExtension(UserDao.class, dao -> dao.getSearchUsers(searchTerm));
                }

                for (User user : users) {

            %>
            <div class="col mb-5">
                <div class="card shadow h-100">

                    <div class="card-body">
                        <h4 class="card-text"><strong><%= user.getName() %> </strong> </h4>
                        <p class="card-text"><%= user.getUsername() %></p>
                        <p class="card-text"><%= user.getRole() %></p>
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="btn-group">
                                <a href="DeleteUserServlet?id=<%= user.getId() %>" type="button" class="btn btn-sm btn-outline-danger mr-1"> Eliminar Usuario</a>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
                                <% } %>



            </div>

        </div>
    </div>
</div>
<%@include file="includes/footer.jsp"%>
