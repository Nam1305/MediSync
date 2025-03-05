/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

import dal.DoctorDAO;
import dal.ScheduleDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Schedule;
import model.Staff;
import model.TimeSlot;
import java.sql.*;

/**
 *
 * @author Phạm Hoàng Nam
 */
@WebServlet(name = "ViewDoctorDetailServlet", urlPatterns = {"/doctorDetail"})
public class ViewDoctorDetailServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void handleViewDoctorDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DoctorDAO doctorDao = new DoctorDAO();
        ScheduleDAO scheduleDao = new ScheduleDAO();
        response.setContentType("text/html;charset=UTF-8");
        String doctorIdStr = request.getParameter("doctorId");
        if (doctorIdStr == null || doctorIdStr.trim().isEmpty()) {
            System.out.println("Lỗi doctorId null");
            return;
        }
        int doctorId = Integer.parseInt(doctorIdStr);
        //lấy ra doctor dựa vào doctorId
        Staff doctor = doctorDao.getStaffById(doctorId);
        //lấy ra lịch làm việc của bác sĩ dựa vào doctorId
        List<Schedule> schedule = scheduleDao.getScheduleByStaffId(doctorId);
        if (schedule.isEmpty()) {
            System.out.println("Lỗi schedule null");
            return;
        }

        // Lấy ngày được chọn từ request, nếu không có thì lấy ngày đầu tiên có lịch
//        String dateStr = request.getParameter("date");
        //khỏi tạo selectedDate để lưu ngày được chọn
//        Date selectedDate;//sql.Date
//        if (dateStr != null) {
//            try {
//                if (dateStr.matches("\\d{4}-\\d{2}-\\d{2}")) { // Kiểm tra nếu đúng yyyy-MM-dd
//                    selectedDate = Date.valueOf(dateStr);
//                } else {
//                    SimpleDateFormat inputFormat = new SimpleDateFormat("dd-MM-yyyy");
//                    java.util.Date utilDate = inputFormat.parse(dateStr);
//                    selectedDate = new java.sql.Date(utilDate.getTime());
//                }
//            } catch (Exception e) {
//                e.printStackTrace();
//                selectedDate = schedule.get(0).getDate(); // Nếu lỗi thì lấy ngày đầu tiên trong lịch
//            }
//        } else {
//            selectedDate = schedule.get(0).getDate();
//        }

        String dateStr = request.getParameter("date");
        Date selectedDate; 
        if(dateStr != null){
            selectedDate = Date.valueOf(dateStr);
        } else{
            selectedDate = schedule.get(0).getDate();
        }
        // Lấy danh sách slot khám trống
        List<TimeSlot> availableSlots = scheduleDao.getAvailableTimeSlots(doctorId, selectedDate);
        request.setAttribute("availableSlot", availableSlots);
        request.setAttribute("selectedDate", selectedDate);
        request.setAttribute("schedule", schedule);
        request.setAttribute("doctor", doctor);
        String message = request.getParameter("message");
        if (message != null) {
            request.setAttribute("message", message);
        }
        request.getRequestDispatcher("customer/doctorDetail.jsp").forward(request, response);
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
        handleViewDoctorDetail(request, response);
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
