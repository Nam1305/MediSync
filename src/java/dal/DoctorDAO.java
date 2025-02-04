/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Staff;

/**
 *
 * @author Acer
 */
public class DoctorDAO extends DBContext {

    DepartmentDAO departDao = new DepartmentDAO();
    RoleDAO roleDao = new RoleDAO();

    public List<Staff> getAllDoctor(Integer roleId) {
        List<Staff> listDoctor = new ArrayList<>();
        String sql = "SELECT * FROM Staff"; // Câu SQL cơ bản

    // Nếu roleId không null, thêm điều kiện lọc
    if (roleId != null) {
        sql += " WHERE roleId = ?";
    }

    try {
        PreparedStatement ps = connection.prepareStatement(sql);

        // Nếu có roleId, truyền vào SQL
        if (roleId != null) {
            ps.setInt(1, roleId);
        }
        ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Staff doctor = new Staff();
                doctor.setStaffId(rs.getInt(1));
                doctor.setName(rs.getString(2));
                doctor.setEmail(rs.getString(3));
                doctor.setAvatar(rs.getString(4));
                doctor.setPhone(rs.getString(5));
                doctor.setPassword(rs.getString(6));
                doctor.setDateOfBirth(rs.getDate(7));
                doctor.setPosition(rs.getString(8));
                doctor.setGender(rs.getString(9));
                doctor.setStatus(rs.getString(10));
                doctor.setDescription(rs.getString(11));
                doctor.setRole(roleDao.getRoleById(rs.getInt(12)));
                doctor.setDepartment(departDao.getDepartmentById(rs.getInt(13)));
                
                listDoctor.add(doctor);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listDoctor;
    }

    public boolean addStaff(Staff staff) {
        // mặc định  status set = '1'
        String sql = "INSERT INTO Staff (name, email,avatar, phone, password, dateOfBirth, position, gender, status, description, roleId, departmentId) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?,?, 'Active',?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, staff.getName());
            ps.setString(2, staff.getEmail());
            ps.setString(3, staff.getAvatar());
            ps.setString(4, staff.getPhone());
            ps.setString(5, staff.getPassword());
            ps.setDate(6, staff.getDateOfBirth());
            ps.setString(7, staff.getPosition());
            ps.setString(8, staff.getGender());
            ps.setString(9, staff.getDescription());
            ps.setInt(10, staff.getRole().getRoleId());
            ps.setInt(11, staff.getDepartment().getDepartmentId());
            

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0; // Return true if the doctor was added successfully
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false; // Return false if an error occurred
        }
    }

    public boolean deleteStaff(int staffId) {
        String sql = "UPDATE Staff SET status = 'Inactive' WHERE StaffId = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, staffId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0; // Return true nếu update status staff về inactive thành công 
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false; // Return false nếu xóa staff thất bại 
        }
    }
    
    public boolean updateStaff(Staff staff) {
    String sql = "UPDATE Staff SET name = ?, email = ?, avatar = ?,phone = ?, password = ?, dateOfBirth = ?, position = ?, gender = ?, status = ?, description =?, roleId = ?, departmentId = ? WHERE staffId = ?";
    try {
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, staff.getName());
        ps.setString(2, staff.getEmail());
        ps.setString(3, staff.getAvatar());
        ps.setString(4, staff.getPhone());
        ps.setString(5, staff.getPassword());
        ps.setDate(6, staff.getDateOfBirth());
        ps.setString(7, staff.getPosition());
        ps.setString(8, staff.getGender());
        ps.setString(9, staff.getStatus());
        ps.setString(10, staff.getDescription());
        ps.setInt(11, staff.getRole().getRoleId());
        ps.setInt(12, staff.getDepartment().getDepartmentId());
        ps.setInt(13, staff.getStaffId());
        
        int rowsAffected = ps.executeUpdate();
        return rowsAffected > 0; // Return true nếu update thành công
    } catch (SQLException ex) {
        ex.printStackTrace();
        return false; // nếu update thất bại 
    }
}
     // Kiểm tra email đã tồn tại hay chưa
    public boolean checkEmail(String email) {
        String query = "SELECT COUNT(*) FROM Staff WHERE email = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // Trả về true nếu email đã tồn tại
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
//    public static void main(String[] args) {
//        DoctorDAO doctor = new DoctorDAO();
//        System.out.println(doctor.getAllDoctor());
//        
//    }

    //Them boi Nguyen Dinh Chinh 1-2-25
    public List<Staff> getTopRatedDoctors() {
        List<Staff> topDoctors = new ArrayList<>();
        String sql = """
        SELECT TOP 4 s.*
        FROM Staff s
        JOIN FeedBack f ON s.staffId = f.staffId
        WHERE s.roleId = 2
        GROUP BY s.staffId, s.name, s.email, s.avatar, s.phone, 
                 s.password, s.dateOfBirth, s.position, s.gender, 
                 s.status, s.description, s.roleId, s.departmentId
        ORDER BY AVG(f.ratings) DESC
    """;

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                topDoctors.add(mapResultSetToStaff(rs));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return topDoctors;
    }

    protected Staff mapResultSetToStaff(ResultSet rs) throws SQLException {
        Staff staff = new Staff();
        staff.setStaffId(rs.getInt("staffId"));
        staff.setName(rs.getString("name"));
        staff.setEmail(rs.getString("email"));
        staff.setAvatar(rs.getString("avatar"));
        staff.setPhone(rs.getString("phone"));
        staff.setPassword(rs.getString("password"));
        staff.setDateOfBirth(rs.getDate("dateOfBirth"));
        staff.setPosition(rs.getString("position"));
        staff.setGender(rs.getString("gender"));
        staff.setStatus(rs.getString("status"));
        staff.setDescription(rs.getString("description"));
        staff.setDepartment(departDao.getDepartmentById(rs.getInt("departmentId")));
        staff.setRole(roleDao.getRoleById(rs.getInt("roleId")));
        return staff;
    }
}
