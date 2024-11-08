    
package Domain.Model;

/**
 *
 * @author Juan Pablo Blanco :)
 */
public class User {
    
    private String cedula;
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

    public String getCedula() {
        return cedula;
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

    public String getEmail() {
        return email;
    }

    public String getTelefono() {
        return telefono;
    }

    public String getEstado() {
        return estado;
    }

    public void setCedula(String cedula) {
        this.cedula = cedula;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
    
}
