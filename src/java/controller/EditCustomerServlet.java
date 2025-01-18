package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "EditCustomerServlet", urlPatterns = {"/editCustomer"})
public class EditCustomerServlet extends HttpServlet {

    private void handleEditCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //lấy tất cả thông tin về
        
        //kiểm tra null
        
        //ghép fullName
        
        //lấy customer dựa vào email, tạo customer
        
        //dùng CustomerDAO để cập nhật thông tin khách hàng trong cơ sở dữ liệu
        
        //kiểm tra kết quả cập nhật
        
        //chuyển về trang listCustomer sau khi thành công
        
        
        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleEditCustomer(request, response);

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
