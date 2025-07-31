package com.uni.dao;

import com.uni.model.Bill;
import com.uni.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillDAO {

    public int save(Bill bill) {
        String sql = "INSERT INTO bills (customer_id, billing_date, total_amount, status) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, bill.getCustomerId());
            stmt.setDate(2, new java.sql.Date(bill.getBillingDate().getTime()));
            stmt.setDouble(3, bill.getTotalAmount());
            stmt.setString(4, bill.getStatus());


            stmt.executeUpdate();
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                bill.setId(rs.getInt(1));
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    public List<Bill> findAll() {
        List<Bill> bills = new ArrayList<>();
        String sql = "SELECT * FROM bills";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Bill bill = new Bill(
                        rs.getInt("id"),
                        rs.getInt("customer_id"),
                        rs.getDate("billing_date"),
                        rs.getDouble("total_amount"),
                        rs.getString("status")
                );
                bills.add(bill);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return bills;
    }

    public Bill findById(int id)  {
        String sql = "SELECT * FROM bills WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Bill(
                        rs.getInt("id"),
                        rs.getInt("customer_id"),
                        rs.getDate("billing_date"),
                        rs.getDouble("total_amount"),
                        rs.getString("status")
                );
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return null;
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM bills WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean update(Bill bill)  {
        String sql = "UPDATE bills SET customer_id = ?, billing_date = ?, total_amount = ?, status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, bill.getCustomerId());
            stmt.setDate(2, new java.sql.Date(bill.getBillingDate().getTime()));
            stmt.setDouble(3, bill.getTotalAmount());
            stmt.setString(4, bill.getStatus());
            stmt.setInt(5, bill.getId());

            stmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
