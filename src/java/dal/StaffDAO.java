package dal;

import java.sql.*;
import model.Staff;

/**
 * Data Access Object cho Staff entity, cung cấp các thao tác cơ bản và các truy
 * vấn liên quan đến quản lý nhân viên
 */
/**
 *
 * @author DIEN MAY XANH
 */
public class StaffDAO extends DBContext {

    DepartmentDAO departDao = new DepartmentDAO();
    RoleDAO roleDao = new RoleDAO();
    PositionDAO posDao = new PositionDAO();

    /**
     * Chuyển đổi dữ liệu từ ResultSet sang đối tượng Staff
     */
    protected Staff mapResultSetToStaff(ResultSet rs) throws SQLException {
        Staff staff = new Staff();
        staff.setStaffId(rs.getInt("staffId"));
        staff.setName(rs.getString("name"));
        staff.setEmail(rs.getString("email"));
        staff.setAvatar(rs.getString("avatar"));
        staff.setPhone(rs.getString("phone"));
        staff.setPassword(rs.getString("password"));
        staff.setDateOfBirth(rs.getDate("dateOfBirth"));
        staff.setPosition(posDao.getPositionByStaffId(rs.getInt("staffId")));
        staff.setGender(rs.getString("gender"));
        staff.setStatus(rs.getString("status"));
        staff.setDescription(rs.getString("description"));
        staff.setDepartment(departDao.getDepartmentById(rs.getInt("departmentId")));
        staff.setRole(roleDao.getRoleById(rs.getInt("roleId")));
        return staff;
    }

    /**
     * Lấy thông tin nhân viên theo email
     */
    public Staff getStaffByEmail(String email) {
        String sql = "SELECT * FROM Staff WHERE email = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToStaff(rs);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public Staff getStaffByPhone(String phone) {
        String sql = "SELECT * FROM Staff WHERE phone = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, phone);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToStaff(rs);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public Staff getStaffById(int id) {
        String sql = """
                     Select staffid, name, email, avatar, 
                     phone, password, dateofBirth, position,
                     gender, status, description, roleId, 
                     departmentId from Staff 
                     WHERE staffId = ?""";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToStaff(rs);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    /**
     * Cập nhật mật khẩu của nhân viên
     */
    public void updatePassword(String email, String newPassword) {
        String sql = "UPDATE Staff SET password = ? WHERE email = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void updateProfile(Staff staff) {
        String sql = "UPDATE [dbo].[Staff]\n"
                + "   SET [name] = ?\n"
                + "      ,[email] = ?\n"
                + "      ,[phone] = ?\n"
                + "      ,[dateOfBirth] = ?\n"
                + "      ,[gender] = ?\n"
                + "      ,[description] = ?\n"
                + "      ,[departmentId] = ?\n"
                + " WHERE staffId = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, staff.getName());
            ps.setString(2, staff.getEmail());
            ps.setString(3, staff.getPhone());
            ps.setDate(4, staff.getDateOfBirth());
            ps.setString(5, staff.getGender());
            ps.setString(6, staff.getDescription());
            ps.setInt(7, staff.getDepartment().getDepartmentId());
            ps.setInt(8, staff.getStaffId());
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void updateAvatar(int staffId, String avatarPath) {
        String sql = "UPDATE Staff SET avatar = ? WHERE staffid = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, avatarPath);
            ps.setInt(2, staffId);
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public Staff checkExitEMail(String email, int id) {
        String sql = "select * \n"
                + "from Staff\n"
                + "where email = ?\n"
                + "     and staffId != ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email.trim());
            ps.setInt(2, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return mapResultSetToStaff(rs);
            }
        } catch (SQLException ex) {

        }
        return null;
    }

    public Staff checkExitPhone(String phone, int id) {
        String sql = "select * \n"
                + "from Staff\n"
                + "where phone = ?\n"
                + "     and staffId != ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, phone.trim());
            ps.setInt(2, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return mapResultSetToStaff(rs);
            }
        } catch (SQLException ex) {

        }
        return null;
    }
}
