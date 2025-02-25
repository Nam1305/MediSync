/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Service;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author Acer
 */
public class ServiceDAO extends DBContext{
     // Thêm service
    public boolean insertService(Service service) {
        String sql = "INSERT INTO Service (content, price, name, status) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, service.getContent());
            ps.setDouble(2, service.getPrice());
            ps.setString(3, service.getName());
            ps.setString(4, service.getStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update service
    public boolean updateService(Service service) {
        String sql = "UPDATE Service SET content = ?, price = ?, name = ?, status = ? WHERE serviceId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, service.getContent());
            ps.setDouble(2, service.getPrice());
            ps.setString(3, service.getName());
            ps.setString(4, service.getStatus());
            ps.setInt(5, service.getServiceId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // xóa service
    public boolean deleteService(int serviceId) {
        String sql = "UPDATE Service SET  status = 'Inactive' WHERE serviceId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, serviceId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
 
    // list ra tất cả service
    public List<Service> getAllServices() {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT serviceId,content,price,name,status  FROM Service";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Service service = new Service(
                    rs.getInt("serviceId"),
                    rs.getString("content"),
                    rs.getDouble("price"),
                    rs.getString("name"),
                    rs.getString("status")
                );
                services.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return services;
    }

    // lấy service theo id
    public Service getServiceById(int serviceId) {
        String sql = "SELECT serviceId, content, price , name, status FROM Service WHERE serviceId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, serviceId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Service(
                    rs.getInt("serviceId"),
                    rs.getString("content"),
                    rs.getDouble("price"),
                    rs.getString("name"),
                    rs.getString("status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
//    public static void main(String[] args) {
//        ServiceDAO service = new ServiceDAO();
//        service.deleteService(17);
//        System.out.println(service.getServiceById(17));
//        
//    }
}

