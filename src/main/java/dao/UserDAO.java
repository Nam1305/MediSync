package dao;
import dao.mydao.MyDAO;
import model.User;
import java.sql.SQLException;

public class UserDAO extends MyDAO {

    public boolean insertUser(User user) {
        try {
            xSql = "INSERT INTO Users (username, email, password) VALUES (?, ?, ?)";
            ps = con.prepareStatement(xSql);
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResources(); // Đảm bảo đóng tài nguyên sau khi thực hiện xong
        }
    }

    // Phương thức để đóng các tài nguyên (ResultSet, PreparedStatement, Connection)
    private void closeResources() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Bạn có thể thêm các phương thức khác để lấy người dùng, kiểm tra tồn tại, v.v.
}
