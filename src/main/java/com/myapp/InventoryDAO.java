package com.myapp;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class InventoryDAO {

    public List<InventoryItem> findAll(String search, String category) throws SQLException {
        List<InventoryItem> items = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT * FROM products WHERE (name LIKE ? OR sku LIKE ? OR supplier LIKE ?)");
        List<Object> params = new ArrayList<>();
        String q = "%" + (search == null ? "" : search.trim()) + "%";
        params.add(q); params.add(q); params.add(q);

        if (category != null && !category.isBlank() && !"All".equalsIgnoreCase(category)) {
            sql.append(" AND category = ?");
            params.add(category);
        }
        sql.append(" ORDER BY id DESC");

        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) ps.setObject(i + 1, params.get(i));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) items.add(map(rs));
            }
        }
        return items;
    }

    public InventoryItem findById(int id) throws SQLException {
        String sql = "SELECT * FROM products WHERE id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? map(rs) : null;
            }
        }
    }

    public void insert(InventoryItem p) throws SQLException {
        String sql = "INSERT INTO products(name,sku,category,quantity,reorder_level,price,supplier) VALUES(?,?,?,?,?,?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            setValues(ps, p);
            ps.executeUpdate();
        }
    }

    public void update(InventoryItem p) throws SQLException {
        String sql = "UPDATE products SET name=?, sku=?, category=?, quantity=?, reorder_level=?, price=?, supplier=? WHERE id=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            setValues(ps, p);
            ps.setInt(8, p.getId());
            ps.executeUpdate();
        }
    }

    public void delete(int id) throws SQLException {
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement("DELETE FROM products WHERE id=?")) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public List<String> getCategories() throws SQLException {
        List<String> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement("SELECT DISTINCT category FROM products ORDER BY category");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(rs.getString(1));
        }
        return list;
    }

    public int countProducts() throws SQLException {
        return scalarInt("SELECT COUNT(*) FROM products");
    }

    public int totalUnits() throws SQLException {
        return scalarInt("SELECT COALESCE(SUM(quantity),0) FROM products");
    }

    public int lowStockCount() throws SQLException {
        return scalarInt("SELECT COUNT(*) FROM products WHERE quantity > 0 AND quantity <= reorder_level");
    }

    public int outOfStockCount() throws SQLException {
        return scalarInt("SELECT COUNT(*) FROM products WHERE quantity = 0");
    }

    public double totalStockValue() throws SQLException {
        String sql = "SELECT COALESCE(SUM(quantity * price),0) FROM products";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            rs.next();
            return rs.getDouble(1);
        }
    }

    private int scalarInt(String sql) throws SQLException {
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            rs.next();
            return rs.getInt(1);
        }
    }

    private InventoryItem map(ResultSet rs) throws SQLException {
        return new InventoryItem(
            rs.getInt("id"),
            rs.getString("name"),
            rs.getString("sku"),
            rs.getString("category"),
            rs.getInt("quantity"),
            rs.getInt("reorder_level"),
            rs.getDouble("price"),
            rs.getString("supplier")
        );
    }

    private void setValues(PreparedStatement ps, InventoryItem p) throws SQLException {
        ps.setString(1, p.getName());
        ps.setString(2, p.getSku());
        ps.setString(3, p.getCategory());
        ps.setInt(4, p.getQuantity());
        ps.setInt(5, p.getReorderLevel());
        ps.setDouble(6, p.getPrice());
        ps.setString(7, p.getSupplier());
    }
}
