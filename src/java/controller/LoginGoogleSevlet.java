package controller;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dal.CustomerDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;
import model.GoogleAccount;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;
import org.apache.http.client.HttpResponseException;
import java.nio.charset.StandardCharsets;
import util.Constant;

public class LoginGoogleSevlet extends HttpServlet {

    private final CustomerDAO customerDao = new CustomerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String code = request.getParameter("code");

        // Kiểm tra nếu không có code
        if (code == null || code.isEmpty()) {
            request.setAttribute("error", "Google không trả về mã xác thực. Vui lòng thử lại!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        try {
            // Lấy access token từ Google
            String accessToken = getToken(code);

            // Lấy thông tin người dùng từ Google
            GoogleAccount user = getUserInfo(accessToken);

            // Tạo đối tượng Customer và lưu thông tin
            Customer customer = new Customer();
            customer.setName(user.getName());
            customer.setEmail(user.getEmail());
            customer.setAvatar(user.getPicture());
            customer.setStatus("Active");

            // Kiểm tra nếu tài khoản đã tồn tại trong CSDL
            Customer account = customerDao.getCustomerByEmail(user.getEmail());

            if (account == null) {
                customerDao.insertCustomer(customer);
                account = customerDao.getCustomerByEmail(user.getEmail()); // Cập nhật lại account
            }

            // Kiểm tra trạng thái tài khoản
            if (account != null && "Inactive".equalsIgnoreCase(account.getStatus())) {
                request.setAttribute("error", "Tài khoản này đã bị vô hiệu hóa!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            // Đặt tài khoản vào session
            HttpSession session = request.getSession();
            session.setAttribute("customer", account);
            response.sendRedirect("home");

        } catch (IOException e) {
            request.setAttribute("error", "Có lỗi xảy ra khi liên kết với Google. Vui lòng thử lại sau!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    // Lấy mã access token từ Google
    public static String getToken(String code) throws ClientProtocolException, IOException {
        String response;
        try {
            // Gửi request đến Google để lấy access token
            response = Request.Post(Constant.GOOGLE_LINK_GET_TOKEN)
                    .bodyForm(
                            Form.form()
                                    .add("client_id", Constant.GOOGLE_CLIENT_ID)
                                    .add("client_secret", Constant.GOOGLE_CLIENT_SECRET)
                                    .add("redirect_uri", Constant.GOOGLE_REDIRECT_URI)
                                    .add("code", code)
                                    .add("grant_type", Constant.GOOGLE_GRANT_TYPE)
                                    .build()
                    )
                    .execute().returnContent().asString(StandardCharsets.UTF_8);

            JsonObject jobj = new Gson().fromJson(response, JsonObject.class);

            // Kiểm tra nếu có lỗi từ Google
            if (jobj.has("error")) {
                throw new IOException("Lỗi từ Google: " + jobj.get("error").getAsString());
            }

            return jobj.get("access_token").getAsString();

        } catch (HttpResponseException e) {
            System.err.println("Lỗi khi gọi API lấy token từ Google: " + e.getMessage());
            throw new IOException("Không thể lấy token từ Google. Vui lòng kiểm tra lại client_id và client_secret.");
        }
    }

    // Lấy thông tin người dùng từ Google API
    public static GoogleAccount getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
        String link = Constant.GOOGLE_LINK_GET_USER_INFO + accessToken;
        String response = Request.Get(link)
                .execute()
                .returnContent()
                .asString(StandardCharsets.UTF_8); // Đảm bảo mã hóa UTF-8

        System.out.println("Response from Google: " + response);
        return new Gson().fromJson(response, GoogleAccount.class);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Không sử dụng doPost cho Google Login
    }

    @Override
    public String getServletInfo() {
        return "Servlet để xử lý đăng nhập với Google";
    }
}
