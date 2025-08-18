package com.uni.controller;

import com.uni.dto.CustomerDTO;
import com.uni.service.CustomerService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/customer-lookup")
public class CustomerLookupServlet extends HttpServlet {
    private final CustomerService customerService = new CustomerService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accountNumber = request.getParameter("accountNumber");

        if (accountNumber != null && !accountNumber.trim().isEmpty()) {
            // Search for customer by account number
            CustomerDTO customer = customerService.getCustomerByAccountNumber(accountNumber.trim());
            
            if (customer != null) {
                request.setAttribute("customer", customer);
            } else {
                request.setAttribute("error", "No customer found with account number: " + accountNumber);
            }
            
            // Mark that a search was performed
            request.setAttribute("searched", true);
        }

        // Forward to the customer lookup JSP
        request.getRequestDispatcher("/WEB-INF/views/customer_lookup.jsp").forward(request, response);
    }
}
