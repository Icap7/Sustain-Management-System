import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;


public class CalculateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database Configuration
    private static final String DB_URL = "jdbc:derby://localhost:1527/WasteManagement";
    private static final String DB_USER = "app";
    private static final String DB_PASSWORD = "app";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve user ID from session
            HttpSession session = request.getSession();
            Integer userId = (Integer) session.getAttribute("id");

            if (userId == null) {
                response.getWriter().println("Error: User not logged in.");
                return;
            }

            // Get user input
            int electricity = Integer.parseInt(request.getParameter("electricity"));
            int renewablesElectricity = Integer.parseInt(request.getParameter("renewables_electricity"));
            int naturalGas = Integer.parseInt(request.getParameter("natural_gas"));
            int renewablesNaturalGas = Integer.parseInt(request.getParameter("renewables_natural_gas"));
            int biomass = Integer.parseInt(request.getParameter("biomass"));
            int coal = Integer.parseInt(request.getParameter("coal"));
            int heatingOil = Integer.parseInt(request.getParameter("heating_oil"));
            int lpg = Integer.parseInt(request.getParameter("lpg"));

            // Carbon footprint calculation
            double carbonFootprint = (electricity * 0.5) + (naturalGas * 0.3) + (biomass * 0.2) +
                                      (coal * 2.0) + (heatingOil * 1.8) + (lpg * 1.5);
            double cost = carbonFootprint * 25.00; // Example cost per tonne CO₂

            // Store data in database
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            String sql = "INSERT INTO footprint_data (user_id, electricity, renewables_electricity, natural_gas, renewables_natural_gas, biomass, coal, heating_oil, lpg, carbon_footprint, cost) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setInt(2, electricity);
            stmt.setInt(3, renewablesElectricity);
            stmt.setInt(4, naturalGas);
            stmt.setInt(5, renewablesNaturalGas);
            stmt.setInt(6, biomass);
            stmt.setInt(7, coal);
            stmt.setInt(8, heatingOil);
            stmt.setInt(9, lpg);
            stmt.setDouble(10, carbonFootprint);
            stmt.setDouble(11, cost);
            stmt.executeUpdate();

            // Pass results back to JSP
            request.setAttribute("carbonFootprint", carbonFootprint);
            request.setAttribute("cost", cost);

            // Forward back to calculator.jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("calculator.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
