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
        String sql = "select scheduleId, startTime, endTime, shift, date, staffId from Schedule where StaffID = ? order by date desc";

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

    public List<Schedule> getScheduleByPage(int staffId, Date start, Date end, int page, int size) {
        List<Schedule> list = new ArrayList<>();
        String sql = "SELECT scheduleId, startTime, endTime, shift, date, staffId "
                + "FROM Schedule WHERE staffId = ? ";

        if (start != null) {
            sql += "AND date >= ? ";
        }
        if (end != null) {
            sql += "AND date <= ? ";
        }

        sql += "ORDER BY date DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            int paramIndex = 1;
            ps.setInt(paramIndex++, staffId);
            if (start != null) {
                ps.setDate(paramIndex++, start);
            }
            if (end != null) {
                ps.setDate(paramIndex++, end);
            }
            ps.setInt(paramIndex++, (page - 1) * size);
            ps.setInt(paramIndex++, size);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToSchedule(rs));
            }
        } catch (SQLException ex) {

        }
        return list;
    }

    public int countScheduleByFilter(int staffId, Date start, Date end, int page, int size) {
        String sql = "SELECT COUNT(*) FROM Schedule WHERE staffId = ? ";
        if (start != null) {
            sql += "AND date >= ? ";
        }
        if (end != null) {
            sql += "AND date <= ? ";
        }

        try {
PreparedStatement ps = connection.prepareStatement(sql);
            int paramIndex = 1;
            ps.setInt(paramIndex++, staffId);
            if (start != null) {
                ps.setDate(paramIndex++, start);
            }
            if (end != null) {
                ps.setDate(paramIndex++, end);
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {

        }
        return 0;
    }

    public void insertSchedule(Schedule schedule) {
        String sql = "insert into Schedule(startTime, endTime, shift, date, staffId) values(?,?,?,?,?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setTime(1, schedule.getStartTime());
            ps.setTime(2, schedule.getEndTime());
            ps.setInt(3, schedule.getShift());
            ps.setDate(4, schedule.getDate());
            ps.setInt(5, schedule.getStaffId());
            ps.executeUpdate();

        } catch (SQLException ex) {
        }
    }

    public Schedule checkExistSchedule(Schedule schedule) {
        String sql = "SELECT leId, startTime, endTime, shift, date, staffId FROM Schedule WHERE staffId = ? AND date = ? AND startTime = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, schedule.getStaffId());
            ps.setDate(2, schedule.getDate());
            ps.setTime(3, schedule.getStartTime());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToSchedule(rs);
            }

        } catch (SQLException e) {
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
        Schedule schedule = new Schedule(
                1, // scheduleId
                Time.valueOf("08:00:00"), // startTime
                Time.valueOf("17:00:00"), // endTime
                1, // shift
                Date.valueOf("2025-02-17"), // date
                101 // staffId
        );
        
        Schedule s = d.checkExistSchedule(schedule);
        System.out.println(s);
    }
}