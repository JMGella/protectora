<%@ page import="com.svalero.aa.domain.Dog" %>
<%@ page import="com.svalero.aa.dao.Database" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.aa.dao.DogDao" %>
<%@ page import="com.svalero.aa.util.DateUtils" %>
<%@ page import="com.svalero.aa.domain.Favorite" %>
<%@ page import="com.svalero.aa.servlet.Fav" %>
<%@ page import="com.svalero.aa.dao.FavDao" %>
<%@include file="includes/header.jsp"%>>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<%
    int dog_id = Integer.parseInt(request.getParameter("id"));
    Database.connect();
    Dog dog = Database.jdbi.withExtension(DogDao.class, dao -> dao.getDog(dog_id));
    Favorite favorite = Database.jdbi.withExtension(FavDao.class, dao -> dao.getFavorite(dog_id, userId));

%>
<div class="container">
    <h1 class="text-center">Ficha de <%=dog.getName()%></h1>
    <div class="row mt-5">
        <div class="col-6">
            <img src="../AA_pictures/<%= dog.getPicture() %>" alt="<%=dog.getName()%>" class="img-fluid mb-5">
        </div>
        <div class="col-6">
            <h2><%=dog.getName()%> <span class="badge rounded-pill text-white bg-danger"><i class="bi bi-heart"></i>  <%=dog.favcount()%></span></h2>
            <p><%=dog.getDescription()%></p>
            <p><strong>Fecha de nacimiento:</strong> <%=DateUtils.format(dog.getBirth())%></p>
            <p><strong>Raza:</strong> <%=dog.getBreed()%></p>
            <p><strong>Sexo:</strong> <%=dog.getSex()%></p>
            <p><strong>Peso:</strong> <%=dog.getWeight()%></p>
            <%if (dog.getAdopted() == 1) {%>
            <h1><span class="badge rounded-pill bg-success"> Adoptado </span></h1>
            <% }
             if (role.equals("user")) {
                if (dog.getAdopted() == 0) {

                if (favorite != null) {%>


            <a href="RemoveFavServlet?fav_id=<%= favorite.getFav_id() %>" type="button" id="eliminar" class="btn btn-lg btn-outline-danger btn-lg px-4 me-md-2 mr-2" onClick="popup()" >Eliminar Favorito</a>
            <script>
                function popup() {
                    alert("Favorito eliminado");
                }
            </script>
            <%

            } else {

            %>
            <a href="FavDogServlet?dog_id=<%=dog_id%>&detail=1" type="button" id="fav-button" class="btn btn-primary btn-lg px-4 me-md-2 mr-2" onClick="popup()">Añadir a Favoritos</a>
            <script>
                function popup() {
                    alert("Favorito añadido");
                </script>

            <% }}
            }
                if (role.equals("admin")) {
            %>
            <a href="edit-dog.jsp?id=<%= dog.getId() %>" type="button" class="btn btn-sm btn-outline-primary">Editar</a>
            <a href="RemoveDogServlet?id=<%= dog.getId() %>" type="button" id="eliminar" class="btn btn-sm btn-outline-danger" onClick="popup()" >Eliminar</a>
            <script>
                function popup() {
                    alert("Perro eliminado");
                }
            </script>
<%} %>
        </div>
    </div>


<%@include file="includes/footer.jsp"%>