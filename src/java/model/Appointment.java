
package model;

import java.sql.*;

public class Appointment {
    private int appointmentId;
    private Date date;
    private Time startTime;
    private Time endTime;
    private String appType;
    private String status;
    private int staffId;
    private int customerId;
    private int prescriptionId;

    public Appointment() {
    }

    public Appointment(int appointmentId, Date date, Time startTime, Time endTime, String appType, String status) {
        this.appointmentId = appointmentId;
        this.date = date;
        this.startTime = startTime;
        this.endTime = endTime;
        this.appType = appType;
        this.status = status;
    }

    public Appointment(int appointmentId, Date date, Time startTime, Time endTime, String appType, String status, int staffId, int customerId, int prescriptionId) {
        this.appointmentId = appointmentId;
        this.date = date;
        this.startTime = startTime;
        this.endTime = endTime;
        this.appType = appType;
        this.status = status;
        this.staffId = staffId;
        this.customerId = customerId;
        this.prescriptionId = prescriptionId;
    }

    public int getAppointmentId() {
        return appointmentId;
    }

    public void setAppointmentId(int appointmentId) {
        this.appointmentId = appointmentId;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
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

    public String getAppType() {
        return appType;
    }

    public void setAppType(String appType) {
        this.appType = appType;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getPrescriptionId() {
        return prescriptionId;
    }

    public void setPrescriptionId(int prescriptionId) {
        this.prescriptionId = prescriptionId;
    }
    
    
    
    
    
    
    
}
