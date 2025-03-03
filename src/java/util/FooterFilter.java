package util;

import dal.BlogDAO;
import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import model.Blog;

@WebFilter(filterName = "FooterFilter", urlPatterns = {"/*"})
public class FooterFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Không cần khởi tạo gì
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        // Lấy thông tin liên hệ từ database
        BlogDAO blogDAO = new BlogDAO();
        Blog addressInfo = blogDAO.getContactInfoByName("Địa chỉ");
        Blog emailInfo = blogDAO.getContactInfoByName("Email");
        Blog phoneInfo = blogDAO.getContactInfoByName("Số điện thoại");
        
        // Đặt thông tin vào request attribute để có thể truy cập từ JSP
        request.setAttribute("addressInfo", addressInfo);
        request.setAttribute("emailInfo", emailInfo);
        request.setAttribute("phoneInfo", phoneInfo);
        
        // Tiếp tục chuỗi filter
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
        // Không cần dọn dẹp gì
    }
}