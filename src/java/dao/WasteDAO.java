package dao;

import util.DBConnection;
import model.Waste;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class WasteDAO {

    public List<Waste> getAllWasteRecords() {
        List<Waste> wasteList = new ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            String query = "SELECT * FROM waste";
            PreparedStatement stmt = conn.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Waste waste = new Waste(
                        rs.getInt("id"),
                        rs.getString("type"),
                        rs.getInt("quantity"),
                        rs.getString("disposalMethod"),
                        rs.getDouble("price"),
                        rs.getInt("user_id")
                );
                wasteList.add(waste);
            }

            rs.close();
            stmt.close();
            conn.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return wasteList;
    }

    // Add new waste entry
    public boolean addWaste(Waste waste) {
        String query = "INSERT INTO waste (type, quantity, disposalMethod, price, user_id) VALUES (?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, waste.getType());
            ps.setInt(2, waste.getQuantity());
            ps.setString(3, waste.getDisposalMethod());
            ps.setDouble(4, waste.getPrice());
            ps.setInt(5, waste.getUserID());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Fetch all waste records for a specific user
    public List<Waste> getAllWasteByUser(int userId) {
        List<Waste> wasteList = new ArrayList<>();
        String query = "SELECT * FROM waste WHERE user_id = ?";

        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                wasteList.add(new Waste(
                        rs.getInt("id"),
                        rs.getString("type"),
                        rs.getInt("quantity"),
                        rs.getString("disposalMethod"),
                        rs.getDouble("price"),
                        rs.getInt("user_id")
                ));
            }
            System.out.println("Waste List Size : " + wasteList.size());

        } catch (Exception e) {
            e.printStackTrace();
        }
        return wasteList;
    }

    // Delete a waste entry by ID and user ID (ensures only the owner can delete)
    public boolean deleteWaste(int id, int userId) {
        String query = "DELETE FROM waste WHERE id = ? AND user_id = ?";

        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, id);
            ps.setInt(2, userId);

            System.out.println("Executing DELETE query: " + query);
            System.out.println("Parameters: id=" + id + ", user_id=" + userId);

            int rowsAffected = ps.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected); // Log the number of rows deleted

            return rowsAffected > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

    }

    public boolean deleteWasteByAdmin(int id) {
        String sql = "DELETE FROM waste WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
