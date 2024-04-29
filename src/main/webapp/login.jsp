<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/header.jsp"%>

<script type="text/javascript">
    $(document).ready(function() {
        $("form").on("submit", function(event) {
            event.preventDefault();
            const formValue = $(this).serialize();
            $.ajax("LoginServlet", {
                type: "POST",
                data: formValue,
                statusCode: {
                    200: function(response) {
                        if (response === "ok") {
                            window.location.href = "/ActividadAprendizaje";
                        } else {
                            $("#result").html(response);
                        }
                    }
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
        <h1 class="h3 mb-3 fw-normal">Inciar Sesión</h1>
    <form>
        <div class="mb-3 form-floating">
            <label for="inputUsuario" class="form-label">Usuario</label>
            <input type="text" class="form-control" id="inputUsuario" name="username" placeholder="Usuario" >
        </div>

        <div class="mb-5 form-floating">
            <label for="inputPassword" class="form-label">Contraseña</label>
            <input type="password" class="form-control" id="inputPassword" name="password" placeholder="*********" >
        </div>

        <button type="submit" class="btn btn-primary">Iniciar Sesión </button>
        <a href="registeruser.jsp" class="btn btn-secondary">Registrarse </a>

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
