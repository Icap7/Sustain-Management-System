import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/SignupRedirectServlet")
public class SignupRedirectServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Do not create a new session
        String function = request.getParameter("function");

        // Check if the user is logged in
        if (session == null || session.getAttribute("user") == null) {
            // User not logged in, redirect to login page
            response.sendRedirect("login.jsp?message=Please+log+in+to+access+this+function");
        } else {
            // User is logged in, redirect to the requested function
            switch (function) {
                case "carbonFootprint":
                    response.sendRedirect("calculator.jsp");
                    break;
                case "waste":
                    response.sendRedirect("waste.jsp");
                    break;
                case "WasteSegregationGuide":
                    response.sendRedirect("WasteSegregationGuide.jsp");
                    break;
                default:
                    response.sendRedirect("dashboard.jsp"); // Default fallback
                    break;
            }
        }
    }
}
