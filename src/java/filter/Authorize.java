package filter;

import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.List;

/**
 * Filter to handle role-based authorization
 */
public class Authorize implements Filter {

    private static final List<String> ADMIN_ALLOW = Arrays.asList(
            "/admin/","/addBlog","/addBlog.jsp", "/addCustomer","/addCustomer.jsp", "/AddDepartment","/addDepartment.jsp",
            "/AddService","/addService.jsp", "/AddStaffServlet","/addStaff.jsp", "/AdminDashBoard","/adminDashboard.jsp", "/blogs-detail.jsp",
            "/blogs-detail","/blogs","/blogs.jsp", "/viewCustomerDetail","/customerDetail.jsp", "/ViewDepartmentDetail","/departmentDetail.jsp",
            "/editCustomer.jsp","/editCustomer","/listCustomer","/listCustomer.jsp", "/ListDepartment","/listDepartment.jsp", "/ListService","/listService.jsp",
            "/manage-banners","/manage-banners.jsp", "/manage-footer","/manage-footer.jsp", "/ViewServiceDetail","/serviceDetail.jsp", "/staffDetail.jsp",
            "/ViewStaffDetail","/updateBlog","/updateBlog.jsp", "/UpdateDepartment","/updateDepartment.jsp", "/UpdateService","/updateService.jsp",
            "/UpdateStaffServlet","/updateStaff.jsp","/ListDoctor","/ListDoctor.jsp","/doctorprofile","/staffProfile.jsp"
    );

    private static final List<String> DOCTOR_ALLOW = Arrays.asList(
            "/doctor/", "/PatientDetail","/Patientdetail.jsp", "/mfeedback","/customerFeedback.jsp", "/doctorAppointment.jsp",
            "/doctorappointment","/doctorappdetail","/doctorAppointmentDetail.jsp", "/footer.jsp", "/left-navbar.jsp", "/listPatient.jsp",
            "/ListPatient","/makeorder","/makeServiceOrder.jsp", "/schedule","/schedule.jsp", "/registershift","/scheduleRegister.jsp", "/top-navbar.jsp",
            "/doctorprofile","/staffProfile.jsp"
    );

    private static final List<String> ADMINISTRATIVE_ALLOW = Arrays.asList(
            "/AdministrativeStaff/", "/footer.jsp", "/left-navbar.jsp", "/listInvoice.jsp","/listinvoice","/invoiceDetail",
            "/scheduleManagement.jsp", "/shiftApproval.jsp", "/top-navbar.jsp", "/viewListAppointment.jsp","/shift-approval",
            "/schedule-management","/confirmappointment","/doctorprofile","/staffProfile.jsp"
    );

    private static final List<String> CUSTOMER_ALLOW = Arrays.asList(
            "/customer/", "/allDoctor.jsp", "/customerAppointmentDetail.jsp","/bookAppointment","/cancelAppointment","/customer-profile",
            "/listAppointments","/invoiceDetail.jsp", "/patientsProfile.jsp", "/return.jsp",
            "/appointmentDetail","/invoiceDetail","/vnpay_return","/vnpay_payment","/customer-appointment.jsp",
            "/customer-profile.jsp"
    );

    private static final boolean debug = true;
    private FilterConfig filterConfig = null;

    public Authorize() {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String requestURI = req.getRequestURI();
        HttpSession session = req.getSession(false);

        // Nếu session không tồn tại, để Authenticate filter khác xử lý
        if (session == null) {
            chain.doFilter(request, response);
            return;
        }

        // Lấy thông tin role từ session (login đã lưu "roleId" và "roleName")
        Integer roleId = (Integer) session.getAttribute("roleId");
        String roleName = (String) session.getAttribute("roleName");
        Object customer = session.getAttribute("customer");
        
        
        // Kiểm tra quyền dựa trên roleId
        boolean isAdmin = (roleId != null && roleId == 1);
                            
        boolean isDoctor = (roleId != null && roleId == 2 ||roleId !=null && roleId ==3);
                            
        boolean isAdministrativeStaff = (roleId != null && roleId == 4);
                            
        boolean isCustomer = (customer != null);

        // Kiểm tra phân quyền theo URL
        if (isAdmin && isURLAllowed(requestURI, ADMIN_ALLOW)) {
            chain.doFilter(request, response);
            return;
        } else if (isDoctor && isURLAllowed(requestURI, DOCTOR_ALLOW)) {
            chain.doFilter(request, response);
            return;
        } else if (isAdministrativeStaff && isURLAllowed(requestURI, ADMINISTRATIVE_ALLOW)) {
            chain.doFilter(request, response);
            return;
        } else if (isCustomer && isURLAllowed(requestURI, CUSTOMER_ALLOW)) {
            chain.doFilter(request, response);
            return;
        }

        // Nếu user cố truy cập vào vùng không thuộc quyền của họ
        if ((!isAdmin && isURLAllowed(requestURI, ADMIN_ALLOW))
                || (!isDoctor && isURLAllowed(requestURI, DOCTOR_ALLOW))
                || (!isAdministrativeStaff && isURLAllowed(requestURI, ADMINISTRATIVE_ALLOW))
                || (!isCustomer && isURLAllowed(requestURI, CUSTOMER_ALLOW))) {
            req.setAttribute("errorMessage", "Bạn không có quyền truy cập trang này.");
            req.getRequestDispatcher("/unauthorized.jsp").forward(request, response);
            return;
        }

        // Nếu không khớp bất kỳ quyền nào, cho phép request đi tiếp
        chain.doFilter(request, response);
    }

    private boolean isURLAllowed(String requestURI, List<String> allowedURLs) {
        for (String url : allowedURLs) {
            if (requestURI.contains(url)) {
                return true;
            }
        }
        return false;
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig;
        if (filterConfig != null && debug) {
            log("Authorize: Initializing filter");
        }
    }

    @Override
    public void destroy() {
    }

    private void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }

    @Override
    public String toString() {
        if (filterConfig == null) {
            return "Authorize()";
        }
        StringBuffer sb = new StringBuffer("Authorize(");
        sb.append(filterConfig);
        sb.append(")");
        return sb.toString();
    }

    private static String getStackTrace(Throwable t) {
        String stackTrace = null;
        try {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            pw.close();
            sw.close();
            stackTrace = sw.getBuffer().toString();
        } catch (Exception ex) {
            // Không xử lý
        }
        return stackTrace;
    }

    private void sendProcessingError(Throwable t, ServletResponse response) {
        String stackTrace = getStackTrace(t);
        if (stackTrace != null && !stackTrace.equals("")) {
            try {
                response.setContentType("text/html");
                PrintStream ps = new PrintStream(response.getOutputStream());
                PrintWriter pw = new PrintWriter(ps);
                pw.print("<html>\n<head>\n<title>Error</title>\n</head>\n<body>\n");
                pw.print("<h1>The resource did not process correctly</h1>\n<pre>\n");
                pw.print(stackTrace);
                pw.print("</pre></body>\n</html>");
                pw.close();
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
                // Không xử lý
            }
        } else {
            try {
                PrintStream ps = new PrintStream(response.getOutputStream());
                t.printStackTrace(ps);
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
                // Không xử lý
            }
        }
    }
}
