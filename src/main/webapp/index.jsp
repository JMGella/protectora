<%@ page import="com.svalero.aa.dao.Database" %>
<%@ page import="com.svalero.aa.dao.DogDao" %>
<%@ page import="com.svalero.aa.domain.Dog" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.aa.domain.Favorite" %>
<%@ page import="com.svalero.aa.dao.FavDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="includes/header.jsp"%>


<script type="text/javascript">




        $(document).ready(function () {
        $("#search-input").focus();
    });


</script>


<%
    if (role.equals("admin")) {
%>


<div class="b-example-divider"></div>
<div class="container col-xxl-8 px-4 py-5">
    <div class="row flex-lg-row-reverse align-items-center g-5 py-5">
        <div class="col-10 col-sm-8 col-lg-6">
            <img src="webimages/hero-image.jpg" class="d-block mx-lg-auto img-fluid"  style="" alt="Protectora San Valero" width="700" height="500" loading="lazy">
        </div>
        <div class="col-lg-6">
            <h1 class="display-5 fw-bold text-body-emphasis text-center lh-1">Protectora de Animales </h1>
            <h1 class="display-5 fw-bold text-body-emphasis text-center lh-1 mb-4">San Valero </h1>
            <p class="lead mb-5">En esta página podras ver todos los perritos que tenemos disponibles para adoptar. Puedes gestionar las fichas de los perros, añadir nuevos perros y eliminarlos.</p>
            <div class="d-grid gap-2 d-md-flex justify-content-md-start">
                <a type="button" class="btn btn-primary btn-lg px-4 me-md-2 mr-2" href="edit-dog.jsp">Registrar Perro</a>
                <a type="button" class="btn btn-outline-secondary btn-lg px-4 mr-2" href="#">Adopciones</a>
                <a type="button" class="btn btn-light btn-lg px-4" href="LogoutServlet">Cerrar Sesión</a>
            </div>
        </div>
    </div>
</div>
<div class="b-example-divider"></div>



        <% } else if (role.equals("anonymous")) { %>
<div class="b-example-divider"></div>
<div class="container col-xxl-8 px-4 py-5">
    <div class="row flex-lg-row-reverse align-items-center g-5 py-5">
        <div class="col-10 col-sm-8 col-lg-6">
            <img src="webimages/hero-image.jpg" class="d-block mx-lg-auto img-fluid" alt="Protectora San Valero" width="700" height="500" loading="lazy">
        </div>
        <div class="col-lg-6">
            <h1 class="display-5 fw-bold text-body-emphasis text-center lh-1">Protectora de Animales </h1>
            <h1 class="display-5 fw-bold text-body-emphasis text-center lh-1 mb-4">San Valero </h1>
            <p class="lead mb-5">En esta página podras ver todos los perritos que tenemos disponibles para adoptar. Si te enamoras de alguno, márcalo como favorito. Y si te lo quieres llevar a casa...</p>
            <div class="d-grid gap-2 d-md-flex justify-content-md-start">
                <a type="button" class="btn btn-primary btn-lg px-4 me-md-2 mr-2" href="adoptions.jsp">¡Adóptalo!</a>
                <a type="button" class="btn btn-outline-secondary btn-lg px-4 mr-2" href="login.jsp">Iniciar Sesión</a>
                <a type="button" class="btn btn-light btn-lg px-4" href="registeruser.jsp">Registrarse</a>

            </div>
        </div>
    </div>
</div>
<div class="b-example-divider"></div>


        <% } else { %>


<div class="b-example-divider"></div>
<div class="container col-xxl-8 px-4 py-5">
    <div class="row flex-lg-row-reverse align-items-center g-5 py-5">
        <div class="col-10 col-sm-8 col-lg-6">
            <img src="webimages/hero-image.jpg" class="d-block mx-lg-auto img-fluid" alt="Protectora San Valero" width="700" height="500" loading="lazy">
        </div>
        <div class="col-lg-6">
            <h1 class="display-5 fw-bold text-body-emphasis text-center lh-1">Protectora de Animales </h1>
            <h1 class="display-5 fw-bold text-body-emphasis text-center lh-1 mb-4">San Valero </h1>
            <h3> ¡Hola <%=name%>,</h3>
            <h3>nos alegramos de volver a verte! </h3>
            <p class="lead mb-5">En esta página podras ver todos los perritos que tenemos disponibles para adoptar. Si te enamoras de alguno, márcalo como favorito. Y si te lo quieres llevar a casa...</p>
            <div class="d-grid gap-2 d-md-flex justify-content-center">
                <a type="button" class="btn btn-primary btn-lg px-4 me-md-2 mr-2" href="adoptions.jsp">¡Adóptalo!</a>


            </div>
        </div>
    </div>
</div>
<div class="b-example-divider"></div>


<% } %>



