<%-- 
    Document   : UserController
    Created on : 7/11/2024, 9:50:14?p. m.
    Author     : Administrador
--%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="Business.Exceptions.DuplicateUserException"%>
<%@page import="java.io.IOException"%> <!-- IMPORTACI'N DE IOException -->
<%@page import="jakarta.servlet.ServletException"%> <!-- IMPORTACI'N DE ServletException -->
<%@page import="jakarta.servlet.http.HttpServletRequest"%> <!-- IMPORTACI'N DE HttpServletRequest -->
<%@page import="jakarta.servlet.http.HttpServletResponse"%> <!-- IMPORTACI'N DE HttpServletResponse -->
<%@page import="jakarta.servlet.http.HttpSession"%> <!-- IMPORTACI'N DE HttpSession -->
<%@page import="Business.Services.UserService"%>
<%@page import="Domain.Model.User"%>
<%@page import="Business.Exceptions.UserNotFoundException"%>
<%@page import="Business.Exceptions.DuplicateUserException"%>

<%
    UserService userService = new UserService();
    String action = request.getParameter("action");
    if (action == null) {
        action = "list";
    }
    switch (action) {
        case "login":
            handleLogin(request, response, session);
            break;
        case "authenticate":
            handleAuthenticate(request, response, session, userService);
            break;
        case "showCreateForm":
            showCreateUserForm(request, response);
            break;
        case "create":
            handleCreateUser(request, response, userService);
            break;
        case "showFindForm":
            showFindForm(request, response, session, userService);
            break;
        case "search":
            handleSearch(request, response, session, userService);
            break;
        case "update":
            handleUpdateUser(request, response, session, userService);
            break;
        case "delete":
            handleDeleteUser(request, response, session, userService);
            break;
        case "deletefl":
            handleDeleteUserFromList(request, response, session, userService);
            break;
        case "listAll":
            handleListAllUsers(request, response, userService);
            break;
        case "logout":
            handleLogout(request, response, session);
            break;
        default:
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            break;
    }
%>

