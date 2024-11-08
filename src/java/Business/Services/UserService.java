package Business.Services;

/**
 *
 * @author Juan Pablo Blanco v
 */
import Domain.Model.User;
import Business.Exceptions.UserNotFoundException;
import Business.Exceptions.DuplicateUserException;
import Infraestructure.Persistence.UserCRUD;
import java.sql.SQLException;
import java.util.List;

public class UserService {

    private UserCRUD userCrud;

    // Constructor
    public UserService() {
        this.userCrud = new UserCRUD();
    }

    // Método para obtener todos los usuarios
    public List<User> getAllUsers() throws SQLException {
        return userCrud.getAllUsers();
    }

    // Método para agregar un nuevo usuario
    public void createUser(String cedula, String password, String username, String nombre, String apellidos, String rol, String email, String telefono, String estado)
            throws DuplicateUserException, SQLException {
        User user = new User(cedula , password , username , nombre,apellidos,rol, email, telefono, estado);
        userCrud.addUser(user);
    }

    // Método para actualizar un usuario
    public void updateUser(String cedula, String password, String username, String nombre, String apellidos, String rol, String email, String telefono, String estado)
            throws UserNotFoundException, SQLException {
        User user = new User(cedula , password , username , nombre,apellidos,rol, email, telefono, estado);
        userCrud.updateUser(user);
    }

    // Método para eliminar un usuario
    public void deleteUser(String code) throws UserNotFoundException, SQLException {
        userCrud.deleteUser(code);
    }

    // Método para obtener un usuario por código
    public User getUserByCode(String code) throws UserNotFoundException, SQLException {
        return userCrud.getUserByCode(code);
    }

    // Método para autenticar un usuario (login)
    public User loginUser(String email, String password) throws UserNotFoundException, SQLException {
        // Usamos el nuevo método getUserByEmail en lugar de obtener todos los usuarios
        User user = userCrud.getUserByEmail(email);

        if (user != null && user.getPassword().equals(password)) {
            return user;
        } else {
            throw new UserNotFoundException("Credenciales incorrectas. No se encontró el usuario o la contraseña es incorrecta.");
        }
    }

    // Método para buscar usuarios por nombre o email
    public List<User> searchUsers(String searchTerm) {
        return userCrud.searchUsers(searchTerm);
    }
}
