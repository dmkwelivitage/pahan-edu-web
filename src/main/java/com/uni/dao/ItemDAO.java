package com.uni.dao;

import com.uni.model.Item;
import com.uni.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemDAO {

    public boolean addItem(Item item) {
        String sql = "INSERT INTO items (code, name, category, unit_price, stock_qty) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, item.getCode());
            ps.setString(2, item.getName());
            ps.setString(3, item.getCategory());
            ps.setDouble(4, item.getUnitPrice());
            ps.setInt(5, item.getStockQty());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Item> getAllItems() {
        List<Item> itemList = new ArrayList<>();
        String sql = "SELECT * FROM items";

        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                itemList.add(extractItemFromResultSet(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return itemList;
    }

    public Item getItemById(int id) {
        String sql = "SELECT * FROM items WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return extractItemFromResultSet(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateItem(Item item) {
        String sql = "UPDATE items SET name=?, category=?, unit_price=?, stock_qty=? WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, item.getName());
            ps.setString(2, item.getCategory());
            ps.setDouble(3, item.getUnitPrice());
            ps.setInt(4, item.getStockQty());
            ps.setInt(5, item.getId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteItem(int id) {
        String sql = "DELETE FROM items WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Item getItemByCode(String code) {
        String sql = "SELECT * FROM items WHERE code = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, code);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return extractItemFromResultSet(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Utility method to map a ResultSet row to an Item object.
     */
    private Item extractItemFromResultSet(ResultSet rs) throws SQLException {
        return new Item(
                rs.getInt("id"),
                rs.getString("code"),
                rs.getString("name"),
                rs.getString("category"),
                rs.getDouble("unit_price"),
                rs.getInt("stock_qty")
        );
    }
}
