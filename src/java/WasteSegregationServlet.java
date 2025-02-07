import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.HashMap;
import javax.servlet.annotation.WebServlet;

@WebServlet("/WasteSegregationServlet")
public class WasteSegregationServlet extends HttpServlet {
    private HashMap<String, String> wasteData;

    public void init() throws ServletException {
        wasteData = new HashMap<>();
        wasteData.put("batteries", "Hazardous Waste - Take to a designated recycling center.");
        wasteData.put("plastic bottles", "Recyclable - Place in the plastic recycling bin.");
        wasteData.put("food scraps", "Biodegradable - Compost or put in the organic waste bin.");
        wasteData.put("glass jars", "Recyclable - Place in the glass recycling bin.");
        wasteData.put("old electronics", "E-Waste - Drop off at an e-waste collection center.");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String item = request.getParameter("item").toLowerCase();
        String result;

        if (wasteData.containsKey(item)) {
            result = item.substring(0, 1).toUpperCase() + item.substring(1) + ": " + wasteData.get(item);
            request.setAttribute("result", "<div class='found'>" + result + "</div>");
        } else {
            request.setAttribute("result", "<div class='not-found'>Item not found. Please try another.</div>");
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("WasteSegregationGuide.jsp");
        dispatcher.forward(request, response);
    }
}