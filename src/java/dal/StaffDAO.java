/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.*;
import model.Department;
import model.Role;
import model.Staff;

/**
 *
 * @author DIEN MAY XANH
 */
public class StaffDAO extends DBContext {

    DepartmentDAO departDao = new DepartmentDAO();
    RoleDAO roleDao = new RoleDAO();

    public Staff getStaffByEmail(String email) {
        String sql = "select * from Staff where email = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Staff staff = new Staff();
                staff.setStaffId(rs.getInt(1));
                staff.setName(rs.getString(2));
                staff.setEmail(rs.getString(3));
                staff.setPassword(rs.getString(5));
                staff.setPhone(rs.getString(4));
                staff.setPosition(rs.getString(7));
                staff.setDateOfBirth(rs.getDate(6));
                staff.setGender(rs.getString(8));
                staff.setStatus(rs.getString(9));
                staff.setRole(roleDao.getRoleById(rs.getInt(11)));
                staff.setDepartment(departDao.getDepartmentById(rs.getInt(10)));
                return staff;
            }
        } catch (SQLException ex) {

        }
        return null;
    }

    //Them boi Nguyen Dinh Chinh 20-1-25
    public void updatePassword(String email, String newPassword) {
        String sql = "UPDATE Staff SET Password = ? WHERE Email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, newPassword);
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (SQLException e) {
            // Xử lý exception
        }
    }

    public Staff getAccountByEmail(String email) {
        String sql = "select * from Staff where email = '" + email + "'";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Staff account = new Staff(
                        rs.getInt("staffId"),
                        rs.getString("name"), 
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("password"),
                        rs.getDate("dateOfBirth"),
                        rs.getString("position"),
                        rs.getString("gender"),
                        rs.getString("status"),
                        new Department( // Department object
                                rs.getInt("departmentId"),
                                rs.getString("departmentName")
                        ),
                        new Role( // Role object
                                rs.getInt("roleId"),
                                rs.getString("roleName")
                        )
                );
                return account;
            }

        } catch (SQLException e) {
        }
        return null;
    }

    public static void main(String[] args) {
        StaffDAO staff = new StaffDAO();
        System.out.println(staff.getStaffByEmail("ntk@example.com"));
    }

}
