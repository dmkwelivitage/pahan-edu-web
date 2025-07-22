package com.uni.controller;

import com.uni.dto.BillDTO;
import com.uni.dto.BillItemDTO;
import com.uni.dto.ItemDTO;
import com.uni.model.Item;
import com.uni.service.BillService;

import com.uni.service.ItemService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/bills")
public class BillServlet extends HttpServlet {
    private final BillService billService = new BillService();
    private final ItemService itemService = new ItemService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam != null) {
            if (request.getParameter("action") != null && request.getParameter("action").equals("delete")) {
                // Handle delete action
                int id = Integer.parseInt(idParam);
                boolean deleted = billService.deleteBill(id);
                response.sendRedirect(request.getContextPath() + "/bills");
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
            request.setAttribute("billItems", billItems);
            request.getRequestDispatcher("/WEB-INF/views/bill_edit.jsp").forward(request, response);
        } else {
            if (request.getParameter("action") != null && request.getParameter("action").equals("create")) {
                // Forward to create bill page
                request.getRequestDispatcher("/WEB-INF/views/bill_create.jsp").forward(request, response);
                return;
            }
            List<BillDTO> bills = billService.getAllBills();
            request.setAttribute("bills", bills);
            request.getRequestDispatcher("/WEB-INF/views/bill_list.jsp").forward(request, response);
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
        String status = request.getParameter("status");
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
            for (int i = 0; i < itemIds.length - 1; i++) {
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
        String status = request.getParameter("status");
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
}
