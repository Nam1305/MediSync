/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import java.util.List;
import model.Invoice;
import java.sql.*;
import model.Appointment;
import model.Service;

/**
 *
 * @author DIEN MAY XANH
 */
public class InvoiceDAO extends DBContext {

    AppointmentDAO appointmentDao = new AppointmentDAO();
    ServiceDAO serviceDao = new ServiceDAO();

    public List<Invoice> getInvoiceByAppointment(int appointmentId) {
        List<Invoice> invoices = new ArrayList<>();
        String sql = "select invoiceId, appointmentId, serviceId, price from Invoice where appointmentId = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, appointmentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Appointment appointment = appointmentDao.getAppointmentById(appointmentId);
                Service service = serviceDao.getServiceById(rs.getInt("serviceId"));
                Invoice invoice = new Invoice(
                        rs.getInt("invoiceId"),
                        appointment,
                        service,
                        rs.getInt("price")
                );
                invoices.add(invoice);

            }
        } catch (SQLException e) {
        }
        return invoices;
    }
    
    
    public List<Invoice> getInvoiceByStaff(int staffId) {
        List<Invoice> invoices = new ArrayList<>();
        String sql = "select invoiceId, appointmentId, serviceId, price from Invoice where appointmentId = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, staffId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Appointment appointment = appointmentDao.getAppointmentById(rs.getInt("appointmentId"));
                Service service = serviceDao.getServiceById(rs.getInt("serviceId"));
                Invoice invoice = new Invoice(
                        rs.getInt("invoiceId"),
                        appointment,
                        service,
                        rs.getInt("price")
                );
                invoices.add(invoice);

            }
        } catch (SQLException e) {
        }
        return invoices;
    }

    public void addInvoice(int appointmentId, int serviceId) {
        String sql = "insert into Invoice(appointmentId, serviceId, price) values (?, ?, (select price from Service where serviceId = ?));";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, appointmentId);
            ps.setInt(2, serviceId);
            ps.setInt(3, serviceId);
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void deleteInvoice(int invoiceId) {
        String sql = "delete from Invoice where InvoiceId = ?";
        try  {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, invoiceId);
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }
    
    //Phần Của Sơn
    public double calculateTotalRevenue() {
        double totalRevenue = 0;
        String sql = "SELECT SUM(price) FROM Invoice";
        
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                totalRevenue = rs.getDouble(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return totalRevenue;
    }
    
}
