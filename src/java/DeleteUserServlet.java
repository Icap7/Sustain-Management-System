
import dao.UserDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeleteUserServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userIdParam = request.getParameter("id");
        boolean deleted = false;

        if (userIdParam != null) {
            try {
                int userId = Integer.parseInt(userIdParam);
                deleted = UserDAO.deleteUser(userId);

                if (deleted) {
                    System.out.println("User with ID " + userId + " deleted successfully.");
                } else {
                    System.out.println("Failed to delete user with ID " + userId);
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        // Redirect with success or failure message
        if (deleted) {
            response.sendRedirect("getUsersServlet?deleteSuccess=true");
        } else {
            response.sendRedirect("getUsersServlet?deleteSuccess=false");
        }
    }
}
