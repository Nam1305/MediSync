package dal;

import model.Customer;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO extends DBContext {

    public Customer getCustomerById(int customerId) {
        String sql = "SELECT name, gender, email, phone, address, dateOfBirth, avatar FROM Customer WHERE customerId = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Customer customer = new Customer();
                customer.setCustomerId(customerId); // customerId lấy từ tham số
                customer.setName(rs.getString("name"));
                customer.setGender(rs.getString("gender").trim());
                customer.setEmail(rs.getString("email"));
                customer.setPhone(rs.getString("phone"));
                customer.setAddress(rs.getString("address"));
                customer.setDateOfBirth(rs.getDate("dateOfBirth"));
                customer.setAvatar(rs.getString("avatar"));
                return customer;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    private Customer mapResultSetToCustomer(ResultSet rs) throws SQLException {
        Customer customer = new Customer();
        customer.setCustomerId(rs.getInt("customerId"));
        customer.setName(rs.getString("name"));
        customer.setAvatar(rs.getString("avatar"));
        customer.setEmail(rs.getString("email"));
        customer.setPassword(rs.getString("password"));
        customer.setAddress(rs.getString("address"));
        customer.setDateOfBirth(rs.getDate("dateOfBirth"));
        customer.setBloodType(rs.getString("bloodType"));
        customer.setGender(rs.getString("gender"));
        customer.setStatus(rs.getString("status"));
        customer.setPhone(rs.getString("phone"));
        return customer;
    }

    public Customer getCustomerByEmail(String email) {
        String sql = "SELECT customerId, name, avatar, email, password, address, dateOfBirth, bloodType, gender, status, phone FROM Customer WHERE email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return mapResultSetToCustomer(rs);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public void addCustomer(Customer customer, String imagePath) {
        String sql = "INSERT INTO Customer (name, email, password, dateOfBirth, gender, phone, avatar, status, address) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, customer.getName());          // name
            ps.setString(2, customer.getEmail());         // email
            ps.setString(3, customer.getPassword());      // password
            ps.setDate(4, customer.getDateOfBirth());     // dateOfBirth
            ps.setString(5, customer.getGender());        // gender
            ps.setString(6, customer.getPhone());         // phone
            ps.setString(7, imagePath);                 // avatar path
            ps.setString(8, "Active");                   // status (mặc định là Active)
            ps.setString(9, customer.getAddress());
            ps.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("Error in addCustomer: " + ex.getMessage());
            ex.printStackTrace();
        }
    }

    public void insertCustomer(Customer customer) {
        String sql = "INSERT INTO Customer (name, avatar, email, password, address, dateOfBirth, bloodType, gender, status, phone) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, customer.getName());
            ps.setString(2, customer.getAvatar());
            ps.setString(3, customer.getEmail());
            ps.setString(4, customer.getPassword());
            ps.setString(5, customer.getAddress());
            ps.setDate(6, customer.getDateOfBirth());
            ps.setString(7, customer.getBloodType());
            ps.setString(8, customer.getGender());
            ps.setString(9, customer.getStatus());
            ps.setString(10, customer.getPhone());
            ps.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("Error in insertCustomer: " + ex.getMessage());
            ex.printStackTrace();
        }
    }

    public List<Customer> getAllCustomer() {
        List<Customer> listCustomer = new ArrayList<>();
        String sql = "SELECT customerId, name, avatar, email, password, address, dateOfBirth, bloodType, gender, status, phone FROM Customer";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                listCustomer.add(mapResultSetToCustomer(rs));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listCustomer;
    }

    public int getTotalCustomer() {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM Customer";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    //paging
    public List<Customer> getCustomerByPage(int page, int pageSize) {
        List<Customer> listCustomer = new ArrayList<>();
        String sql = "SELECT customerId, name, avatar, email, password, address, dateOfBirth, bloodType, gender, status, phone \n"
                + "FROM Customer ORDER BY customerId \n"
                + "OFFSET ?\n"
                + "ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            int offset = (page - 1) * pageSize;
            ps.setInt(1, offset);
            ps.setInt(2, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                listCustomer.add(mapResultSetToCustomer(rs));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listCustomer;
    }

    //lấy bệnh nhân theo trạng thái
    public List<Customer> getCustomersByStatus(String status, int page, int pageSize) {
        List<Customer> listCustomer = new ArrayList<>();
        String sql = "SELECT customerId, name, avatar, email, password, address, dateOfBirth, bloodType, gender, status, phone "
                + "FROM Customer WHERE status = ? "
                + "ORDER BY customerId OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, (page - 1) * pageSize); // OFFSET
            ps.setInt(3, pageSize);  // FETCH NEXT
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                listCustomer.add(mapResultSetToCustomer(rs));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listCustomer;
    }

    //lấy bệnh nhân theo giới tính
    public List<Customer> getCustomersByGender(String gender, int page, int pageSize) {
        List<Customer> listCustomer = new ArrayList<>();
        String sql = "SELECT customerId, name, avatar, email, password, address, dateOfBirth, bloodType, gender, status, phone "
                + "FROM Customer WHERE gender = ? "
                + "ORDER BY customerId OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, gender);
            ps.setInt(2, (page - 1) * pageSize); // OFFSET
            ps.setInt(3, pageSize);  // FETCH NEXT
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                listCustomer.add(mapResultSetToCustomer(rs));

            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listCustomer;
    }

    //lấy bệnh nhân dựa vào cả trạng thái và giới tính
    public List<Customer> getFilteredCustomers(String status, String gender, int page, int pageSize) {
        List<Customer> listCustomer = new ArrayList<>();

        StringBuilder sql = new StringBuilder("SELECT customerId, name, avatar, email, password, address, dateOfBirth, bloodType, gender, status, phone FROM Customer WHERE 1=1");

        // Thêm điều kiện cho status nếu có
        if (status != null && !status.isEmpty()) {
            sql.append(" AND status = ?");
        }

        // Thêm điều kiện cho gender nếu có
        if (gender != null && !gender.isEmpty()) {
            sql.append(" AND gender = ?");
        }

        // Sử dụng ORDER BY + OFFSET + FETCH NEXT cho phân trang trong SQL Server
        sql.append(" ORDER BY customerId OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try {
            PreparedStatement ps = connection.prepareStatement(sql.toString());
            int index = 1;

            // Thiết lập tham số cho các điều kiện
            if (status != null && !status.isEmpty()) {
                ps.setString(index++, status);
            }
            if (gender != null && !gender.isEmpty()) {
                ps.setString(index++, gender);
            }

            // Thiết lập tham số phân trang
            ps.setInt(index++, (page - 1) * pageSize); // OFFSET
            ps.setInt(index++, pageSize); // FETCH NEXT

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                listCustomer.add(mapResultSetToCustomer(rs));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listCustomer;
    }

    //tìm kiếm bệnh nhân theo tên hoặc số điện thoại
    public List<Customer> searchCustomers(String searchQuery) {
        List<Customer> customers = new ArrayList<>();
        // Câu lệnh SQL tìm kiếm khách hàng theo tên hoặc số điện thoại
        String sql = "SELECT * FROM Customer WHERE name LIKE ? OR phone LIKE ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            String searchPattern = "%" + searchQuery + "%"; // Thêm ký tự % để tìm kiếm chứa chuỗi
            ps.setString(1, searchPattern); // Tìm kiếm theo tên
            ps.setString(2, searchPattern); // Tìm kiếm theo số điện thoại

            // Thực thi câu lệnh SQL và lấy kết quả
            ResultSet rs = ps.executeQuery();

            // Duyệt qua các kết quả và thêm vào danh sách
            while (rs.next()) {
                // Thêm khách hàng vào danh sách
                customers.add(mapResultSetToCustomer(rs));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return customers;
    }

    public boolean updateCustomer(Customer customer) {
        boolean isUpdated = false;
        // Câu lệnh SQL cập nhật thông tin khách hàng
        String sql = "UPDATE Customer SET name = ?, email = ?, address = ?, dateOfBirth = ?, gender = ?, phone = ? WHERE customerId = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            // Thiết lập các tham số cho câu lệnh SQL
            ps.setString(1, customer.getName());          // name
            ps.setString(2, customer.getEmail());         // email
            ps.setString(3, customer.getAddress());       // address
            ps.setDate(4, customer.getDateOfBirth());     // dateOfBirth
            ps.setString(5, customer.getGender());        // gender
            ps.setString(6, customer.getPhone());         // phone
            ps.setInt(7, customer.getCustomerId());       // customerId

            // Thực thi câu lệnh SQL và kiểm tra số hàng bị ảnh hưởng
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                isUpdated = true;
            }
        } catch (SQLException ex) {
            System.out.println("Error in updateCustomer: " + ex.getMessage());
            ex.printStackTrace();
        }
        return isUpdated;
    }

    public void updatePassword(String email, String newPassword) {
        String sql = "UPDATE Customer SET password = ? WHERE email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, newPassword);
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("Error in updatePassword: " + ex.getMessage());
            ex.printStackTrace();
        }
    }

    public boolean deleteCustomer(Customer customer) {
        boolean isDeleted = false;
        String sql = "UPDATE Customer SET status = 'Inactive' WHERE customerId = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, customer.getCustomerId());
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                isDeleted = true;
            }
        } catch (SQLException ex) {
            System.out.println("Error in deleteCustomer: " + ex.getMessage());
            ex.printStackTrace();
        }
        return isDeleted;
    }

    public boolean isEmailExists(String email) {
        String query = "SELECT COUNT(*) FROM Customer WHERE email = ? AND status = 'Active'";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println("Error in isEmailExists: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public boolean isPhoneExists(String phone) {
        String query = "SELECT COUNT(*) FROM Customer WHERE phone = ? AND status = 'Active'";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, phone);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println("Error in isPhoneExists: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public boolean checkEmailOtherCustomer(String email, int customerId) {
        String query = "SELECT COUNT(*) FROM Customer WHERE email = ? AND customerId != ? and status = 'Active'";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, email);
            ps.setInt(2, customerId);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println("Error in checkEmailOtherPeople: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public boolean checkPhoneOtherCustomer(String phone, int customerId) {
        String query = "SELECT COUNT(*) FROM Customer WHERE phone = ? AND customerId != ? and status = 'Active'";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, phone);
            ps.setInt(2, customerId);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println("Error in isPhoneExists: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public String getDepartmentByCustomerID(int customerId) {
        String departmentName = null;
        String sql = "SELECT d.departmentName AS Department "
                + "FROM Customer c "
                + "INNER JOIN Appointment a ON c.customerId = a.customerId "
                + "INNER JOIN Staff s ON a.staffId = s.staffId "
                + "INNER JOIN Department d ON s.departmentId = d.departmentId "
                + "WHERE c.customerId = ?";
        try {

            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                departmentName = rs.getString("Department");
            }
        } catch (SQLException e) {
            System.out.println("Error in getDepartmentByCustomerID: " + e.getMessage());
            e.printStackTrace();
        }

        return departmentName;
    }

    public String getDoctorName(int customerId) {
        String doctor = null;
        String sql = "SELECT \n"
                + "    s.name AS Doctor\n"
                + "FROM \n"
                + "    Customer c\n"
                + "INNER JOIN \n"
                + "    Appointment a ON c.customerId = a.customerId\n"
                + "INNER JOIN \n"
                + "    Staff s ON a.staffId = s.staffId\n"
                + "INNER JOIN \n"
                + "    Department d ON s.departmentId = d.departmentId WHERE c.customerId = ?";
        try {

            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                doctor = rs.getString("Doctor");
            }
        } catch (SQLException e) {
            System.out.println("Error in getDoctor: " + e.getMessage());
            e.printStackTrace();
        }
        return doctor;
    }

    public Date getAppointmentDate(int customerId) {
        Date appointmentDate = null;
        String sql = "SELECT \n"
                + "    a.date AS AppointmentDate\n"
                + "FROM \n"
                + "    Customer c\n"
                + "INNER JOIN \n"
                + "    Appointment a ON c.customerId = a.customerId\n"
                + "INNER JOIN \n"
                + "    Staff s ON a.staffId = s.staffId\n"
                + "INNER JOIN \n"
                + "    Department d ON s.departmentId = d.departmentId WHERE c.customerId = ?";
        try {

            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                appointmentDate = rs.getDate("AppointmentDate");
            }
        } catch (SQLException e) {
            System.out.println("Error in getDoctor: " + e.getMessage());
            e.printStackTrace();
        }
        return appointmentDate;
    }

    public Time getAppointmentTime(int customerId) {
        Time appointmentTime = null;
        String sql = "SELECT \n"
                + "    a.startTime AS AppointmentTime\n"
                + "FROM \n"
                + "    Customer c\n"
                + "INNER JOIN \n"
                + "    Appointment a ON c.customerId = a.customerId\n"
                + "INNER JOIN \n"
                + "    Staff s ON a.staffId = s.staffId\n"
                + "INNER JOIN \n"
                + "    Department d ON s.departmentId = d.departmentId WHERE c.customerId = ?";
        try {

            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                appointmentTime = rs.getTime("AppointmentTime");
            }
        } catch (SQLException e) {
            System.out.println("Error in getDoctor: " + e.getMessage());
            e.printStackTrace();
        }
        return appointmentTime;
    }

    public Customer getCustomerByPhone(String phone) {
        String sql = "select * from Customer where phone = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, phone);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return mapResultSetToCustomer(rs);
            }
        } catch (SQLException ex) {

        }
        return null;
    }

    public static void main(String[] args) {
        CustomerDAO d = new CustomerDAO();
    }
}
