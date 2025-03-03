/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
                depart.setStatus(rs.getString(3));
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
                        rs.getString(2),
                        rs.getString(3)
                );
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
                        rs.getString("DepartmentName"),
                        rs.getString("status")
                );
                list.add(department);
            }
        } catch (SQLException ex) {
            System.out.println("Error getting departments with Khoa: " + ex.getMessage());
        }
        return list;
    }

//    public static void main(String[] args) {
//        DepartmentDAO de = new DepartmentDAO();
//        System.out.println(de.getActiveDepartment());
//    }
    public List<Department> getAllDepartments(String searchQuery, int page, int pageSize, String status) {
        List<Department> list = new ArrayList<>();
        String sql = "select departmentId, departmentName, status from Department Where 1 = 1";
        if (searchQuery != null && !searchQuery.isEmpty()) {
            sql += " AND (departmentName LIKE ? )";
        }
         if (status != null && !status.isEmpty()) {
            sql += " AND status = ?";
        }
        sql += " ORDER BY departmentId OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            int index = 1;
            PreparedStatement ps = connection.prepareStatement(sql);

            if (searchQuery != null && !searchQuery.isEmpty()) {
                ps.setString(index++, "%" + searchQuery + "%");
            }
            if (status != null && !status.isEmpty()) {
                ps.setString(index++, status);
            }
            ps.setInt(index++, (page - 1) * pageSize);
            ps.setInt(index++, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Department o = new Department(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3)
                );
                list.add(o);
            }
        } catch (SQLException ex) {

        }
        return list;
    }

    public List<Department> getActiveDepartment() {
        List<Department> list = new ArrayList<>();
        String sql = "SELECT departmentId, departmentName, status FROM Department WHERE status = 'Active'";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Department o = new Department(rs.getInt(1), rs.getString(2), rs.getString(3));
                list.add(o);
            }

            // Debug số lượng department
            System.out.println("Number of departments found: " + list.size());

        } catch (SQLException ex) {
            ex.printStackTrace(); // In lỗi để debug
        }

        return list;
    }

    // xóa phòng ban 
    public boolean deleteDepartment(int departmentId) {
        String sql = "UPDATE Department SET status = 'Inactive' WHERE departmentId = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, departmentId);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException ex) {
            System.out.println("Error updating status to Inactive: " + ex.getMessage());
        }
        return false;
    }

    // cập nhật phòng ban 
    public boolean updateDepartment(Department department) {
        String sql = "UPDATE Department SET departmentName = ?, status = ? WHERE departmentId = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, department.getDepartmentName());
            ps.setString(2, department.getStatus());
            ps.setInt(3, department.getDepartmentId());
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException ex) {
            System.out.println("Error updating department: " + ex.getMessage());
        }
        return false;
    }

    // Thêm phòng ban mới
    public boolean insertDepartment(Department department) {
        String sql = "INSERT INTO Department (departmentName, status) VALUES (?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, department.getDepartmentName());
            ps.setString(2, department.getStatus());
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException ex) {
            System.out.println("Error inserting department: " + ex.getMessage());
        }
        return false;
    }

    // hàm check phòng ban xem có bị trùng tên hay không
    public boolean isDepartmentExists(String departmentName) {
        // Chuẩn hóa dữ liệu trước khi so sánh: loại bỏ khoảng trắng ở đầu và cuối, và thay thế khoảng trắng thừa giữa các từ thành một khoảng trắng duy nhất.

        String sql = "SELECT COUNT(*) FROM Department WHERE LOWER(REPLACE(LTRIM(RTRIM(departmentName)), ' ', ' ')) = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, departmentName.trim().toLowerCase().replaceAll("\\s+", " "));
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return true; // Tên đã tồn tại
            }
        } catch (SQLException ex) {
            System.out.println("Lỗi kiểm tra phòng ban: " + ex.getMessage());
        }
        return false;
    }

    // hàm check xem có phòng bn nào bị trùng trừ phòng ban hiện đang update hay không
    public boolean isDepartmentExistsNotCurrentDepartment(String departmentName, int departmentId) {
        // Chuẩn hóa dữ liệu đầu vào
        departmentName = departmentName.trim().toLowerCase().replaceAll("\\s+", " ");

        String sql = "SELECT COUNT(*) FROM Department WHERE LOWER(TRIM(departmentName)) = ? AND departmentId != ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, departmentName);
            ps.setInt(2, departmentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return true; // Tên đã tồn tại
            }
        } catch (SQLException ex) {
            System.out.println("Lỗi kiểm tra phòng ban: " + ex.getMessage());
        }
        return false;
    }

    public int getTotalDepartments(String searchQuery, String status) {
        List<Department> list = new ArrayList<>();
        String sql = "select COUNT(*) from Department Where 1 = 1";
        if (searchQuery != null && !searchQuery.isEmpty()) {
            sql += " AND (departmentName LIKE ? )";
        }
        if (status != null && !status.isEmpty()) {
            sql += " AND status = ?";
        }

        try {
            int index = 1;
            PreparedStatement ps = connection.prepareStatement(sql);

            if (searchQuery != null && !searchQuery.isEmpty()) {
                ps.setString(index++, "%" + searchQuery + "%");
            }
            if (status != null && !status.isEmpty()) {
                ps.setString(index++, status);
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1); // Lấy số lượng Phòng Ban từ COUNT(*)
            }
        } catch (SQLException ex) {

        }
        return 0;
    }

    public List<Integer> countStaffByRole(int departmentId) {
    String sql = "SELECT roleId, COUNT(*) AS count "
               + "FROM Staff WHERE departmentId = ? "
               + "AND roleId IN (2, 3, 4) "
               + "GROUP BY roleId";

    // Tạo danh sách chứa số lượng nhân viên theo thứ tự [Bác sĩ, Chuyên gia, Nhân viên]
    List<Integer> roleCounts = Arrays.asList(0, 0, 0); 

    try {
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, departmentId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            int roleId = rs.getInt("roleId");  
            int count = rs.getInt("count");    

            // Gán giá trị vào danh sách dựa theo index tương ứng
            if (roleId == 2) roleCounts.set(0, count); // Bác sĩ
            if (roleId == 3) roleCounts.set(1, count); // Chuyên gia
            if (roleId == 4) roleCounts.set(2, count); // Nhân viên
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    }

    return roleCounts;
}
}
