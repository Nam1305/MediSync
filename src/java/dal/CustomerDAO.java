package dal;

import model.Customer;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author DIEN MAY XANH
 */
public class CustomerDAO extends DBContext {

    public Customer getCustomerByEmail(String email) {
        String sql = "SELECT customerId, name, avatar, email, password, address, dateOfBirth, bloodType, gender, status, phone FROM Customer WHERE email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt("customerId"));
                customer.setName(rs.getString("name"));
                customer.setAvatar(rs.getString("avatar"));
                customer.setEmail(rs.getString("email"));
                customer.setPassword(rs.getString("password"));
                customer.setAddress(rs.getString("address"));
                customer.setDateOfBirth(rs.getDate("dateOfBirth"));
                customer.setBloodType(rs.getString("bloodType"));
                customer.setGender(rs.getString("gender"));
                customer.setStatus(rs.getString("status"));
                customer.setPhone(rs.getString("phone"));
                return customer;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public void addCustomer(Customer customer) {
        String sql = "insert into Customer(name, email, password, phone, dateOfBirth) values (?,?,?,?,?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, customer.getName());
            ps.setString(2, customer.getEmail());
            ps.setString(3, customer.getPassword());
            ps.setString(4, customer.getPhone());
            ps.setDate(5, customer.getDateOfBirth());

            ps.executeUpdate();

        } catch (SQLException ex) {
            System.out.println("Loi roi!");
        }
    }

    public void insertCustomer(Customer customer) {
        String sql = "INSERT INTO Customer (name, avatar, email, password, address, dateOfBirth, bloodType, gender, status, phone) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, customer.getName());
            ps.setString(2, customer.getAvatar());
            ps.setString(3, customer.getEmail());
            ps.setString(4, customer.getPassword());
            ps.setString(5, customer.getAddress());
            ps.setDate(6, customer.getDateOfBirth());
            ps.setString(7, customer.getBloodType());
            ps.setString(8, customer.getGender());
            ps.setString(9, customer.getStatus());
            ps.setString(10, customer.getPhone());
            ps.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("Error in insertCustomer: " + ex.getMessage());
            ex.printStackTrace();
        }
    }

    public List<Customer> getAllCustomer() {
        List<Customer> listCustomer = new ArrayList<>();
        String sql = "SELECT customerId, name, avatar, email, password, address, dateOfBirth, bloodType, gender, status, phone FROM Customer";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt("customerId"));
                customer.setName(rs.getString("name"));
                customer.setAvatar(rs.getString("avatar"));
                customer.setEmail(rs.getString("email"));
                customer.setPassword(rs.getString("password"));
                customer.setAddress(rs.getString("address"));
                customer.setDateOfBirth(rs.getDate("dateOfBirth"));
                customer.setBloodType(rs.getString("bloodType"));
                customer.setGender(rs.getString("gender"));
                customer.setStatus(rs.getString("status"));
                customer.setPhone(rs.getString("phone"));
                listCustomer.add(customer);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listCustomer;
    }

    public boolean updateCustomer(Customer customer) {
        boolean isUpdated = false;
        String sql = "UPDATE Customer SET name = ?, avatar = ?, email = ?, address = ?, dateOfBirth = ?, bloodType = ?, gender = ?, phone = ? WHERE customerId = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, customer.getName());
            ps.setString(2, customer.getAvatar());
            ps.setString(3, customer.getEmail());
            ps.setString(4, customer.getAddress());
            ps.setDate(5, customer.getDateOfBirth());
            ps.setString(6, customer.getBloodType());
            ps.setString(7, customer.getGender());
            ps.setString(8, customer.getPhone());
            ps.setInt(9, customer.getCustomerId());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                isUpdated = true;
            }
        } catch (SQLException ex) {
            System.out.println("Error in updateCustomer: " + ex.getMessage());
            ex.printStackTrace();
        }
        return isUpdated;
    }

    public void updatePassword(String email, String newPassword) {
        String sql = "UPDATE Customer SET password = ? WHERE email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, newPassword);
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("Error in updatePassword: " + ex.getMessage());
            ex.printStackTrace();
        }
    }

    public boolean deleteCustomer(Customer customer) {
        boolean isDeleted = false;
        String sql = "UPDATE Customer SET status = 'Inactive' WHERE customerId = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, customer.getCustomerId());
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                isDeleted = true;
            }
        } catch (SQLException ex) {
            System.out.println("Error in deleteCustomer: " + ex.getMessage());
            ex.printStackTrace();
        }
        return isDeleted;
    }

    public static void main(String[] args) {
        CustomerDAO d = new CustomerDAO();
        System.out.println(d.getCustomerByEmail("hoangduc060704@gmail.com"));
    }
}
