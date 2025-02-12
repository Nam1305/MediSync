package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Blog;

public class BlogDAO extends DBContext {

    public BlogDAO() {
        super();
    }

    public List<Blog> getRandomBlogs() {
        List<Blog> blogs = new ArrayList<>();
        String sql = "SELECT TOP 3 blogId, blogName, [content], image, author, date, typeId, selectedBanner FROM Blog WHERE typeId = 0 ORDER BY NEWID();";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                blogs.add(mapResultSetToBlog(rs));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return blogs;
    }

    public List<Blog> getAllBlogs() {
        List<Blog> listBlog = new ArrayList<>();
        String sql = "SELECT blogId, blogName, [content], image, author, date, typeId, selectedBanner FROM Blog WHERE typeId = 0;";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                listBlog.add(mapResultSetToBlog(rs));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listBlog;
    }

    public Blog getBlogById(int blogId) {
        String sql = "SELECT blogId, blogName, [content], image, author, date, typeId, selectedBanner FROM Blog WHERE blogId = ?;";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, blogId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToBlog(rs);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public List<Blog> getBlogs(String search, String sort) {
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT blogId, blogName, [content], image, author, date, typeId, selectedBanner FROM Blog WHERE blogName LIKE ? ORDER BY date ";

        if ("asc".equals(sort)) {
            sql += "ASC";
        } else {
            sql += "DESC";
        }

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + (search != null ? search : "") + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapResultSetToBlog(rs));
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public List<Blog> getActiveBanners() {
        List<Blog> banners = new ArrayList<>();
        String sql = "SELECT blogId, blogName, [content], image, author, date, typeId, selectedBanner FROM Blog WHERE typeId = 1 AND selectedBanner = 1;";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                banners.add(mapResultSetToBlog(rs));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return banners;
    }

    private Blog mapResultSetToBlog(ResultSet rs) throws SQLException {
        return new Blog(
                rs.getInt("blogId"),
                rs.getString("blogName"),
                rs.getString("content"),
                rs.getString("image"),
                rs.getString("author"),
                rs.getDate("date"),
                rs.getInt("typeId"),
                rs.getInt("selectedBanner")
        );
    }

    public List<Blog> getAllBlogsForBanner(int page, int itemsPerPage, String searchQuery, String sortOrder) {
        List<Blog> blogs = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT blogId, blogName, [content], image, author, date, typeId, selectedBanner FROM (");
        sql.append("  SELECT blogId, blogName, [content], image, author, date, typeId, selectedBanner, ");
        sql.append("  ROW_NUMBER() OVER (ORDER BY date ");
        sql.append(sortOrder.equalsIgnoreCase("asc") ? "ASC" : "DESC");
        sql.append("  ) AS RowNum FROM Blog WHERE typeId = 1"); // Điều kiện cơ bản

        // Thêm điều kiện tìm kiếm vào TRONG phạm vi của typeId = 1
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            sql.append(" AND (LOWER(blogName) LIKE LOWER(?) OR LOWER(content) LIKE LOWER(?))");
        }

        sql.append(") AS PagedResults WHERE RowNum BETWEEN ? AND ?");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int parameterIndex = 1;

            // Set search parameters if exists
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                ps.setString(parameterIndex++, "%" + searchQuery + "%");
                ps.setString(parameterIndex++, "%" + searchQuery + "%");
            }

            // Set pagination parameters
            int start = (page - 1) * itemsPerPage + 1;
            int end = page * itemsPerPage;
            ps.setInt(parameterIndex++, start);
            ps.setInt(parameterIndex, end);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    blogs.add(mapResultSetToBlog(rs));
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return blogs;
    }

    public int getTotalBannersCount(String searchQuery) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Blog WHERE typeId = 1"); // Điều kiện cơ bản

        // Thêm điều kiện tìm kiếm vào TRONG phạm vi của typeId = 1
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            sql.append(" AND (LOWER(blogName) LIKE LOWER(?) OR LOWER(content) LIKE LOWER(?))");
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                ps.setString(1, "%" + searchQuery + "%");
                ps.setString(2, "%" + searchQuery + "%");
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

    public void updateBannerStatus(int blogId, boolean setAsBanner) {
        String sql = "UPDATE Blog SET selectedBanner = ? WHERE blogId = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, setAsBanner ? 1 : 0);
            ps.setInt(2, blogId);
            ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void addNewBanner(Blog banner) {
        String sql = "INSERT INTO Blog (blogName, content, image, typeId, selectedBanner, date, author) "
                + "VALUES (?, ?, ?, ?, ?, GETDATE(), 'Admin')";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, banner.getBlogName());
            ps.setString(2, banner.getContent());
            ps.setString(3, banner.getImage());
            ps.setInt(4, banner.getTypeId());
            ps.setInt(5, banner.getSelectedBanner());
            ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
}
