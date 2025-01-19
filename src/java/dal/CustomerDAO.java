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

        String sql = "select * from Customer where email =  ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt(1));
                customer.setName(rs.getString(2));
                customer.setEmail(rs.getString(3));
                customer.setPassword(rs.getString(4));
                customer.setPhone(rs.getString(5));
                customer.setAddress(rs.getString(6));
                customer.setBloodtype(rs.getString(7));
                customer.setGender(rs.getString(8));
                customer.setDateOfBirth(rs.getDate(9));
                customer.setStatus(rs.getString(10));
                return customer;
            }
        } catch (SQLException ex) {

        }
        return null;
    }

    public void insertCustomer(Customer customer) {
        String sql = "insert into Customer(name, email, password, phone, address, status) values (?,?,?,?,?,?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, customer.getName());
            ps.setString(2, customer.getEmail());
            ps.setString(3, customer.getPassword());
            ps.setString(4, customer.getPhone());
            ps.setString(5, customer.getAddress());
            ps.setString(6, customer.getStatus());
            ps.executeUpdate();

        } catch (SQLException ex) {
            System.out.println("Loi roi!");
        }
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

    //list all customer
    public List<Customer> getAllCustomer() {
        List<Customer> listCustomer = new ArrayList<>();
        String sql = "select * from Customer";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt(1));
                customer.setName(rs.getString(2));
                customer.setEmail(rs.getString(3));
                customer.setPassword(rs.getString(4));
                customer.setPhone(rs.getString(5));
                customer.setAddress(rs.getString(6));
                customer.setBloodtype(rs.getString(7));
                customer.setGender(rs.getString(8));
                customer.setDateOfBirth(rs.getDate(9));
                customer.setStatus(rs.getString(10));
                listCustomer.add(customer);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listCustomer;
    }

    public boolean updateCustomer(Customer customer) {
        boolean isUpdated = false;
        String sql = "UPDATE customers SET name = ?, email = ?, phone = ? WHERE customerId = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, customer.getName());
            ps.setString(2, customer.getEmail());
            ps.setString(3, customer.getPhone());
            ps.setInt(4, customer.getCustomerId());
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                isUpdated = true;
            }
        } catch (SQLException ex) {
            System.out.println("Loi roi!");
        }
        return isUpdated;

    }

    public static void main(String[] args) {
        CustomerDAO d = new CustomerDAO();
        System.out.println(d.getCustomerByEmail("nva@example.com"));
    }
}
