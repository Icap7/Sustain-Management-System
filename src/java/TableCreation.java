
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

            // Create WASTE Table (Now includes PRICE column)
            String createWasteTable = "CREATE TABLE WASTE ("
                    + "ID INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1), "
                    + "USER_ID INTEGER NOT NULL, "
                    + "TYPE VARCHAR(100) NOT NULL, "
                    + "QUANTITY INTEGER NOT NULL, "
                    + "DISPOSALMETHOD VARCHAR(100) NOT NULL, "
                    + "PRICE DOUBLE NOT NULL, "
                    + // Added Price Column
                    "FOREIGN KEY (USER_ID) REFERENCES USERS(ID) ON DELETE CASCADE)";
            stmt.executeUpdate(createWasteTable);
            System.out.println("WASTE table created.");

            // Create WASTE_GUIDE Table (Now includes USER_ID as a foreign key)
            String createWasteGuideTable = "CREATE TABLE WASTE_GUIDE ("
                    + "ID INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1), "
                    + "WASTE_TYPE VARCHAR(100) NOT NULL, "
                    + "CATEGORY VARCHAR(100) NOT NULL, "
                    + "DISPOSAL_METHOD VARCHAR(255) NOT NULL, "
                    + "RECYCLING_INSTRUCTIONS VARCHAR(500), "
                    + "IMAGE_PATH VARCHAR(255), "
                    + "USER_ID INTEGER NOT NULL, "
                    + // Added User ID
                    "FOREIGN KEY (USER_ID) REFERENCES USERS(ID) ON DELETE CASCADE)";
            stmt.executeUpdate(createWasteGuideTable);
            System.out.println("WASTE_GUIDE table created.");

            // Insert sample data into USERS table
            stmt.executeUpdate("INSERT INTO USERS (NAME, EMAIL, PASSWORD, ROLE) VALUES "
                    + "('Alice Johnson', 'user@gmail.com', '123', 'user'),"
                    + "('Bob Smith', 'admin@gmail.com', '123', 'admin')");
            System.out.println("Inserted sample data into USERS table.");

            // Insert sample data into FOOTPRINT_DATA table
            stmt.executeUpdate("INSERT INTO FOOTPRINT_DATA (USER_ID, BIOMASS, CARBON_FOOTPRINT, COAL, COST, ELECTRICITY, HEATING_OIL, LPG, NATURAL_GAS, RENEWABLES_ELECTRICITY, RENEWABLES_NATURAL_GAS) "
                    + "VALUES (1, 200, 5.4, 100, 20.5, 300, 50, 20, 10, 100, 50)");
            System.out.println("Inserted sample data into FOOTPRINT_DATA table.");

            // Insert sample data into WASTE table (Now includes PRICE calculation)
            stmt.executeUpdate("INSERT INTO WASTE (USER_ID, TYPE, QUANTITY, DISPOSALMETHOD, PRICE) "
                    + "VALUES (1, 'Plastic', 5, 'Recycling', 5 * 2), "
                    +"(2, 'Paper', 3, 'Recycling', 3 * 2)");
            System.out.println("Inserted sample data into WASTE table.");

            // Insert sample data into WASTE_GUIDE table (Now includes USER_ID)
            stmt.executeUpdate("INSERT INTO WASTE_GUIDE (WASTE_TYPE, CATEGORY, DISPOSAL_METHOD, RECYCLING_INSTRUCTIONS, IMAGE_PATH, USER_ID) VALUES "
                    + "('Plastic', 'Recyclable', 'Recycle Bin', 'Ensure plastic is clean before recycling.', 'uploads/1739346544219_cycling.jpg', 1),"
                    + "('Paper', 'Recyclable', 'Paper Bin', 'Do not mix with contaminated paper.', 'uploads/1739345336073_photo_2024-09-23_22-11-45.jpg', 1),"
                    + "('Glass', 'Recyclable', 'Glass Bin', 'Remove lids before disposal.', 'uploads/1739345178506_football.jpg', 2),"
                    + "('Batteries', 'Hazardous', 'Hazardous Waste Collection', 'Drop off at designated recycling centers.', 'uploads/1739344727909_football.jpg', 2)");
            System.out.println("Inserted sample data into WASTE_GUIDE table.");

            System.out.println("All tables created and sample data inserted successfully!");

        } catch (SQLException e) {
            if (e.getSQLState().equals("X0Y32")) { // Derby error code for "table already exists"
                System.out.println("Some tables already exist. Skipping creation.");
            } else {
                e.printStackTrace();
            }
        }
    }
}
