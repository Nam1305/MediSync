/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
import java.sql.*;
import model.Role;
/**
 *
 * @author DIEN MAY XANH
 */
public class RoleDAO extends DBContext{
    public Role getRoleById(int id) {
        String sql = "select * from role where roleid = "+id+"";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Role role = new Role();
                role.setRoleId(rs.getInt(1));
                role.setRole(rs.getString(2));
                return role;
            }
        } catch (SQLException ex) {
            
        }
        return null;
    }
}
