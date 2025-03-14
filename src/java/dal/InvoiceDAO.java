/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import java.util.List;
import model.Invoice;
import java.sql.*;
import java.util.LinkedHashMap;
import java.util.Map;
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

    public List<Invoice> getInvoiceByStaff(int staffId) throws SQLException {
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


    public boolean saveInvoice(int appointmentId, String[] serviceIds, String[] prices) {
        String deleteSql = "DELETE FROM Invoice WHERE appointmentId = ?";
        String insertSql = "INSERT INTO Invoice (appointmentId, serviceId, price) VALUES (?, ?, ?)";
        try {
            connection.setAutoCommit(false);

            // Xóa các invoice cũ của appointment
            try (PreparedStatement deletePs = connection.prepareStatement(deleteSql)) {
                deletePs.setInt(1, appointmentId);
                deletePs.executeUpdate();
            }

            // Chèn các invoice mới
            try (PreparedStatement ps = connection.prepareStatement(insertSql)) {
                for (int i = 0; i < serviceIds.length; i++) {
                    ps.setInt(1, appointmentId);
                    if (serviceIds[i] != null && !serviceIds[i].trim().isEmpty()) {
                        ps.setInt(2, Integer.parseInt(serviceIds[i]));
                        double price = (prices != null && prices.length > i && prices[i] != null && !prices[i].trim().isEmpty())
                                ? Double.parseDouble(prices[i]) : 0.0;
                        ps.setDouble(3, price);
                    } else {
                        ps.setNull(2, java.sql.Types.INTEGER);
                        ps.setNull(3, java.sql.Types.DOUBLE);
                    }
                    ps.addBatch();
                }
                for (int res : ps.executeBatch()) {
                    if (res == PreparedStatement.EXECUTE_FAILED) {
                        connection.rollback();
                        return false;
                    }
                }
            }

            connection.commit();
            return true;
        } catch (NumberFormatException | SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
            }
            return false;
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
            }
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
    public Map<String, Double> getRevenueStats(int year, int month, int day) {
    Map<String, Double> stats = new LinkedHashMap<>();
    String sql = "SELECT FORMAT(a.date, 'yyyy-MM-dd') AS day, SUM(i.price) AS totalRevenue " +
                 "FROM Appointment a JOIN Invoice i ON a.appointmentId = i.appointmentId " +
                 "WHERE (YEAR(a.date) = ? OR ? = 0) " +
                 "AND (MONTH(a.date) = ? OR ? = 0) " +
                 "AND (DAY(a.date) = ? OR ? = 0) " +
                 "GROUP BY FORMAT(a.date, 'yyyy-MM-dd') ORDER BY MIN(a.date)";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, year);
        ps.setInt(2, year);
        ps.setInt(3, month);
        ps.setInt(4, month);
        ps.setInt(5, day);
        ps.setInt(6, day);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            stats.put(rs.getString("day"), rs.getDouble("totalRevenue"));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return stats;
}

    public static void main(String[] args) {
        InvoiceDAO i = new InvoiceDAO();
        System.out.println(i.getRevenueStats(2025, 1, 25));
    }
}
