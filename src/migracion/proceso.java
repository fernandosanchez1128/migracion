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
     
     public void leer () throws SQLException
     {
         Connection conn = conexion.conectarBD();
         Statement stmt = conn.createStatement();
         
      
     String [] tablas = {
//         "dbo.AdventureWorksDWBuildVersion","adventure_works_dwbuild_version",
//         "dbo.DimProductCategory","dim_product_category",
//         "dbo.DimProductSubcategory","dim_product_subcategory","dbo.DimPromotion","dim_promotion",
//         "dbo.DatabaseLog","database_log","dbo.DimAccount","dim_account",
//         "dbo.dimCurrency","dim_currency",
//         "dbo.DimSalesTerritory","dim_sales_territory",
//         "dbo.DimGeography","dim_geography", "dbo.DimProduct","dim_product",
//         "dbo.DimCustomer", "dim_customer", "dbo.dimDate","dim_date","dbo.DimDepartmentGroup","dim_department_group", 
         "dbo.DimEmployee","dim_employee", //problem
//         "dbo.DimOrganization","dim_organization", //problem
//         "dbo.DimReseller","dim_reseller","dbo.DimSalesReason","dim_sales_reason",
//         "dbo.DimScenario","dimscenario",
//         "dbo.FactAdditionalInternationalProductDescription","fact_additional_international_product_description",
//     "dbo.FactCallCenter","fact_call_center","dbo.FactCurrencyRate","fact_currency_rate",
//     "dbo.FactFinance","fact_finance","dbo.FactInternetSales","fact_internet_sales",
//     "dbo.FactInternetSalesReason","fact_internet_sales_reason","dbo.FactProductInventory","fact_product_inventory",
//     "dbo.FactResellerSales","fact_reseller_sales","dbo.FactSalesQuota","fact_sales_quota",
//     "dbo.FactSurveyResponse","fact_survey_response","dbo.NewFactCurrencyRate.","new_fact_currency_rate",
//     "dbo.ProspectiveBuyer","prospective_buyer"
     };
     
     Connection con_postgres = conexion.conectarPostgres();
     Statement stmt_post = con_postgres.createStatement();
     for (int index=1; index <= tablas.length;index+=2)
     {
         if (tablas[index] != "dim_employee" && tablas[index] !="dim_organization")
         {
     
            String sql_consulta =  "SELECT * FROM " + tablas[index-1];

            ResultSet rs = stmt.executeQuery(sql_consulta);

            String sql_save ="";

            while (rs.next())
            {
                ResultSetMetaData rsMd = rs.getMetaData();
                int cantidadColumnas = rsMd.getColumnCount();
                sql_save = "INSERT INTO " + tablas[index] + " values (";
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
             tabla_recursiva(tablas[index-1],tablas[index]);
             
     }
     }
     
     }
     
     public void tabla_recursiva (String name_sql_server, String name) throws SQLException
     {
         Connection conn = conexion.conectarBD();
         Statement stmt = conn.createStatement();
         Connection con_postgres = conexion.conectarPostgres();
         Statement stmt_post = con_postgres.createStatement();
         String sql_consulta =  "SELECT * FROM " + name_sql_server;

            ResultSet rs = stmt.executeQuery(sql_consulta);

            String sql_save ="";

            while (rs.next())
            {
                ResultSetMetaData rsMd = rs.getMetaData();
                int cantidadColumnas = rsMd.getColumnCount();
                sql_save = "INSERT INTO " + name + " values (";
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
            actualizar_pad
     }
     
     public void actualizar_padre()
       public static void main(String[] args) throws SQLException {
           proceso process =  new proceso();
           process.leer();
        

    }
             
    
}
