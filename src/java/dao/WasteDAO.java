package dao;

import util.DBConnection;
import model.Waste;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class WasteDAO {

    // Fetch waste records for a specific user
    public static List<Waste> getUserWasteRecords(int userId) {
        List<Waste> wasteList = new ArrayList<Waste>();
        
        try (Connection con = DBConnection.getConnection()) {
            String query = "SELECT * FROM waste WHERE user_id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Waste waste = new Waste();
                waste.setId(rs.getInt("id"));
                waste.setUserID(rs.getInt("user_id"));
                waste.setType(rs.getString("type"));
                waste.setQuantity(rs.getInt("quantity"));
                waste.setDisposalMethod(rs.getString("disposalMethod"));
                wasteList.add(waste);
            }
            System.out.println(wasteList);
        } catch (Exception e) {
            e.printStackTrace(); // Log error for debugging
        }

        return wasteList;
    }
}
