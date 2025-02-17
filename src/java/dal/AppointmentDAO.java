package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Appointment;
import model.Customer;
import model.Staff;

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
        String sql = "SELECT * FROM Appointment WHERE customerId = ?";

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

}
