<%@ page import="com.svalero.aa.dao.Database" %>
<%@ page import="com.svalero.aa.domain.Dog" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.aa.dao.FavDao" %>
<%@ page import="com.svalero.aa.domain.Favorite" %>
<%@ page import="com.svalero.aa.dao.DogDao" %>
<%@ page import="com.svalero.aa.dao.UserDao" %>
<%@ page import="com.svalero.aa.domain.User" %>
<%@include file="includes/header.jsp"%>>




<div class="album py-5">

    <% if (role.equals("user")) { %>
    <div class="container">
        <h1 class="mb-5">Favoritos de <%= name %></h1>
        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                <%
                        Database.connect();
                        List<Favorite> favs = Database.jdbi.withExtension(FavDao.class, dao -> dao.getFavoriteByUser(userId));
                        for (Favorite fav : favs) {
                            int dog_id = fav.getDog_id();
                            Dog dog = Database.jdbi.withExtension(DogDao.class, dao -> dao.getDog(dog_id));

                    %>
            <div class="col mb-5">
                <div class="card shadow h-100">
                    <img src="../AA_pictures/<%= dog.getPicture() %>" class="card-img-top" style="object-fit: cover" width="100%" height="225" >

                    <div class="card-body">
                        <p class="card-text"><strong><%= dog.getName() %></strong></p>
                        <p class="card-text"><%= dog.getDescription() %></p>
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="btn-group">
                                <a href="dog-detail.jsp?id=<%= dog.getId() %>" type="button" class="btn btn-sm btn-outline-primary mr-1">+ Info</a>

                                <a href="RemoveFavServlet?fav_id=<%= fav.getFav_id() %>" type="button" id="eliminar" class="btn btn-sm btn-outline-danger" onClick="popup()" >Eliminar Favorito</a>
                                <script>
                                    function popup() {
                                        alert("Favorito eliminado");
                                    }
                                    </script>

                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <% }} else if (role.equals("admin")){ %>
                    <div class="album py-5">
                        <div class="container">
                            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                    <%
                        Database.connect();
                        List<Favorite> allfavs = Database.jdbi.withExtension(FavDao.class, dao -> dao.getAllFavorites());
                        for (Favorite fav : allfavs) {
                            int dog_id = fav.getDog_id();
                            Dog dog = Database.jdbi.withExtension(DogDao.class, dao -> dao.getDog(dog_id));
                            int user_id = fav.getUser_id();
                            User user = Database.jdbi.withExtension(UserDao.class, dao -> dao.getUserid(user_id));

                    %>
                                <div class="col mb-5">
                                    <div class="card shadow">
                                        <img src="../AA_pictures/<%= dog.getPicture() %>" class="card-img-top" style="object-fit: cover" width="100%" height="225"  </img>
                                        <div class="card-body">
                                            <p class="card-text"><strong><%= dog.getName() %></strong></p>
                                            <p class="card-text"><%= dog.getDescription() %></p>
                                            <p class="card-text"><strong><a href="dog-detail.jsp?id=<%= dog.getId() %>"><%=dog.getName()%></a> ha sido marcado favorito por: <%= user.getName() %> </strong></p>
                                        </div>
                                    </div>
                                </div>

                    <% }
                        } else {
                        response.sendRedirect("login.jsp");}%>
        </div>
                <% if (role.equals("user")) { %>
                            <h5>Si quieres adoptar, rellena el formulario en el botón <i>Adóptalo</i> el la ficha del perro.</h5>
                <% } %>
    </div>

</div>



<%@include file="includes/footer.jsp"%>