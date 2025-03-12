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

    public List<Feedback> getFeedbackByStaffId(int staffId, int pageNumber, int pageSize, int starFilter, String sortOrder) {
        List<Feedback> feedbackList = new ArrayList<>();
        String sql = "SELECT f.feedBackId, f.ratings, f.content, f.date, f.staffId, f.customerId "
                + "FROM Feedback f "
                + "WHERE f.staffId = ? ";

        if (starFilter >= 1 && starFilter <= 5) {
            sql += " AND f.ratings = ? ";
        }

        if (sortOrder.equals("asc")) {
            sql += " ORDER BY f.date ASC ";
        } else {
            sql += " ORDER BY f.date DESC ";
        }

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
                SUM(CASE WHEN ratings = 5 THEN 1 ELSE 0 END) AS count_5_star,
                SUM(CASE WHEN ratings = 4 THEN 1 ELSE 0 END) AS count_4_star,
                SUM(CASE WHEN ratings = 3 THEN 1 ELSE 0 END) AS count_3_star,
                SUM(CASE WHEN ratings = 2 THEN 1 ELSE 0 END) AS count_2_star,
                SUM(CASE WHEN ratings = 1 THEN 1 ELSE 0 END) AS count_1_star,
                COUNT(*) AS total_count
            FROM Feedback
            WHERE staffId = ?
            GROUP BY staffId
        )
        SELECT 
            ROUND(avg_rating, 2) AS avg_rating, 
            ROUND(count_5_star * 100.0 / total_count, 2) AS percent_5_star,
            count_5_star AS count_5_star,
            ROUND(count_4_star * 100.0 / total_count, 2) AS percent_4_star,
            count_4_star AS count_4_star,
            ROUND(count_3_star * 100.0 / total_count, 2) AS percent_3_star,
            count_3_star AS count_3_star,
            ROUND(count_2_star * 100.0 / total_count, 2) AS percent_2_star,
            count_2_star AS count_2_star,
            ROUND(count_1_star * 100.0 / total_count, 2) AS percent_1_star,
            count_1_star AS count_1_star
        FROM RatingCount;
    """;
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, staffId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new double[]{
                    rs.getDouble("avg_rating"),
                    rs.getDouble("percent_5_star"),
                    rs.getInt("count_5_star"),
                    rs.getDouble("percent_4_star"),
                    rs.getInt("count_4_star"),
                    rs.getDouble("percent_3_star"),
                    rs.getInt("count_3_star"),
                    rs.getDouble("percent_2_star"),
                    rs.getInt("count_2_star"),
                    rs.getDouble("percent_1_star"),
                    rs.getInt("count_1_star")
                };
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return new double[]{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
    }

    public double[] getFeedbackTypePercentages(int staffId) {
        String sql = """
        WITH RatingCount AS (
            SELECT 
                COUNT(*) AS total_count,
                SUM(CASE WHEN ratings = 1 THEN 1 ELSE 0 END) AS count_1_star,
                SUM(CASE WHEN ratings = 2 THEN 1 ELSE 0 END) AS count_2_star,
                SUM(CASE WHEN ratings = 3 THEN 1 ELSE 0 END) AS count_3_star,
                SUM(CASE WHEN ratings = 4 THEN 1 ELSE 0 END) AS count_4_star,
                SUM(CASE WHEN ratings = 5 THEN 1 ELSE 0 END) AS count_5_star
            FROM Feedback
            WHERE staffId = ?
        )
        SELECT 
            total_count,
            ROUND((count_1_star + count_2_star) * 100.0 / total_count, 2) AS negativePercent,
            ROUND((count_3_star + count_4_star + count_5_star) * 100.0 / total_count, 2) AS positivePercent
        FROM RatingCount;
    """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, staffId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new double[]{
                        rs.getDouble("total_count"), // Tổng số feedback
                        rs.getDouble("negativePercent"), // Phần trăm phản hồi tiêu cực (1-2 sao)
                        rs.getDouble("positivePercent") // Phần trăm phản hồi tích cực (3-5 sao)
                    };
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return new double[]{0, 0, 0};
    }

    public boolean insertNewFeedback(Feedback feedback) {
        String sql = "INSERT INTO Feedback (ratings, content, date, staffId, customerId) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, feedback.getRatings());
            ps.setString(2, feedback.getContent());
            ps.setDate(3, feedback.getDate());
            ps.setInt(4, feedback.getStaff().getStaffId());
            ps.setInt(5, feedback.getCustomer().getCustomerId());

            return ps.executeUpdate() > 0; // Nếu có ít nhất 1 dòng được thêm, trả về true
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) {
        FeedbackDAO f = new FeedbackDAO();
        double[] d = f.getRatingStatistics(1);

        for (int i = 0; i < d.length; i++) {
            System.out.println(d[i]);
        }

    }

}
