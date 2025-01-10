/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.mydao;

import com.mycompany.testmaven.DatabaseConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author macbook
 */
public class MyDAO extends DatabaseConnection {
    protected Connection con = null;
    protected PreparedStatement ps = null;
    protected ResultSet rs = null;
    protected String xSql = null;

    public MyDAO() {
        this.con = connection;
    }
    
    public void finalize() {
     try {
        if(con != null) con.close();
     }
     catch(Exception e) {
        e.printStackTrace();
     }
  }
}
