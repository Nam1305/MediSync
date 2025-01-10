
package controller;

import com.google.gson.Gson;
import dao.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Account;

/**
 *
 * @author Admin
 */
@WebServlet(name="AccountServlet", urlPatterns={"/AccountServlet"})
public class AccountServlet extends HttpServlet {
   
    private void getAllAccounts(HttpServletResponse response) throws IOException {
        AccountDAO accountDao = new AccountDAO();
        List<Account> allAccounts = accountDao.getAllAccount(); // Giả sử phương thức này đã được định nghĩa trong MangaDAO
        Gson gson = new Gson();
        String json = gson.toJson(allAccounts);
        response.getWriter().write(json);
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        // Cấu hình CORS
        response.setHeader("Access-Control-Allow-Origin", "*"); // Thay '*' bằng tên miền cụ thể nếu cần
        response.setHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");
        getAllAccounts(response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
