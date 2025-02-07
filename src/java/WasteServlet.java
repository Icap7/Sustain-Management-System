import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Waste;

public class WasteServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:derby://localhost:1527/WasteManagement;create=true";
    private static final String DB_USER = "app";
    private static final String DB_PASS = "app";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("add".equals(action)) {
            addWaste(request);
        } else if ("delete".equals(action)) {
            deleteWaste(request);
        }
        response.sendRedirect("waste.jsp");
    }

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    List<Waste> wasteList = getAllWaste();
    request.setAttribute("wasteList", wasteList);
    request.getRequestDispatcher("waste.jsp").forward(request, response);
}


    private void addWaste(HttpServletRequest request) {
        String type = request.getParameter("type");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String disposalMethod = request.getParameter("disposalMethod");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
             PreparedStatement stmt = conn.prepareStatement("INSERT INTO Waste (type, quantity, disposalMethod) VALUES (?, ?, ?)");) {
            stmt.setString(1, type);
            stmt.setInt(2, quantity);
            stmt.setString(3, disposalMethod);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void deleteWaste(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
             PreparedStatement stmt = conn.prepareStatement("DELETE FROM Waste WHERE id = ?");) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private List<Waste> getAllWaste() {
        List<Waste> wasteList = new ArrayList<>();
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM Waste");) {
            while (rs.next()) {
                wasteList.add(new Waste(
                        rs.getInt("id"),
                        rs.getString("type"),
                        rs.getInt("quantity"),
                        rs.getString("disposalMethod")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return wasteList;
    }
}
