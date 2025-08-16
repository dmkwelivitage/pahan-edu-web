package com.uni.controller;

import com.uni.dto.UserDTO;
import com.uni.dto.CustomerDTO;
import com.uni.dto.ItemDTO;
import com.uni.dto.BillDTO;
import com.uni.service.CustomerService;
import com.uni.service.ItemService;
import com.uni.service.BillService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private final CustomerService customerService = new CustomerService();
    private final ItemService itemService = new ItemService();
    private final BillService billService = new BillService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        UserDTO user = (session != null) ? (UserDTO) session.getAttribute("loggedUser") : null;

        if (user == null) {
            resp.sendRedirect("login");
            return;
        }

        try {
            // Fetch data for dashboard
            List<CustomerDTO> customers = customerService.getAllCustomers();
            List<ItemDTO> items = itemService.getAllItems();
            List<BillDTO> bills = billService.getAllBills();

            // Set attributes for the dashboard
            req.setAttribute("customers", customers);
            req.setAttribute("items", items);
            req.setAttribute("bills", bills);
            
        } catch (Exception e) {
            // Log error but don't fail the dashboard
            System.err.println("Error fetching dashboard data: " + e.getMessage());
            // Set empty lists as fallback
            req.setAttribute("customers", java.util.Collections.emptyList());
            req.setAttribute("items", java.util.Collections.emptyList());
            req.setAttribute("bills", java.util.Collections.emptyList());
        }

        req.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(req, resp);
    }
}
