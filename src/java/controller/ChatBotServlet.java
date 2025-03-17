///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
// */
//package controller;
//
//import java.io.IOException;
//import java.io.PrintWriter;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import java.io.BufferedReader;
//import java.io.InputStreamReader;
//import java.io.OutputStream;
//import java.net.HttpURLConnection;
//import java.net.URL;
//import java.util.Scanner;
//import org.json.JSONArray;
//import org.json.JSONObject;
//
///**
// *
// * @author Acer
// */
//@WebServlet(name = "ChatBotServlet", urlPatterns = {"/ChatBot"})
//public class ChatBotServlet extends HttpServlet {
//    
//    private static final String API_KEY = "AIzaSyDtoDrWkmHUZ0PDgnsNqLb7Atatign-XW8"; // Thay bằng API Key của bạn
//    String apiUrl = "https://generativelanguage.googleapis.com/v1/models/gemini-1.5-pro:generateContent?key=" + API_KEY;
//
//    /**
//     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
//     * methods.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//        try (PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet ChatBotServlet</title>");
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet ChatBotServlet at " + request.getContextPath() + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }
//    }
//
//    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
//    /**
//     * Handles the HTTP <code>GET</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        request.getRequestDispatcher("Chatbot.jsp").forward(request, response);
//    }
//
//    /**
//     * Handles the HTTP <code>POST</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
////        String userMessage = request.getParameter("message");
////        if (userMessage == null) {
////            response.getWriter().write("{\"error\": \"Message parameter is missing\"}");
////            return;
////        }
////        String jsonInput = "{\"model\":\"gpt-3.5-turbo\",\"messages\":[{\"role\":\"user\",\"content\":\""
////                + userMessage.replace("\"", "\\\"") + "\"}]}";
////
////        URL url = new URL(API_URL);
////        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
////        conn.setRequestMethod("POST");
////        conn.setRequestProperty("Authorization", "Bearer " + API_KEY);
////        conn.setRequestProperty("Content-Type", "application/json");
////        conn.setDoOutput(true);
////
////        try (OutputStream os = conn.getOutputStream()) {
////            os.write(jsonInput.getBytes());
////            os.flush();
////        }
////
////        int responseCode = conn.getResponseCode();
////        System.out.println("Response Code: " + responseCode);
////
////        if (responseCode != 200) {
////            Scanner errorScanner = new Scanner(conn.getErrorStream());
////            StringBuilder errorResponse = new StringBuilder();
////            while (errorScanner.hasNext()) {
////                errorResponse.append(errorScanner.nextLine());
////            }
////            errorScanner.close();
////            System.out.println("Error Response: " + errorResponse.toString());
////        }
////
////        Scanner scanner = new Scanner(conn.getInputStream());
////        StringBuilder responseText = new StringBuilder();
////        while (scanner.hasNext()) {
////            responseText.append(scanner.nextLine());
////        }
////        scanner.close();
////
////        response.setContentType("application/json");
////        response.getWriter().write(responseText.toString());
//        String userMessage = request.getParameter("message");
//        if (userMessage == null || userMessage.trim().isEmpty()) {
//            response.getWriter().write("{\"error\": \"Vui lòng nhập tin nhắn!\"}");
//            return;
//        }
//
//        // Tạo JSON request body theo đúng format API của Gemini
//        JSONObject json = new JSONObject();
//        JSONArray contents = new JSONArray();
//        JSONObject part = new JSONObject();
//        part.put("text", userMessage);
//        contents.put(new JSONObject().put("parts", new JSONArray().put(part)));
//        json.put("contents", contents);
//
//        // Gửi request đến Gemini API
//        URL url = new URL(apiUrl);
//        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
//        conn.setRequestMethod("POST");
//        conn.setRequestProperty("Content-Type", "application/json");
//        conn.setDoOutput(true);
//
//        try (OutputStream os = conn.getOutputStream()) {
//            os.write(json.toString().getBytes());
//            os.flush();
//        }
//
//        // Đọc phản hồi từ Gemini AI
//        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
//        StringBuilder responseText = new StringBuilder();
//        String line;
//        while ((line = br.readLine()) != null) {
//            responseText.append(line);
//        }
//        br.close();
//        response.setCharacterEncoding("UTF-8");
//        response.setContentType("application/json; charset=UTF-8");
//        response.getWriter().write(responseText.toString());
//    }
//
//    /**
//     * Returns a short description of the servlet.
//     *
//     * @return a String containing servlet description
//     */
//    @Override
//    public String getServletInfo() {
//        return "Short description";
//    }// </editor-fold>
//
//}
