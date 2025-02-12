import dao.FootprintDataDAO;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeleteFootprintServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:derby://localhost:1527/WasteManagement;create=true";
    private static final String JDBC_USER = "app";
    private static final String JDBC_PASSWORD = "app";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");

        if (idParam != null) {
            int id = Integer.parseInt(idParam);

            try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
                FootprintDataDAO dao = new FootprintDataDAO(conn);
                dao.deleteFootprintData(id);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect("ManageFootprintServlet");
    }
}
