/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.sql.*;
import java.text.SimpleDateFormat;
/**
 *
 * @author DIEN MAY XANH
 */
public class Schedule {

    private int scheduleId;
    private Time startTime;
    private Time endTime;
    private int shift;
    private Date date;
    private int staffId;

    public Schedule() {
    }

    public Schedule(int scheduleId, Time startTime, Time endTime, int shift, Date date, int staffId) {
        this.scheduleId = scheduleId;
        this.startTime = startTime;
        this.endTime = endTime;
        this.shift = shift;
        this.date = date;
        this.staffId = staffId;
    }

    public int getScheduleId() {
        return scheduleId;
    }

    public void setScheduleId(int scheduleId) {
        this.scheduleId = scheduleId;
    }

    public Time getStartTime() {
        return startTime;
    }

    public void setStartTime(Time startTime) {
        this.startTime = startTime;
    }

    public Time getEndTime() {
        return endTime;
    }

    public void setEndTime(Time endTime) {
        this.endTime = endTime;
    }

    public int getShift() {
        return shift;
    }

    public void setShift(int shift) {
        this.shift = shift;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    @Override
    public String toString() {
        return "Schedule{" + "scheduleId=" + scheduleId + ", startTime=" + startTime + ", endTime=" + endTime + ", shift=" + shift + ", date=" + date + ", staffId=" + staffId + '}';
    }
    
    public String getFormatDate() {
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyy");
        return sdf.format(this.date);
    }
    
    public String getUrlDate() {
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    return sdf.format(this.date);
}
    
    
    
}
