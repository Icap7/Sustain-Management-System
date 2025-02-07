import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Database connection parameters for JavaDB (Apache Derby)
    private static final String DB_URL = "jdbc:derby://localhost:1527/WasteManagement";
    private static final String DB_USER = "app";
    private static final String DB_PASSWORD = "app";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Retrieve form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // Validate input (basic example)
        if (name == null || email == null || password == null || role == null || name.isEmpty() || email.isEmpty() || password.isEmpty()) {
            out.println("<h3>All fields are required!</h3>");
            return;
        }

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            // Load the JDBC driver for Apache Derby
            Class.forName("org.apache.derby.jdbc.ClientDriver");

            // Establish the connection
            connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Insert user into the database
            String sql = "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, name);
            preparedStatement.setString(2, email);
            preparedStatement.setString(3, password);
            preparedStatement.setString(4, role);

            int rowsInserted = preparedStatement.executeUpdate();

            if (rowsInserted > 0) {
                // Redirect to login page upon successful signup
                response.sendRedirect("login.jsp");
            } else {
                out.println("<h3>Sign up failed. Please try again later.</h3>");
            }

        } catch (ClassNotFoundException e) {
            out.println("<h3>Error: Unable to load database driver.</h3>");
            e.printStackTrace(out);
        } catch (SQLException e) {
            out.println("<h3>Error: Database connection failed or email already exists.</h3>");
            e.printStackTrace(out);
        } finally {
            // Close resources
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace(out);
            }
        }
    }
}
