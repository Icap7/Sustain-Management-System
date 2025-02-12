import dao.WasteGuideDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class DeleteWasteGuideServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        WasteGuideDAO dao = new WasteGuideDAO();

        if (dao.deleteGuide(id)) {
            response.sendRedirect("WasteGuideServlet?deleteSuccess=true"); // Redirect on delete success  
        } else {
            response.sendRedirect("WasteGuideServlet?deleteSuccess=false");
        }
    }
}
