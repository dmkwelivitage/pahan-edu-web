package com.uni.service;

import com.uni.dao.CustomerDAO;
import com.uni.dto.CustomerDTO;
import com.uni.model.Customer;

import java.util.ArrayList;
import java.util.List;

public class CustomerService {
    private final CustomerDAO customerDAO = new CustomerDAO();

    // Add customer
    public boolean addCustomer(CustomerDTO dto) {
        Customer customer = mapDtoToEntity(dto);
        return customerDAO.addCustomer(customer);
    }

    // Get all customers
    public List<CustomerDTO> getAllCustomers() {
        List<Customer> customers = customerDAO.getAllCustomers();
        List<CustomerDTO> DTOs = new ArrayList<>();

        for (Customer customer : customers) {
            DTOs.add(mapEntityToDto(customer));
        }

        return DTOs;
    }

    // Update customer
    public boolean updateCustomer(int id, CustomerDTO dto) {
        Customer customer = mapDtoToEntity(dto);
        customer.setId(id);
        return customerDAO.updateCustomer(customer);
    }

    // Delete customer
    public boolean deleteCustomer(int id) {
        return customerDAO.deleteCustomer(id);
    }

    // Get customer by ID
    public CustomerDTO getCustomerById(int id) {
        Customer customer = customerDAO.getCustomerById(id);
        if (customer != null) {
            return mapEntityToDto(customer);
        }
        return null;
    }

    // Map DTO → Entity
    private Customer mapDtoToEntity(CustomerDTO dto) {
        return new Customer(
                dto.getId(),
                dto.getAccountNumber(),
                dto.getName(),
                dto.getAddress(),
                dto.getPhone(),
                dto.getUnitsConsumed()
        );
    }

    // Map Entity → DTO
    private CustomerDTO mapEntityToDto(Customer customer) {
        return new CustomerDTO(
                customer.getId(),
                customer.getAccountNumber(),
                customer.getName(),
                customer.getAddress(),
                customer.getPhone(),
                customer.getUnitsConsumed()
        );
    }
}
