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
            "/admin/", "/addBlog.jsp", "/addCustomer.jsp", "/addDepartment.jsp",
            "/addService.jsp", "/addStaff.jsp", "/adminDashboard.jsp", "/blogs-detail.jsp",
            "/blogs.jsp", "/customerDetail.jsp", "/departmentDetail.jsp", "/editCustomer.jsp",
            "/listCustomer.jsp", "/listDepartment.jsp", "/listService.jsp",
            "/manage-banners.jsp", "/manage-footer.jsp", "/serviceDetail.jsp", "/staffDetail.jsp",
            "/updateBlog.jsp", "/updateDepartment.jsp", "/updateService.jsp", "/updateStaff.jsp"
    );

    private static final List<String> DOCTOR_ALLOW = Arrays.asList(
            "/doctor/", "/Patientdetail.jsp", "/customerFeedback.jsp", "/doctorAppointment.jsp",
            "/doctorAppointmentDetail.jsp", "/footer.jsp", "/left-navbar.jsp", "/listPatient.jsp",
            "/makeServiceOrder.jsp", "/schedule.jsp", "/scheduleRegister.jsp", "/top-navbar.jsp"
    );

    private static final List<String> ADMINISTRATIVE_ALLOW = Arrays.asList(
            "/AdministrativeStaff/", "/footer.jsp", "/left-navbar.jsp", "/listInvoice.jsp",
            "/scheduleManagement.jsp", "/shiftApproval.jsp", "/top-navbar.jsp", "/viewListAppointment.jsp"
    );

    private static final List<String> CUSTOMER_ALLOW = Arrays.asList(
            "/customer/", "/allDoctor.jsp", "/customerAppointmentDetail.jsp", "/doctorDetail.jsp",
            "/invoiceDetail.jsp", "/patientsProfile.jsp", "/return.jsp", "/staffFeedback.jsp"
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

        // If session doesn't exist, let Authenticate filter handle it
        if (session == null) {
            chain.doFilter(request, response);
            return;
        }

        // Check if user is authenticated with a specific role
        Object admin = session.getAttribute("admin");
        Object doctor = session.getAttribute("doctor");
        Object staff = session.getAttribute("administrativeStaff");
        Object customer = session.getAttribute("customer");

        // Check role-specific authorization
        if (admin != null && isURLAllowed(requestURI, ADMIN_ALLOW)) {
            chain.doFilter(request, response);
            return;
        } else if (doctor != null && isURLAllowed(requestURI, DOCTOR_ALLOW)) {
            chain.doFilter(request, response);
            return;
        } else if (staff != null && isURLAllowed(requestURI, ADMINISTRATIVE_ALLOW)) {
            chain.doFilter(request, response);
            return;
        } else if (customer != null && isURLAllowed(requestURI, CUSTOMER_ALLOW)) {
            chain.doFilter(request, response);
            return;
        }

        // If we're here, let's see if the user is trying to access a protected area they shouldn't
        if ((admin == null && isURLAllowed(requestURI, ADMIN_ALLOW))
                || (doctor == null && isURLAllowed(requestURI, DOCTOR_ALLOW))
                || (staff == null && isURLAllowed(requestURI, ADMINISTRATIVE_ALLOW))
                || (customer == null && isURLAllowed(requestURI, CUSTOMER_ALLOW))) {
            // User is trying to access a protected area without proper role
            req.setAttribute("errorMessage", "Bạn không có quyền truy cập trang này.");
            req.getRequestDispatcher("/unauthorized.jsp").forward(request, response);
            return;
        }

        // If not matching any specific role-based URL, let request pass through
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
        if (filterConfig != null) {
            if (debug) {
                log("Authorize:Initializing filter");
            }
        }
    }

    @Override
    public void destroy() {
    }

    private void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }

    /**
     * Return a String representation of this object.
     */
    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("Authorize()");
        }
        StringBuffer sb = new StringBuffer("Authorize(");
        sb.append(filterConfig);
        sb.append(")");
        return (sb.toString());
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
            }
        } else {
            try {
                PrintStream ps = new PrintStream(response.getOutputStream());
                t.printStackTrace(ps);
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        }
    }
}
