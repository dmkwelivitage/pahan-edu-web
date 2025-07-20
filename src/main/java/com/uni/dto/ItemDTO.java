package com.uni.dto;

public class ItemDTO {
    private int id;
    private String code;
    private String name;
    private String category;
    private double unitPrice;
    private int stockQty;

    public ItemDTO() {}

    public ItemDTO(int id, String code, String name, String category, double unitPrice, int stockQty) {
        this.id = id;
        this.code = code;
        this.name = name;
        this.category = category;
        this.unitPrice = unitPrice;
        this.stockQty = stockQty;
    }

    // Getters & Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }

    public int getStockQty() {
        return stockQty;
    }

    public void setStockQty(int stockQty) {
        this.stockQty = stockQty;
    }
}
