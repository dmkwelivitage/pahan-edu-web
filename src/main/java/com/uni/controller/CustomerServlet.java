package com.uni.controller;

import com.uni.dto.CustomerDTO;
import com.uni.service.CustomerService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/customers")
public class CustomerServlet extends HttpServlet {
    private final CustomerService customerService = new CustomerService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam != null) {
            // Fetch single customer
            int id = Integer.parseInt(idParam);
            CustomerDTO customer = customerService.getCustomerById(id);
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("/WEB-INF/views/customer_edit.jsp").forward(request, response);
        } else {
            // Fetch all customers
            List<CustomerDTO> customers = customerService.getAllCustomers();
            request.setAttribute("customers", customers);
            request.getRequestDispatcher("/WEB-INF/views/customer_list.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("update".equalsIgnoreCase(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            CustomerDTO dto = extractCustomerDTO(request);
            boolean updated = customerService.updateCustomer(id, dto);

            if (updated) {
                response.sendRedirect(request.getContextPath() + "/customers");
            } else {
                request.setAttribute("error", "Failed to update customer.");
                request.getRequestDispatcher("/WEB-INF/views/customer_edit.jsp").forward(request, response);
            }

        } else if ("delete".equalsIgnoreCase(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean deleted = customerService.deleteCustomer(id);
            response.sendRedirect(request.getContextPath() + "/customers");

        } else {
            // Create new customer
            CustomerDTO dto = extractCustomerDTO(request);
            boolean success = customerService.addCustomer(dto);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/customers");
            } else {
                request.setAttribute("error", "Failed to add customer.");
                request.getRequestDispatcher("/WEB-INF/views/customer_list.jsp").forward(request, response);
            }
        }
    }

    private CustomerDTO extractCustomerDTO(HttpServletRequest request) {
        int id = request.getParameter("id") != null ? Integer.parseInt(request.getParameter("id")) : 0;
        String accountNumber = request.getParameter("accountNumber");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        int units = Integer.parseInt(request.getParameter("unitsConsumed"));

        return new CustomerDTO(id, accountNumber, name, address, phone, units);
    }
}
