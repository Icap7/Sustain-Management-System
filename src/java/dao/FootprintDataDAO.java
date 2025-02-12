package dao;

import model.FootprintData;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FootprintDataDAO {

    private Connection conn;

    public FootprintDataDAO(Connection conn) {
        this.conn = conn;
    }

    // Insert new footprint data
    public boolean insertFootprintData(FootprintData data) {
        String sql = "INSERT INTO FOOTPRINT_DATA (USER_ID, BIOMASS, CARBON_FOOTPRINT, COAL, COST, ELECTRICITY, HEATING_OIL, LPG, NATURAL_GAS, RENEWABLES_ELECTRICITY, RENEWABLES_NATURAL_GAS) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, data.getUserId());
            stmt.setInt(2, data.getBiomass());
            stmt.setDouble(3, data.getCarbonFootprint());
            stmt.setInt(4, data.getCoal());
            stmt.setDouble(5, data.getCost());
            stmt.setInt(6, data.getElectricity());
            stmt.setInt(7, data.getHeatingOil());
            stmt.setInt(8, data.getLpg());
            stmt.setInt(9, data.getNaturalGas());
            stmt.setInt(10, data.getRenewablesElectricity());
            stmt.setInt(11, data.getRenewablesNaturalGas());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Retrieve all footprint data (For admin users)
    public List<FootprintData> getAllFootprintData() {
        List<FootprintData> dataList = new ArrayList<>();
        String sql = "SELECT fd.*, u.NAME FROM FOOTPRINT_DATA fd "
                + "JOIN USERS u ON fd.USER_ID = u.ID";

        try (PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                FootprintData data = new FootprintData(
                        rs.getInt("ID"),
                        rs.getInt("USER_ID"),
                        rs.getString("NAME"), // Add user name
                        rs.getInt("BIOMASS"),
                        rs.getDouble("CARBON_FOOTPRINT"),
                        rs.getInt("COAL"),
                        rs.getDouble("COST"),
                        rs.getInt("ELECTRICITY"),
                        rs.getInt("HEATING_OIL"),
                        rs.getInt("LPG"),
                        rs.getInt("NATURAL_GAS"),
                        rs.getInt("RENEWABLES_ELECTRICITY"),
                        rs.getInt("RENEWABLES_NATURAL_GAS")
                );
                dataList.add(data);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dataList;
    }

    // Retrieve all footprint data for a specific user
    public List<FootprintData> getFootprintDataByUser(int userId) {
        List<FootprintData> dataList = new ArrayList<>();
        String sql = "SELECT * FROM FOOTPRINT_DATA WHERE USER_ID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                FootprintData data = new FootprintData(
                        rs.getInt("ID"),
                        rs.getInt("USER_ID"),
                        rs.getInt("BIOMASS"),
                        rs.getDouble("CARBON_FOOTPRINT"),
                        rs.getInt("COAL"),
                        rs.getDouble("COST"),
                        rs.getInt("ELECTRICITY"),
                        rs.getInt("HEATING_OIL"),
                        rs.getInt("LPG"),
                        rs.getInt("NATURAL_GAS"),
                        rs.getInt("RENEWABLES_ELECTRICITY"),
                        rs.getInt("RENEWABLES_NATURAL_GAS")
                );
                dataList.add(data);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dataList;
    }

    // Delete footprint data by ID
    public boolean deleteFootprintData(int id) {
        String sql = "DELETE FROM FOOTPRINT_DATA WHERE ID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update footprint data
    public boolean updateFootprintData(FootprintData data) {
        String sql = "UPDATE FOOTPRINT_DATA SET BIOMASS=?, CARBON_FOOTPRINT=?, COAL=?, COST=?, ELECTRICITY=?, HEATING_OIL=?, LPG=?, NATURAL_GAS=?, RENEWABLES_ELECTRICITY=?, RENEWABLES_NATURAL_GAS=? WHERE ID=?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, data.getBiomass());
            stmt.setDouble(2, data.getCarbonFootprint());
            stmt.setInt(3, data.getCoal());
            stmt.setDouble(4, data.getCost());
            stmt.setInt(5, data.getElectricity());
            stmt.setInt(6, data.getHeatingOil());
            stmt.setInt(7, data.getLpg());
            stmt.setInt(8, data.getNaturalGas());
            stmt.setInt(9, data.getRenewablesElectricity());
            stmt.setInt(10, data.getRenewablesNaturalGas());
            stmt.setInt(11, data.getId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
