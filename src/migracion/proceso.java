/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package migracion;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;


/**
 *
 * @author fernando
 */
public class proceso {
     ConexionBD conexion;
     static DatabaseMetaData metadatos;
     
     proceso () {
        conexion = new ConexionBD();      
     }
     
     public void leer () throws SQLException
     {
         Connection conn = conexion.conectarBD();
         Statement stmt = conn.createStatement();
         
      
         
     ResultSet rs = stmt.executeQuery("SELECT * FROM dbo.dimScenario");
     Connection con_postgres = conexion.conectarPostgres();
     Statement stmt_post = con_postgres.createStatement();
     String sql_save ="";
         
     while (rs.next())
     {
         ResultSetMetaData rsMd = rs.getMetaData();
         int cantidadColumnas = rsMd.getColumnCount();
         sql_save = "INSERT INTO dimscenario values (";
         for (int i=1;i<=cantidadColumnas;i++)
         {
                if (i!=cantidadColumnas)
                {
                    sql_save += "'"+rs.getObject(i)+"'"+",";
                }
                else
                {
                    sql_save += "'" +rs.getObject(i)+"'";
                }
                
         }
         sql_save +=");";
         System.out.println(sql_save);
         stmt_post.executeUpdate(sql_save);
     }
         
     
     
     
         
     }
     
     
       public static void main(String[] args) throws SQLException {
           proceso process =  new proceso();
           process.leer();
        

    }
             
    
}
