package dao;

import model.WasteSegregationGuide;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.DBConnection;

public class WasteGuideDAO {

    public WasteGuideDAO() {
        try {
            Connection conn = DBConnection.getConnection(); // Get DB connection
        } catch (SQLException ex) {
            Logger.getLogger(WasteGuideDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // Fetch all waste guides
    public List<WasteSegregationGuide> getAllGuides() {
        List<WasteSegregationGuide> guides = new ArrayList<>();
        String sql = "SELECT * FROM waste_guide";

        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                guides.add(new WasteSegregationGuide(
                        rs.getInt("id"),
                        rs.getInt("user_id"),
                        rs.getString("waste_type"),
                        rs.getString("category"),
                        rs.getString("disposal_method"),
                        rs.getString("recycling_instructions"),
                        rs.getString("image_path")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return guides;
    }

    // Insert a new waste guide
    public boolean addGuide(WasteSegregationGuide guide) {
        String sql = "INSERT INTO waste_guide (user_id, waste_type, category, disposal_method, recycling_instructions, image_path) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, guide.getUserId());
            stmt.setString(2, guide.getWasteType());
            stmt.setString(3, guide.getCategory());
            stmt.setString(4, guide.getDisposalMethod());
            stmt.setString(5, guide.getRecyclingInstructions());
            stmt.setString(6, guide.getImagePath());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateGuide(WasteSegregationGuide guide) {
        String sql = "UPDATE waste_guide SET waste_type = ?, category = ?, disposal_method = ?, recycling_instructions = ?, image_path = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, guide.getWasteType());
            stmt.setString(2, guide.getCategory());
            stmt.setString(3, guide.getDisposalMethod());
            stmt.setString(4, guide.getRecyclingInstructions());
            stmt.setString(5, guide.getImagePath());
            stmt.setInt(6, guide.getId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteGuide(int id) {
        String sql = "DELETE FROM waste_guide WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static WasteSegregationGuide getGuideById(int id) {
        WasteSegregationGuide guide = null;
        String sql = "SELECT * FROM waste_guide WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    guide = new WasteSegregationGuide();
                    guide.setId(rs.getInt("id"));
                    guide.setUserId(rs.getInt("user_id")); // Ensure user_id is included if needed
                    guide.setWasteType(rs.getString("waste_type"));
                    guide.setCategory(rs.getString("category"));
                    guide.setDisposalMethod(rs.getString("disposal_method"));
                    guide.setRecyclingInstructions(rs.getString("recycling_instructions"));
                    guide.setImagePath(rs.getString("image_path"));
                } else {
                    System.out.println("No record found for ID: " + id);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching guide by ID: " + id);
            e.printStackTrace();
        }
        return guide;
    }

}
