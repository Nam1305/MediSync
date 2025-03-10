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

    public List<Blog> getNearestBlogs() {
        List<Blog> topBlog = new ArrayList<>();
        String sql = "SELECT TOP 3 date, blogId, blogName, [content], image, author, typeId, selectedBanner FROM Blog WHERE typeId = 0 ORDER BY date DESC;";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                topBlog.add(mapResultSetToBlog(rs));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return topBlog;
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
                + "SELECT *, ROW_NUMBER() OVER (ORDER BY date "
                + (sort != null && sort.equals("asc") ? "ASC" : "DESC")
                + ", blogId "
                + (sort != null && sort.equals("asc") ? "ASC" : "DESC")
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

    public int getTotalBlogs() {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM Blog WHERE typeId = 0";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    total = rs.getInt(1);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return total;
    }

    public boolean updateBlog(Blog blog) {
        boolean isUpdated = false;
        String sql = "UPDATE Blog SET blogName=?, content=?, image=?, author=?, date=?, typeId=?, selectedBanner=? WHERE blogId=?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, blog.getBlogName());
            ps.setString(2, blog.getContent());
            ps.setString(3, blog.getImage());
            ps.setString(4, blog.getAuthor());
            ps.setDate(5, blog.getDate());
            ps.setInt(6, blog.getTypeId());
            ps.setInt(7, blog.getSelectedBanner());
            ps.setInt(8, blog.getBlogId());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                isUpdated = true;
            }
        } catch (SQLException ex) {
            System.out.println("Error updating blog: " + ex.getMessage());
            ex.printStackTrace();
        }
        return isUpdated;
    }

    public boolean addBlog(Blog blog) {
        String sql = "INSERT INTO Blog (blogName, content, image, author, date, typeId, selectedBanner) VALUES (?, ?, ?, ?, ?, 0, 0)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, blog.getBlogName());
            ps.setString(2, blog.getContent());
            ps.setString(3, blog.getImage());
            ps.setString(4, blog.getAuthor());
            ps.setDate(5, blog.getDate());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return true;
    }

    public boolean deleteBlog(int blogId) {
        boolean isDeleted = false;
        String sql = "DELETE FROM Blog WHERE blogId = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, blogId);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                isDeleted = true;
            }
        } catch (SQLException ex) {
            System.out.println("Error in deleteBlog: " + ex.getMessage());
            ex.printStackTrace();
        }
        return isDeleted;
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

    //code cho footer
    //Code cho footer
    // Method to add a single contact info entry
    public boolean addContactInfo(String blogName, String content, String image, String author) {
        String sql = "INSERT INTO Blog (blogName, [content], image, author, date, typeId, selectedBanner) VALUES (?, ?, ?, ?, GETDATE(), 2, 0)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, blogName);
            ps.setString(2, content);
            ps.setString(3, image); // Can be null
            ps.setString(4, author);

            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException ex) {
            System.out.println("Error adding contact information: " + ex.getMessage());
            ex.printStackTrace();
            return false;
        }
    }

// Method to add multiple contact info entries at once
    public int addMultipleContactInfo(List<Blog> contactList) {
        String sql = "INSERT INTO Blog (blogName, [content], image, author, date, typeId, selectedBanner) VALUES (?, ?, ?, ?, GETDATE(), 2, 0)";
        int successCount = 0;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            for (Blog contact : contactList) {
                ps.setString(1, contact.getBlogName());
                ps.setString(2, contact.getContent());
                ps.setString(3, contact.getImage());
                ps.setString(4, contact.getAuthor());

                successCount += ps.executeUpdate();
            }
            return successCount;
        } catch (SQLException ex) {
            System.out.println("Error adding multiple contact information: " + ex.getMessage());
            ex.printStackTrace();
            return successCount;
        }
    }

