package dal;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Appointment;
import model.Customer;
import model.Service;
import model.Staff;
import java.sql.*;
import model.Department;
import model.Prescription;
import model.Role;
import model.TreatmentPlan;

public class AppointmentDAO extends DBContext {

    StaffDAO staffDao = new StaffDAO();
    CustomerDAO customerDao = new CustomerDAO();

    private Appointment mapResultSetToAppointment(ResultSet rs) throws SQLException {
        Appointment appointment = new Appointment();
        appointment.setAppointmentId(rs.getInt("appointmentId"));
        appointment.setDate(rs.getDate("date"));
        appointment.setStart(rs.getTime("startTime"));
        appointment.setEnd(rs.getTime("endTime"));
        appointment.setStatus(rs.getString("status"));
        Staff staff = staffDao.getStaffById(rs.getInt("staffId"));
        appointment.setStaff(staff);
        Customer customer = customerDao.getCustomerById(rs.getInt("customerId"));
        appointment.setCustomer(customer);
        return appointment;
    }

    public List<Appointment> getListAppointmentsByCustomerId(int customerId) {
        List<Appointment> appointments = new ArrayList<>();
        // lấy ra lịch hẹn theo customerId
        String sql = "select appointmentId, date, startTime, endTime, status, staffId, customerId "
                + "FROM Appointment WHERE customerId = ? AND status != 'cancelled'";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            // Thực thi câu lệnh SQL và lấy kết quả
            ResultSet rs = ps.executeQuery();
            // Duyệt qua các kết quả và thêm vào danh sách
            while (rs.next()) {
                // Thêm khách hàng vào danh sách
                appointments.add(mapResultSetToAppointment(rs));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return appointments;
    }

    public List<Appointment> getFilteredAppointments(int customerId, String search, String sort, String gender, String status, int pageNumber, int pageSize) {
        List<Appointment> appointments = new ArrayList<>();
        String sql = "SELECT a.appointmentId, a.date, a.startTime, "
                + "a.endTime, a.status, a.staffId, a.customerId, s.name as doctorName "
                + "FROM Appointment a "
                + "JOIN Staff s ON a.staffId = s.staffId "
                + "WHERE a.customerId = ?";

        // Thêm điều kiện tìm kiếm theo tên bác sĩ
        if (search != null && !search.trim().isEmpty()) {
            sql += " AND s.name LIKE ? ";
        }

        // Lọc theo giới tính bác sĩ
        if (gender != null && (gender.equals("M") || gender.equals("F"))) {
            sql += " AND s.gender = ? ";
        }

        // Lọc theo trạng thái lịch hẹn
        if (status != null && !status.equals("all")) {
            sql += " AND a.status = ? ";
        }
        // Sắp xếp theo ngày giảm dần, nếu cùng ngày thì startTime giảm dần
        if ("asc".equalsIgnoreCase(sort)) {
            sql += " ORDER BY a.date ASC, a.startTime ASC ";
        } else {
            sql += " ORDER BY a.date DESC, a.startTime DESC ";
        }

        // Kiểm tra nếu pageNumber < 1 thì mặc định là 1
        if (pageNumber < 1) {
            pageNumber = 1;
        }

        // Phân trang
        sql += " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY ";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int paramIndex = 1;
            ps.setInt(paramIndex++, customerId);

            if (search != null && !search.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + search + "%");
            }

            if (gender != null && (gender.equals("M") || gender.equals("F"))) {
                ps.setString(paramIndex++, gender);
            }

            if (status != null && !status.equals("all")) {
                ps.setString(paramIndex++, status);
            }

            ps.setInt(paramIndex++, (pageNumber - 1) * pageSize);
            ps.setInt(paramIndex++, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                appointments.add(mapResultSetToAppointment(rs));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return appointments;
    }

    public int getTotalAppointments(int customerId) {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM Appointment where customerId = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    public List<Appointment> getAppointmentsByStaff(int staffId) throws SQLException {
        List<Appointment> appointments = new ArrayList<>();
        String sql = "SELECT appointmentId, date, startTime, endTime, status, staffId, customerId "
                + "FROM Appointment "
                + "WHERE staffId = ? AND status != 'cancelled'";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, staffId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                appointments.add(mapResultSetToAppointment(rs));
            }
        } catch (SQLException e) {
        }
        return appointments;
    }

    public List<Service> getListService(int customerId, int appointmentId) {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT a.[date] AS appointmentDate, s.serviceId, s.name AS serviceName "
                + "FROM Service s "
                + "JOIN Invoice i ON s.serviceId = i.serviceId "
                + "JOIN Appointment a ON i.appointmentId = a.appointmentId "
                + "WHERE a.customerId = ? and a.appointmentId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ps.setInt(2, appointmentId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int serviceId = rs.getInt("serviceId");
                String serviceName = rs.getString("serviceName");
                Date appointmentDate = rs.getDate("appointmentDate");

                Service service = new Service(serviceId, serviceName);
                services.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return services;
    }

