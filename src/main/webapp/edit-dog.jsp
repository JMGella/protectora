<%@ page import="com.svalero.aa.domain.Dog" %>
<%@ page import="com.svalero.aa.dao.Database" %>
<%@ page import="com.svalero.aa.dao.DogDao" %>
<%@ page import="java.sql.SQLException" %>
<%@include file="includes/header.jsp"%>>

<script>
    $(document).ready(function () {
        $("#edit-button").click(function (event) {
            event.preventDefault();
            const form = $("#edit-form")[0];
            const data = new FormData(form);

            $("#edit-button").prop("disabled", true);

            $.ajax({
                type: "POST",
                enctype: "multipart/form-data",
                url: "EditDogServlet",
                data: data,
                processData: false,
                contentType: false,
                cache: false,
                timeout: 600000,
                success: function (data) {
                    $("#result").html(data);
                    $("#edit-button").prop("disabled", false);
                },
                error: function (error) {
                    $("#result").html(error.responseText);
                    $("#edit-button").prop("disabled", false);
                }
            });
        });
    });


</script>

<%

    if (!role.equals("admin")) {
        response.sendRedirect("index.jsp");
    }

    int id;
    Dog dog = null;
    if (request.getParameter("id") == null) {
        id = 0;
    } else {
        id = Integer.parseInt(request.getParameter("id"));
        try {
            Database.connect();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        dog = Database.jdbi.withExtension(DogDao.class, dao -> dao.getDog(id));
    }
%>

<main>

    <div class="container">
        <% if (id == 0) { %>
        <h1 class="mb-5">Registrar Perro</h1>
        <% } else { %>
        <h1 class="mb-5">Modificar Ficha de <%=dog.getName()%></h1>
        <% } %>
        <form class="row g-3 needs-validation"  method="post" enctype="multipart/form-data" id="edit-form">
            <div class="col-md-4">
                <label for="inputNombre" class="form-label">Nombre (Obligatorio)</label>
                <input type="text" name="name" class="form-control" id="inputNombre" placeholder="El nombre del perrito" <% if (id != 0) { %> value="<%= dog.getName() %>"<% } %>>
            </div>

            <div class="col-md-4">
                <label for="inputFecha"  class="form-label">Fecha de Nacimiento</label>
        <input type="date" name="birth" class="form-control"  id="inputFecha" <% if (id != 0) { %> value="<%= dog.getBirth() %>"<% } %>>
    </div>
    <div class="col-md-4">
        <label for="inputSexo"  class="form-label">Sexo (Obligatorio)</label>
    <select name="sex" class="form-select mb-3 d-block"  id="inputSexo" aria-label="Default select example" >
        <% if (id != 0) { %> <option hidden value=""><%= dog.getSex() %></option> <% } else { %>
        <option hidden value="">Elige uno</option> <% } %>
        <option value="Macho">Macho</option>
        <option value="Hembra">Hembra</option>

    </select>
    </div>

    <div class="col-md-4">
        <label for="inputRaza"  class="form-label">Raza</label>
        <input type="text" name="breed" class="form-control"  id="inputRaza" placeholder="Labrador, Boxer, Mestizo... " <% if (id != 0) { %> value="<%= dog.getBreed() %>"<% } %>" >
    </div>


    <div class="col-md-4">
        <label for="inputPeso"  class="form-label">Peso</label>
        <input type="text" name="weight" class="form-control" id="inputPeso" placeholder="XX Kg"  <% if (id != 0) { %> value="<%= dog.getWeight() %>"<% } %>">
    </div>

        <div class="col-md-4">
            <label for="inputFoto" class="form-label">Foto</label>
            <input type="file" name="picture" class="form-control"  id="inputFoto">
        </div>

    <div class="input-group justify-content-center mt-4">
        <span class="input-group-text">Describe al perro (Obligatorio)</span>
        <textarea name="description" class="form-control"  id="inputDescripcion" > <% if (id != 0) { %> <%=dog.getDescription() %> <% } %> </textarea>
        <span class="input-group-text" id="contador"></span>
    </div>
<div class="mt-4 justify-content-center">
    <input type="hidden" name="id" value="<%= id %>"/>

        <input class="btn btn-outline-primary btn-lg"  <% if (id != 0) { %> value="Actualizar ficha"<% } else { %> value="Registrar Perro" <% } %> id="edit-button" type="submit">
</div>

    </form>

        <script>


            const descripcion = document.getElementById('inputDescripcion');
            const contador = document.getElementById('contador');
            descripcion.addEventListener('input', function(e) {
                const target = e.target;
                const longitudAct = target.value.length;
                contador.innerHTML = longitudAct + `/250`;

                if (longitudAct > 250) {
                    descripcion.style.borderColor = 'red';
                    contador.style.color = 'red';
                    document.getElementById('edit-button').disabled = true;
                }

            });
        </script>
    <div id="result"></div>

</div>

</main>


<%@include file="includes/footer.jsp"%>