/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import java.util.List;
import model.Schedule;
import java.sql.*;
import model.ShiftRegistration;
import model.TimeSlot;

/**
 *
 * @author DIEN MAY XANH
 */
public class ScheduleDAO extends DBContext {

    private Schedule mapResultSetToSchedule(ResultSet rs) throws SQLException {
        int scheduleId = rs.getInt("scheduleId");
        Time startTime = rs.getTime("startTime");
        Time endTime = rs.getTime("endTime");
        int shift = rs.getInt("shift");
        Date dateWork = rs.getDate("date");
        int staffId = rs.getInt("staffId");
        return new Schedule(scheduleId, startTime, endTime, shift, dateWork, staffId);
    }

    public List<Schedule> getScheduleByStaffId(int staffId) {
        List<Schedule> list = new ArrayList<>();
        String sql = "select scheduleId, startTime, endTime, shift, date, staffId from Schedule where StaffID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, staffId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToSchedule(rs));
            }
        } catch (SQLException ex) {

        }
        return list;
    }

    public List<ShiftRegistration> ShiftRegistrationByStaffId(int staffId, int page, int pageSize) {
        List<ShiftRegistration> list = new ArrayList<>();
        String sql = "SELECT registrationId, staffId, shift, status, registrationDate "
                + "FROM DoctorShiftRegistration "
                + "WHERE staffId = ? "
                + "ORDER BY registrationDate DESC "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, staffId);
            ps.setInt(2, (page - 1) * pageSize); // Đặt OFFSET trước
            ps.setInt(3, pageSize); // Sau đó là số dòng cần lấy

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ShiftRegistration o = new ShiftRegistration(
                        rs.getInt(1), // registrationId
                        rs.getInt(2), // staffId
                        rs.getInt(3), // shift
                        rs.getString(4), // status
                        rs.getDate(5) // registrationDate
                );
                list.add(o);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public int countShiftRegistrationByStaffId(int staffId) {
        List<ShiftRegistration> list = new ArrayList<>();
        String sql = "SELECT Count(*) FROM DoctorShiftRegistration WHERE staffId = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, staffId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    public boolean insertShiftRegistration(int staffId, int shift, Date date) {
        String sql = "insert into DoctorShiftRegistration (staffId, shift, status, registrationDate) values(?,?,'Pending',?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, staffId);
            ps.setInt(2, shift);
            ps.setDate(3, date);
            ps.executeUpdate();
        } catch (SQLException e) {
            return false;
        }
        return true;
    }

    public List<Schedule> getSchedulesByDoctor(int staffId, Date date) {
        List<Schedule> schedules = new ArrayList<>();
        String sql = "SELECT * FROM Schedule WHERE staffId = ? AND date = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, staffId);
            ps.setDate(2, date);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Schedule schedule = new Schedule(
                        rs.getInt("scheduleId"),
                        rs.getTime("startTime"),
                        rs.getTime("endTime"),
                        rs.getInt("shift"),
                        rs.getDate("date"),
                        rs.getInt("staffId")
                );
                schedules.add(schedule);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return schedules;
    }

    public List<TimeSlot> getAvailableTimeSlots(int staffId, Date date) {
        List<TimeSlot> timeSlots = new ArrayList<>();
        // Lấy danh sách ca làm của bác sĩ trong ngày
        List<Schedule> schedules = getSchedulesByDoctor(staffId, date);

        // Truy vấn danh sách các lịch hẹn đã đặt
        String sql = "SELECT startTime FROM Appointment WHERE staffId = ? AND date = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, staffId);
            ps.setDate(2, date);
            ResultSet rs = ps.executeQuery(); //rs này chứa các danh sách slot đã được đặt

            // Lưu các slot đã được đặt vào danh sách
            List<Time> bookedSlots = new ArrayList<>();
            while (rs.next()) {
                bookedSlots.add(rs.getTime("startTime"));
            }

            // Tạo danh sách slot khám từ các ca làm việc
            for (Schedule schedule : schedules) {
                List<TimeSlot> slots = generateTimeSlots(schedule.getStartTime(), schedule.getEndTime());

                // Đánh dấu các slot đã được đặt
                for (TimeSlot slot : slots) {
                    if (bookedSlots.contains(slot.getStartTime())) {
                        slot.setIsBooked(true);
                    }
                }

                timeSlots.addAll(slots);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return timeSlots;
    }

    private List<TimeSlot> generateTimeSlots(Time start, Time end) {
        List<TimeSlot> slots = new ArrayList<>();
        long interval = 30 * 60 * 1000; // 30 phút tính bằng milliseconds
        long current = start.getTime();

        while (current + interval <= end.getTime()) {
            Time startTime = new Time(current);
            Time endTime = new Time(current + interval);
            slots.add(new TimeSlot(startTime, endTime, false));
            current += interval;
        }
        return slots;
    }

    public boolean bookAppointment(int staffId, int customerId, Time startTime, Time endTime, Date date) {
        String sql = "INSERT INTO Appointment (staffId, customerId, startTime, endTime, date, status) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, staffId);
            ps.setInt(2, customerId);
            ps.setTime(3, startTime);
            ps.setTime(4, endTime);
            ps.setDate(5, date);
            ps.setString(6, "pending");
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            return false;
        }
    }
    
    
    public boolean deleteShiftRegistration(int registrationId) {
        String sql = "delete from DoctorShiftRegistration where registrationId = ?";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, registrationId);
            ps.executeUpdate();     
        } catch (SQLException ex) {
            return false;
        }
        return true;
    }
    
    //Them boi Nguyen Dinh Chinh
    public boolean updateShiftRegistration(ShiftRegistration registration) {
        String sql = "UPDATE DoctorShiftRegistration SET staffId = ?, shift = ?, status = ?, registrationDate = ? WHERE registrationId = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, registration.getStaffId());
            ps.setInt(2, registration.getShift());
            ps.setString(3, registration.getStatus());
            ps.setDate(4, registration.getRegisDate());
            ps.setInt(5, registration.getRegistrationId());

            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    /**
     * Lấy danh sách đăng ký ca làm việc với các tùy chọn lọc và phân trang
     *
     * @param staffId ID của nhân viên, truyền vào null để lấy tất cả nhân viên
     * @param fromDate Ngày bắt đầu tìm kiếm, truyền vào null để không giới hạn
     * @param toDate Ngày kết thúc tìm kiếm, truyền vào null để không giới hạn
     * @param page Số trang hiện tại
     * @param pageSize Số lượng bản ghi trên mỗi trang
     * @return Danh sách các đăng ký ca làm việc
     */
    public List<ShiftRegistration> getShiftRegistrations(Integer staffId, Date fromDate, Date toDate, int page, int pageSize) {
        List<ShiftRegistration> list = new ArrayList<>();
        StringBuilder sqlBuilder = new StringBuilder();
        sqlBuilder.append("SELECT registrationId, staffId, shift, status, registrationDate ")
                .append("FROM DoctorShiftRegistration WHERE 1=1 ");

        if (staffId != null) {
            sqlBuilder.append("AND staffId = ? ");
        }

        if (fromDate != null) {
            sqlBuilder.append("AND registrationDate >= ? ");
        }

        if (toDate != null) {
            sqlBuilder.append("AND registrationDate <= ? ");
        }

        sqlBuilder.append("ORDER BY registrationDate DESC ")
                .append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try {
            PreparedStatement ps = connection.prepareStatement(sqlBuilder.toString());
            int paramIndex = 1;

            if (staffId != null) {
                ps.setInt(paramIndex++, staffId);
            }

            if (fromDate != null) {
                ps.setDate(paramIndex++, fromDate);
            }

            if (toDate != null) {
                ps.setDate(paramIndex++, toDate);
            }

            ps.setInt(paramIndex++, (page - 1) * pageSize);
            ps.setInt(paramIndex, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ShiftRegistration o = new ShiftRegistration(
                        rs.getInt("registrationId"),
                        rs.getInt("staffId"),
                        rs.getInt("shift"),
                        rs.getString("status"),
                        rs.getDate("registrationDate")
                );
                list.add(o);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    /**
     * Đếm tổng số bản ghi đăng ký ca làm việc thỏa mãn điều kiện lọc
     *
     * @param staffId ID của nhân viên, truyền vào null để đếm tất cả nhân viên
     * @param fromDate Ngày bắt đầu tìm kiếm, truyền vào null để không giới hạn
     * @param toDate Ngày kết thúc tìm kiếm, truyền vào null để không giới hạn
     * @return Tổng số bản ghi thỏa mãn điều kiện
     */
    public int countShiftRegistrations(Integer staffId, Date fromDate, Date toDate) {
        StringBuilder sqlBuilder = new StringBuilder();
        sqlBuilder.append("SELECT COUNT(*) FROM DoctorShiftRegistration WHERE 1=1 ");

        if (staffId != null) {
            sqlBuilder.append("AND staffId = ? ");
        }

        if (fromDate != null) {
            sqlBuilder.append("AND registrationDate >= ? ");
        }

        if (toDate != null) {
            sqlBuilder.append("AND registrationDate <= ? ");
        }

        try {
            PreparedStatement ps = connection.prepareStatement(sqlBuilder.toString());
            int paramIndex = 1;

            if (staffId != null) {
                ps.setInt(paramIndex++, staffId);
            }

            if (fromDate != null) {
                ps.setDate(paramIndex++, fromDate);
            }

            if (toDate != null) {
                ps.setDate(paramIndex++, toDate);
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    /**
     * Lấy thông tin đăng ký ca làm việc theo ID
     *
     * @param registrationId ID của đăng ký cần tìm
     * @return Đối tượng ShiftRegistration nếu tìm thấy, null nếu không tìm thấy
     */
    public ShiftRegistration getShiftRegistrationById(int registrationId) {
        String sql = "SELECT registrationId, staffId, shift, status, registrationDate "
                + "FROM DoctorShiftRegistration WHERE registrationId = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, registrationId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new ShiftRegistration(
                        rs.getInt("registrationId"),
                        rs.getInt("staffId"),
                        rs.getInt("shift"),
                        rs.getString("status"),
                        rs.getDate("registrationDate")
                );
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) {
        ScheduleDAO d = new ScheduleDAO();
//        List<Schedule> l = d.getScheduleByPage(1, null, null, 1, 3);
//        for (Schedule s : l) {
//            System.out.println(s.toString());
//        }
//        System.out.println(l.size());
//        Schedule schedule = new Schedule(
//                1, // scheduleId
//                Time.valueOf("08:00:00"), // startTime
//                Time.valueOf("17:00:00"), // endTime
//                1, // shift
//                Date.valueOf("2025-02-17"), // date
//                101 // staffId
//        );
//
//        Date workDate = new Date(System.currentTimeMillis());
//        d.insertShiftRegistration(1, 1, workDate);
//        List<ShiftRegistration> l = d.ShiftRegistrationByStaffId(1, 1, 10);
//        for (ShiftRegistration sh : l) {
//            System.out.println(sh);
//        }

//        int staffId = 1; // ID của bác sĩ cần test
//        List<Schedule> schedules = d.getSchedulesByDoctor(staffId, Date.valueOf("2025-01-26"));
//        if (schedules.isEmpty()) {
//            System.out.println("Không có lịch làm việc nào cho bác sĩ " + staffId + " vào ngày " );
//        } else {
//            System.out.println("Lịch làm việc của bác sĩ " + staffId + " vào ngày "  + ":");
//            for (Schedule schedule : schedules) {
//                System.out.println("Schedule ID: " + schedule.getScheduleId()
//                        + ", Start Time: " + schedule.getStartTime()
//                        + ", End Time: " + schedule.getEndTime()
//                        + ", Shift: " + schedule.getShift());
//            }
//        }
//        List<TimeSlot> timeSlot = d.generateTimeSlots(Time.valueOf("08:00:00"), Time.valueOf("10:00:00"));
//        for (TimeSlot timeSlot1 : timeSlot) {
//            System.out.println(timeSlot);
//        }
        List<TimeSlot> timeSlot = d.getAvailableTimeSlots(1, Date.valueOf("2025-01-25"));
        for (TimeSlot timeSlot1 : timeSlot) {
            if (timeSlot1.isIsBooked() == false) {
                System.out.println(timeSlot1);
            }

        }
        
        boolean x = d.bookAppointment(1, 11,Time.valueOf("10:00:00"), Time.valueOf("10:30:00"), Date.valueOf("2025-01-25"));
        System.out.println(x);
    }
    
    public boolean insertSchedule(Schedule schedule) {
        String sql = "INSERT INTO Schedule (startTime, endTime, shift, date, staffId) VALUES (?, ?, ?, ?, ?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setTime(1, schedule.getStartTime());
            ps.setTime(2, schedule.getEndTime());
            ps.setInt(3, schedule.getShift());
            ps.setDate(4, schedule.getDate());
            ps.setInt(5, schedule.getStaffId());

            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
