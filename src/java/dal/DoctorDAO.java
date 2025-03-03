/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Statement;
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
    PositionDAO positionDao = new PositionDAO();
    
    // list ra danh sách tất cả nhân viên trừ admin
    public List<Staff> getAllStaff(Integer roleId, String status, String searchQuery, int page, int pageSize) {
        List<Staff> listDoctor = new ArrayList<>();
        String sql = "SELECT staffId, name , email , avatar , phone , password , dateOfBirth, position, gender, status, description, roleId, departmentId FROM Staff WHERE roleId != 1"; // Loại bỏ roleId = 1

        // Nếu roleId khác null, thêm điều kiện lọc
        if (roleId != null) {
            sql += " AND roleId = ?";
        }
//        nếu status! null thêm lọc theo status
        if (status != null && !status.isEmpty()) {
            sql += " AND status = ?";
        }
//        thêm tìm kiếm theo tên 
        if (searchQuery != null && !searchQuery.isEmpty()) {
            sql += " AND (name LIKE ? OR phone LIKE ?)";
        }
        //Thêm phân trang 
        sql += " ORDER BY staffId DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY  ";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            int index = 1;
            if (roleId != null) {
                ps.setInt(index++, roleId);
            }
            if (status != null && !status.isEmpty()) {
                ps.setString(index++, status);
            }
            if (searchQuery != null && !searchQuery.isEmpty()) {
                ps.setString(index++, "%" + searchQuery + "%");
                ps.setString(index++, "%" + searchQuery + "%");
            }
            // **Phân trang**: OFFSET = (page - 1) * pageSize, FETCH = pageSize
            ps.setInt(index++, (page - 1) * pageSize);
            ps.setInt(index++, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int staffId = rs.getInt(1);
                Staff doctor = new Staff();
                doctor.setStaffId(staffId);
                doctor.setName(rs.getString(2));
                doctor.setEmail(rs.getString(3));
                doctor.setAvatar(rs.getString(4));
                doctor.setPhone(rs.getString(5));
                doctor.setPassword(rs.getString(6));
                doctor.setDateOfBirth(rs.getDate(7));
                doctor.setPosition(positionDao.getPositionByStaffId(staffId));
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
    // đếm số nhân viên để phân trang
    public int getTotalStaffCount(Integer roleId, String status, String searchQuery) {
        String sql = "SELECT COUNT(*) FROM Staff WHERE roleId != 1"; // Đếm tất cả bác sĩ (trừ admin)

        if (roleId != null) {
            sql += " AND roleId = ?";
        }
        if (status != null && !status.isEmpty()) {
            sql += " AND status = ?";
        }
        if (searchQuery != null && !searchQuery.isEmpty()) {
            sql += " AND (name LIKE ? OR phone LIKE ?)";
        }

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            int index = 1;
            if (roleId != null) {
                ps.setInt(index++, roleId);
            }
            if (status != null && !status.isEmpty()) {
                ps.setString(index++, status);
            }
            if (searchQuery != null && !searchQuery.isEmpty()) {
                ps.setString(index++, "%" + searchQuery + "%");
                ps.setString(index++, "%" + searchQuery + "%");
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1); // Lấy số lượng bác sĩ từ COUNT(*)
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

  public int addStaff(Staff staff) {
    // Mặc định `status` = 'Active'
    String sql = "INSERT INTO Staff (name, email, avatar, phone, password, dateOfBirth, position, gender, status, description, roleId, departmentId) "
               + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'Active', ?, ?, ?)";
    
    try {
        // Sử dụng RETURN_GENERATED_KEYS để lấy ID tự động tăng
        PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
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

        // Kiểm tra nếu INSERT thành công
        if (rowsAffected > 0) {
            ResultSet rs = ps.getGeneratedKeys(); // Lấy ID vừa tạo
            if (rs.next()) {
                return rs.getInt(1); // Trả về ID của nhân viên mới
            }
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    
    return -1; // Trả về -1 nếu thêm thất bại
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
    // Kiểm tra xem avatar có bị thay đổi hay không
    boolean hasAvatar = staff.getAvatar() != null && !staff.getAvatar().isEmpty();
    
    String sql = "UPDATE Staff SET name = ?, email = ?, phone = ?, password = ?, dateOfBirth = ?, position = ?, gender = ?, status = ?, description = ?, roleId = ?, departmentId = ?";
    if (hasAvatar) {
        sql += ", avatar = ?";  // Chỉ cập nhật avatar nếu có thay đổi
    }
    sql += " WHERE staffId = ?";
    
    try {
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, staff.getName());
        ps.setString(2, staff.getEmail());
        ps.setString(3, staff.getPhone());
        ps.setString(4, staff.getPassword());
        ps.setDate(5, staff.getDateOfBirth());
        ps.setString(6, staff.getPosition());
        ps.setString(7, staff.getGender());
        ps.setString(8, staff.getStatus());
        ps.setString(9, staff.getDescription());
        ps.setInt(10, staff.getRole().getRoleId());
        ps.setInt(11, staff.getDepartment().getDepartmentId());

        int index = 12;
        if (hasAvatar) {
            ps.setString(index++, staff.getAvatar());  // Chỉ set avatar nếu có
        }
        ps.setInt(index, staff.getStaffId());  // Set staffId vào cuối

        int rowsAffected = ps.executeUpdate();
        return rowsAffected > 0;
    } catch (SQLException ex) {
        ex.printStackTrace();
        return false;
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
        public boolean checkEmailExistsCurrentStaff(String email, int staffId) {
    String query = "SELECT COUNT(*) FROM Staff WHERE email = ? AND staffId != ?";
    try (
         PreparedStatement ps = connection.prepareStatement(query)) {
        ps.setString(1, email);
        ps.setInt(2, staffId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1) > 0; // Nếu số lượng > 0, nghĩa là đã tồn tại số điện thoại
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}
      public Staff getStaffById(int staffId) {
        String sql = "SELECT staffId, name , email , avatar , phone , password , dateOfBirth, position, gender, status, description, roleId, departmentId FROM Staff WHERE staffId = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, staffId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Staff staff = new Staff();
                staff.setStaffId(rs.getInt("staffId"));
                staff.setName(rs.getString("name"));
                staff.setEmail(rs.getString("email"));
                staff.setAvatar(rs.getString("avatar"));
                staff.setPhone(rs.getString("phone"));
                staff.setPassword(rs.getString("password"));
                staff.setDateOfBirth(rs.getDate("dateOfBirth"));
                staff.setPosition(positionDao.getPositionByStaffId(staffId));
                staff.setGender(rs.getString("gender"));
                staff.setStatus(rs.getString("status"));
                staff.setDescription(rs.getString("description"));
                staff.setRole(roleDao.getRoleById(rs.getInt("roleId")));
                staff.setDepartment(departDao.getDepartmentById(rs.getInt("departmentId")));
                return staff;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null; // Trả về null nếu không tìm thấy nhân viên
    }

    public boolean checkPhoneExists(String phone) {
        String sql = "SELECT TOP 1 phone FROM Staff WHERE phone = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, phone);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // Nếu có dữ liệu, số điện thoại đã tồn tại
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false; // Mặc định trả về false nếu có lỗi
    }
    // Hàm check trùng số điện thoại trừ số điện thoại của nhân viên đang update 
    public boolean checkPhoneExistsCurrentStaff(String phone, int staffId) {
    String query = "SELECT COUNT(*) FROM Staff WHERE phone = ? AND staffId != ?";
    try (
         PreparedStatement ps = connection.prepareStatement(query)) {
        ps.setString(1, phone);
        ps.setInt(2, staffId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1) > 0; // Nếu số lượng > 0, nghĩa là đã tồn tại số điện thoại
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}
    // hàm lấy ra số sao trung bình mà nhân viên được vote
    public double getAverageRating(int staffId) {
    String sql = "SELECT AVG(ratings) FROM FeedBack WHERE staffId = ?";

    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, staffId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            return rs.getDouble(1); // Lấy giá trị trung bình từ cột đầu tiên
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    return 0.0; // Trả về 0 nếu không có dữ liệu
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
    
    public List<Staff> getAllDoctors() {
        List<Staff> allDoctors = new ArrayList<>();
        String sql = "select s.staffId, \n"
                + "s.name, \n"
                + "s.email, \n"
                + "s.avatar, \n"
                + "s.phone, \n"
                + "s.password,\n"
                + "s.dateOfBirth, \n"
                + "s.position, \n"
                + "s.gender, \n"
                + "s.status, \n"
                + "s.description, \n"
                + "s.roleId, \n"
                + "s.departmentId\n"
                + "from Staff as s\n"
                + "where roleId = 2 or roleId = 3";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int staffId = rs.getInt(1);
                Staff doctor = new Staff();
                doctor.setStaffId(staffId);
                doctor.setName(rs.getString(2));
                doctor.setEmail(rs.getString(3));
                doctor.setAvatar(rs.getString(4));
                doctor.setPhone(rs.getString(5));
                doctor.setPassword(rs.getString(6));
                doctor.setDateOfBirth(rs.getDate(7));
                doctor.setPosition(positionDao.getPositionByStaffId(staffId));
                doctor.setGender(rs.getString(9));
                doctor.setStatus(rs.getString(10));
                doctor.setDescription(rs.getString(11));
                doctor.setRole(roleDao.getRoleById(rs.getInt(12)));
                doctor.setDepartment(departDao.getDepartmentById(rs.getInt(13)));

                allDoctors.add(doctor);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return allDoctors;
    }
}
