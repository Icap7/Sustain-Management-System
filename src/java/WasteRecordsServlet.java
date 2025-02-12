
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

        // Get current user session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            response.sendRedirect("login.jsp?error=Please+login+first");
            return;
        }

        int userId = (Integer) session.getAttribute("id");
        String role = (String) session.getAttribute("role");

        WasteDAO wasteDAO = new WasteDAO();
        List<Waste> wasteList;

        if ("admin".equals(role)) {
            // Admin sees all waste records
            wasteList = wasteDAO.getAllWasteRecords();
            request.setAttribute("wasteList", wasteList);
            System.out.println("waste" +wasteList.size());
            request.getRequestDispatcher("manageWasteRecords.jsp").forward(request, response);
        } else {
            // Normal users see only their own waste records
            wasteList = wasteDAO.getAllWasteByUser(userId);
            request.setAttribute("wasteList", wasteList);
            request.getRequestDispatcher("wasteRecords.jsp").forward(request, response);
        }
    }
}
