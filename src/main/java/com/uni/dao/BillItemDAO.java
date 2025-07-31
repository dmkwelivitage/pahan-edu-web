package com.uni.dao;

import com.uni.model.BillItem;
import com.uni.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillItemDAO {

    public void save(BillItem item) {
        String sql = "INSERT INTO bill_items (bill_id, item_id, quantity, unit_price, line_total) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, item.getBillId());
            stmt.setInt(2, item.getItemId());
            stmt.setInt(3, item.getQuantity());
            stmt.setDouble(4, item.getUnitPrice());
            stmt.setDouble(5, item.getLineTotal());

            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<BillItem> findByBillId(int billId) {
        List<BillItem> items = new ArrayList<>();
        String sql = "SELECT * FROM bill_items WHERE bill_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, billId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                BillItem item = new BillItem(
                        rs.getInt("id"),
                        rs.getInt("bill_id"),
                        rs.getInt("item_id"),
                        rs.getInt("quantity"),
                        rs.getDouble("unit_price"),
                        rs.getDouble("line_total")
                );
                items.add(item);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return items;
    }

    public void deleteByBillId(int billId) {
        String sql = "DELETE FROM bill_items WHERE bill_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, billId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void deleteById(int id) {
        String sql = "DELETE FROM bill_items WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void update(BillItem item) {
        String sql = "UPDATE bill_items SET quantity = ?, unit_price = ?, line_total = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, item.getQuantity());
            stmt.setDouble(2, item.getUnitPrice());
            stmt.setDouble(3, item.getLineTotal());
            stmt.setInt(4, item.getId());

            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
