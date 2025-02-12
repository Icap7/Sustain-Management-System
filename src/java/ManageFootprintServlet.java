
import dao.FootprintDataDAO;
import model.FootprintData;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ManageFootprintServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:derby://localhost:1527/WasteManagement;create=true";
    private static final String JDBC_USER = "app";
    private static final String JDBC_PASSWORD = "app";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get current session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            response.sendRedirect("login.jsp?error=Please+login+first");
            return;
        }

        int userId = (Integer) session.getAttribute("id");
        String role = (String) session.getAttribute("role");

        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            FootprintDataDAO dao = new FootprintDataDAO(conn);
            List<FootprintData> footprintList;

            if ("admin".equals(role)) {
                // Admin retrieves all footprint records
                footprintList = dao.getAllFootprintData();
            } else {
                // Regular users retrieve only their own footprint records
                footprintList = dao.getFootprintDataByUser(userId);
            }

            request.setAttribute("footprintList", footprintList);
            request.getRequestDispatcher("manageFootprint.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
