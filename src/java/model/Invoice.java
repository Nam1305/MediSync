/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author DIEN MAY XANH
 */
public class Invoice {
    private int invoiceId;
    private Appointment appointment;
    private Service service;
    private int price;

    public Invoice() {
    }

    public Invoice(int invoiceId, Appointment appointment, Service service, int price) {
        this.invoiceId = invoiceId;
        this.appointment = appointment;
        this.service = service;
        this.price = price;
    }

    public int getInvoiceId() {
        return invoiceId;
    }

    public void setInvoiceId(int invoiceId) {
        this.invoiceId = invoiceId;
    }

    public Appointment getAppointment() {
        return appointment;
    }

    public void setAppointment(Appointment appointment) {
        this.appointment = appointment;
    }

    public Service getService() {
        return service;
    }

    public void setService(Service service) {
        this.service = service;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "Invoice{" + "invoiceId=" + invoiceId + ", appointment=" + appointment + ", service=" + service + ", price=" + price + '}';
    }

    
    
    
    
}
