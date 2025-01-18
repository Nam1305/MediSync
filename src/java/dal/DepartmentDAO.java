/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
import java.sql.*;
import model.Department;
/**
 *
 * @author DIEN MAY XANH
 */
public class DepartmentDAO extends DBContext{
    public Department getDepartmentById(int id) {
        String sql = "select * from Department where DepartmentId = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Department depart = new Department();
                depart.setDepartmentId(rs.getInt(1));
                depart.setName(rs.getString(2));
                return depart;
            }
        } catch (SQLException ex) {
            
        }
        return null;
    }
}
