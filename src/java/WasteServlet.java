import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Waste;

@WebServlet("/WasteServlet")
public class WasteServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:derby://localhost:1527/WasteManagement";
    private static final String DB_USER = "app";
    private static final String DB_PASS = "app";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Retrieve existing session
        if (session == null || session.getAttribute("id") == null) {
            response.sendRedirect("login.jsp?error=Please+login+first");
            return;
        }

        int userId = (Integer) session.getAttribute("id");
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addWaste(request, userId);
        } else if ("delete".equals(action)) {
            deleteWaste(request, userId);
        }
        response.sendRedirect("waste.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            response.sendRedirect("login.jsp?error=Please+login+first");
            return;
        }

        int userId = (Integer) session.getAttribute("id");
        List<Waste> wasteList = getAllWaste(userId);
        request.setAttribute("wasteList", wasteList);
        request.getRequestDispatcher("waste.jsp").forward(request, response);
    }

    private void addWaste(HttpServletRequest request, int userId) {
        String type = request.getParameter("type");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String disposalMethod = request.getParameter("disposalMethod");

        String sql = "INSERT INTO Waste (type, quantity, disposalMethod, user_id) VALUES (?, ?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, type);
            stmt.setInt(2, quantity);
            stmt.setString(3, disposalMethod);
            stmt.setInt(4, userId); // Use session-stored user ID
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void deleteWaste(HttpServletRequest request, int userId) {
        int id = Integer.parseInt(request.getParameter("id"));

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
             PreparedStatement stmt = conn.prepareStatement("DELETE FROM Waste WHERE id = ? AND user_id = ?")) {

            stmt.setInt(1, id);
            stmt.setInt(2, userId); // Ensure only the owner can delete
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private List<Waste> getAllWaste(int userId) {
        List<Waste> wasteList = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM Waste WHERE user_id = ?")) {

            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    wasteList.add(new Waste(
                            rs.getInt("id"),
                            rs.getString("type"),
                            rs.getInt("quantity"),
                            rs.getString("disposalMethod")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return wasteList;
    }
}
