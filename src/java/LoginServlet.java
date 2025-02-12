import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Database connection details for Apache Derby
    private static final String DB_URL = "jdbc:derby://localhost:1527/WasteManagement";
    private static final String DB_USER = "app";
    private static final String DB_PASSWORD = "app";

    static {
        try {
            // Load JDBC driver for Apache Derby (loads only once)
            Class.forName("org.apache.derby.jdbc.ClientDriver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Error loading JDBC Driver", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve login credentials
        String role = request.getParameter("role");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validate input
        if (email == null || password == null || role == null ||
            email.isEmpty() || password.isEmpty() || role.isEmpty()) {
            response.sendRedirect("login.jsp?error=Please+fill+all+fields");
            return;
        }

        // Query to check if user exists
        String query = "SELECT id, name FROM users WHERE email = ? AND password = ? AND role = ?";

        try (
            Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            PreparedStatement preparedStatement = connection.prepareStatement(query)
        ) {
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password);
            preparedStatement.setString(3, role);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    // Retrieve user ID
                    int userId = resultSet.getInt("id");
                    String userName = resultSet.getString("name");

                    // Create session and store user details
                    HttpSession session = request.getSession();
                    session.setAttribute("id", userId);  // Store user ID
                    session.setAttribute("role", role);
                    session.setAttribute("email", email);
                    session.setAttribute("user", userName);

                    // Redirect based on role
                    if ("admin".equalsIgnoreCase(role)) {
                        response.sendRedirect("AdminDashboardServlet");
                    } else {
                        response.sendRedirect("index.jsp");
                    }
                } else {
                    // Invalid credentials
                    response.sendRedirect("login.jsp?error=Invalid+email,+password,+or+role");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=An+error+occurred.+Please+try+again.");
        }
    }
}
