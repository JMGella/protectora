
<%@ page import="com.svalero.aa.dao.Database" %>
<%@ page import="com.svalero.aa.domain.User" %>
<%@ page import="com.svalero.aa.dao.UserDao" %>
<%@ page import="com.svalero.aa.domain.Request" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.aa.dao.RequestDao" %>
<%@ page import="com.svalero.aa.dao.DogDao" %>
<%@ page import="com.svalero.aa.domain.Dog" %>
<%@include file="includes/header.jsp"%>>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>




<%

    if (role.equals("anonymous")) {
        response.sendRedirect("login.jsp");
    }else{



        User user = Database.jdbi.withExtension(UserDao.class, dao -> dao.getUserid(userId));


%>





<div class="container">
    <h1 class="mb-4">Perfil de <%= user.getName() %></h1>
    <div class="row">

        <div class="col">
            <p>Nombre: <%= user.getName() %></p>
            <p> Usuario: <%= user.getUsername() %></p>

        </div>
        <div class="col">
        <a href="favs.jsp" type="button" class="btn btn-lg btn-outline-primary btn-lg px-4 me-md-2 mr-2" >Tus Favoritos</a><a href="registeruser.jsp?=id<%=user.getId()%>" type="button" class="btn btn-lg btn-outline-primary btn-lg px-4 me-md-2 mr-2" > Modifica tus datos</a>
      </div>
    </div>

    <div class="album py-5">
        <div class="container">
            <h1 class="mb-4">Tus Peticiones de adopción</h1>
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">

         <%
            List<Request> requests = Database.jdbi.withExtension(RequestDao.class, dao -> dao.getRequestsByUser(userId));
            for (Request req : requests) {
                Dog dog = Database.jdbi.withExtension(DogDao.class, dao -> dao.getDog(req.getDog_id()));
                %>
        <div class="col mb-5">
            <div class="card shadow">
                <img src="../AA_pictures/<%= dog.getPicture() %>" class="card-img-top" style="object-fit: cover" width="100%" height="225"  </img>

                <div class="card-body">
                    <p class="card-text"><strong><a href="dog-detail.jsp?id=<%= dog.getId() %>"><%=dog.getName()%></a>  </strong></p>


                    <h5 class="card-text">Solicitud nº: <%=req.getReq_id()%></h5>
                    <p><%= req.getReq_text() %></p>
                    <p><%= req.getCity() %></p>

                    <a href="DeleteRequestServlet?req_id=<%=req.getReq_id()%>" type="button" id="delete-req-button" class="btn btn-outline-danger px-4 me-md-2 mr-2"">Eliminar petición</a>
                    <a href="edit-request-form.jsp?req_id=<%=req.getReq_id()%>&dog_id=<%=dog.getId()%>" type="button" id="delete-req-button" class="btn btn-outline-warning px-4 me-md-2 mr-2"">Editar petición</a>


                </div>
            </div>

        </div>
                <%
            }
         %>
    </div>
</div>

<%
}
%>


<%@include file="includes/footer.jsp"%>