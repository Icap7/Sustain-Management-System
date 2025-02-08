package dao;

import util.DBConnection;
import model.Users;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // Fetch user details by user ID
    public static Users getUserById(int userId) {
        Users user = null;

        try (Connection con = DBConnection.getConnection()) {
            String query = "SELECT * FROM USERS WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new Users();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log error for debugging
        }

        return user;
    }

    // Fetch all users
    public static List<Users> getAllUsers() {
        List<Users> userList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {
            String query = "SELECT * FROM USERS";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Users user = new Users();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setPassword(rs.getString("password"));
                userList.add(user);
            }
            System.out.println("User list size " + userList.size());
        } catch (Exception e) {
            e.printStackTrace(); // Log error for debugging
        }

        return userList;
    }
    
    public static boolean deleteUser(int userId) {
    try (Connection con = DBConnection.getConnection()) {
        String query = "DELETE FROM USERS WHERE id = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, userId);
        int rowsAffected = ps.executeUpdate();
        return rowsAffected > 0; // Return true if deletion was successful
    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
}

}
