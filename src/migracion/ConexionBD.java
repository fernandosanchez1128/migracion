/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package migracion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author fernando
 */
public class ConexionBD {
    private Connection con = null;
    private String driverBd = "";
    private String urlBd = "";
    private String usuarioBd = "";
    private String passwordBd = "";

    public ConexionBD() {
    }

    public Connection getConexion() throws SQLException {
        return conectarBD();
    }

    public Connection conectarBD() throws SQLException {
        Connection con = null;

        try {
            // String driver = "com.mysql.jdbc.Driver"; // driver para Mysql
            String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"; // driver para Mysql


            // Declaración de valores
            //     String url = "jdbc:mysql://localhost/utez-test"; // Cadena de conexión para mysql
            String url = "jdbc:sqlserver://FERNANDO-PC\\KDD:1433;"
                    + "databaseName=AdventureWorksDW2014 ;integratedSecurity=false;";  // Cadena de conexión para mysql

            String login = "fernando";
            String password = "fernando1128";

            // Cargar Driver
            Class.forName(driver);

            // Realiza la conexión a la B.D.
            con = (Connection) DriverManager.getConnection(url, login, password);

            System.out.println("Conexión exitosa");

        } catch (ClassNotFoundException e) {
            System.out.println("No se pudo cargar el driver " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("SQLException atrapada " + e.getMessage());
            e.printStackTrace();
        }

        return con;

    }
    
    
    public Connection conectarPostgres() throws SQLException {
        Connection conexion = null;
        String url,usuario,password;
        url = "jdbc:postgresql://localhost:5432/AdventureWorksDW2014";
        usuario="fernando";
        password="fernando1128";
         //System.out.println("Entro metodo");
            try {
            // Se carga el driver
              //Class.forName("PostgreSQL");
            Class.forName("org.postgresql.Driver");
            //Class.forName("/home/daniel/Documents/Work/GitProjects/SISCONDOC/postgresql-9.0-801.jdbc3.jar");
            System.out.println( "Driver Cargado" );
            } catch( Exception e ) {
                System.out.println( "No se pudo cargar el driver." );
            }

            try{
                     //Crear el objeto de conexion a la base de datos
                     conexion = DriverManager.getConnection(url, usuario, password);
                     System.out.println( "Conexion Abierta" );
                     return conexion;
                  //Crear objeto Statement para realizar queries a la base de datos
             } catch( Exception e ) {
                System.out.println( "No se pudo abrir la bd." );
                return null;
             }

        }


    
    public void cerrar(PreparedStatement ps){
        try {
            ps.close();
        } catch (SQLException ex) {
            
        }
    }
    
    public void cerrar(Connection conn){
        try {
            conn.close();
        } catch (SQLException ex) {
        
        }
    }
    
    public void cerrar(ResultSet rs){
        try {
            rs.close();
        } catch (SQLException ex) {
         
        }
    }
    
    
  
}