<div class="container mb-5">
    <div class="col"></div>
    <div class="col"><h1 class="display-5 fw-bold text-body-emphasis lh-1 mb-3 text-center">Nuestros Perritos en adopción</h1></div>
    <div class="col"></div>
</div>
<div class="container">
<form class="row g-3 align-items-center" id="search-form" method="GET" >
        <div class="col"></div>
        <div class="col-6 align-items-center">
            <input type="text" class="form-control" placeholder="Buscar perro... Raza..." name="search" id="search-input">



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
                    List<Dog> dogs = null;
                    if (search.isEmpty()) {
                        dogs = Database.jdbi.withExtension(DogDao.class, dao -> dao.getAllDogs());
                    } else {
                        final String searchTerm = search;
                        dogs = Database.jdbi.withExtension(DogDao.class, dao -> dao.getSearchDogs(searchTerm));
                    }

                    for (Dog dog : dogs) {
                        Favorite favorite = Database.jdbi.withExtension(FavDao.class, dao -> dao.getFavorite(dog.getId(), userId));
                %>
                <div class="col mb-5">
                    <div class="card shadow h-100">
                        <img src="../AA_pictures/<%= dog.getPicture() %>" class="card-img-top" style="object-fit: cover" width="100%" height="225"  </img>

                        <div class="card-body">
                            <h4 class="card-text"><strong><%= dog.getName() %>   <span class="badge rounded-pill text-white bg-danger"><i class="bi bi-heart"></i>  <%=dog.favcount()%></span></strong></h4>
                            <% if (dog.getAdopted() == 1) { %> <h4><span class="badge rounded-pill bg-success"> Adoptado </span></h4> <% } %>
                            <p class="card-text"><%= dog.getDescription() %></p>
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="btn-group">
                                    <a href="dog-detail.jsp?id=<%= dog.getId() %>" type="button" class="btn btn-sm btn-outline-primary mr-1">+ Info</a>

                                  <%

                                    if (role.equals("admin")) {
                                  %>
                                    <a href="edit-dog.jsp?id=<%= dog.getId() %>" type="button" class="btn btn-sm btn-outline-primary">Editar</a>
                                    <a href="RemoveDogServlet?id=<%= dog.getId() %>" type="button" id="eliminar" class="btn btn-sm btn-outline-danger" onClick="popup()" >Eliminar</a>
                                    <script>
                                        function popup() {
                                            alert("Perro eliminado");
                                        }
                                    </script>
                                    <%
                                        } if(role.equals("user")) {
                                    if (favorite != null) {%>


                                    <a href="RemoveFavServlet?fav_id=<%= favorite.getFav_id() %>" type="button" id="eliminar" class="btn btn-sm btn-outline-danger" onClick="popup2()" >Eliminar Favorito</a>
                                    <script>
                                        function popup2() {
                                            alert("Favorito eliminado");
                                        }
                                    </script>
                                    <%

                                    } else {

                                    %>
                                    <a href="FavDogServlet?dog_id=<%= dog.getId()%>" type="button" id="fav-button" class="btn btn-sm btn-outline-primary" onClick="popup3()">Añadir a Favoritos</a>
                                    <script>
                                        function popup3() {
                                            alert("Favorito añadido");
                                        }
                                    </script>
                                    <div id="result"></div>
                                    <% }}
                                    %>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </div>



<%@include file="includes/footer.jsp"%>
