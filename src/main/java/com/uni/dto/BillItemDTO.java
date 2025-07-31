package com.uni.dto;

import com.uni.model.BillItem;

import java.util.List;

public class BillItemDTO {
    private int id;
    private int billId;
    private int itemId;
    private int quantity;
    private double unitPrice;
    private double lineTotal;

    public BillItemDTO() {}

    public BillItemDTO(int id, int billId, int itemId, int quantity, double unitPrice, double lineTotal) {
        this.id = id;
        this.billId = billId;
        this.itemId = itemId;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.lineTotal = lineTotal;
    }

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getBillId() { return billId; }
    public void setBillId(int billId) { this.billId = billId; }

    public int getItemId() { return itemId; }
    public void setItemId(int itemId) { this.itemId = itemId; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getUnitPrice() { return unitPrice; }
    public void setUnitPrice(double unitPrice) { this.unitPrice = unitPrice; }

    public double getLineTotal() { return lineTotal; }
    public void setLineTotal(double lineTotal) { this.lineTotal = lineTotal; }
}
