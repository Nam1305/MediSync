/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import java.util.List;
import model.Feedback;
import java.sql.*;
import model.Staff;
import model.Customer;

/**
 *
 * @author DIEN MAY XANH
 */
public class FeedbackDAO extends DBContext {

    StaffDAO staffDao = new StaffDAO();
    CustomerDAO customerDao = new CustomerDAO();

    public List<Feedback> getFeedbackByStaffId(int staffId) {
        List<Feedback> feedbackList = new ArrayList<>();
        String sql = "SELECT feedBackId, ratings, content, date, staffId, customerId FROM Feedback WHERE staffId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, staffId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Staff staff = staffDao.getStaffById(rs.getInt("staffId"));
                Customer customer = customerDao.getCustomerById(rs.getInt("customerId"));

                Feedback feedback = new Feedback(
                        rs.getInt("feedBackId"),
                        rs.getInt("ratings"),
                        rs.getString("content"),
                        rs.getDate("date"),
                        staff,
                        customer
                );
                feedbackList.add(feedback);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return feedbackList;
    }

    public double[] getRatingStatistics(int staffId) {
        String sql = """
        WITH RatingCount AS (
            SELECT 
                staffId,
                COUNT(*) AS total_feedback,
                AVG(CAST(ratings AS FLOAT)) AS avg_rating,
                SUM(CASE WHEN ratings = 5 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS percent_5_star,
                SUM(CASE WHEN ratings = 4 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS percent_4_star,
                SUM(CASE WHEN ratings = 3 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS percent_3_star,
                SUM(CASE WHEN ratings = 2 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS percent_2_star,
                SUM(CASE WHEN ratings = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS percent_1_star
            FROM Feedback
            WHERE staffId = ?
            GROUP BY staffId
        )
        SELECT ROUND(avg_rating, 2), 
               ROUND(percent_5_star, 2),
               ROUND(percent_4_star, 2),
               ROUND(percent_3_star, 2),
               ROUND(percent_2_star, 2),
               ROUND(percent_1_star, 2)
        FROM RatingCount;
    """;
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, staffId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new double[]{
                    rs.getDouble(1),
                    rs.getDouble(2),
                    rs.getDouble(3),
                    rs.getDouble(4),
                    rs.getDouble(5),
                    rs.getDouble(6)
                };
            }
        } catch (Exception e) {
        }
        return new double[]{0, 0, 0, 0, 0, 0};
    
        
}
    public static void main(String[] args) {
        FeedbackDAO f = new FeedbackDAO();
        double[] d = f.getRatingStatistics(1);
        for(int i = 0; i < d.length; i++){
            System.out.println(d[i]);
        }
    }

}
