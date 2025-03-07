/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Prescription;

/**
 *
 * @author DIEN MAY XANH
 */
public class PrescriptionDAO extends DBContext {

    public boolean savePrescription(int appointmentId, String[] medicineNames, String[] totalQuantities, String[] dosages, String[] notes) {
        String deleteSql = "DELETE FROM Prescription WHERE appointmentId = ?";
        String insertSql = "INSERT INTO Prescription (appointmentId, medicineName, totalQuantity, dosage, note) VALUES (?, ?, ?, ?, ?)";

        try {
            connection.setAutoCommit(false); // Bắt đầu transaction

            // Xóa đơn thuốc cũ
            try (PreparedStatement deletePs = connection.prepareStatement(deleteSql)) {
                deletePs.setInt(1, appointmentId);
                deletePs.executeUpdate();
            }

            // Chèn đơn thuốc mới
            try (PreparedStatement ps = connection.prepareStatement(insertSql)) {
                for (int i = 0; i < medicineNames.length; i++) {
                    ps.setInt(1, appointmentId);

                    // Xử lý null cho từng trường
                    if (medicineNames[i] == null) {
                        ps.setNull(2, java.sql.Types.VARCHAR);
                    } else {
                        ps.setString(2, medicineNames[i]);
                    }

                    if (totalQuantities[i] == null) {
                        ps.setNull(3, java.sql.Types.VARCHAR);
                    } else {
                        ps.setString(3, totalQuantities[i]);
                    }

                    if (dosages[i] == null) {
                        ps.setNull(4, java.sql.Types.VARCHAR);
                    } else {
                        ps.setString(4, dosages[i]);
                    }

                    if (notes[i] == null) {
                        ps.setNull(5, java.sql.Types.VARCHAR);
                    } else {
                        ps.setString(5, notes[i]);
                    }

                    ps.addBatch();
                }

                int[] results = ps.executeBatch();

                // Kiểm tra batch, rollback nếu có lỗi
                for (int res : results) {
                    if (res == PreparedStatement.EXECUTE_FAILED) {
                        connection.rollback();
                        return false;
                    }
                }
            }

            connection.commit(); // Commit nếu thành công
            return true;

        } catch (SQLException ex) {
            ex.printStackTrace();
            try {
                connection.rollback(); // Rollback nếu có exception
            } catch (SQLException e) {
                e.printStackTrace();
            }
            return false;
        } finally {
            try {
                connection.setAutoCommit(true); // Reset auto-commit
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

    public List<Prescription> getPrescriptionByAppointmentId(int appointmentId) {
        List<Prescription> prescriptions = new ArrayList<>();
        String sql = "SELECT prescriptionId,appointmentId, medicineName, totalQuantity, dosage , note FROM Prescription WHERE appointmentId = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, appointmentId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Prescription prescription = new Prescription(
                        rs.getInt("prescriptionId"),
                        rs.getInt("appointmentId"),
                        rs.getString("medicineName"),
                        rs.getString("totalQuantity"),
                        rs.getString("dosage"),
                        rs.getString("note")
                );
                prescriptions.add(prescription);
            }
        } catch (SQLException e) {
        }

        return prescriptions;
    }

    public static void main(String[] args) {
        PrescriptionDAO dao = new PrescriptionDAO();
       
    }

}
