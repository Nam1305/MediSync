/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.TreatmentPlan;
import java.sql.*;

/**
 *
 * @author DIEN MAY XANH
 */
public class TreatmentPlanDAO extends DBContext {

    public TreatmentPlan getTreatmentPlanByAppointmentId(int appointmentId) {
        String sql = "select treatmentId, appointmentId, symptoms, diagnosis, testResults, treatmentPlan, followUp from TreatmentPlan where appointmentId = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, appointmentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                TreatmentPlan o = new TreatmentPlan(rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7));
                return o;
            }
        } catch (Exception e) {
        }
        return null; // Nếu không có bệnh án nào thì trả về null
    }

    public void saveTreatmentPlan(TreatmentPlan treatmentPlan) {
        String checkSql = "SELECT COUNT(*) FROM TreatmentPlan WHERE appointmentId = ?";
        String insertSql = "INSERT INTO TreatmentPlan (appointmentId, symptoms, diagnosis, testResults, treatmentPlan, followUp) VALUES (?, ?, ?, ?, ?, ?)";
        String updateSql = "UPDATE TreatmentPlan SET symptoms = ?, diagnosis = ?, testResults = ?, treatmentPlan = ?, followUp = ? WHERE appointmentId = ?";

        try {
            PreparedStatement checkStmt = connection.prepareStatement(checkSql);
            checkStmt.setInt(1, treatmentPlan.getAppointmentId());
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                // Nếu đã tồn tại, thực hiện UPDATE
                PreparedStatement updateStmt = connection.prepareStatement(updateSql);
                updateStmt.setString(1, treatmentPlan.getSymptoms());
                updateStmt.setString(2, treatmentPlan.getDiagnosis());
                updateStmt.setString(3, treatmentPlan.getTestResult());
                updateStmt.setString(4, treatmentPlan.getPlan());
                updateStmt.setString(5, treatmentPlan.getFollowUp());
                updateStmt.setInt(6, treatmentPlan.getAppointmentId());
                updateStmt.executeUpdate();
                updateStmt.close();
            } else {
                // Nếu chưa tồn tại, thực hiện INSERT
                PreparedStatement insertStmt = connection.prepareStatement(insertSql);
                insertStmt.setInt(1, treatmentPlan.getAppointmentId());
                insertStmt.setString(2, treatmentPlan.getSymptoms());
                insertStmt.setString(3, treatmentPlan.getDiagnosis());
                insertStmt.setString(4, treatmentPlan.getTestResult());
                insertStmt.setString(5, treatmentPlan.getPlan());
                insertStmt.setString(6, treatmentPlan.getFollowUp());
                insertStmt.executeUpdate();
                insertStmt.close();
            }

            rs.close();
            checkStmt.close();
        } catch (SQLException e) {
        }
    }

}
