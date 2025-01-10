/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import java.util.List;
import model.Account;
import java.sql.*;

/**
 *
 * @author DIEN MAY XANH
 */
public class AccountDAO extends DBContext {

    public List<Account> getAll() {
        List<Account> listAccount = new ArrayList<>();
        String sql = "select * from Account";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Account account = new Account(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getInt(5));
                listAccount.add(account);
            }
        } catch (SQLException ex) {

        }
        return listAccount;
    }

    public Account getAccountByEmail(String email) {
        String sql = "select * from Account where email = '" + email + "'";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Account account = new Account(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getInt(5));
                return account;
            }
        } catch (SQLException e) {
        }
        return null;
    }
    public static void main(String[] args) {
        AccountDAO account = new AccountDAO();

        System.out.println(account.getAccountByEmail("user4@example.com"));
    }
}
