<%-- 
    Document   : login
    Created on : 7/11/2024, 9:53:25 p. m.
    Author     : Administrador
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        <h1>Iniciar Sesion</h1>
        <%--Mensaje de error en caso de credenciales incorrectas  --%>
        <%-- if(request.getAttribute("errorMessage")!=null {%>
        <p style="color: red;"><%=request.getAttribute("errorMessage") %></p>
        <% } %>
        
        <%--Formulario de Login --%>
        <form action="<%= request.getContextPath() %>/Controllers/UserController.jsp?action=authenticate" method="post">
            <label for="email">Email: </label><br>
            <input type="email" id="email" name="email" required> <br><br>
            
            <label for="password">Contrasena </label><br>
            <input type="password" id="password" name="password" required> <br><br>
            
            <input type="submit" value ="Iniciar Sesion">
        </form>
        <br>
        <a href="<%= request.getContextPath() %>/index.jsp"> Volver a la pagina de inicio </a>
        
    </body>
</html>
