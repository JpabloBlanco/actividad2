
package Business.Exceptions;

/**
 *
 * @author Administrador
 */
public class DuplicateUserException extends Exception{
    public DuplicateUserException(String message){
        super(message);
    }
}