
import dao.UserDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Users;

public class getUsersServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            response.sendRedirect("login.jsp?error=Please+login+first");
            return;
        }

        UserDAO userDAO = new UserDAO();
        List<Users> userList = userDAO.getAllUsers(); // Fetch users from DB

        System.out.println("User List in Servlet: " + userList); // Debugging

        request.setAttribute("userList", userList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("manageUser.jsp");
        dispatcher.forward(request, response);
    }
}
