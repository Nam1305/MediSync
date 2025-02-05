/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Position;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
/**
 *
 * @author Acer
 */
public class PositionDAO extends DBContext {
     public String getPositionByStaffId(int staffId) {
        String sql = "SELECT top 1 position FROM HistoryPosition WHERE staffId = ? ORDER BY date DESC "; 
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, staffId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("position"); // Chỉ trả về tên vị trí
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return "Unknown"; // Nếu không có vị trí, trả về "Unknown"
    }
//     public static void main(String[] args) {
//         PositionDAO p = new PositionDAO();
//         
//         System.out.println(p.getPositionByStaffId(1));
//    }
     public void insertPositionHistory(int staffId, String position) {
    String sql = "INSERT INTO HistoryPosition (staffId, position, date) VALUES (?, ?, GETDATE())"; 
    try {
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, staffId);
        ps.setString(2, position);
        ps.executeUpdate();
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
}
}
