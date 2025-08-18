package com.uni.controller;

import com.uni.dto.BillDTO;
import com.uni.dto.BillItemDTO;
import com.uni.dto.CustomerDTO;
import com.uni.dto.ItemDTO;
import com.uni.model.Item;
import com.uni.service.BillService;

import com.uni.service.CustomerService;
import com.uni.service.ItemService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet({"/bills", "/bill"})
public class BillServlet extends HttpServlet {
    private final BillService billService = new BillService();
    private final ItemService itemService = new ItemService();
    private final CustomerService customerService = new CustomerService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        String requestURI = request.getRequestURI();
        String contextPath = request.getContextPath();

        // Handle bill summary endpoint (/bill)
        if (requestURI.endsWith("/bill") && idParam != null) {
            int id = Integer.parseInt(idParam);
            BillDTO bill = billService.getBillById(id);
            if (bill != null) {
                CustomerDTO customer = customerService.getCustomerById(bill.getCustomerId());
                List<BillItemDTO> billItems = bill.getItems();
                
                // Get item details for each bill item
                List<ItemDTO> items = itemService.getAllItems();
                
                request.setAttribute("bill", bill);
                request.setAttribute("customer", customer);
                request.setAttribute("billItems", billItems);
                request.setAttribute("items", items);
                request.getRequestDispatcher("/WEB-INF/views/bill_summary.jsp").forward(request, response);
                return;
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Bill not found");
                return;
            }
        }

        // Handle bills endpoint (/bills)
        if (requestURI.endsWith("/bills")) {
            if (idParam != null) {
                if (request.getParameter("action") != null && request.getParameter("action").equals("delete")) {
                    // Handle delete action
                    int id = Integer.parseInt(idParam);
                    boolean deleted = billService.deleteBill(id);
                    response.sendRedirect(contextPath + "/bills");
                    return;
                }
                List<ItemDTO> items = itemService.getAllItems();
                request.setAttribute("items", items);

                int id = Integer.parseInt(idParam);
                BillDTO bill = billService.getBillById(id);
                request.setAttribute("bill", bill);
                List<ItemDTO> billItems = new ArrayList<>();
                for (BillItemDTO item : bill.getItems()) {
                    ItemDTO itemDTO = itemService.getItemById(item.getItemId());
                    if (itemDTO != null) {
                        billItems.add(itemDTO);
                    }
                }
                List<CustomerDTO> customers = customerService.getAllCustomers();
                request.setAttribute("customers", customers);
                request.setAttribute("billItems", billItems);
                request.getRequestDispatcher("/WEB-INF/views/bill_edit.jsp").forward(request, response);
            } else {
                if (request.getParameter("action") != null && request.getParameter("action").equals("create")) {
                    // Forward to create bill page
                    request.getRequestDispatcher("/WEB-INF/views/bill_create.jsp").forward(request, response);
                    return;
                }
                List<BillDTO> bills = billService.getAllBills();
                List<CustomerDTO> customers = customerService.getAllCustomers();
                List<ItemDTO> items = itemService.getAllItems();
                request.setAttribute("bills", bills);
                request.setAttribute("customers", customers);
                request.setAttribute("items", items);
                request.getRequestDispatcher("/WEB-INF/views/bill_list.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("update".equalsIgnoreCase(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            BillDTO dto = extractBillDTOUpdate(request);
            boolean updated = billService.updateBill(id, dto);

            if (updated) {
                response.sendRedirect(request.getContextPath() + "/bills");
            } else {
                request.setAttribute("error", "Failed to update bill.");
                request.getRequestDispatcher("/WEB-INF/views/bill_edit.jsp").forward(request, response);
            }

        } else if ("delete".equalsIgnoreCase(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean deleted = billService.deleteBill(id);
            response.sendRedirect(request.getContextPath() + "/bills");

        } else {
            BillDTO dto = extractBillDTO(request);
            boolean success = billService.addBill(dto);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/bills");
            } else {
                request.setAttribute("error", "Failed to add bill.");
                request.getRequestDispatcher("/WEB-INF/views/bill_list.jsp").forward(request, response);
            }
        }
    }

    private BillDTO extractBillDTO(HttpServletRequest request) {
        int id = request.getParameter("id") != null ? Integer.parseInt(request.getParameter("id")) : 0;
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        String status = "Pending";
        double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));

