/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.doctor;

import dal.AppointmentDAO;
import dal.PrescriptionDAO;
import dal.TreatmentPlanDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Appointment;
import model.Prescription;
import model.Staff;
import model.TreatmentPlan;

/**
 *
 * @author DIEN MAY XANH
 */
public class DoctorAppointmentDetail extends HttpServlet {

    AppointmentDAO ad = new AppointmentDAO();
    PrescriptionDAO pd = new PrescriptionDAO();
    TreatmentPlanDAO td = new TreatmentPlanDAO();

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
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Staff st = (Staff) session.getAttribute("staff");

        // Đặt charset cho request và response
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String appId = request.getParameter("appointmentId");
        int appointmentId = 0;
        try {
            appointmentId = Integer.parseInt(appId);
        } catch (NumberFormatException e) {
        }
        Appointment app = ad.getAppointmentsById(appointmentId);
        int countAppointment = ad.countAppointmentsWithSameCustomer(appointmentId, st.getStaffId());
        List<Prescription> listPre = pd.getPrescriptionByAppointmentId(appointmentId);
        TreatmentPlan treatment = td.getTreatmentPlanByAppointmentId(appointmentId);
        request.setAttribute("app", app);
        request.setAttribute("listPre", listPre);
        request.setAttribute("treatment", treatment);
        request.setAttribute("countAppointment", countAppointment);
        request.getRequestDispatcher("doctor/doctorAppointmentDetail.jsp").forward(request, response);

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
        request.setCharacterEncoding("UTF-8");
        int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
        String action = request.getParameter("action") == null
                ? ""
                : request.getParameter("action");
        switch (action) {
            case "pres":
                String[] medicineNames = request.getParameterValues("medicineName[]");
                String[] totalQuantities = request.getParameterValues("totalQuantity[]");
                String[] dosages = request.getParameterValues("dosage[]");
                String[] notes = request.getParameterValues("note[]");
                pd.savePrescription(appointmentId, medicineNames, totalQuantities, dosages, notes);
                break;
            case "treat":
                String symptoms = request.getParameter("symptoms");
                String diagnosis = request.getParameter("diagnosis");
                String testResults = request.getParameter("testResult");
                String plan = request.getParameter("plan");
                String followUp = request.getParameter("followUp");
                TreatmentPlan tm = new TreatmentPlan(appointmentId, appointmentId, symptoms, diagnosis, testResults, plan, followUp);
                td.saveTreatmentPlan(tm);
                break;
            default:
                System.out.println("Default");
                break;

        }
        response.sendRedirect("doctorappdetail?appointmentId=" + appointmentId);

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
