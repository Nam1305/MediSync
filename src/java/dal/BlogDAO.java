package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Blog;
import util.BCrypt;

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

    public List<Blog> getBlogs(String search, String sort, int page, int itemsPerPage) {
        List<Blog> list = new ArrayList<>();
        String sql = "WITH CTE AS ( "
                + "SELECT TOP 8 date,blogId, blogName, content, image, author, typeId, selectedBanner, ROW_NUMBER() OVER (ORDER BY date "
                + (sort != null && sort.equals("asc") ? "ASC" : "DESC") // Xử lý phần sắp xếp
                + ") AS RowNum "
                + "FROM Blog WHERE blogName LIKE ? and typeId = 0  ) "
                + "SELECT * FROM CTE WHERE RowNum BETWEEN ? AND ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + (search != null ? search : "") + "%");
            //thêm logic phân trang
            int start = (page - 1) * itemsPerPage + 1;
            int end = page * itemsPerPage;
            ps.setInt(2, start);
            ps.setInt(3, end);
            //thêm logic phân trang
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
        sql.append("  SELECT blogId, blogName, [content], image, author, date, typeId, selectedBanner, ROW_NUMBER() OVER (ORDER BY date ");
        sql.append(sortOrder.equalsIgnoreCase("asc") ? "ASC" : "DESC");
        sql.append("  ) AS RowNum FROM Blog WHERE typeId = 1");

        // Add search condition if search query is provided
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            sql.append(" AND blogName LIKE ?");
        }

        sql.append(") AS PagedResults WHERE RowNum BETWEEN ? AND ?");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int parameterIndex = 1;

            // Set search parameter if exists
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
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
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Blog WHERE typeId = 1");
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            sql.append(" AND blogName LIKE ?");
        }
        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                ps.setString(1, "%" + searchQuery + "%");
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

    public int getTotalBlogsCount(String search) {
        String sql = "SELECT COUNT(blogId) FROM Blog WHERE blogName LIKE ? and typeId =0";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + (search != null ? search : "") + "%");

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

    public boolean isBannerNameExists(String bannerName) {
        String sql = "SELECT COUNT(*) FROM Blog WHERE blogName = ? AND typeId = 1";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, bannerName);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            System.out.println("Error checking banner name: " + e.getMessage());
        }
        return false;
    }
}
