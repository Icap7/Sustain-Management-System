
import dao.WasteGuideDAO;
import model.WasteSegregationGuide;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.*;
import java.nio.file.Paths;

@MultipartConfig(fileSizeThreshold = 2 * 1024 * 1024, // 2MB
        maxFileSize = 10 * 1024 * 1024, // 10MB
        maxRequestSize = 50 * 1024 * 1024) // 50MB
public class UpdateWasteGuideServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get parameters
            int id = Integer.parseInt(request.getParameter("id"));
            String wasteType = request.getParameter("wasteType");
            String category = request.getParameter("category");
            String disposalMethod = request.getParameter("disposalMethod");
            String recyclingInstructions = request.getParameter("recyclingInstructions");
            Part filePart = request.getPart("image");

            // Get existing guide from DB
            WasteGuideDAO dao = new WasteGuideDAO();
            WasteSegregationGuide existingGuide = dao.getGuideById(id);

            if (existingGuide == null) {
                response.sendRedirect("WasteGuideServlet?error=GuideNotFound");
                return;
            }

            // Define upload directory
            String uploadDir = "C:/Users/danish/Documents/NetBeansProjects/sustain/web/uploads";
            File uploadPath = new File(uploadDir);
            if (!uploadPath.exists()) {
                uploadPath.mkdirs();
            }

            // Handle file upload
            String fileName = null;
            if (filePart != null && filePart.getSize() > 0) {
                fileName = System.currentTimeMillis() + "_" + Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                File file = new File(uploadPath, fileName);

                try (InputStream fileContent = filePart.getInputStream();
                        FileOutputStream outputStream = new FileOutputStream(file)) {
                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = fileContent.read(buffer)) != -1) {
                        outputStream.write(buffer, 0, bytesRead);
                    }
                }
            } else {
                // Keep existing image if no new image is uploaded
                fileName = existingGuide.getImagePath();
            }

            // Store relative path in DB
            String dbFilePath = (fileName != null) ? "uploads/" + fileName : existingGuide.getImagePath();

            // Update the guide object
            WasteSegregationGuide guide = new WasteSegregationGuide(id, existingGuide.getUserId(), wasteType, category, disposalMethod, recyclingInstructions, dbFilePath);

            // Update in DB
            if (dao.updateGuide(guide)) {
                response.sendRedirect("WasteGuideServlet?success=true");
            } else {
                response.sendRedirect("WasteGuideServlet?error=UpdateFailed");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("WasteGuideServlet?error=InvalidID");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("WasteGuideServlet?error=ServerError");
        }
    }
}
