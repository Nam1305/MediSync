package controller;

import dao.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONException;
import org.json.JSONObject;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            setCorsHeaders(response);
            response.setStatus(HttpServletResponse.SC_OK); 

        try {
            JSONObject requestBody = parseRequestBody(request);
            String username = requestBody.optString("username");
            String password = requestBody.optString("password");
            String email = requestBody.optString("email");

            // Kiểm tra các trường nhập vào không rỗng
            if (!username.isEmpty() && !password.isEmpty() && !email.isEmpty()) {
                handleRegistration(response, username, password, email);
            } else {
                sendJsonResponse(response, false, "Dữ liệu đầu vào không hợp lệ.");
            }
        } catch (Exception e) {
            try {
                sendJsonResponse(response, false, "Lỗi khi xử lý yêu cầu: " + e.getMessage());
            } catch (JSONException ex) {
                Logger.getLogger(RegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            e.printStackTrace();
        }
    }
    
     @Override
    protected void doOptions(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        setCorsHeaders(response);  // Đảm bảo trả về các header CORS
        response.setStatus(HttpServletResponse.SC_OK);  // Trả về mã trạng thái 200 OK cho yêu cầu OPTIONS
    }

    private void handleRegistration(HttpServletResponse response, String username, String password, String email)
            throws IOException, JSONException {
        // Tạo đối tượng User và gọi phương thức đăng ký
        User user = new User(username, email, password); // Không mã hóa mật khẩu
        UserDAO userDAO = new UserDAO();

        if (userDAO.insertUser(user)) {
            sendJsonResponse(response, true, "Đăng ký thành công!");
        } else {
            sendJsonResponse(response, false, "Đăng ký thất bại. Vui lòng thử lại.");
        }
    }

    private JSONObject parseRequestBody(HttpServletRequest request) throws IOException, JSONException {
        StringBuilder sb = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        return new JSONObject(sb.toString().trim());
    }

    private void sendJsonResponse(HttpServletResponse response, boolean success, String message) throws IOException, JSONException {
        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("success", success);
        jsonResponse.put("message", message);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse.toString());
    }

    private void setCorsHeaders(HttpServletResponse response) {
        response.setHeader("Access-Control-Allow-Origin", "http://127.0.0.1:5500");
        response.setHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");
        response.setHeader("Access-Control-Allow-Credentials", "true");
    }
}
