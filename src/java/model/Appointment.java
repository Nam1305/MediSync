/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import dal.AppointmentDAO;
import java.sql.*;
import java.util.List;
/**
 *
 * @author DIEN MAY XANH
 */
public class Appointment {
    AppointmentDAO appointmentDao = new AppointmentDAO();
    private int appointmentId;
    private Date date;
    private Time start, end;
    private String type;
    private String status;
    private Staff staff;
    private Customer customer;

    public Appointment() {
    }

    public Appointment(int appointmentId, Date date, Time start, Time end, String type, String status, Staff staff, Customer customer) {
        this.appointmentId = appointmentId;
        this.date = date;
        this.start = start;
        this.end = end;
        this.type = type;
        this.status = status;
        this.staff = staff;
        this.customer = customer;
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

    public Time getStart() {
        return start;
    }

    public void setStart(Time start) {
        this.start = start;
    }

    public Time getEnd() {
        return end;
    }

    public void setEnd(Time end) {
        this.end = end;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Staff getStaff() {
        return staff;
    }

    public void setStaff(Staff staff) {
        this.staff = staff;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    @Override
    public String toString() {
        return "Appointment{" + "appointmentId=" + appointmentId + ", date=" + date + ", start=" + start + ", end=" + end + ", type=" + type + ", status=" + status + ", staff=" + staff + ", customer=" + customer + '}';
    }
    
    
    
    
}
