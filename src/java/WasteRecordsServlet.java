import dao.WasteDAO;
import model.Waste;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class WasteRecordsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get current user ID from session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            response.sendRedirect("login.jsp?error=Please+login+first");
            return;
        }

        int userId = (Integer) session.getAttribute("id");

        // Fetch user's waste records
        List<Waste> wasteList = WasteDAO.getUserWasteRecords(userId);
        
        // Store waste records in request scope
        request.setAttribute("wasteList", wasteList);
        
        // Forward request to JSP
        request.getRequestDispatcher("wasteRecords.jsp").forward(request, response);
    }
}
