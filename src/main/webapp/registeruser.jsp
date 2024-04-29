<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/header.jsp"%>

<script type="text/javascript">
    $(document).ready(function () {
        $("#register-button").click(function (event) {
            event.preventDefault();
            const form = $("#register-form")[0];
            const data = new FormData(form);

            $("#register-button").prop("disabled", true);

            $.ajax({
                type: "POST",
                enctype: "multipart/form-data",
                url: "RegisterServlet",
                data: data,
                processData: false,
                contentType: false,
                cache: false,
                timeout: 600000,
                success: function (data) {
                    $("#result").html(data);
                    $("#register-button").prop("disabled", false);
                },
                error: function (error) {
                    $("#result").html(error.responseText);
                    $("#register-button").prop("disabled", false);
                }
            });
        });
    });
</script>



<main class="form-signin w-100 m-auto">
    <div class="container mt-5">
        <div class="row">
            <div class="col">
            </div>
            <div class="col">
                <h1 class="h3 mb-3 fw-normal">Registro de nuevo usuario</h1>
                <form method="post" enctype="multipart/form-data" id="register-form">
                    <div class="mb-3 form-floating">
                        <label for="inputNombre" class="form-label">Nombre</label>
                        <input type="text" class="form-control" id="inputNombre" name="name" placeholder="Nombre" >
                    </div>

                    <div class="mb-3 form-floating">
                        <label for="inputUsuario" class="form-label">Usuario</label>
                        <input type="text" class="form-control" id="inputUsuario" name="username" placeholder="Usuario" >
                    </div>


                    <div class="mb-5 form-floating">
                        <label for="inputPassword" class="form-label">Contraseña</label>
                        <input type="password" class="form-control" id="inputPassword" name="password" placeholder="*********" >
                    </div>

                    <button type="submit" class="btn btn-primary" id="register-button">Registrarse</button>


                </form>
            </div>
            <div class="col">
            </div>
        </div><br/>
        <div class="container">
            <div class="col"></div>
            <div id="result"></div>
            <div class="col"></div>
        </div>
    </div>

</main>

<%@include file="includes/footer.jsp"%>
