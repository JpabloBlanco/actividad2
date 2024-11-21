<%-- 
    Document   : agregar
    Created on : 7/11/2024, 9:51:37 p. m.
    Author     : Administrador
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agregar Usuario</title>
    </head>
    <body>
        <h1>Agregar Usuario</h1>
        
        <%--Mensaje de error o de exito  --%>
        <%-- if(request.getAttribute("errorMessage")!=null {%>
        <p style="color: red;"><%=request.getAttribute("errorMessage") %></p>
        <% } %>
        
        <%-- if(request.getAttribute("successMessage")!=null {%>
        <p style="color: greend;"><%=request.getAttribute("successMessage") %></p>
        <% } %>
       
        
        <%--Formulario para agregar Usuario --%>
        <form action="<%= request.getContextPath() %>/Controllers/UserController.jsp?action=create" method="post">
            <label for="cedula">cedula: </label><br>
            <input type="cedula" id="cedula" name="cedula" required> <br><br>
            
            <label for="nombre">nombre: </label><br>
            <input type="nombre" id="nombre" name="nombre" required> <br><br>
            
            <label for="email">Email: </label><br>
            <input type="email" id="email" name="email" required> <br><br>
            
            <label for="password">Contrasena </label><br>
            <input type="password" id="password" name="password" required> <br><br>
            
            <input type="submit" value ="Iniciar Sesión">
        </form>
        <br>
        <a href="<%= request.getContextPath() %>/index.jsp"> Volver a menu principal </a>
        
    </body>
</html>
