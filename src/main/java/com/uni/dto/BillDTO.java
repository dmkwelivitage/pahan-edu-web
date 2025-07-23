package com.uni.dto;

import java.util.Date;
import java.util.List;

public class BillDTO {
    private int id;
    private int customerId;
    private Date billingDate;
    private double totalAmount;
    private String status;

    private List<BillItemDTO> items;

    public BillDTO() {}

    public BillDTO(int id, int customerId, Date billingDate, double totalAmount, String status) {
        this.id = id;
        this.customerId = customerId;
        this.billingDate = billingDate;
        this.totalAmount = totalAmount;
        this.status = status;
    }

    public BillDTO(int id, int customerId, Date billingDate, double totalAmount, String status, List<BillItemDTO> items) {
        this.id = id;
        this.customerId = customerId;
        this.billingDate = billingDate;
        this.totalAmount = totalAmount;
        this.status = status;
        this.items = items;
    }

    public List<BillItemDTO> getItems() {
        return items;
    }
    public void setItems(List<BillItemDTO> items) {
        this.items = items;
    }

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }

    public Date getBillingDate() { return billingDate; }
    public void setBillingDate(Date billingDate) { this.billingDate = billingDate; }

    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
