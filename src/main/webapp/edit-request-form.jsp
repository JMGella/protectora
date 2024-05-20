<%@ page import="com.svalero.aa.dao.Database" %>
<%@ page import="com.svalero.aa.domain.Dog" %>
<%@ page import="com.svalero.aa.dao.DogDao" %>
<%@ page import="com.svalero.aa.domain.Request" %>
<%@ page import="com.svalero.aa.dao.RequestDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/header.jsp"%>

<script type="text/javascript">
    $(document).ready(function () {
        $("#request-button").click(function (event) {
            event.preventDefault();
            const form = $("#request-form")[0];
            const data = new FormData(form);

            $("#register-button").prop("disabled", true);

            $.ajax({
                type: "POST",
                enctype: "multipart/form-data",
                url: "EditRequestServlet",
                data: data,
                processData: false,
                contentType: false,
                cache: false,
                timeout: 600000,
                success: function (data) {
                    $("#result").html(data);
                    $("#request-button").prop("disabled", false);
                },
                error: function (error) {
                    $("#result").html(error.responseText);
                    $("#request-button").prop("disabled", false);
                }
            });
        });
    });
</script>

<%

    Database.connect();
    int dog_id = Integer.parseInt(request.getParameter("dog_id"));
    Dog dog = Database.jdbi.withExtension(DogDao.class, dao -> dao.getDog(dog_id));
    int req_id = Integer.parseInt(request.getParameter("req_id"));

%>




<main class="form-signin w-100 m-auto">
    <div class="container mt-5">
        <div class="row">
            <div class="col"> <img src="../AA_pictures/<%= dog.getPicture() %>" class="card-img-top" style="object-fit: cover" width="540"   </img>

            </div>
            <div class="col">
                <h1 class="h3 mb-3 fw-normal">Petición de adopción</h1>
                <form method="post" enctype="multipart/form-data" id="request-form">
                    <div class="mb-3 form-floating">
                        <label for="inputtexto" class="form-label">Cuentanos sobre ti y por que quieres adoptar a <%=dog.getName()%></label>
                        <textarea name="req_text" class="form-control"  id="inputtexto"></textarea>
                        <label for="inputCiudad" class="form-label">Tu ciudad</label>
                        <input type="text" class="form-control" id="inputCiudad" name="city" placeholder="Ciudad" >

                    </div>

                    <input type="hidden" name="dog_id" value="<%=dog_id%>"/>
                    <input type="hidden" name="req_id" value="<%=req_id%>"/>

                    <button type="submit" class="btn btn-primary" id="request-button">Enviar petición</button>


                </form>
            </div>

        </div><br/>
        <div class="container">
            <div class="col"></div>
            <div id="result"></div>
            <div class="col"></div>
        </div>
    </div>

</main>