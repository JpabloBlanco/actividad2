
package Infraestructure.Database;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Juan pablo Blanco :)
 */
public class ConnectionDbMySql {

    private static final String URL = "jdbc:mysql://root@localhost/ejercicio4";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    private static final String DRIVER = "com.mysql.jdbc.Driver";

    //metodo para devolver la base de datos
    public static Connection getConnection() throws SQLException {
        Connection connection = null;
        try {
            Class.forName(DRIVER);
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new SQLException("Error: No se encontro el Driver Mysql");
        } catch (SQLException e) {
            e.printStackTrace();
            //var message = "Erro: No se pudo establecer la conexion con la base de datos";
            String message = "Erro: No se pudo establecer la conexion con la base de datos";
            throw new SQLException(message);
        }
        return connection;
    }

}
