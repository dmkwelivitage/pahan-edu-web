package com.uni.service;

import com.uni.dao.BillDAO;
import com.uni.dao.BillItemDAO;
import com.uni.dto.BillDTO;
import com.uni.dto.BillItemDTO;
import com.uni.model.Bill;
import com.uni.model.BillItem;

import java.util.ArrayList;
import java.util.List;

public class BillService {

    private final BillDAO billDAO = new BillDAO();
    private final BillItemDAO billItemDAO = new BillItemDAO();

    // Add a bill with items
    public boolean addBill(BillDTO dto) {
        Bill bill = mapDtoToEntity(dto);

        int billSaved = billDAO.save(bill);
        if (billSaved == 0) return false;

        // This must be set by the DAO (e.g., auto-incremented ID)
        for (BillItem item : bill.getBillItems()) {
            item.setBillId(billSaved);
            // Calculate line total
            item.setLineTotal(item.getQuantity() * item.getUnitPrice());
            billItemDAO.save(item);
        }

        return true;
    }

    // Get all bills
    public List<BillDTO> getAllBills() {
        List<Bill> bills = billDAO.findAll();
        List<BillDTO> DTOs = new ArrayList<>();

        for (Bill bill : bills) {
            List<BillItem> items = billItemDAO.findByBillId(bill.getId());
            bill.setBillItems(items);
            DTOs.add(mapEntityToDto(bill));
        }

        return DTOs;
    }

    // Get bill by ID
    public BillDTO getBillById(int id) {
        Bill bill = billDAO.findById(id);
        if (bill != null) {
            List<BillItem> items = billItemDAO.findByBillId(bill.getId());
            bill.setBillItems(items);
            return mapEntityToDto(bill);
        }
        return null;
    }

    // Update bill
    public boolean updateBill(int id, BillDTO dto) {
        Bill bill = mapDtoToEntity(dto);
        bill.setId(id);

        boolean billUpdated = billDAO.update(bill);
        if (!billUpdated) return false;

        // Delete old items and add new ones
        billItemDAO.deleteByBillId(id);

        for (BillItem item : bill.getBillItems()) {
            item.setBillId(id);
            // Calculate line total
            item.setLineTotal(item.getQuantity() * item.getUnitPrice());
            billItemDAO.save(item);
        }

        return true;
    }

    // Delete bill
    public boolean deleteBill(int id) {
        List<BillItem> items =  billItemDAO.findByBillId(id);
        // First delete all items associated with the bill
        for (BillItem item : items) {
            billItemDAO.deleteById(item.getId());
        }
        return billDAO.delete(id);
    }

    // --- Mapping methods ---

    private Bill mapDtoToEntity(BillDTO dto) {
        List<BillItem> items = new ArrayList<>();
        for (BillItemDTO itemDTO : dto.getItems()) {
            // Calculate line total if not already set
            double lineTotal = itemDTO.getLineTotal();
            if (lineTotal <= 0) {
                lineTotal = itemDTO.getQuantity() * itemDTO.getUnitPrice();
            }
            
            items.add(new BillItem(
                    itemDTO.getId(),
                    itemDTO.getBillId(),
                    itemDTO.getItemId(),
                    itemDTO.getQuantity(),
                    itemDTO.getUnitPrice(),
                    lineTotal
            ));
        }

        return new Bill(
                dto.getId(),
                dto.getCustomerId(),
                dto.getBillingDate(),
                dto.getTotalAmount(),
                dto.getStatus(),
                items
        );
    }

    private BillDTO mapEntityToDto(Bill bill) {
        List<BillItemDTO> itemDTOs = new ArrayList<>();
        for (BillItem item : bill.getBillItems()) {
            itemDTOs.add(new BillItemDTO(
                    item.getId(),
                    item.getBillId(),
                    item.getItemId(),
                    item.getQuantity(),
                    item.getUnitPrice(),
                    item.getLineTotal()
            ));
        }

        return new BillDTO(
                bill.getId(),
                bill.getCustomerId(),
                bill.getBillingDate(),
                bill.getTotalAmount(),
                bill.getStatus(),
                itemDTOs
        );
    }
}
