/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.*;

/**
 *
 * @author DIEN MAY XANH
 */
public class ShiftRegistration {

    private int registrationId, staffId, shift;
    private String status;
    private Date regisDate;
    private Date startDate; // New field
    private Date endDate;   // New field

    public ShiftRegistration() {
    }

    public ShiftRegistration(int registrationId, int staffId, int shift, String status, Date regisDate) {
        this.registrationId = registrationId;
        this.staffId = staffId;
        this.shift = shift;
        this.status = status;
        this.regisDate = regisDate;
    }

    // New constructor with startDate and endDate
    public ShiftRegistration(int registrationId, int staffId, int shift, String status, Date regisDate, Date startDate, Date endDate) {
        this.registrationId = registrationId;
        this.staffId = staffId;
        this.shift = shift;
        this.status = status;
        this.regisDate = regisDate;
        this.startDate = startDate;
        this.endDate = endDate;
    }

    public int getRegistrationId() {
        return registrationId;
    }

    public void setRegistrationId(int registrationId) {
        this.registrationId = registrationId;
    }

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public int getShift() {
        return shift;
    }

    public void setShift(int shift) {
        this.shift = shift;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getRegisDate() {
        return regisDate;
    }

    public void setRegisDate(Date regisDate) {
        this.regisDate = regisDate;
    }

    // Getters and setters for new fields
    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    @Override
    public String toString() {
        return "ShiftRegistration{" + "registrationId=" + registrationId + ", staffId=" + staffId + ", shift=" + shift
                + ", status=" + status + ", regisDate=" + regisDate + ", startDate=" + startDate + ", endDate=" + endDate + '}';
    }
}
