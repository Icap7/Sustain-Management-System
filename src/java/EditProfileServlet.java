
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class EditProfileServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String currentUsername = (String) session.getAttribute("user");

        if (currentUsername == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String newName = request.getParameter("name");
        String newEmail = request.getParameter("email");
        String newPassword = request.getParameter("password");

        String url = "jdbc:derby://localhost:1527/WasteManagement";
        String dbUser = "app";
        String dbPassword = "app";

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            try (Connection conn = DriverManager.getConnection(url, dbUser, dbPassword)) {
                String query;

                // Check if the password is empty (to keep the old one)
                if (newPassword == null || newPassword.isEmpty()) {
                    query = "UPDATE USERS SET NAME = ?, EMAIL = ? WHERE NAME = ?";
                } else {
                    query = "UPDATE USERS SET NAME = ?, EMAIL = ?, PASSWORD = ? WHERE NAME = ?";
                }

                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setString(1, newName);
                    stmt.setString(2, newEmail);

                    if (newPassword == null || newPassword.isEmpty()) {
                        stmt.setString(3, currentUsername);
                    } else {
                        stmt.setString(3, newPassword);
                        stmt.setString(4, currentUsername);
                    }

                    int updatedRows = stmt.executeUpdate();
                    if (updatedRows > 0) {
                        session.setAttribute("user", newName); // Update session with new name
                        response.sendRedirect("index.jsp");
                    } else {
                        response.getWriter().println("Error updating profile.");
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Database error: " + e.getMessage());
        }
    }
}