        // Optional: parse custom billing date or use current
        Date billingDate = new Date();

        // Extract bill items
        List<BillItemDTO> billItems = new ArrayList<>();
        String[] itemIds = request.getParameterValues("itemIds[]");
        String[] quantities = request.getParameterValues("quantities[]");
        String[] unitPrices = request.getParameterValues("unitPrices[]");
//        String[] lineTotals = request.getParameterValues("lineTotals[]");

        if (itemIds != null) {
            for (int i = 0; i < itemIds.length; i++) {
                BillItemDTO item = new BillItemDTO(
                        0,
                        id,
                        Integer.parseInt(itemIds[i]),
                        Integer.parseInt(quantities[i]),
                        Double.parseDouble(unitPrices[i]),
                        0
//                        Double.parseDouble(lineTotals[i])
                );
                billItems.add(item);
            }
        }

        return new BillDTO(id, customerId, billingDate, totalAmount, status, billItems);
    }

    private BillDTO extractBillDTOUpdate(HttpServletRequest request) {
        int id = request.getParameter("id") != null ? Integer.parseInt(request.getParameter("id")) : 0;
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        String status = "Pending"; // Default status for updates
        double totalAmount = 0.0;
        
        // Get total amount from form
        String totalAmountParam = request.getParameter("totalAmount");
        if (totalAmountParam != null && !totalAmountParam.trim().isEmpty()) {
            try {
                totalAmount = Double.parseDouble(totalAmountParam);
            } catch (NumberFormatException e) {
                totalAmount = 0.0;
            }
        }

        // Parse billing date or use current
        Date billingDate = new Date();
        String billingDateParam = request.getParameter("billingDate");
        if (billingDateParam != null && !billingDateParam.trim().isEmpty()) {
            try {
                // Parse the date string to Date object
                java.time.LocalDate localDate = java.time.LocalDate.parse(billingDateParam);
                billingDate = java.sql.Date.valueOf(localDate);
            } catch (Exception e) {
                // If parsing fails, try to use the original bill's billing date
                try {
                    BillDTO originalBill = billService.getBillById(id);
                    if (originalBill != null && originalBill.getBillingDate() != null) {
                        billingDate = originalBill.getBillingDate();
                    }
                } catch (Exception ex) {
                    billingDate = new Date();
                }
            }
        }

        // Extract bill items
        List<BillItemDTO> billItems = new ArrayList<>();
        String[] itemIds = request.getParameterValues("itemIds[]");
        String[] quantities = request.getParameterValues("quantities[]");
        String[] unitPrices = request.getParameterValues("unitPrices[]");

        if (itemIds != null) {
            for (int i = 0; i < itemIds.length; i++) {
                if (itemIds[i] != null && !itemIds[i].trim().isEmpty() &&
                    quantities[i] != null && !quantities[i].trim().isEmpty() &&
                    unitPrices[i] != null && !unitPrices[i].trim().isEmpty()) {
                    
                    try {
                        BillItemDTO item = new BillItemDTO(
                            0,
                            id,
                            Integer.parseInt(itemIds[i]),
                            Integer.parseInt(quantities[i]),
                            Double.parseDouble(unitPrices[i]),
                            0
                        );
                        billItems.add(item);
                    } catch (NumberFormatException e) {
                        // Skip invalid items
                        continue;
                    }
                }
            }
        }

        return new BillDTO(id, customerId, billingDate, totalAmount, status, billItems);
    }
}
