/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Service;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Acer
 */
public class ServiceDAO extends DBContext {
    // Thêm service

    public boolean insertService(Service service) {
        String sql = "INSERT INTO Service (content, price, name, status) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, service.getContent());
            ps.setDouble(2, service.getPrice());
            ps.setString(3, service.getName());
            ps.setString(4, service.getStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update service
    public boolean updateService(Service service) {
        String sql = "UPDATE Service SET content = ?, price = ?, name = ?, status = ? WHERE serviceId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, service.getContent());
            ps.setDouble(2, service.getPrice());
            ps.setString(3, service.getName());
            ps.setString(4, service.getStatus());
            ps.setInt(5, service.getServiceId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // xóa service
    public boolean deleteService(int serviceId) {
        String sql = "UPDATE Service SET  status = 'Inactive' WHERE serviceId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, serviceId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // list ra tất cả service
    public List<Service> getAllServices(String searchQuery, String status, int page, int pageSize) {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT serviceId,content,price,name,status  FROM Service Where 1 = 1 ";
        if (searchQuery != null && !searchQuery.isEmpty()) {
            sql += " AND (name LIKE ? )";
        }
        if (status != null && !status.isEmpty()) {
            sql += " AND status = ?";
        }
        sql += " ORDER BY serviceId OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            int index = 1;
            PreparedStatement ps = connection.prepareStatement(sql);
            if (searchQuery != null && !searchQuery.isEmpty()) {
                ps.setString(index++, "%" + searchQuery + "%");
            }
            if (status != null && !status.isEmpty()) {
                ps.setString(index++, status);
            }
            ps.setInt(index++, (page - 1) * pageSize);
            ps.setInt(index++, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Service service = new Service(
                        rs.getInt("serviceId"),
                        rs.getString("content"),
                        rs.getDouble("price"),
                        rs.getString("name"),
                        rs.getString("status")
                );
                services.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return services;
    }

    // list ra tất cả service
    public int getTotalServices(String searchQuery, String status) {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT  COUNT(*)   FROM Service Where 1 = 1 ";
        if (searchQuery != null && !searchQuery.isEmpty()) {
            sql += " AND (name LIKE ? )";
        }
        if (status != null && !status.isEmpty()) {
            sql += " AND status = ?";
        }
        
        try {
            int index = 1;
            PreparedStatement ps = connection.prepareStatement(sql);
            if (searchQuery != null && !searchQuery.isEmpty()) {
                ps.setString(index++, "%" + searchQuery + "%");
            }
            if (status != null && !status.isEmpty()) {
                ps.setString(index++, status);
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1); // Lấy số lượng Service từ COUNT(*)
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // lấy service theo id
    public Service getServiceById(int serviceId) {
        String sql = "SELECT serviceId, content, price , name, status FROM Service WHERE serviceId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, serviceId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Service(
                        rs.getInt("serviceId"),
                        rs.getString("content"),
                        rs.getDouble("price"),
                        rs.getString("name"),
                        rs.getString("status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // hàm check phòng ban xem có bị trùng tên hay không
    public boolean isServiceExists(String name) {
        // Chuẩn hóa dữ liệu trước khi so sánh: loại bỏ khoảng trắng ở đầu và cuối, và thay thế khoảng trắng thừa giữa các từ thành một khoảng trắng duy nhất.

        String sql = "SELECT COUNT(*) FROM Service WHERE LOWER(REPLACE(LTRIM(RTRIM(name)), ' ', ' ')) = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, name.trim().toLowerCase().replaceAll("\\s+", " "));
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return true; // Tên đã tồn tại
            }
        } catch (SQLException ex) {
            System.out.println("Lỗi kiểm tra phòng ban: " + ex.getMessage());
        }
        return false;
    }
    // hàm check phòng ban xem có bị trùng tên hay không

    public boolean isServiceNotCurrentExists(String name, int serviceId) {
        // Chuẩn hóa dữ liệu trước khi so sánh: loại bỏ khoảng trắng ở đầu và cuối, và thay thế khoảng trắng thừa giữa các từ thành một khoảng trắng duy nhất.

        String sql = "SELECT COUNT(*) FROM Service WHERE LOWER(REPLACE(LTRIM(RTRIM(name)), ' ', ' ')) = ? AND serviceId != ? ";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, name.trim().toLowerCase().replaceAll("\\s+", " "));
            ps.setInt(2, serviceId);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return true; // Tên đã tồn tại
            }
        } catch (SQLException ex) {
            System.out.println("Lỗi kiểm tra phòng ban: " + ex.getMessage());
        }
        return false;
    }

    public boolean isContentExists(String name) {
        // Chuẩn hóa dữ liệu trước khi so sánh: loại bỏ khoảng trắng ở đầu và cuối, và thay thế khoảng trắng thừa giữa các từ thành một khoảng trắng duy nhất.

        String sql = "SELECT COUNT(*) FROM Service WHERE LOWER(REPLACE(LTRIM(RTRIM(content)), ' ', ' ')) = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, name.trim().toLowerCase().replaceAll("\\s+", " "));
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return true; // Tên đã tồn tại
            }
        } catch (SQLException ex) {
            System.out.println("Lỗi kiểm tra phòng ban: " + ex.getMessage());
        }
        return false;
    }

    public boolean isContentNotCurrentExists(String name, int serviceId) {
        // Chuẩn hóa dữ liệu trước khi so sánh: loại bỏ khoảng trắng ở đầu và cuối, và thay thế khoảng trắng thừa giữa các từ thành một khoảng trắng duy nhất.

        String sql = "SELECT COUNT(*) FROM Service WHERE LOWER(REPLACE(LTRIM(RTRIM(content)), ' ', ' ')) = ? AND serviceId != ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, name.trim().toLowerCase().replaceAll("\\s+", " "));
            ps.setInt(2, serviceId);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return true; // Tên đã tồn tại
            }
        } catch (SQLException ex) {
            System.out.println("Lỗi kiểm tra phòng ban: " + ex.getMessage());
        }
        return false;
    }
//    public static void main(String[] args) {
//        ServiceDAO service = new ServiceDAO();
//        service.deleteService(17);
//        System.out.println(service.getServiceById(17));
//        
//    }

    private Service mapResultSetToService(ResultSet rs) throws SQLException {
        return new Service(
                rs.getInt("serviceId"),
                rs.getString("content"),
                rs.getFloat("price"),
                rs.getString("name"),
                rs.getString("status")
        );
    }

    public List<Service> getAllActiveServices() {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT serviceId, [content], price, name, status FROM Service WHERE status = 'Active'";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                services.add(mapResultSetToService(rs));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return services;
    }

    public List<Service> getServices(String serviceType, String search, String sortPrice,
            Double minPrice, Double maxPrice, // thêm 2 tham số mới
            int page, int pageSize) {
        List<Service> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("WITH CTE AS ( ");
        sql.append("    SELECT *, ROW_NUMBER() OVER (");

        if (sortPrice != null) {
            sql.append(" ORDER BY price ");
            sql.append(sortPrice.equals("asc") ? "ASC" : "DESC");
        } else {
            sql.append(" ORDER BY serviceId DESC");
        }
        sql.append(") AS RowNum FROM Service WHERE status = 'Active'");

        // Thêm điều kiện lọc theo khoảng giá
        if (minPrice != null) {
            sql.append(" AND price >= ?");
        }
        if (maxPrice != null) {
            sql.append(" AND price <= ?");
        }

        if (serviceType != null && !serviceType.isEmpty()) {
            if (serviceType.equals("other")) {
                sql.append(" AND name NOT LIKE N'%Khám%' ")
                        .append(" AND name NOT LIKE N'%Tư vấn%' ")
                        .append(" AND name NOT LIKE N'%Nội soi%' ")
                        .append(" AND name NOT LIKE N'%xét nghiệm%'");
            } else {
                sql.append(" AND name LIKE N'%" + serviceType + "%'");
            }
        }

        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND LOWER(name) LIKE LOWER(?)");
        }

        sql.append(") SELECT serviceId, [content], price, name, status ")
                .append("FROM CTE WHERE RowNum BETWEEN ? AND ?");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int parameterIndex = 1;

            // Set giá trị cho các tham số khoảng giá
            if (minPrice != null) {
                ps.setDouble(parameterIndex++, minPrice);
            }
            if (maxPrice != null) {
                ps.setDouble(parameterIndex++, maxPrice);
            }

            if (search != null && !search.trim().isEmpty()) {
                ps.setString(parameterIndex++, "%" + search + "%");
            }

            int start = (page - 1) * pageSize + 1;
            int end = page * pageSize;
            ps.setInt(parameterIndex++, start);
            ps.setInt(parameterIndex, end);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToService(rs));
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public int getTotalServicesCount(String serviceType, String search, Double minPrice, Double maxPrice) {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT COUNT(serviceId) FROM Service WHERE status = 'Active'");

        // Thêm điều kiện lọc theo khoảng giá
        if (minPrice != null) {
            sql.append(" AND price >= ?");
        }
        if (maxPrice != null) {
            sql.append(" AND price <= ?");
        }

        if (serviceType != null && !serviceType.isEmpty()) {
            if (serviceType.equals("other")) {
                sql.append(" AND name NOT LIKE N'%Khám%' ")
                        .append(" AND name NOT LIKE N'%Tư vấn%' ")
                        .append(" AND name NOT LIKE N'%Nội soi%' ")
                        .append(" AND name NOT LIKE N'%xét nghiệm%'");
            } else {
                sql.append(" AND name LIKE N'%" + serviceType + "%'");
            }
        }

        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND LOWER(name) LIKE LOWER(?)");
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int parameterIndex = 1;

            // Set giá trị cho các tham số khoảng giá
            if (minPrice != null) {
                ps.setDouble(parameterIndex++, minPrice);
            }
            if (maxPrice != null) {
                ps.setDouble(parameterIndex++, maxPrice);
            }

            if (search != null && !search.trim().isEmpty()) {
                ps.setString(parameterIndex++, "%" + search + "%");
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }
}
