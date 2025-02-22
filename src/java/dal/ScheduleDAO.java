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

    public static void main(String[] args) {
        ScheduleDAO d = new ScheduleDAO();
//        List<Schedule> l = d.getScheduleByPage(1, null, null, 1, 3);
//        for (Schedule s : l) {
//            System.out.println(s.toString());
//        }
//        System.out.println(l.size());
        Schedule schedule = new Schedule(
                1, // scheduleId
                Time.valueOf("08:00:00"), // startTime
                Time.valueOf("17:00:00"), // endTime
                1, // shift
                Date.valueOf("2025-02-17"), // date
                101 // staffId
        );

        Date workDate = new Date(System.currentTimeMillis());
        d.insertShiftRegistration(1, 1, workDate);
        List<ShiftRegistration> l = d.ShiftRegistrationByStaffId(1, 1, 10);
        for (ShiftRegistration sh : l) {
            System.out.println(sh);
        }
    }
}
