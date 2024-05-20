
<html>
<head>
    <meta charset="UTF-8">
    <title>Protectora de animales San Valero</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="icon" type="image/x-icon" href="icons/favicon.svg">

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>

    <%
    HttpSession currentSession = request.getSession();
    String role = "anonymous";
    String username = "none";
    String name = "none";
    int userId  ;

    if (currentSession.getAttribute("role") != null) {
        role = currentSession.getAttribute("role").toString();
        name = currentSession.getAttribute("name").toString();
        username = currentSession.getAttribute("username").toString();
        userId = Integer.parseInt(currentSession.getAttribute("id").toString());
    }else {userId=0;}
%>





<header class="p-3 mb-3 border-bottom bg-white">
    <div class="container">

        <div class="d-flex flex-wrap align-items-center justify-content-around">
            <a href="index.jsp" class="d-flex align-items-center mb-2 mb-lg-0 link-body-emphasis text-decoration-none">
                <svg xmlns="http://www.w3.org/2000/svg" width="40" height="32" fill="currentColor" class="bi bi-house-heart" viewBox="0 0 16 16">
                    <path d="M8 6.982C9.664 5.309 13.825 8.236 8 12 2.175 8.236 6.336 5.309 8 6.982"/>
                    <path d="M8.707 1.5a1 1 0 0 0-1.414 0L.646 8.146a.5.5 0 0 0 .708.707L2 8.207V13.5A1.5 1.5 0 0 0 3.5 15h9a1.5 1.5 0 0 0 1.5-1.5V8.207l.646.646a.5.5 0 0 0 .708-.707L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293zM13 7.207V13.5a.5.5 0 0 1-.5.5h-9a.5.5 0 0 1-.5-.5V7.207l5-5z"/>
                </svg>
                <div class="badge text-bg-primary text-wrap" style="width: 6rem;">
                    Protectora de Animales San Valero
                </div>
            </a>

            <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-around mb-md-0">
                <li><a href="index.jsp" class="nav-link px-2 link-secondary">Perros</a></li>
                <li><a href="adoptions.jsp" class="nav-link px-2 link-body-emphasis">Adopciones</a></li>
                <% if(role.equals("admin")) { %>
                <li><a href="requestlist.jsp" class="nav-link px-2 link-body-emphasis">Peticiones</a></li>
                <li><a href="userlist.jsp" class="nav-link px-2 link-body-emphasis">Usuarios</a></li>
                <% } %>
                <% if(!role.equals("anonymous")) { %>
                <li><a href="favs.jsp" class="nav-link px-2 link-body-emphasis">Favoritos</a></li>
                <% } %>
            </ul>



            <div class="  text-end">
                <a href="#" class="d-block link-body-emphasis text-decoration-none dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                    <img src="icons/user.png" alt="mdo" width="32" height="32" class="rounded-circle">
                </a>
                <ul class="dropdown-menu text-small" style="">
                    <% if(role.equals("anonymous")) { %>
                    <li><a class="dropdown-item" href="login.jsp">Iniciar Sesi&oacuten</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item" href="registeruser.jsp">Registrarse</a></li>
                    <% } else { %>
                    <li><a class="dropdown-item" href="profile.jsp">Perfil</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item" href="LogoutServlet">Cerrar Sesi&oacuten</a></li>
                    <% } %>


                </ul>
            </div>
        </div>
    </div>

</header>

