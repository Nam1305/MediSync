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
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import model.Customer;
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
    public List<Staff> getAllStaff(Integer roleId, String status, String searchQuery, int page, int pageSize, String sort) {
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
        sql += " ORDER BY staffId " + (sort != null && sort.equals("DESC") ? "DESC" : "ASC");
        sql += " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

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
        String sql = "INSERT INTO Staff (name, email, avatar, phone, password, dateOfBirth, position, gender, status, description, roleId, departmentId,certificate) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'Active', ?, ?, ?,?)";

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
            ps.setString(12, staff.getCertificate());
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

        String sql = "UPDATE Staff SET name = ?, email = ?, phone = ?, password = ?, dateOfBirth = ?, position = ?, gender = ?, status = ?, description = ?, roleId = ?, departmentId = ?,certificate = ?";
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
            ps.setString(12, staff.getCertificate());
            int index = 13;
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

    // hàm lấy ra 3 id nhân viên có số sao y=trung bình cao nhát 
    public List<Integer> getTop3HighestRatedStaffIds() {
        List<Integer> staffIds = new ArrayList<>();
        String sql = "SELECT TOP 3 staffId "
                + "FROM FeedBack "
                + "GROUP BY staffId "
                + "ORDER BY AVG(ratings) DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                staffIds.add(rs.getInt("staffId"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return staffIds;
    }

    public Map<Staff, Double> getTop3HighestRatedStaff() {
        Map<Staff, Double> topStaffMap = new LinkedHashMap<>();
        List<Integer> topStaffIds = getTop3HighestRatedStaffIds(); // Lấy danh sách top 3 ID nhân viên

        for (int staffId : topStaffIds) {
            Staff staff = getStaffById(staffId); // Lấy thông tin nhân viên
            double avgRating = getAverageRating(staffId); // Lấy số sao trung bình

            if (staff != null) {
                topStaffMap.put(staff, avgRating);
            }
        }
        return topStaffMap;
    }

    public List<Customer> getPatientsByDoctor(int doctorId, String searchQuery, int page, int pageSize, String sort, String bloodType) {
        List<Customer> patientList = new ArrayList<>();
        String sql = "SELECT DISTINCT c.customerId, c.name, c.avatar, c.email, c.phone, "
                + "c.gender, c.address, c.dateOfBirth, c.bloodType, c.status "
                + "FROM Customer c "
                + "JOIN Appointment a ON c.customerId = a.customerId "
                + "WHERE a.staffId = ?";

        // Nếu có tìm kiếm theo tên hoặc số điện thoại
        if (searchQuery != null && !searchQuery.isEmpty()) {
            sql += " AND (c.name LIKE ? OR c.phone LIKE ?)";
        }

        // Nếu có lọc theo nhóm máu
        if (bloodType != null && !bloodType.isEmpty()) {
            sql += " AND c.bloodType = ?";
        }

        // Sắp xếp theo tên hoặc id
        sql += " ORDER BY c.name " + (sort != null && sort.equals("DESC") ? "DESC" : "ASC");

        // Thêm phân trang
        sql += " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int index = 1;
            ps.setInt(index++, doctorId);

            if (searchQuery != null && !searchQuery.isEmpty()) {
                ps.setString(index++, "%" + searchQuery + "%");
                ps.setString(index++, "%" + searchQuery + "%");
            }

            if (bloodType != null && !bloodType.isEmpty()) {
                ps.setString(index++, bloodType);
            }

            // Phân trang
            ps.setInt(index++, (page - 1) * pageSize);
            ps.setInt(index++, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Customer patient = new Customer();
                patient.setCustomerId(rs.getInt("customerId"));
                patient.setName(rs.getString("name"));
                patient.setAvatar(rs.getString("avatar"));
                patient.setEmail(rs.getString("email"));
                patient.setPhone(rs.getString("phone"));
                patient.setGender(rs.getString("gender"));
                patient.setAddress(rs.getString("address"));
                patient.setBloodType(rs.getString("bloodType"));
                patient.setStatus(rs.getString("status"));

                Date dateOfBirth = rs.getDate("dateOfBirth");
                patient.setDateOfBirth(dateOfBirth != null ? new java.sql.Date(dateOfBirth.getTime()) : null);

                patientList.add(patient);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return patientList;
    }

    public int getTotalPatientsByDoctor(int doctorId, String searchQuery, String bloodType) {
        String sql = "SELECT COUNT(DISTINCT c.customerId) FROM Customer c "
                + "JOIN Appointment a ON c.customerId = a.customerId "
                + "WHERE a.staffId = ?";

        // Nếu có tìm kiếm theo tên hoặc số điện thoại
        if (searchQuery != null && !searchQuery.isEmpty()) {
            sql += " AND (c.name LIKE ? OR c.phone LIKE ?)";
        }
        // Nếu có lọc theo nhóm máu
        if (bloodType != null && !bloodType.isEmpty()) {
            sql += " AND c.bloodType = ?";
        }
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int index = 1;
            ps.setInt(index++, doctorId);

            if (searchQuery != null && !searchQuery.isEmpty()) {
                ps.setString(index++, "%" + searchQuery + "%");
                ps.setString(index++, "%" + searchQuery + "%");
            }
            if (bloodType != null && !bloodType.isEmpty()) {
                ps.setString(index++, bloodType);
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1); // Trả về tổng số bệnh nhân
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0; // Trả về 0 nếu có lỗi
    }
    public Map<String, Object> getPatientDetail(int customerId, int doctorId) {
    Map<String, Object> patientDetail = new HashMap<>();
    String sql = """
        SELECT 
            c.customerId, 
            c.name, 
            c.phone, 
            c.email, 
            c.gender, 
            c.dateOfBirth, 
            c.bloodType,
            p.prescriptionId, 
            p.medicineName, 
            p.totalQuantity, 
            p.dosage, 
            p.note, 
            t.treatmentId, 
            t.symptoms, 
            t.diagnosis, 
            t.testResults, 
            t.treatmentPlan, 
            t.followUp
        FROM Customer c
        JOIN Appointment a ON c.customerId = a.customerId
        LEFT JOIN TreatmentPlan t ON a.appointmentId = t.appointmentId
        LEFT JOIN Staff s ON s.staffId = a.staffId
        LEFT JOIN Prescription p ON a.appointmentId = p.appointmentId
        WHERE s.staffId = ? AND c.customerId = ?
        ORDER BY a.date DESC, a.startTime DESC
    """;

    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, doctorId);
        ps.setInt(2, customerId);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                patientDetail.put("customerId", rs.getInt("customerId"));
                patientDetail.put("name", rs.getString("name"));
                patientDetail.put("phone", rs.getString("phone"));
                patientDetail.put("email", rs.getString("email"));
                patientDetail.put("gender", rs.getString("gender"));
                patientDetail.put("dateOfBirth", rs.getDate("dateOfBirth"));
                patientDetail.put("bloodType", rs.getString("bloodType"));
                patientDetail.put("prescriptionId", rs.getInt("prescriptionId"));
                patientDetail.put("medicineName", rs.getString("medicineName"));
                patientDetail.put("totalQuantity", rs.getString("totalQuantity"));
                patientDetail.put("dosage", rs.getString("dosage"));
                patientDetail.put("note", rs.getString("note"));
                patientDetail.put("treatmentId", rs.getInt("treatmentId"));
                patientDetail.put("symptoms", rs.getString("symptoms"));
                patientDetail.put("diagnosis", rs.getString("diagnosis"));
                patientDetail.put("testResults", rs.getString("testResults"));
                patientDetail.put("treatmentPlan", rs.getString("treatmentPlan"));
                patientDetail.put("followUp", rs.getString("followUp"));
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return patientDetail;
}


//    public static void main(String[] args) {
//        DoctorDAO doctor = new DoctorDAO();
//        System.out.println(doctor.getPatientDetail(5, 2));
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
        staff.setCertificate(rs.getString("certificate"));
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

    public List<Staff> getDoctorsByFilters(String name, int departmentId, String gender, int page, int pageSize) throws SQLException {
        List<Staff> doctors = new ArrayList<>();
        String sql = "SELECT staffId, name, email, avatar, phone, "
                + "password, dateOfBirth, position, gender, "
                + "status, description, roleId, departmentId "
                + "FROM Staff "
                + "WHERE (roleId = 2 OR roleId = 3) AND status = 'Active'";

        if (name != null && !name.trim().isEmpty()) {
            sql += " AND name LIKE ?";
        }
        if (departmentId != -1) { // Chỉ lọc theo departmentId nếu khác -1
            sql += " AND departmentId = ?";
        }
        if (gender != null && !gender.trim().isEmpty()) {
            sql += " AND gender = ?";
        }

        // Thêm ORDER BY trước OFFSET để tránh lỗi cú pháp
        sql += " ORDER BY staffId OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int index = 1;
            if (name != null && !name.trim().isEmpty()) {
                ps.setString(index++, "%" + name + "%");
            }
            if (departmentId != -1) {
                ps.setInt(index++, departmentId);
            }
            if (gender != null && !gender.trim().isEmpty()) {
                ps.setString(index++, gender);
            }

            int offset = (page - 1) * pageSize;
            ps.setInt(index++, offset);
            ps.setInt(index++, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                doctors.add(mapResultSetToStaff(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return doctors;
    }

    public int getTotalDoctorsByFilters(String name, int departmentId, String gender) {
        String sql = "SELECT COUNT(*) FROM Staff WHERE (roleId = 2 OR roleId = 3) "
                + "AND status = 'Active'";

        // Thêm điều kiện nếu có bộ lọc
        if (name != null && !name.trim().isEmpty()) {
            sql += " AND name LIKE ?";
        }
        if (departmentId > 0) {
            sql += " AND departmentId = ?";
        }
        if (gender != null && !gender.trim().isEmpty()) {
            sql += " AND gender = ?";
        }

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int paramIndex = 1;

            if (name != null && !name.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + name + "%");
            }
            if (departmentId > 0) {
                ps.setInt(paramIndex++, departmentId);
            }
            if (gender != null && !gender.trim().isEmpty()) {
                ps.setString(paramIndex++, gender);
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1); // Lấy số lượng bác sĩ từ COUNT(*)
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    public static void main(String[] args) {
        DoctorDAO d = new DoctorDAO();
        //List<Staff> = d.getDoctorsByFilters("Nguyễn Văn A", -1, null, 1, 4);
        try {
            List<Staff> l = d.getDoctorsByFilters(null, 1, "M", 1, 4);
            System.out.println(l);
        } catch (Exception e) {
        }
    }
}
