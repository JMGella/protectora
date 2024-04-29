<%@ page import="com.svalero.aa.domain.Dog" %>
<%@ page import="com.svalero.aa.dao.Database" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.aa.dao.DogDao" %>
<%@ page import="com.svalero.aa.util.DateUtils" %>
<%@ page import="com.svalero.aa.domain.Adoption" %>
<%@ page import="com.svalero.aa.dao.AdoptDao" %>
<%@ page import="com.svalero.aa.domain.User" %>
<%@ page import="com.svalero.aa.dao.UserDao" %>
<%@include file="includes/header.jsp"%>>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>




<div class="container mt-5">
   <% if(!role.equals("admin")) { %><h5> Si quieres adoptar, envianos un mail a <a href="mailto:protectora@sanvalero.com">protectora@sanvalero.com</a> con tus datos y los del perro que quieres adoptar.</h5>
    <p>Responderemos lo antes posible. Gracias por querer dar un hogar a uno de nuestros peludos.</p>
    <%} %>

<h1 class="mb-5 mt-5">Últimas adopciones: </h1>
    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
<%

                Database.connect();
    List<Adoption> adoptions = Database.jdbi.withExtension(AdoptDao.class, dao -> dao.getAllAdoptions());
    for (Adoption adoption : adoptions) {
        int user_id = adoption.getUser_id();
         int dog_id = adoption.getDog_id();
                            Dog dog = Database.jdbi.withExtension(DogDao.class, dao -> dao.getDog(dog_id));
                            User user = Database.jdbi.withExtension(UserDao.class, dao -> dao.getUserid(user_id));
%>
        <div class="col mb-5">
          <div class="card shadow h-100">
            <img src="../AA_pictures/<%= dog.getPicture() %>" class="card-img-top" style="object-fit: cover" width="100%" height="225">

            <div class="card-body">
                <p class="card-text"><strong><%= dog.getName() %></strong></p>
                <p class="card-text"><%= dog.getDescription() %></p>
                <div class="d-flex justify-content-between align-items-center">
                    <div class="btn-group">
                        <p class="card-text">Adoptado por: <%= user.getName() %></p>
                    </div>
                </div>
             </div>
          </div>
        </div>
        <% } %>
     </div>


</div>




<%
     if (role.equals("admin")) {
%>

    <div class="container">
        <h1 class="mb-5"> Crear adopciones: </h1>
        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">

                <%

                Database.connect();
                List<Dog> dogs = Database.jdbi.withExtension(DogDao.class, dao -> dao.getAllDogs());
                List<User> users = Database.jdbi.withExtension(UserDao.class, dao -> dao.getAllUsers());
                for (Dog dog : dogs){
                        %>
                        <div class="col mb-5">
                            <div class="card shadow h-100">
                                <img src="../AA_pictures/<%= dog.getPicture() %>" class="card-img-top" style="object-fit: cover" width="100%" height="225">

                                <div class="card-body">
                                    <p class="card-text"><strong><%= dog.getName() %></strong></p>
                                    <p class="card-text"><%= dog.getDescription() %></p>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div class="btn-group">
                                            <form method="post" action="AdoptDogServlet" id="adoption-form">
                                                <input type="hidden" name="dog_id" value="<%= dog.getId() %>">
                                            <select name="user_id" class="form-select mb-3 d-block"  id="inputuser" >
                                                <% for (User user : users) { %>
                                                <option value="<%=user.getId()%>" name="user_id"><%=user.getName()%></option>
                                                <% } %>
                                            </select>
                                            <button type="submit" class="btn btn-sm btn-outline-primary mr-1" id="adopt-button">Crear adopción</button>
                                            </form>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%
                    }
                }%>
        </div>
    </div>





<%@include file="includes/footer.jsp"%>