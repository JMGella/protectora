<%@ page import="com.svalero.aa.dao.Database" %>
<%@ page import="com.svalero.aa.domain.Request" %>
<%@ page import="com.svalero.aa.dao.RequestDao" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.aa.domain.Dog" %>
<%@ page import="com.svalero.aa.dao.DogDao" %>
<%@ page import="com.svalero.aa.domain.User" %>
<%@ page import="com.svalero.aa.dao.UserDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/header.jsp"%>>


<div class="album py-5">
    <div class="container">
        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
        <%
            Database.connect();
            List<Request> allrequest = Database.jdbi.withExtension(RequestDao.class, dao -> dao.getAllRequests());
            for (Request req : allrequest) {
                int dog_id = req.getDog_id();
                Dog dog = Database.jdbi.withExtension(DogDao.class, dao -> dao.getDog(dog_id));
                int user_id = req.getUser_id();
                User user = Database.jdbi.withExtension(UserDao.class, dao -> dao.getUserid(user_id));

        %>
            <div class="col mb-5">
                <div class="card shadow">
                    <img src="../AA_pictures/<%= dog.getPicture() %>" class="card-img-top" style="object-fit: cover" width="100%" height="225"  </img>

                    <div class="card-body">
                        <p class="card-text"><strong><a href="dog-detail.jsp?id=<%= dog.getId() %>"><%=dog.getName()%></a>  quiere ser adoptado por <%= user.getName() %> </strong></p>


                        <h5 class="card-text">Solicitud</h5>
                        <p><%= req.getReq_text() %></p>
                        <a href="adoptions.jsp" type="button" id="request-button" class="btn btn-primary px-4 me-md-2 mr-2"">Tramitar adopción</a>
                        <a <a href="DeleteRequestServlet?req_id=<%=req.getReq_id()%>" type="button" id="delete-req-button" class="btn btn-outline-danger px-4 me-md-2 mr-2"">Eliminar petición</a>

                    </div>
                    </div>

        </div>

    <% } %>
    </div>
    </div>
</div>
</div>
</div>


<%@include file="includes/footer.jsp"%>

