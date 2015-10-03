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
import java.util.ArrayList;


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
     
     /**
      * @brief metodo principal encargado de realizar la migracion de los datos 
      * de sql-server a postgresql.
      * @return  migracion de la base de datos
      * @throws SQLException captura las excepciones sql
      */
     public void migracion () throws SQLException
     {
         //conexion a sql-server
         Connection conn = conexion.conectarBD();
         Statement stmt = conn.createStatement();
         
    //arreglo con el nombre de las tablas  
     String [] tablas = {
         "AdventureWorksDWBuildVersion",    "DimProductCategory",
         "DimProductSubcategory",   "DimPromotion",
         "DatabaseLog",     "DimAccount",
         "DimCurrency",     "DimSalesTerritory",
         "DimGeography",    "DimProduct",
         "DimCustomer",     "DimDate",  
         "DimDepartmentGroup",   "DimEmployee",   
         "DimOrganization",  "DimReseller",
         "DimSalesReason",  "DimScenario",
         "FactAdditionalInternationalProductDescription",   "FactCallCenter",
         "FactCurrencyRate",    "FactFinance",
         "FactInternetSales",   "FactInternetSalesReason",
         "FactProductInventory",    "FactResellerSales",
         "FactSalesQuota",  "FactSurveyResponse",
         "NewFactCurrencyRate", "ProspectiveBuyer",
     };
     
     //conexion a postgres
     Connection con_postgres = conexion.conectarPostgres();
     Statement stmt_post = con_postgres.createStatement();
     
     for (int index=1; index <= tablas.length;index++)
     {
         //caso especial de tablas recursivas
         if (tablas[index-1] != "DimEmployee" && tablas[index-1] !="DimOrganization")
         {
     
            //consulta a sql-server para traer los datos 
            String sql_consulta =  "SELECT * FROM " + "dbo."+tablas[index-1];

            ResultSet rs = stmt.executeQuery(sql_consulta);

            String sql_save ="";
            
            //while donde se hace el paso de los datos
            while (rs.next())
            {
                ResultSetMetaData rsMd = rs.getMetaData();
                int cantidadColumnas = rsMd.getColumnCount();
                sql_save = "INSERT INTO \"" + tablas[index-1] + "\" values (";
                for (int i=1;i<=cantidadColumnas;i++)
                {
                    ResultSetMetaData meta = rs.getMetaData();
                       if (i!=cantidadColumnas)
                       {
                           if (rs.getObject(i) != null && meta.getColumnTypeName(i) != "bit")
                           {   
                               String texto = rs.getString(i);
                               String new_text = texto.replaceAll("'", "");

                            sql_save += "'"+new_text+"'"+",";
                           }
                           else
                           {   
                               if (meta.getColumnTypeName(i) == "bit")
                               {
                                   boolean bool= rs.getBoolean(i);
                                   if (bool)
                                   {
                                        sql_save += "1"+",";
                                   }
                                   else
                                   {
                                       sql_save += "0" +",";
                                   }
                               }
                               else
                               {
                                   sql_save += rs.getObject(i)+",";
                               }


                           }
                       }
                       else
                       {
                           if (rs.getObject(i) != null && meta.getColumnTypeName(i) != "bit")
                           {
                               String texto = rs.getString(i);
                               String new_text = texto.replaceAll("'", "");
                            sql_save += "'" +new_text+"'";
                           }
                           else
                           {
                               if (meta.getColumnTypeName(i) == "bit")
                               {
                                   boolean bool= rs.getBoolean(i);
                                   if (bool)
                                   {
                                        sql_save += "1";
                                   }
                                   else
                                   {
                                       sql_save += "0";
                                   }
                               }
                               else
                               {

                                   sql_save += rs.getObject(i);
                               }
                           }
                       }

                }
                sql_save +=");";
                System.out.println(sql_save);
                stmt_post.executeUpdate(sql_save);
               }
         } 
         else
     {
             tabla_recursiva(tablas[index-1]);
             
     }
     }
     
     }
     
     /**
      * @brief metodo que se encarga de pasar las tablas recursivas, pasa 
      * todos los datos menos la columna que tiene referencia a ella misma ya que
      * genera exepcion por restriccion de llave foranea.
      * @param name nombre de la tabla que tieen una relacion recursiva
      * @throws SQLException 
      */
     public void tabla_recursiva (String name) throws SQLException
     {
         Connection conn = conexion.conectarBD();
         Statement stmt = conn.createStatement();
         Connection con_postgres = conexion.conectarPostgres();
         Statement stmt_post = con_postgres.createStatement();
         String sql_consulta =  "SELECT * FROM " + "dbo." + name;

            ResultSet rs = stmt.executeQuery(sql_consulta);

            String sql_save ="";

            while (rs.next())
            {
                ResultSetMetaData rsMd = rs.getMetaData();
                int cantidadColumnas = rsMd.getColumnCount();
                sql_save = "INSERT INTO \"" + name + "\" values (";
                for (int i=1;i<=cantidadColumnas;i++)
                {
                    ResultSetMetaData meta = rs.getMetaData();
                    if (i!=cantidadColumnas)
                    {
                        if (i!=2)
                        {
                            if (rs.getObject(i) != null && meta.getColumnTypeName(i) != "bit")
                           {   
                               String texto = rs.getString(i);
                               String new_text = texto.replaceAll("'", "");

                            sql_save += "'"+new_text+"'"+",";
                           }
                           else
                           {   
                               if (meta.getColumnTypeName(i) == "bit")
                               {
                                   boolean bool= rs.getBoolean(i);
                                   if (bool)
                                   {
                                        sql_save += "1"+",";
                                   }
                                   else
                                   {
                                       sql_save += "0" +",";
                                   }
                               }
                               else
                               {
                                   sql_save += rs.getObject(i)+",";
                               }


                           }
                        }
                        else
                        {
                            sql_save +="null" +",";
                        }
                    }
                    else
                    {
                        sql_save += "'"+rs.getObject(i)+"'";
                    }
                }
                   sql_save +=");";
            System.out.println(sql_save);
                stmt_post.executeUpdate(sql_save);
            }
            actualizar_padre(name);
     }
     
     /**
      * @brief despues de pasar los datos de las tablas recursivas
      * este metodo se encarga de actualizar la columna que se referencia a 
      * ella misma.
      * @param name nombre de la tabla
      * @throws SQLException 
      */
     public void actualizar_padre(String name) throws SQLException
     {
         Connection conn = conexion.conectarBD();
         Statement stmt = conn.createStatement();
         Connection con_postgres = conexion.conectarPostgres();
         Statement stmt_post = con_postgres.createStatement(); 
         String sql_consulta =  "SELECT * FROM " + "dbo." + name;
         ResultSet rs = stmt.executeQuery(sql_consulta);
                
         while (rs.next())
         {
            ResultSetMetaData rsMd = rs.getMetaData();
            String pk = rsMd.getColumnName(1);
            String nombre_columna = rsMd.getColumnName(2);
            String sql_update = "";
            if (rs.getObject(2) != null)
            {
                sql_update = "UPDATE \"" + name + "\" SET \"" + nombre_columna + "\" ='" +
                rs.getObject(2) + "' WHERE \""+ pk + "\" ='" + rs.getObject(1)+"'";
                System.out.println(sql_update);
            }
            else
            {
                sql_update = "UPDATE \"" + name + "\" SET \"" + nombre_columna + "\" =" +
                rs.getObject(2) + " WHERE \""+ pk + "\" ='" + rs.getObject(1)+"'";
                System.out.println(sql_update);
            }
            stmt_post.executeUpdate(sql_update);
         }
         
     }
       public static void main(String[] args) throws SQLException {
           proceso process =  new proceso();
           process.migracion();
        

    }
             
    
}
