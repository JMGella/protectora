
<%@ page import="com.svalero.aa.dao.Database" %>
<%@ page import="com.svalero.aa.domain.User" %>
<%@ page import="com.svalero.aa.dao.UserDao" %>
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
        <a href="favs.jsp" type="button" class="btn btn-lg btn-outline-primary btn-lg px-4 me-md-2 mr-2" >Tus Favoritos</a>
            <a href="registeruser.jsp?=id<%=user.getId()%>" type="button" class="btn btn-lg btn-outline-primary btn-lg px-4 me-md-2 mr-2" > Modifica tus datos</a>
      </div>
    </div>



</div>

<%
}
%>


<%@include file="includes/footer.jsp"%>