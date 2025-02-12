
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EditUserServlet")
public class EditUserServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve form data
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password"); // Optional field
        String role = request.getParameter("role");

        // Database connection details
        String url = "jdbc:derby://localhost:1527/WasteManagement";
        String dbUser = "app";
        String dbPassword = "app";

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Load Derby JDBC driver
            Class.forName("org.apache.derby.jdbc.ClientDriver");

            // Establish connection
            conn = DriverManager.getConnection(url, dbUser, dbPassword);

            if (password == null || password.trim().isEmpty()) {
                // If password is empty, do not update it
                stmt = conn.prepareStatement("UPDATE USERS SET NAME=?, EMAIL=?, ROLE=? WHERE ID=?");
                stmt.setString(1, name);
                stmt.setString(2, email);
                stmt.setString(3, role);
                stmt.setInt(4, id);
            } else {
                // If password is provided, update it too
                stmt = conn.prepareStatement("UPDATE USERS SET NAME=?, EMAIL=?, PASSWORD=?, ROLE=? WHERE ID=?");
                stmt.setString(1, name);
                stmt.setString(2, email);
                stmt.setString(3, password);
                stmt.setString(4, role);
                stmt.setInt(5, id);
            }

            // Execute update
            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated > 0) {
                response.sendRedirect("getUsersServlet?updateSuccess=true");
            } else {
                response.sendRedirect("getUsersServlet?updateSuccess=false");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("getUsersServlet?updateSuccess=false");
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
