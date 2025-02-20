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

public class AppointmentDAO extends DBContext {

    StaffDAO staffDao = new StaffDAO();
    CustomerDAO customerDao = new CustomerDAO();

    private Appointment mapResultSetToAppointment(ResultSet rs) throws SQLException {
        Appointment appointment = new Appointment();
        appointment.setAppointmentId(rs.getInt("appointmentId"));
        appointment.setDate(rs.getDate("date"));
        appointment.setStart(rs.getTime("startTime"));
        appointment.setEnd(rs.getTime("endTime"));
        appointment.setType(rs.getString("appType"));
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
        String sql = "select appointmentId, date, startTime, endTime, appType, status, staffId, customerId "
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

    public List<Appointment> getAppointmentsByStaff(int staffId) throws SQLException {
        List<Appointment> appointments = new ArrayList<>();
        String sql = "SELECT appointmentId, date, startTime, endTime, appType, status, staffId, customerId "
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

    public Time getDetailStartTime(int customerId, int appointmentId) {
        String sql = "SELECT a.startTime AS appointmentStartTime "
                + "FROM Appointment a "
                + "JOIN Customer c ON a.customerId = c.customerId "
                + "WHERE c.customerId = ? AND a.appointmentId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ps.setInt(2, appointmentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getTime("appointmentStartTime");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Time getDetailEndTime(int customerId, int appointmentId) {
        String sql = "SELECT a.endTime AS appointmentEndTime "
                + "FROM Appointment a "
                + "JOIN Customer c ON a.customerId = c.customerId "
                + "WHERE c.customerId = ? AND a.appointmentId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ps.setInt(2, appointmentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getTime("appointmentEndTime");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public String getDetailDoctorName(int customerId, int appointmentId) {
        String sql = "SELECT \n"
                + "    st.name AS doctorName\n"
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
                + "    c.customerId = ? and a.appointmentId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ps.setInt(2, appointmentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("doctorName");
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
        String sql = "SELECT appointmentId, date, startTime, endTime, appType, status, staffId, customerId "
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

    public List<Appointment> getAppointmentsByPage(int staffId, String search, String status, Date date, int page, int pageSize) throws SQLException {
        List<Appointment> appointments = new ArrayList<>();
        String sql = "SELECT appointmentId, date, startTime, endTime, appType, status, staffId, customerId "
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
        sql += " ORDER BY date DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

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
        String sql = "select appointmentId, date, startTime, endTime, appType, status, staffId, customerId from Appointment where appointmentId = ?";

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

    public static void main(String[] args) throws SQLException {
        AppointmentDAO a = new AppointmentDAO();
        List<Appointment> l = a.getAppointmentsByPage(1, "an", null, null, 1, 10);
        System.out.println(l.size());

        Appointment ap = a.getAppointmentsById(1);
        System.out.println(ap.toString());
    }

}
