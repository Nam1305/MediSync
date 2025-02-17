
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Appointment;
import model.Customer;


public class AppointmentDAO extends DBContext{
    
    private Appointment mapResultSetToAppointment(ResultSet rs) throws SQLException {
        Appointment appointment = new Appointment();
        appointment.setAppointmentId(rs.getInt("appointmentId"));
        appointment.setDate(rs.getDate("date"));
        appointment.setStartTime(rs.getTime("startTime"));
        appointment.setEndTime(rs.getTime("endTime"));
        appointment.setAppType(rs.getString("appType"));
        appointment.setStatus(rs.getString("status"));
        appointment.setStaffId(rs.getInt("staffId"));
        appointment.setCustomerId(rs.getInt("customerId"));
        appointment.setPrescriptionId(rs.getInt("prescriptionId"));
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
    
}
