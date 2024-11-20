<%-- 
    Document   : find_edit_delete
    Created on : 7/11/2024, 9:52:25 p. m.
    Author     : Juan pablo Blanco
--%>

<%@page import = "Domain.Model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Buscar, editar o eliminar Usuario</title>
        <script>
            //Funcion: Habilitar botones, Editar y Eliminar
            function enableButtons() {
                document.getElementById("editBtn").disabled = false;
                document.getElementById("deleteBtn").disabled = false;
            }

            // Funcion para deshabilitar los botones de Editar y Eliminar
            function disableButtons() {
                document.getElementById("editBtn").disabled = true;
                document.getElementById("deleteBtn").disabled = true;
            }

            // Funcion: cambiar accion gormulario y confrimar la eliminacion
            function setActionAndSubmit(action, confirmMessage) {
                if (confirmMessage) {
                    if (!confirm(confirMessage)) {

                    }
                }
                document.getElementById("actionInput").value = action;
                document.getElementById("deleteBtn").submit();
            }
        </script>
    </head>
    <body onload="<%=(session.getAttribute("searchedUser") !=null)? "enableButtons" : "disableButtons()" %>">
        <h1>Buscar, editar o eliminar Usuario</h1>

        <%--Mensaje de error o de exito  --%>
        <%-- if(request.getAttribute("errorMessage")!=null { %>
        <p style="color: red;"><%=request.getAttribute("errorMessage") %></p>
        <% } %>
        
        <%-- if(request.getAttribute("successMessage") !=null {%>
        <p style="color: greend;"><%=request.getAttribute("successMessage") %></p>
        <% } %>
       
        
        <%--Formulario para buscar, editar y eliminar --%>
        <form id = "userForm" action ="<%= request.getContextPath() %>/Controllers/UserController.jsp" method="post">
            <!-- El balor cambiara dinamicamente -->
            <input type="hidden" id="actionInput" name="action" value ="search">

            <label for="search">Codigo del usuario: </label><br>
            <input type="text" id="cedula" name="cedula" required value="
                   <%= session.getAtribute("searcheUser") != null ?
                           ((User)session.getAttribute("searchedUser")).getCedula()
                           : ""%>">
            <br><br>
            <%-- Detalles del usuario (despues de la busqueda) --%>
            <% User sessionUser = (User) session.getAttribute("searchedUser");%>

            <% if (sessionUser != null){%>
            <h3> Detaller del Usuario </h3>
            <p> <strong>Cedula: </strong> <%= sessionUser.getCedula() %> </p>
            <p> <strong>Nombre: </strong> <%= sessionUser.getNombre() %> </p>
            <p> <strong>Email: </strong> <%= sessionUser.getEmail() %> </p>
            label for="email">Email: </label><br>

        <label for="Nombre">Nuevo Nombre </label><br>
        <input type="text" id="nombre" name="nombre" value"<%= sessionUser.get.Nombre()%>" required>

        <label for="Email">Nuevo Email </label><br>
        <input type="text" id="Email" name="Email" value"<%= sessionUser.get.Email()%>" required>

        <label for=password"">Nuevo password </label><br>
        <input type="text" id="password" name="password" value"<%= sessionUser.get.Password()%>" required>
        <%} else { %>
        <p> No se ha buscado nigun usuario aun o le usuario no fue encontrado.</p>
        <% } %>


        <br>

        <%--Botones en la misma fila --%>
        <button type ="submit" onclick="setActionAndSubmit('search')"
                id ="searchBtn">Buscar Usuario</button>
        <button type="button" id="editBtn" disabled
                onclick="setActionAndSubmit('update', '?seguro que deseas editar este usuario?')">
            editar Usuario
        </button>

        <button type="button" id="deleteBtn" disabled
                onclick="setActionAndSubmit('delete', '?seguro que deseas eliminar este usuario?')">
            editar Usuario
        </button>

    </form>

    <br>
    <a href="<%= request.getContextPath() %>/index.jsp"> Menu principal </a>

</body>
</html>
