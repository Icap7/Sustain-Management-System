
import dao.WasteDAO;
import model.Waste;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class WasteServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            response.sendRedirect("login.jsp?error=Please+login+first");
            return;
        }

        // Check if the request is for DELETE
        String method = request.getParameter("_method");
        if (method != null && method.equalsIgnoreCase("DELETE")) {
            doDelete(request, response);
            return;
        }

        // Default behavior for adding waste
        try {
            int userId = (Integer) session.getAttribute("id");
            String type = request.getParameter("type");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String disposalMethod = request.getParameter("disposalMethod");
            double totalPrice = Double.parseDouble(request.getParameter("totalPrice"));

            Waste waste = new Waste(0, type, quantity, disposalMethod, totalPrice, userId);
            WasteDAO wasteDAO = new WasteDAO();

            boolean success = wasteDAO.addWaste(waste);
            response.sendRedirect("waste.jsp?success=" + success);

        } catch (NumberFormatException e) {
            response.sendRedirect("waste.jsp?error=Invalid+input");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            response.sendRedirect("login.jsp?error=Please+login+first");
            return;
        }

        int userId = (Integer) session.getAttribute("id");
        WasteDAO wasteDAO = new WasteDAO();
        List<Waste> wasteList = wasteDAO.getAllWasteByUser(userId);

        request.setAttribute("wasteList", wasteList);
        request.getRequestDispatcher("waste.jsp").forward(request, response);
    }

    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Please log in first.");
            return;
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            int userId = (Integer) session.getAttribute("id");
            String role = (String) session.getAttribute("role"); // Get user role

            WasteDAO wasteDAO = new WasteDAO();
            boolean success;

            if ("admin".equals(role)) {
                // Admin can delete any record
                success = wasteDAO.deleteWasteByAdmin(id);
            } else {
                // Normal users can only delete their own records
                success = wasteDAO.deleteWaste(id, userId);
            }

            response.getWriter().write("{\"success\": " + success + "}");

        } catch (NumberFormatException e) {
            response.getWriter().write("{\"success\": false}");
        }
    }

}
