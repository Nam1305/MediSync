/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Department;

/**
 *
 * @author DIEN MAY XANH
 */
public class DepartmentDAO extends DBContext {

    public Department getDepartmentById(int id) {
        String sql = "select * from Department where DepartmentId = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Department depart = new Department();
                depart.setDepartmentId(rs.getInt(1));
                depart.setDepartmentName(rs.getString(2));
                return depart;
            }
        } catch (SQLException ex) {

        }
        return null;
    }

    public List<Department> getAllDepartment() {
        List<Department> list = new ArrayList<>();
        String sql = "select * from Department";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Department o = new Department(rs.getInt(1),
                        rs.getString(2));
                list.add(o);
            }
        } catch (SQLException ex) {

        }
        return list;
    }
    
    public List<Department> getDepartmentsWithKhoa() {
        List<Department> list = new ArrayList<>();
        String sql = "SELECT * FROM Department WHERE DepartmentName LIKE N'%Khoa%'";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Department department = new Department(
                    rs.getInt("DepartmentId"),
                    rs.getString("DepartmentName")
                );
                list.add(department);
            }
        } catch (SQLException ex) {
            System.out.println("Error getting departments with Khoa: " + ex.getMessage());
        }
        return list;
    }
}
