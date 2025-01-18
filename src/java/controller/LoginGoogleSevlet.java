/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dal.CustomerDAO;
import dal.StaffDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.nio.charset.StandardCharsets;
import model.Customer;
import model.GoogleAccount;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;
import util.Constant;

/**
 *
 * @author DIEN MAY XANH
 */
public class LoginGoogleSevlet extends HttpServlet {

    StaffDAO staffDao = new StaffDAO();
    CustomerDAO customerDao = new CustomerDAO();

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String code = request.getParameter("code");
        String accessToken = getToken(code);
        GoogleAccount user = getUserInfo(accessToken);
        Customer customer = new Customer();
        customer.setName(user.getName());
        customer.setEmail(user.getEmail());
        customer.setStatus("Active");
        Customer account = customerDao.getCustomerByEmail(user.getEmail());
        if (account == null) {
            customerDao.insertCustomer(customer);
        }
        HttpSession session = request.getSession();
        session.setAttribute("account", account);
        request.getRequestDispatcher("home.jsp").forward(request, response);

    }

    public static String getToken(String code) throws ClientProtocolException, IOException {
        String response = Request.Post(Constant.GOOGLE_LINK_GET_TOKEN)
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
        return jobj.get("access_token").getAsString();
    }

    public static GoogleAccount getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
        String link = Constant.GOOGLE_LINK_GET_USER_INFO + accessToken;
        String response = Request.Get(link)
                .execute()
                .returnContent()
                .asString(StandardCharsets.UTF_8); // Đảm bảo mã hóa UTF-8

        System.out.println("Response from Google: " + response);
        return new Gson().fromJson(response, GoogleAccount.class);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
