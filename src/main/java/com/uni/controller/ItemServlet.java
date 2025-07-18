package com.uni.controller;

import com.uni.dto.ItemDTO;
import com.uni.service.ItemService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/items")
public class ItemServlet extends HttpServlet {

    private final ItemService itemService = new ItemService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam != null) {
            // Fetch item for editing
            int id = Integer.parseInt(idParam);
            ItemDTO item = itemService.getItemById(id);
            request.setAttribute("item", item);
            request.getRequestDispatcher("/WEB-INF/views/items/edit.jsp").forward(request, response);
        } else {
            // Fetch all items
            List<ItemDTO> items = itemService.getAllItems();
            request.setAttribute("items", items);
            request.getRequestDispatcher("/WEB-INF/views/items/list.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("add".equalsIgnoreCase(action)) {
            handleAdd(request);
        } else if ("update".equalsIgnoreCase(action)) {
            handleUpdate(request);
        } else if ("delete".equalsIgnoreCase(action)) {
            handleDelete(request);
        }

        // Redirect to item list
        response.sendRedirect(request.getContextPath() + "/items");
    }

    private void handleAdd(HttpServletRequest request) {
        ItemDTO dto = new ItemDTO();
        dto.setCode(request.getParameter("code"));
        dto.setName(request.getParameter("name"));
        dto.setCategory(request.getParameter("category"));
        dto.setUnitPrice(Double.parseDouble(request.getParameter("unitPrice")));
        dto.setStockQty(Integer.parseInt(request.getParameter("stockQty")));
        itemService.addItem(dto);
    }

    private void handleUpdate(HttpServletRequest request) {
        ItemDTO dto = new ItemDTO();
        dto.setId(Integer.parseInt(request.getParameter("id")));
        dto.setName(request.getParameter("name"));
        dto.setCategory(request.getParameter("category"));
        dto.setUnitPrice(Double.parseDouble(request.getParameter("unitPrice")));
        dto.setStockQty(Integer.parseInt(request.getParameter("stockQty")));
        itemService.updateItem(dto);
    }

    private void handleDelete(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        itemService.deleteItem(id);
    }
}
