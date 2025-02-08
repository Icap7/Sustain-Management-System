
import java.sql.*;

public class TableCreation {

    public static void main(String[] args) {
        String url = "jdbc:derby://localhost:1527/WasteManagement;create=true";
        String user = "app"; // Default username for Derby
        String password = "app"; // Default password for Derby

        try (Connection conn = DriverManager.getConnection(url, user, password);
                Statement stmt = conn.createStatement()) {

            System.out.println("Connected to Derby database successfully!");

            // Create USERS Table
            String createUsersTable = "CREATE TABLE USERS ("
                    + "ID INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1), "
                    + "NAME VARCHAR(100) NOT NULL, "
                    + "EMAIL VARCHAR(100) NOT NULL UNIQUE, "
                    + "PASSWORD VARCHAR(255) NOT NULL, "
                    + "ROLE VARCHAR(50) NOT NULL)";
            stmt.executeUpdate(createUsersTable);
            System.out.println("USERS table created.");

            // Create FOOTPRINT_DATA Table
            String createFootprintTable = "CREATE TABLE FOOTPRINT_DATA ("
                    + "ID INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1), "
                    + "USER_ID INTEGER NOT NULL, "
                    + "BIOMASS INTEGER NOT NULL, "
                    + "CARBON_FOOTPRINT DOUBLE NOT NULL, "
                    + "COAL INTEGER NOT NULL, "
                    + "COST DOUBLE NOT NULL, "
                    + "ELECTRICITY INTEGER NOT NULL, "
                    + "HEATING_OIL INTEGER NOT NULL, "
                    + "LPG INTEGER NOT NULL, "
                    + "NATURAL_GAS INTEGER NOT NULL, "
                    + "RENEWABLES_ELECTRICITY INTEGER NOT NULL, "
                    + "RENEWABLES_NATURAL_GAS INTEGER NOT NULL, "
                    + "FOREIGN KEY (USER_ID) REFERENCES USERS(ID) ON DELETE CASCADE)";
            stmt.executeUpdate(createFootprintTable);
            System.out.println("FOOTPRINT_DATA table created.");

            // Create WASTE Table
            String createWasteTable = "CREATE TABLE WASTE ("
                    + "ID INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1), "
                    + "USER_ID INTEGER NOT NULL, "
                    + "TYPE VARCHAR(100) NOT NULL, "
                    + "QUANTITY INTEGER NOT NULL, "
                    + "DISPOSALMETHOD VARCHAR(100) NOT NULL, "
                    + "FOREIGN KEY (USER_ID) REFERENCES USERS(ID) ON DELETE CASCADE)";
            stmt.executeUpdate(createWasteTable);
            System.out.println("WASTE table created.");

            System.out.println("All tables created successfully!");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
