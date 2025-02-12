
import dao.WasteGuideDAO;
import model.WasteSegregationGuide;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

@MultipartConfig(fileSizeThreshold = 2 * 1024 * 1024, // 2MB  
        maxFileSize = 10 * 1024 * 1024, // 10MB  
        maxRequestSize = 50 * 1024 * 1024) // 50MB  
public class WasteGuideServlet extends HttpServlet {

    private WasteGuideDAO wasteGuideDAO;

    @Override
    public void init() {
        wasteGuideDAO = new WasteGuideDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<WasteSegregationGuide> guideList = wasteGuideDAO.getAllGuides();
        request.setAttribute("guideList", guideList);
        request.getRequestDispatcher("manageWasteGuide.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        String wasteType = request.getParameter("wasteType");
        String category = request.getParameter("category");
        String disposalMethod = request.getParameter("disposalMethod");
        String recyclingInstructions = request.getParameter("recyclingInstructions");
        Part filePart = request.getPart("image");

        // Extract file name and generate a unique name
        String fileName = System.currentTimeMillis() + "_" + Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        // Define upload directory
        String uploadDir = "C:/Users/danish/Documents/NetBeansProjects/sustain/web/uploads";
        File uploadPath = new File(uploadDir);

        // Ensure upload directory exists
        if (!uploadPath.exists() && !uploadPath.mkdirs()) {
            throw new IOException("Failed to create upload directory: " + uploadDir);
        }

        // Full file path where the image will be stored
        File file = new File(uploadPath, fileName);

        // Manually write the file using FileOutputStream
        try (java.io.InputStream fileContent = filePart.getInputStream();
                java.io.FileOutputStream outputStream = new java.io.FileOutputStream(file)) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = fileContent.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
        } catch (IOException e) {
            System.err.println("Error writing file: " + e.getMessage());
            throw e;
        }

        // Store relative path in the database
        String dbFilePath = "uploads/" + fileName;

        // Create a new WasteSegregationGuide object
        WasteSegregationGuide guide = new WasteSegregationGuide();
        guide.setUserId(userId);
        guide.setWasteType(wasteType);
        guide.setCategory(category);
        guide.setDisposalMethod(disposalMethod);
        guide.setRecyclingInstructions(recyclingInstructions);
        guide.setImagePath(dbFilePath);

        // Insert guide into database
        boolean isAdded = wasteGuideDAO.addGuide(guide);

        // Redirect or handle errors
        if (isAdded) {
            response.sendRedirect("WasteGuideServlet");
        } else {
            request.setAttribute("errorMessage", "Failed to add guide. Please try again.");
            doGet(request, response);
        }

        // Debugging outputs
        System.out.println("Upload Directory: " + uploadDir);
        System.out.println("File Path (Absolute): " + file.getAbsolutePath());
        System.out.println("DB Path (Relative): " + dbFilePath);
    }

}