    public Staff getDetailDoctor(int appointmentId) {
        String sql = "SELECT \n"
                + "    st.staffId, st.name, st.email, st.avatar, st.phone, st.password,\n"
                + "    st.dateOfBirth, st.position, st.gender, st.status, st.description,\n"
                + "    st.roleId, st.departmentId, d.departmentName\n"
                + "FROM \n"
                + "    Appointment a\n"
                + "JOIN \n"
                + "    Staff st ON a.staffId = st.staffId\n"
                + "JOIN \n"
                + "    Department d ON st.departmentId = d.departmentId\n"
                + "WHERE \n"
                + "    a.appointmentId = ?;";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            //ps.setInt(1, customerId);
            ps.setInt(1, appointmentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Staff doctor = new Staff();
                doctor.setStaffId(rs.getInt("staffId"));
                doctor.setName(rs.getString("name"));
                doctor.setEmail(rs.getString("email"));
                doctor.setAvatar(rs.getString("avatar"));
                doctor.setPhone(rs.getString("phone"));
                doctor.setPassword(rs.getString("password"));
                doctor.setDateOfBirth(rs.getDate("dateOfBirth"));
                doctor.setPosition(rs.getString("position"));
                doctor.setGender(rs.getString("gender"));
                doctor.setStatus(rs.getString("status"));
                doctor.setDescription(rs.getString("description"));
                // Khởi tạo Department
                Department department = new Department();
                department.setDepartmentId(rs.getInt("departmentId"));
                department.setDepartmentName(rs.getString("departmentName"));
                doctor.setDepartment(department);

                // Khởi tạo Role
                Role role = new Role();
                role.setRoleId(rs.getInt("roleId"));
                doctor.setRole(role);

                return doctor;

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public String getDetailStatus(int customerId, int appointmentId) {
        String sql = "SELECT \n"
                + "	a.status AS status\n"
                + "FROM \n"
                + "    Service s\n"
                + "JOIN \n"
                + "    Invoice i ON s.serviceId = i.serviceId\n"
                + "JOIN \n"
                + "    Appointment a ON i.appointmentId = a.appointmentId\n"
                + "JOIN \n"
                + "    Staff st ON a.staffId = st.staffId\n"
                + "JOIN \n"
                + "    Customer c ON a.customerId = c.customerId\n"
                + "WHERE \n"
                + "    c.customerId = ? and a.appointmentId = ?;";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ps.setInt(2, appointmentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("status");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Appointment getAppointmentById(int appId) {
        Appointment appointment = null;
        // SQL query để lấy chi tiết cuộc hẹn theo appointmentId
        String sql = "SELECT appointmentId, date, startTime, endTime, status, staffId, customerId "
                + "FROM Appointment WHERE appointmentId = ? AND status != 'cancelled'";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, appId);  // Gán appId vào câu lệnh SQL
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Lấy thông tin cuộc hẹn từ ResultSet và tạo đối tượng Appointment
                appointment = mapResultSetToAppointment(rs);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return appointment;
    }

    public List<Appointment> getAppointmentsByPage(int staffId, String search, String status, Date date, int page, int pageSize, String sort) throws SQLException {
        List<Appointment> appointments = new ArrayList<>();
        String sql = "SELECT appointmentId, date, startTime, endTime, status, staffId, customerId "
                + "FROM Appointment WHERE staffId = ?";

        if (search != null && !search.trim().isEmpty()) {
            sql += " AND customerId IN (SELECT customerId FROM Customer WHERE name LIKE ?)";
        }
        if (status != null && !status.trim().isEmpty()) {
            sql += " AND status = ?";
        }
        if (date != null) {
            sql += " AND date = ?";
        }

        // Sử dụng cú pháp OFFSET FETCH cho phân trang (SQL Server)
        sql += " ORDER BY date DESC, startTime " + sort + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            int index = 1;
            ps.setInt(index++, staffId);
            if (search != null && !search.trim().isEmpty()) {
                ps.setString(index++, "%" + search + "%");
            }
            if (status != null && !status.trim().isEmpty()) {
                ps.setString(index++, status);
            }
            if (date != null) {
                ps.setDate(index++, date);
            }
            int offset = (page - 1) * pageSize;
            ps.setInt(index++, offset);
            ps.setInt(index++, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                appointments.add(mapResultSetToAppointment(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return appointments;
    }

    public int countAppointmentsByFilter(int staffId, String search, String status, Date date) throws SQLException {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM Appointment WHERE staffId = ?";

        if (search != null && !search.trim().isEmpty()) {
            sql += " AND customerId IN (SELECT customerId FROM Customer WHERE name LIKE ?)";
        }
        if (status != null && !status.trim().isEmpty()) {
            sql += " AND status = ?";
        }
        if (date != null) {
            sql += " AND date = ?";
        }

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            int index = 1;
            ps.setInt(index++, staffId);
            if (search != null && !search.trim().isEmpty()) {
                ps.setString(index++, "%" + search + "%");
            }
            if (status != null && !status.trim().isEmpty()) {
                ps.setString(index++, status);
            }
            if (date != null) {
                ps.setDate(index++, date);
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public boolean updateAppointmentStatus(int appointmentId, String newStatus) {
        String sql = "UPDATE Appointment SET status = ? WHERE appointmentId = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, newStatus);
            ps.setInt(2, appointmentId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            return false;
        }
    }

    public Appointment getAppointmentsById(int id) {
        String sql = "select appointmentId, date, startTime, endTime, status, staffId, customerId from Appointment where appointmentId = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return mapResultSetToAppointment(rs);
            }
        } catch (SQLException ex) {
        }
        return null;
    }

    public TreatmentPlan getTreatmentPlanDetail(int customerId, int appointmentId) {
        String sql = "SELECT \n"
                + "tp.treatmentId,\n"
                + "tp.appointmentId,\n"
                + "tp.symptoms,\n"
                + "tp.diagnosis,\n"
                + "tp.testResults,\n"
                + "tp.treatmentPlan,\n"
                + "tp.followUp\n"
                + "FROM TreatmentPlan tp\n"
                + "JOIN Appointment a ON tp.appointmentId = a.appointmentId\n"
                + "WHERE a.customerId = ? AND a.appointmentId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ps.setInt(2, appointmentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                TreatmentPlan treatmentPlan = new TreatmentPlan();
                treatmentPlan.setTreatmentId(rs.getInt("treatmentId"));
                treatmentPlan.setAppointmentId(rs.getInt("appointmentId"));
                treatmentPlan.setSymptoms(rs.getString("symptoms"));
                treatmentPlan.setDiagnosis(rs.getString("diagnosis"));
                treatmentPlan.setTestResult(rs.getString("testResults")); // Đúng tên
                treatmentPlan.setPlan(rs.getString("treatmentPlan")); // Đúng tên
                treatmentPlan.setFollowUp(rs.getString("followUp"));
                return treatmentPlan;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Prescription> getPrescriptionDetail(int customerId, int appointmentId) {
        List<Prescription> prescriptions = new ArrayList<>();
        String sql = "SELECT p.prescriptionId, p.appointmentId, p.medicineName, p.totalQuantity, p.dosage, p.note "
                + "FROM Prescription p "
                + "JOIN Appointment a ON p.appointmentId = a.appointmentId "
                + "WHERE a.appointmentId = ? AND a.customerId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, appointmentId);
            ps.setInt(2, customerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Prescription prescription = new Prescription();
                prescription.setPrescriptionId(rs.getInt("prescriptionId"));
                prescription.setAppointmentId(rs.getInt("appointmentId"));
                prescription.setMedicineName(rs.getString("medicineName"));
                prescription.setTotalQuantity(rs.getString("totalQuantity"));
                prescription.setDosage(rs.getString("dosage"));
                prescription.setNote(rs.getString("note"));
                prescriptions.add(prescription);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return prescriptions;
    }

    public List<Appointment> getInvoiceByPage(Integer staffId, Integer appointmentId, String search,
            String status, Date date, Double totalFrom, Double totalTo,
            int page, int pageSize, String sortDate, String sortPrice) {
        List<Appointment> appointments = new ArrayList<>();

        // Xử lý giá trị mặc định cho sortPrice để tránh lỗi NULL
        sortPrice = (sortPrice == null || sortPrice.trim().isEmpty()) ? "ASC" : sortPrice;

        String sql = "WITH CTE AS ( "
                + "    SELECT a.appointmentId, a.date, a.startTime, a.endTime, a.status, "
                + "           a.staffId, a.customerId, COALESCE(SUM(i.price), 0) AS total "
                + "    FROM Appointment a "
                + "    LEFT JOIN Invoice i ON a.appointmentId = i.appointmentId "
                + "    WHERE 1=1 "; // Tránh lỗi nếu không có điều kiện lọc nào

        if (staffId != null) {
            sql += " AND a.staffId = ? ";
        }
        if (appointmentId != null) {
            sql += " AND a.appointmentId = ? ";
        }
        if (search != null && !search.trim().isEmpty()) {
            sql += " AND a.customerId IN (SELECT customerId FROM Customer WHERE name LIKE ?) ";
        }

        // Xử lý điều kiện status đúng với yêu cầu
        if (status != null && !status.trim().isEmpty()) {
            if ("paid".equalsIgnoreCase(status)) {
                sql += " AND a.status = 'paid' ";
            } else if ("unpaid".equalsIgnoreCase(status)) {
                sql += " AND a.status != 'paid' ";
            }
        }

        if (date != null) {
            sql += " AND a.date = ? ";
        }

        sql += "    GROUP BY a.appointmentId, a.date, a.startTime, a.endTime, "
                + "             a.status, a.staffId, a.customerId "
                + ") SELECT * FROM CTE WHERE 1=1 ";

        if (totalFrom != null) {
            sql += " AND total >= ? ";
        }
        if (totalTo != null) {
            sql += " AND total <= ? ";
        }

        // Xử lý ORDER BY: Nếu sortDate != null thì thêm ORDER BY date
        if (sortDate != null && !sortDate.trim().isEmpty()) {
            sql += " ORDER BY date " + sortDate + ", ";
        } else {
            sql += " ORDER BY ";
        }

        // ORDER BY total (0 luôn nhỏ nhất khi ASC)
        sql += " CASE WHEN total = 0 THEN -999999 ELSE total END " + sortPrice
                + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int index = 1;
            if (staffId != null) {
                ps.setInt(index++, staffId);
            }
            if (appointmentId != null) {
                ps.setInt(index++, appointmentId);
            }
            if (search != null && !search.trim().isEmpty()) {
                ps.setString(index++, "%" + search + "%");
            }
            if (date != null) {
                ps.setDate(index++, date);
            }
            if (totalFrom != null) {
                ps.setDouble(index++, totalFrom);
            }
            if (totalTo != null) {
                ps.setDouble(index++, totalTo);
            }
            ps.setInt(index++, (page - 1) * pageSize);
            ps.setInt(index++, pageSize);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Appointment appointment = mapResultSetToAppointment(rs);
                    appointment.setTotal(rs.getDouble("total")); // Nếu NULL -> đã thành 0 từ SQL
                    appointments.add(appointment);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return appointments;
    }

    public int countInvoiceByPage(Integer staffId, Integer appointmentId, String search,
            String status, Date date, Double totalFrom, Double totalTo) {
        int count = 0;

        String sql = "WITH CTE AS ( "
                + "    SELECT a.appointmentId, a.date, a.startTime, a.endTime, a.status, "
                + "           a.staffId, a.customerId, COALESCE(SUM(i.price), 0) AS total "
                + "    FROM Appointment a "
                + "    LEFT JOIN Invoice i ON a.appointmentId = i.appointmentId "
                + "    WHERE 1=1 "; // Đảm bảo không có lỗi nếu không có điều kiện nào

        if (staffId != null) {
            sql += " AND a.staffId = ? ";
        }
        if (appointmentId != null) {
            sql += " AND a.appointmentId = ? ";
        }
        if (search != null && !search.trim().isEmpty()) {
            sql += " AND a.customerId IN (SELECT customerId FROM Customer WHERE name LIKE ?) ";
        }

        // Xử lý điều kiện status đúng với yêu cầu
        if (status != null && !status.trim().isEmpty()) {
            if ("paid".equalsIgnoreCase(status)) {
                sql += " AND a.status = 'paid' ";
            } else if ("unpaid".equalsIgnoreCase(status)) {
                sql += " AND a.status != 'paid' ";
            }
        }

        if (date != null) {
            sql += " AND a.date = ? ";
        }

        sql += "    GROUP BY a.appointmentId, a.date, a.startTime, a.endTime, "
                + "             a.status, a.staffId, a.customerId "
                + ") SELECT COUNT(*) FROM CTE WHERE 1=1 ";

        if (totalFrom != null) {
            sql += " AND total >= ? ";
        }
        if (totalTo != null) {
            sql += " AND total <= ? ";
        }

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int index = 1;
            if (staffId != null) {
                ps.setInt(index++, staffId);
            }
            if (appointmentId != null) {
                ps.setInt(index++, appointmentId);
            }
            if (search != null && !search.trim().isEmpty()) {
                ps.setString(index++, "%" + search + "%");
            }
            if (date != null) {
                ps.setDate(index++, date);
            }
            if (totalFrom != null) {
                ps.setDouble(index++, totalFrom);
            }
            if (totalTo != null) {
                ps.setDouble(index++, totalTo);
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public static void main(String[] args) throws SQLException {
        AppointmentDAO a = new AppointmentDAO();
        List<Appointment> l = a.getInvoiceByPage(1, null, null, null, null, null, null, 1, 10, null, null);
        for (Appointment appointment : l) {
            System.out.println(appointment.getCustomer().getName() + " " + appointment.getTotal());
        }
    }

}
