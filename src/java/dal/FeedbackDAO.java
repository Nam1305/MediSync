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

    public List<Feedback> getFeedbackByStaffId(int staffId, int pageNumber, int pageSize, int starFilter) {
        List<Feedback> feedbackList = new ArrayList<>();
        String sql = "SELECT f.feedBackId, f.ratings, f.content, f.date, f.staffId, f.customerId "
                + "FROM Feedback f "
                + "WHERE f.staffId = ? ";

        if (starFilter >= 1 && starFilter <= 5) {
            sql += " AND f.ratings = ? ";
        }

        sql += " ORDER BY f.date DESC ";

        // Phân trang
        sql += " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY ";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            int paramIndex = 1;
            ps.setInt(paramIndex++, staffId);

            if (starFilter >= 1 && starFilter <= 5) {
                ps.setInt(paramIndex++, starFilter);
            }

            ps.setInt(paramIndex++, (pageNumber - 1) * pageSize);
            ps.setInt(paramIndex++, pageSize);

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

    public int getTotalFeedbackCountByStaffId(int staffId, int starFilter) {
        String sql = "SELECT COUNT(*) FROM Feedback WHERE staffId = ?";

        if (starFilter >= 1 && starFilter <= 5) {
            sql += " AND ratings = ?";
        }

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int paramIndex = 1;
            ps.setInt(paramIndex++, staffId);

            if (starFilter >= 1 && starFilter <= 5) {
                ps.setInt(paramIndex++, starFilter);
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
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

        for (int i = 0; i < d.length; i++) {
            System.out.println(d[i]);
        }

        List<Feedback> listFeedback = f.getFeedbackByStaffId(1, 1, 6, 0);
        for (Feedback feedback : listFeedback) {
            System.out.println(feedback.getRatings());
        }

    }

}
