
package Domain.Model;

/**
 *
 * @author Juan Pablo Blanco :)
 */
public class User {
    
    private String cedula;
    private String id;
    private String username;
    private String password;
    private String nombre;
    private String apellidos;
    private String rol;
    private String email;
    private String telefono;
    private String estado;
    
    public  User(){
        
    }
    // Constructor
    public User(String cedula, String password, String username, String nombre, String apellidos, String rol, String email, String telefono, String estado) {
        this.cedula = cedula;
        this.password = password;
        this.username = username;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.rol = rol;
        this.email = email;
        this.telefono = telefono;
        this.estado = estado != null ? estado : "activo";
    }
    
    // Métodos getters
    public String getId() {
        return id;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public String getNombre() {
        return nombre;
    }

    public String getApellidos() {
        return apellidos;
    }

    public String getRol() {
        return rol;
    }

    public String getCedula() {
        if (cedula == null || cedula instanceof String) {
            throw new IllegalArgumentException("Expected a string, but got an array.");
        }
        return cedula;
    }

    public String getEmail() {
        return email;
    }

    public String getTelefono() {
        return telefono;
    }

    public String getEstado() {
        return estado;
    }

    // Métodos setters
    public void setEmail(String email) {
        this.email = email;
    }


    
}
