/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import java.util.List;
import model.Schedule;
import java.sql.*;

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
        
    }
}