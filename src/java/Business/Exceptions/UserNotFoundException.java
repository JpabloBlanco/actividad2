
package Business.Exceptions;

/**
 *
 * @author Administrador
 */
public class UserNotFoundException extends Exception {
    public UserNotFoundException(String message){
        super(message);
    }
}