<%-- 
    Document   : list_all
    Created on : 7/11/2024, 9:52:59 p. m.
    Author     : Juan pablo Blanco
--%>

<%@page import="java.util.List"%>
<%@page import="Domain.Model.User"%>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lista de Usuario</title>
    </head>
    <body>
        <h1>Lista de Usuarios</h1>
        <%-- Mensajes de error o éxito --%>
        <% if (request.getAttribute("errorMessage") != null) { %>
        <p style="color:red;"><%= request.getAttribute("errorMessage") %></p>
        <% } %>
        <% if (request.getAttribute("successMessage") != null) { %>
        <p style="color:green;"><%= request.getAttribute("successMessage") %></p>
        <% } %>

        <%-- Tabla para mostrar la lista de usuarios --%>
        <table border="1">
            <thead>
                <tr>
                    <th>Cédula</th>
                    <th>Nombre</th>
                    <th>Apellidos</th>
                    <th>Email</th>
                    <th>Teléfono</th>
                    <th>Rol</th>
                    <th>Estado</th>
                    <th>Fecha de Registro</th>
                    <th>Acciones</th>
                    <th>Facturas</th>
                    <th>Id usuario</th> <!-- Aquí es donde añades la columna para el ID usuario -->
                </tr>
            </thead>
            <tbody>
                <% 
                List<User> users = (List<User>) request.getAttribute("users");
                if (users != null && !users.isEmpty()) {
                    for (User user : users) {
                %>
                <tr>
                    <td><%= user.getCedula() %></td>
                    <td><%= user.getNombre() %></td>
                    <td><%= user.getApellidos() %></td>
                    <td><%= user.get() %></td>
                    <td>
                        <%-- Enlace mailto: para el cliente de correo interesante --%>
                        <a href="mailto:<%= user.getEmail() %>?subject= ¡Hola! Te escribe el departamento de donaciones del colegio o universidad  XXXXXX &body=Gracias por contribuir">
                            <%= user.getEmail() %>
                        </a>
                    </td>

                    <td><%= user.getTelefono() %></td>
                    <td><%= user.getRol() %></td>
                    <td><%= user.getEstado() %></td>
                    <td><%= user.getFecha_registro() %></td>
                    <td>
                        <a href="<%= request.getContextPath() %>/Controllers/UserController.jsp?action=search&code=<%= user.getCedula() %>">Editar</a> |
                        <a href="<%= request.getContextPath() %>/Controllers/UserController.jsp?action=delete&code=<%= user.getCedula() %>" onclick="return confirm('¿Seguro que deseas eliminar este usuario?');">Eliminar</a>
                        
                    </td>

                    <td>
                        <a href="<%= request.getContextPath() %>/Controllers/FacturaControllers.jsp?action=searchByUsuarioId&usuario_id=<%= user.getId() %>">Ver Facturas</a>
                    </td>

                    <!-- Aquí es donde añades el ID Estudiante -->
                    <td><%= user.getId() %></td> <!-- Muestra el ID Estudiante -->
                </tr>
                <% 
                    }
                } else {
                %>
                <tr>
                    <td colspan="10">No hay usuarios disponibles</td>
                </tr>
                <% 
                }
                %>
            </tbody>
        </table>

        <br>
        <a href="<%= request.getContextPath() %>/Controllers/UserController.jsp?action=showCreateForm">Agregar Nuevo Usuario</a>

    </body>
</html>
