
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Database connection details (JavaDB/Apache Derby)
    private static final String DB_URL = "jdbc:derby://localhost:1527/WasteManagement";
    private static final String DB_USER = "app";
    private static final String DB_PASSWORD = "app";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Map<String, Integer> summaryData = new HashMap<>();
        Connection connection = null;

        try {
            // Load JDBC driver
            Class.forName("org.apache.derby.jdbc.ClientDriver");

            // Establish the connection
            connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Get counts for dashboard
            summaryData.put("totalUsers", getCount(connection, "SELECT COUNT(*) FROM users"));
            summaryData.put("totalGuides", getCount(connection, "SELECT COUNT(*) FROM waste_guide"));
            summaryData.put("totalWasteRecords", getCount(connection, "SELECT COUNT(*) FROM waste"));
            summaryData.put("totalCarbonFootprints", getCount(connection, "SELECT COUNT(*) FROM footprint_data"));

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database driver not found.");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database connection failed.");
        } finally {
            // Close the connection
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        // Attach data to request
        request.setAttribute("summaryData", summaryData);

        // Forward to admin dashboard
        RequestDispatcher dispatcher = request.getRequestDispatcher("adminDashboard.jsp");
        dispatcher.forward(request, response);
    }

    // Method to get count from a table
    private int getCount(Connection connection, String query) {
        try (PreparedStatement stmt = connection.prepareStatement(query);
                ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0; // Default if query fails
    }
}
