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

@WebServlet("/CalculateServlet")
public class CalculateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // MySQL Database Configuration
    private static final String DB_URL = "jdbc:derby://localhost:1527/WasteManagement";
    private static final String DB_USER = "app";
    private static final String DB_PASSWORD = "app";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get user input
            int electricity = Integer.parseInt(request.getParameter("electricity"));
            int renewablesElectricity = Integer.parseInt(request.getParameter("renewables_electricity"));
            int naturalGas = Integer.parseInt(request.getParameter("natural_gas"));
            int renewablesNaturalGas = Integer.parseInt(request.getParameter("renewables_natural_gas"));
            int biomass = Integer.parseInt(request.getParameter("biomass"));
            int coal = Integer.parseInt(request.getParameter("coal"));
            int heatingOil = Integer.parseInt(request.getParameter("heating_oil"));
            int lpg = Integer.parseInt(request.getParameter("lpg"));

            // Carbon footprint calculation (example values)
            double carbonFootprint = (electricity * 0.5) + (naturalGas * 0.3) + (biomass * 0.2) +
                                      (coal * 2.0) + (heatingOil * 1.8) + (lpg * 1.5);
            double cost = carbonFootprint * 25.00; // Example cost per tonne CO₂

            // Store data in database
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            String sql = "INSERT INTO footprint_data (electricity, renewables_electricity, natural_gas, renewables_natural_gas, biomass, coal, heating_oil, lpg, carbon_footprint, cost) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, electricity);
            stmt.setInt(2, renewablesElectricity);
            stmt.setInt(3, naturalGas);
            stmt.setInt(4, renewablesNaturalGas);
            stmt.setInt(5, biomass);
            stmt.setInt(6, coal);
            stmt.setInt(7, heatingOil);
            stmt.setInt(8, lpg);
            stmt.setDouble(9, carbonFootprint);
            stmt.setDouble(10, cost);
            stmt.executeUpdate();

            // Pass results back to JSP
            request.setAttribute("carbonFootprint", carbonFootprint);
            request.setAttribute("cost", cost);

            // Forward back to index.jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("calculator.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