// Method to add basic contact info (address, email, phone)
    public int addBasicContactInfo(String addressContent, String emailContent, String phoneContent, String author) {
        if (author == null || author.trim().isEmpty()) {
            author = "Admin";
        }

        List<Blog> contactList = new ArrayList<>();

        // Create Blog object for Address
        Blog addressBlog = new Blog();
        addressBlog.setBlogName("Địa chỉ");
        addressBlog.setContent(addressContent);
        addressBlog.setImage(null);
        addressBlog.setAuthor(author);
        addressBlog.setTypeId(2); // Changed to typeId = 2
        addressBlog.setSelectedBanner(0);
        contactList.add(addressBlog);

        // Create Blog object for Email
        Blog emailBlog = new Blog();
        emailBlog.setBlogName("Email");
        emailBlog.setContent(emailContent);
        emailBlog.setImage(null);
        emailBlog.setAuthor(author);
        emailBlog.setTypeId(2); // Changed to typeId = 2
        emailBlog.setSelectedBanner(0);
        contactList.add(emailBlog);

        // Create Blog object for Phone
        Blog phoneBlog = new Blog();
        phoneBlog.setBlogName("Số điện thoại");
        phoneBlog.setContent(phoneContent);
        phoneBlog.setImage(null);
        phoneBlog.setAuthor(author);
        phoneBlog.setTypeId(2); // Changed to typeId = 2
        phoneBlog.setSelectedBanner(0);
        contactList.add(phoneBlog);

        return addMultipleContactInfo(contactList);
    }

// Method to get contact info by name
    public Blog getContactInfoByName(String blogName) {
        String sql = "SELECT blogId, blogName, [content], image, author, date, typeId, selectedBanner "
                + "FROM Blog WHERE typeId = 2 AND blogName = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, blogName);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToBlog(rs);
                }
            }
        } catch (SQLException ex) {
            System.out.println("Error retrieving contact information by name: " + ex.getMessage());
            ex.printStackTrace();
        }

        return null;
    }

// Method to update contact info
    public boolean updateContactInfo(int blogId, String content) {
        String sql = "UPDATE Blog SET [content] = ?, date = GETDATE() WHERE blogId = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, content);
            ps.setInt(2, blogId);

            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException ex) {
            System.out.println("Error updating contact information: " + ex.getMessage());
            ex.printStackTrace();
            return false;
        }
    }

// Method to update contact info with author
    public boolean updateContactInfoWithAuthor(int blogId, String content, String author) {
        String sql = "UPDATE Blog SET [content] = ?, author = ?, date = GETDATE() WHERE blogId = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, content);
            ps.setString(2, author);
            ps.setInt(3, blogId);

            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException ex) {
            System.out.println("Error updating contact information with author: " + ex.getMessage());
            ex.printStackTrace();
            return false;
        }
    }

// Method to update all contact info
    public int updateAllContactInfo(String addressContent, String emailContent, String phoneContent, String author) {
        int successCount = 0;

        // Get current information
        Blog addressBlog = getContactInfoByName("Địa chỉ");
        Blog emailBlog = getContactInfoByName("Email");
        Blog phoneBlog = getContactInfoByName("Số điện thoại");

        // Update address info if exists
        if (addressBlog != null) {
            if (updateContactInfoWithAuthor(addressBlog.getBlogId(), addressContent, author)) {
                successCount++;
            }
        } else {
            // If not exists, create new
            Blog newAddress = new Blog();
            newAddress.setBlogName("Địa chỉ");
            newAddress.setContent(addressContent);
            newAddress.setImage(null);
            newAddress.setAuthor(author);
            newAddress.setTypeId(2); // Changed to typeId = 2
            newAddress.setSelectedBanner(0);

            if (addContactInfo(newAddress.getBlogName(), newAddress.getContent(), newAddress.getImage(), author)) {
                successCount++;
            }
        }

        // Update email info if exists
        if (emailBlog != null) {
            if (updateContactInfoWithAuthor(emailBlog.getBlogId(), emailContent, author)) {
                successCount++;
            }
        } else {
            // If not exists, create new
            Blog newEmail = new Blog();
            newEmail.setBlogName("Email");
            newEmail.setContent(emailContent);
            newEmail.setImage(null);
            newEmail.setAuthor(author);
            newEmail.setTypeId(2); // Changed to typeId = 2
            newEmail.setSelectedBanner(0);

            if (addContactInfo(newEmail.getBlogName(), newEmail.getContent(), newEmail.getImage(), author)) {
                successCount++;
            }
        }

        // Update phone info if exists
        if (phoneBlog != null) {
            if (updateContactInfoWithAuthor(phoneBlog.getBlogId(), phoneContent, author)) {
                successCount++;
            }
        } else {
            // If not exists, create new
            Blog newPhone = new Blog();
            newPhone.setBlogName("Số điện thoại");
            newPhone.setContent(phoneContent);
            newPhone.setImage(null);
            newPhone.setAuthor(author);
            newPhone.setTypeId(2); // Changed to typeId = 2
            newPhone.setSelectedBanner(0);

            if (addContactInfo(newPhone.getBlogName(), newPhone.getContent(), newPhone.getImage(), author)) {
                successCount++;
            }
        }

        return successCount;
    }
}
