/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.VNPayUtils;

/**
 *
 * @author Phạm Hoàng Nam
 */
@WebServlet(name = "VnpayServlet", urlPatterns = {"/vnpay_payment"})
public class VnpayServlet extends HttpServlet {

    private static final String VNP_TMN_CODE = "OIJ856WE";  // Mã Website của bạn
    private static final String VNP_HASH_SECRET = "MVO1QPLUJ1KNNXTJSUDY0LLNS05ATT9M"; // Secret Key
    private static final String VNP_URL = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html"; // URL thanh toán của VNPAY
    private static final String RETURN_URL = "http://localhost:9999/MediSyncSys/vnpay_return"; // Trang xử lý sau khi thanh toán
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet VnpayServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VnpayServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

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
        processRequest(request, response);
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
        long amount = Long.parseLong(request.getParameter("amount")) * 100; // VNPAY tính theo đơn vị VND x100
        String appointmentId = request.getParameter("appointmentId");  // Lấy ID từ form
        //String transactionId = appointmentId + System.currentTimeMillis(); // Tạo ID mới
        System.out.println(appointmentId);
         // Tạo request params
        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", "2.1.0");
        vnp_Params.put("vnp_Command", "pay");
        vnp_Params.put("vnp_TmnCode", VNP_TMN_CODE);
        vnp_Params.put("vnp_Amount", String.valueOf(amount));
        vnp_Params.put("vnp_CurrCode", "VND");
        vnp_Params.put("vnp_TxnRef", appointmentId);
        vnp_Params.put("vnp_OrderInfo", "Nap tien vao tai khoan");
        vnp_Params.put("vnp_OrderType", "topup");
        vnp_Params.put("vnp_Locale", "vn");
        vnp_Params.put("vnp_ReturnUrl", RETURN_URL);
        vnp_Params.put("vnp_IpAddr", request.getRemoteAddr());
        
        // Thời gian tạo request
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        vnp_Params.put("vnp_CreateDate", formatter.format(new Date()));
        
        // Sắp xếp tham số theo thứ tự alphabet để tạo checksum
        List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();
        for (String fieldName : fieldNames) {
            String value = vnp_Params.get(fieldName);
            if ((value != null) && (!value.isEmpty())) {
                hashData.append(fieldName).append('=').append(URLEncoder.encode(value, "UTF-8"));
                query.append(fieldName).append('=').append(URLEncoder.encode(value, "UTF-8"));
                if (!fieldName.equals(fieldNames.get(fieldNames.size() - 1))) {
                    hashData.append('&');
                    query.append('&');
                }
            }
        }

        // Tạo checksum (mã bảo mật) cho request
        String secureHash = VNPayUtils.hmacSHA512(VNP_HASH_SECRET, hashData.toString());
        query.append("&vnp_SecureHash=").append(secureHash);

        // Chuyển hướng đến trang thanh toán của VNPAY
        String paymentUrl = VNP_URL + "?" + query.toString();
        response.sendRedirect(paymentUrl);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