<%! 
    // Motodo para mostrar el formulario de login
    private void handleLogin(HttpServletRequest request, HttpServletResponse response, HttpSession session)
        throws ServletException, IOException {
        session.invalidate(); // Cerramos la sesión existente
        response.sendRedirect(request.getContextPath() + "/Views/Forms/Users/login.jsp");
    }

    // Método para autenticar el usuario
    private void handleAuthenticate(HttpServletRequest request, HttpServletResponse response, HttpSession session, UserService userService)
        throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            User loggedInUser = userService.loginUser(email, password);
            session.setAttribute("loggedInUser", loggedInUser); // Guardamos el usuario en la sesión
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } catch (UserNotFoundException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Users/login.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos. Inténtelo de nuevo.");
            request.getRequestDispatcher("/Views/Forms/Users/login.jsp").forward(request, response);
        }
    }

    // Mostrar el formulario para crear un usuario
    private void showCreateUserForm(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/Views/Forms/Users/create.jsp");
    }

    // Método para crear un nuevo usuario (después de enviar el formulario)
    private void handleCreateUser(HttpServletRequest request, HttpServletResponse response, UserService userService)
        throws ServletException, IOException {
        String cedula = request.getParameter("cedula");
        String password = request.getParameter("password");
        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String rol = request.getParameter("rol");
        String email = request.getParameter("email");
        String telefono = request.getParameter("telefono");
        String estado = request.getParameter("estado");;
        
        try {
            userService.createUser(cedula, password, nombre, apellidos, rol, email, telefono, estado);
            request.setAttribute("successMessage", "Usuario creado exitosamente.");
            handleListAllUsers(request, response, userService);
        } catch (DuplicateUserException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Users/create.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos. Inténtelo de nuevo.");
            request.getRequestDispatcher("/Views/Forms/Users/create.jsp").forward(request, response);
        }
    }

    // Mostrar el formulario para editar un usuario
    private void showFindForm(HttpServletRequest request, HttpServletResponse response, HttpSession session, UserService userService)
        throws ServletException, IOException {
        request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
    }

    // Método para buscar un usuario
    private void handleSearch(HttpServletRequest request, HttpServletResponse response, HttpSession session, UserService userService)
        throws ServletException, IOException {
        String searchCode = request.getParameter("cedula");
        try {
            User user = userService.getUserByCode(searchCode);
            session.setAttribute("searchedUser", user); // Guardamos el usuario en la sesión
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
        } catch (UserNotFoundException e) {
            session.removeAttribute("searchedUser"); // Limpiamos la sesión si no se encuentra el usuario
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos.");
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
        }
    }

    // Mostrar el formulario para editar un usuario
    private void showEditUserForm(HttpServletRequest request, HttpServletResponse response, HttpSession session, UserService userService)
        throws ServletException, IOException {
        String code = request.getParameter("cedula");
        try {
            User user = userService.getUserByCode(code);
            session.setAttribute("userToEdit", user); // Guardamos el usuario en sesión
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
        } catch (UserNotFoundException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Users/list_all.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos.");
            request.getRequestDispatcher("/Views/Forms/Users/list_all.jsp").forward(request, response);
        }
    }

    // Método para actualizar los datos del usuario
    private void handleUpdateUser(HttpServletRequest request, HttpServletResponse response, HttpSession session, UserService userService)
        throws ServletException, IOException {
        User searchedUser = (User) session.getAttribute("searchedUser");
        if (searchedUser == null) {
            request.setAttribute("errorMessage", "Primero debe buscar un usuario para editar.");
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
            return;
        }
        
        String cedula = searchedUser.getCedula();
        String password = request.getParameter("password");
        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String rol = request.getParameter("rol");
        String email = request.getParameter("email");
        String telefono = request.getParameter("telefono");
        String estado = request.getParameter("estado");
        
      
        try {
            userService.updateUser(cedula, password, nombre, apellidos, rol, email, telefono, estado);
            request.setAttribute("successMessage", "Usuario actualizado exitosamente.");
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
        } catch (UserNotFoundException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos.");
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
        }
    }

    private void handleDeleteUserFromList(HttpServletRequest request, HttpServletResponse response, HttpSession session, UserService userService)
        throws ServletException, IOException {
        var code = request.getParameter("cedula");
        if (code == null || code.trim().isEmpty()) {
            request.setAttribute("errorMessage", "El código es requerido");
            request.getRequestDispatcher("/Views/Forms/Users/list_all.jsp").forward(request, response);
            return;
        }
        try {
            userService.deleteUser(code);
            session.removeAttribute("searchedUser");
            request.setAttribute("successMessage", "Usuario eliminado exitosamente.");
            handleListAllUsers(request, response, userService);
        } catch (UserNotFoundException e) {
            request.setAttribute("errorMessage", e.getMessage());
            handleListAllUsers(request, response, userService);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos.");
            handleListAllUsers(request, response, userService);
        }
    }

    // Método para eliminar un usuario
    private void handleDeleteUser(HttpServletRequest request, HttpServletResponse response, HttpSession session, UserService userService)
        throws ServletException, IOException {
        User searchedUser = (User) session.getAttribute("searchedUser");
        if (searchedUser == null) {
            request.setAttribute("errorMessage", "Primero debe buscar un usuario para eliminar.");
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
            return;
        }
        String code = searchedUser.getCedula(); // Usamos el código del usuario buscado
        try {
            userService.deleteUser(code);
            session.removeAttribute("searchedUser");
            request.setAttribute("successMessage", "Usuario eliminado exitosamente.");
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
        } catch (UserNotFoundException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos.");
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
        }
    }

    // Método para listar todos los usuarios
    private void handleListAllUsers(HttpServletRequest request, HttpServletResponse response, UserService userService)
        throws ServletException, IOException {
        try {
            List<User> users = userService.getAllUsers();
            request.setAttribute("users", users);
            request.getRequestDispatcher("/Views/Forms/Users/list_all.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos al listar usuarios.");
            request.getRequestDispatcher("/Views/Forms/Users/list_all.jsp").forward(request, response);
        }
    }

    // Método para cerrar sesión
    private void handleLogout(HttpServletRequest request, HttpServletResponse response, HttpSession session)
        throws IOException {
        session.invalidate(); // Invalida la sesión actual
        response.sendRedirect(request.getContextPath() + "/Views/Forms/Users/login.jsp");
    }
%>
