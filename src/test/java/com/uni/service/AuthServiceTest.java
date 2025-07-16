package com.uni.service;

import com.uni.dto.LoginRequestDTO;
import com.uni.dto.UserDTO;
import com.uni.util.DBConnection;
import org.junit.jupiter.api.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import static org.junit.jupiter.api.Assertions.*;

class AuthServiceTest {

    private AuthService authService;

    // Test user credentials
    private final String testUsername = "testUser";
    private final String testPassword = "testPass";
    private final String testRole = "tester";

    @BeforeEach
    void setUp() {
        authService = new AuthService();
        insertTestUser();
    }

    @AfterEach
    void tearDown() {
        deleteTestUser();
    }

    @Test
    void testLoginWithValidCredentials() {
        LoginRequestDTO loginDTO = new LoginRequestDTO(testUsername, testPassword);
        UserDTO user = authService.login(loginDTO);

        assertNotNull(user, "User should not be null for valid credentials");
        assertEquals(testUsername, user.getUsername());
        assertEquals(testRole, user.getRole());
    }

    @Test
    void testLoginWithInvalidCredentials() {
        LoginRequestDTO loginDTO = new LoginRequestDTO("wrongUser", "wrongPass");
        UserDTO user = authService.login(loginDTO);

        assertNull(user, "User should be null for invalid credentials");
    }

    private void insertTestUser() {
        String sql = "INSERT INTO users (username, password, role) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, testUsername);
            stmt.setString(2, testPassword);
            stmt.setString(3, testRole);
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error inserting test user: " + e.getMessage());
        }
    }

    private void deleteTestUser() {
        String sql = "DELETE FROM users WHERE username = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, testUsername);
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error deleting test user: " + e.getMessage());
        }
    }
}
