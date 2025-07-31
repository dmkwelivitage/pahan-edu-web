package com.uni.service;

import com.uni.dto.CustomerDTO;
import org.junit.jupiter.api.*;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class CustomerServiceTest {

    private static CustomerService customerService;
    private static int testCustomerId;

    @BeforeAll
    static void setup() {
        customerService = new CustomerService();
    }

    @Test
    @Order(1)
    void testAddCustomer() {
        CustomerDTO dto = new CustomerDTO(0, "CUSTTEST123", "Test User", "123 Test Street", "0711111111", 100);
        boolean added = customerService.addCustomer(dto);
        assertTrue(added, "Customer should be added");

        // Fetch it to get the generated ID
        List<CustomerDTO> customers = customerService.getAllCustomers();
        CustomerDTO testCustomer = customers.stream()
                .filter(c -> "CUSTTEST123".equals(c.getAccountNumber()))
                .findFirst()
                .orElse(null);

        assertNotNull(testCustomer, "Test customer should exist after insertion");
        testCustomerId = testCustomer.getId();
        assertTrue(testCustomerId > 0, "ID of test customer should be greater than 0");
    }

    @Test
    @Order(2)
    void testGetCustomerById() {
        CustomerDTO customer = customerService.getCustomerById(testCustomerId);
        assertNotNull(customer, "Customer should be found");
        assertEquals("Test User", customer.getName());
    }

    @Test
    @Order(3)
    void testUpdateCustomer() {
        CustomerDTO updated = new CustomerDTO(testCustomerId, "CUSTTEST123", "Updated Name", "New Address", "0722222222", 150);
        boolean success = customerService.updateCustomer(testCustomerId, updated);
        assertTrue(success, "Customer should be updated");

        CustomerDTO result = customerService.getCustomerById(testCustomerId);
        assertEquals("Updated Name", result.getName());
        assertEquals("New Address", result.getAddress());
        assertEquals(150, result.getUnitsConsumed());
    }

    @Test
    @Order(4)
    void testGetAllCustomers() {
        List<CustomerDTO> customers = customerService.getAllCustomers();
        assertNotNull(customers);
        assertTrue(customers.size() > 0, "There should be at least one customer");
    }

    @Test
    @Order(5)
    void testDeleteCustomer() {
        boolean deleted = customerService.deleteCustomer(testCustomerId);
        assertTrue(deleted, "Customer should be deleted");

        CustomerDTO deletedCustomer = customerService.getCustomerById(testCustomerId);
        assertNull(deletedCustomer, "Deleted customer should not be found");
    }
}
