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

    public List<Appointment> getAppointmentsByPage(int staffId, String search, String status, Date fromDate, Date toDate, int page, int pageSize, String sort) throws SQLException {
        List<Appointment> appointments = new ArrayList<>();
        String sql = "SELECT appointmentId, date, startTime, endTime, status, staffId, customerId "
                + "FROM Appointment WHERE staffId = ?";

        if (search != null && !search.trim().isEmpty()) {
            sql += " AND customerId IN (SELECT customerId FROM Customer WHERE name LIKE ?)";
        }

        if (status != null && !status.trim().isEmpty()) {
            // Nếu status được truyền, áp dụng mapping đã định:
            if ("confirmed".equals(status)) {
                sql += " AND status = 'confirmed'";
            } else if ("waitpay".equals(status)) {
                sql += " AND status IN ('waitpay','paid')";
            } else if ("absent".equals(status)) {
                sql += " AND status = 'absent'";
            }
        } else {
            // Nếu không có status được truyền, lọc tất cả nhưng loại trừ cancelled và pending
            sql += " AND status NOT IN ('cancelled','pending')";
        }

        // Xử lý date: hỗ trợ nhập 1 trong 2 hoặc cả 2
        if (fromDate != null && toDate != null) {
            sql += " AND date BETWEEN ? AND ?";
        } else if (fromDate != null) {
            sql += " AND date >= ?";
        } else if (toDate != null) {
            sql += " AND date <= ?";
        }

        sql += " ORDER BY date DESC, startTime " + sort + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        PreparedStatement ps = connection.prepareStatement(sql);
        int index = 1;
        ps.setInt(index++, staffId);

        if (search != null && !search.trim().isEmpty()) {
            ps.setString(index++, "%" + search + "%");
        }

        if (fromDate != null && toDate != null) {
            ps.setDate(index++, fromDate);
            ps.setDate(index++, toDate);
        } else if (fromDate != null) {
            ps.setDate(index++, fromDate);
        } else if (toDate != null) {
            ps.setDate(index++, toDate);
        }

        int offset = (page - 1) * pageSize;
        ps.setInt(index++, offset);
        ps.setInt(index++, pageSize);

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            appointments.add(mapResultSetToAppointment(rs));
        }
        return appointments;
    }

    public int[] countAppointmentStatsByFilter(int staffId, String search, String status, Date fromDate, Date toDate) throws SQLException {
        // Mảng kết quả: [total, completed, waiting, absent]
        int[] stats = new int[4];

        String sql = "SELECT COUNT(*) as total, "
                + "SUM(CASE WHEN status IN ('waitpay','paid') THEN 1 ELSE 0 END) as completed, "
                + "SUM(CASE WHEN status = 'confirmed' THEN 1 ELSE 0 END) as waiting, "
                + "SUM(CASE WHEN status = 'absent' THEN 1 ELSE 0 END) as absent "
                + "FROM Appointment WHERE staffId = ?";

        // Filter theo tìm kiếm
        if (search != null && !search.trim().isEmpty()) {
            sql += " AND customerId IN (SELECT customerId FROM Customer WHERE name LIKE ?)";
        }

        // Filter theo status:
        if (status != null && !status.trim().isEmpty()) {
            if ("confirmed".equals(status)) {
                // Nếu filter là pending, thì chỉ lấy các appointment có status = 'confirmed'
                sql += " AND status = 'confirmed'";
            } else if ("waitpay".equals(status)) {
                // Nếu filter là confirmed, chỉ lấy các appointment có status IN ('waitpay','paid')
                sql += " AND status IN ('waitpay','paid')";
            } else if ("absent".equals(status)) {
                // Nếu filter là absent
                sql += " AND status = 'absent'";
            }
        } else {
            // Nếu không có filter status, lấy tất cả các appointment nhưng loại trừ cancelled và pending
            sql += " AND status NOT IN ('cancelled','pending')";
        }

        // Xử lý điều kiện ngày: hỗ trợ nhập 1 trong 2 hoặc cả 2
        if (fromDate != null && toDate != null) {
            sql += " AND date BETWEEN ? AND ?";
        } else if (fromDate != null) {
            sql += " AND date >= ?";
        } else if (toDate != null) {
            sql += " AND date <= ?";
        }

        PreparedStatement ps = connection.prepareStatement(sql);
        int index = 1;
        ps.setInt(index++, staffId);

        if (search != null && !search.trim().isEmpty()) {
            ps.setString(index++, "%" + search + "%");
        }

        if (fromDate != null && toDate != null) {
            ps.setDate(index++, fromDate);
            ps.setDate(index++, toDate);
        } else if (fromDate != null) {
            ps.setDate(index++, fromDate);
        } else if (toDate != null) {
            ps.setDate(index++, toDate);
        }

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            stats[0] = rs.getInt("total");
            stats[1] = rs.getInt("completed");
            stats[2] = rs.getInt("waiting");
            stats[3] = rs.getInt("absent");
        }
        return stats;
    }

    public int countAppointmentsWithSameCustomer(int appointmentId, int staffId) {
        String sql = """
        SELECT COUNT(*) AS numAppointments
        FROM Appointment
        WHERE customerId = (
            SELECT customerId
            FROM Appointment
            WHERE appointmentId = ?
        )
          AND staffId = ?
    """;

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, appointmentId);
            ps.setInt(2, staffId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("numAppointments");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
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

    public List<Appointment> getInvoiceByPage(Integer appointmentId, String search,
            String status, Date dateFrom, Date dateTo, Double totalFrom, Double totalTo,
            int page, int pageSize, String sortDate, String sortPrice) {
        List<Appointment> appointments = new ArrayList<>();

        // Đảm bảo sortPrice có giá trị mặc định nếu NULL
        sortPrice = (sortPrice == null || sortPrice.trim().isEmpty()) ? "ASC" : sortPrice;

        String sql = "WITH CTE AS ( "
                + "    SELECT a.appointmentId, a.date, a.startTime, a.endTime, a.status, "
                + "           a.staffId, a.customerId, SUM(i.price) AS total "
                + "    FROM Appointment a "
                + "    INNER JOIN Invoice i ON a.appointmentId = i.appointmentId "
                + "    WHERE 1=1 ";

        if (appointmentId != null) {
            sql += " AND a.appointmentId = ? ";
        }
        if (search != null && !search.trim().isEmpty()) {
            sql += " AND a.customerId IN (SELECT customerId FROM Customer WHERE name LIKE ?) ";
        }
        if (status != null && !status.trim().isEmpty()) {
            if ("paid".equalsIgnoreCase(status)) {
                sql += " AND a.status = 'paid' ";
            } else if ("unpaid".equalsIgnoreCase(status)) {
                sql += " AND a.status != 'paid' ";
            }
        }
        // Sử dụng khoảng ngày (từ dateFrom đến dateTo)
        if (dateFrom != null) {
            sql += " AND a.date >= ? ";
        }
        if (dateTo != null) {
            sql += " AND a.date <= ? ";
        }

        sql += "    GROUP BY a.appointmentId, a.date, a.startTime, a.endTime, a.status, a.staffId, a.customerId "
                + ") SELECT * FROM CTE WHERE 1=1 ";

        if (totalFrom != null) {
            sql += " AND total >= ? ";
        }
        if (totalTo != null) {
            sql += " AND total <= ? ";
        }
        // Xử lý ORDER BY
        if (sortDate != null && !sortDate.trim().isEmpty()) {
            sql += " ORDER BY date " + sortDate + ", ";
        } else {
            sql += " ORDER BY ";
        }
        sql += " CASE WHEN total = 0 THEN -999999 ELSE total END " + sortPrice
                + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int index = 1;
            if (appointmentId != null) {
                ps.setInt(index++, appointmentId);
            }
            if (search != null && !search.trim().isEmpty()) {
                ps.setString(index++, "%" + search + "%");
            }
            if (dateFrom != null) {
                ps.setDate(index++, dateFrom);
            }
            if (dateTo != null) {
                ps.setDate(index++, dateTo);
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
                    appointment.setTotal(rs.getDouble("total")); // Nếu NULL -> 0
                    appointments.add(appointment);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return appointments;
    }

    public int countInvoiceByPage(Integer appointmentId, String search,
            String status, Date dateFrom, Date dateTo, Double totalFrom, Double totalTo) {
        int count = 0;

        String sql = "WITH CTE AS ( "
                + "    SELECT a.appointmentId, a.date, a.startTime, a.endTime, a.status, "
                + "           a.staffId, a.customerId, SUM(i.price) AS total "
                + "    FROM Appointment a "
                + "    INNER JOIN Invoice i ON a.appointmentId = i.appointmentId "
                + "    WHERE 1=1 ";

        if (appointmentId != null) {
            sql += " AND a.appointmentId = ? ";
        }
        if (search != null && !search.trim().isEmpty()) {
            sql += " AND a.customerId IN (SELECT customerId FROM Customer WHERE name LIKE ?) ";
        }
        if (status != null && !status.trim().isEmpty()) {
            if ("paid".equalsIgnoreCase(status)) {
                sql += " AND a.status = 'paid' ";
            } else if ("unpaid".equalsIgnoreCase(status)) {
                sql += " AND a.status != 'paid' ";
            }
        }
        if (dateFrom != null) {
            sql += " AND a.date >= ? ";
        }
        if (dateTo != null) {
            sql += " AND a.date <= ? ";
        }

        sql += "    GROUP BY a.appointmentId, a.date, a.startTime, a.endTime, a.status, a.staffId, a.customerId "
                + ") SELECT COUNT(*) FROM CTE WHERE 1=1 ";

        if (totalFrom != null) {
            sql += " AND total >= ? ";
        }
        if (totalTo != null) {
            sql += " AND total <= ? ";
        }

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int index = 1;
            if (appointmentId != null) {
                ps.setInt(index++, appointmentId);
            }
            if (search != null && !search.trim().isEmpty()) {
                ps.setString(index++, "%" + search + "%");
            }
            if (dateFrom != null) {
                ps.setDate(index++, dateFrom);
            }
            if (dateTo != null) {
                ps.setDate(index++, dateTo);
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

    public boolean cancelAppointment(int appointmentId) {
        String sql = "UPDATE Appointment SET status = 'cancelled' where appointmentId = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, appointmentId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;

    }

    public List<Appointment> getAllAppointmentsByPage(String search, String status, Date date, int page, int pageSize, String sort) throws SQLException {
        List<Appointment> appointments = new ArrayList<>();
        String sql = "SELECT appointmentId, date, startTime, endTime, status, staffId, customerId "
                + "FROM Appointment WHERE 1=1";

        if (search != null && !search.trim().isEmpty()) {
            sql += " AND customerId IN (SELECT customerId FROM Customer WHERE name LIKE ?)";
        }
        if (status != null && !status.trim().isEmpty()) {
            sql += " AND status = ?";
        }
        if (date != null) {
            sql += " AND date = ?";
        }

        // Sử dụng ORDER BY để sắp xếp theo ngày và thời gian
        sql += " ORDER BY date " + (sort.equalsIgnoreCase("asc") ? "ASC" : "DESC")
                + ", startTime " + (sort.equalsIgnoreCase("asc") ? "ASC" : "DESC")
                + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int index = 1;
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

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    appointments.add(mapResultSetToAppointment(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return appointments;
    }

    public int countAllAppointmentsByFilter(String search, String status, Date date) throws SQLException {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM Appointment WHERE 1=1";

        if (search != null && !search.trim().isEmpty()) {
            sql += " AND customerId IN (SELECT customerId FROM Customer WHERE name LIKE ?)";
        }
        if (status != null && !status.trim().isEmpty()) {
            sql += " AND status = ?";
        }
        if (date != null) {
            sql += " AND date = ?";
        }

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int index = 1;
            if (search != null && !search.trim().isEmpty()) {
                ps.setString(index++, "%" + search + "%");
            }
            if (status != null && !status.trim().isEmpty()) {
                ps.setString(index++, status);
            }
            if (date != null) {
                ps.setDate(index++, date);
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

    public int countAllAppointmentsByFilterForPatient(int customerId, String search, String gender, String status) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM Appointment a "
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

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return count;
    }

    public void updateStatusForPayInvoice(int appointmentId) {
        String sql = "UPDATE Appointment SET status = 'paid' where appointmentId = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, appointmentId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int getTotalAppointments() {
        String sql = "SELECT COUNT(*) FROM Appointment";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1); // Lấy giá trị COUNT từ kết quả truy vấn
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0; // Trả về 0 nếu có lỗi
    }
    
    public void updateInvoiceStatus(int appointmentId, String newStatus) {
        String sql = "UPDATE Appointment SET status = ? WHERE appointmentId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, appointmentId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

//    public static void main(String[] args) throws SQLException {
//        AppointmentDAO a = new AppointmentDAO();
////        List<Appointment> l = a.getInvoiceByPage(1, null, null, null, null, null, null, 1, 10, null, null);
////        for (Appointment appointment : l) {
////            System.out.println(appointment.getCustomer().getName() + " " + appointment.getTotal());
////        }
//        int x = a.countAllAppointmentsByFilterForPatient(1, null, "M", "all");
//        System.out.println(x);
//    }
      public static void main(String[] args) {
        AppointmentDAO appointmentDAO = new AppointmentDAO();
        
          System.out.println(appointmentDAO.getTotalAppointments());
    }
}
