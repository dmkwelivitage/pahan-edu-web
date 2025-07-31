package com.uni.test;

import com.uni.dto.BillDTO;
import com.uni.dto.BillItemDTO;
import com.uni.service.BillService;
import org.junit.jupiter.api.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class BillServiceTest {

    private BillService billService;
    private int testBillId;

    @BeforeAll
    void setUp() {
        billService = new BillService();

        // Create initial test bill with 2 bill items
        BillDTO bill = new BillDTO();
        bill.setCustomerId(1); // assume this customer exists
        bill.setBillingDate(new Date());
        bill.setStatus("PAID");

        List<BillItemDTO> items = new ArrayList<>();
        items.add(new BillItemDTO(0, 0, 1, 2, 50.0, 100.0)); // itemId 1
        items.add(new BillItemDTO(0, 0, 2, 1, 150.0, 150.0)); // itemId 2

        bill.setItems(items);
        bill.setTotalAmount(250.0);

        boolean created = billService.addBill(bill);
        if (!created){
            fail();
        } else {
            List<BillDTO> bills = billService.getAllBills();
            for (BillDTO b : bills) {
                if (b.getCustomerId() == 1 && b.getTotalAmount() == 250.0) {
                    bill.setId(b.getId());
                    break;
                }
            }
        }
        assertTrue(bill.getId() > 0 , "Bill ID should be greater than 0. The Output: " +  bill.getId());
        testBillId = bill.getId();
    }

    @Test
    void testReadBill() {
        BillDTO fetched = billService.getBillById(testBillId);
        assertNotNull(fetched);
        assertEquals(testBillId, fetched.getId());
        assertEquals(2, fetched.getItems().size());
    }

    @Test
    void testUpdateBill() {
        BillDTO bill = billService.getBillById(testBillId);
        bill.setStatus("PENDING");
        bill.getItems().getFirst().setQuantity(5);
        bill.getItems().getFirst().setLineTotal(250.0);
        bill.setTotalAmount(400.0);

        boolean updated = billService.updateBill(bill.getId(), bill);
        assertTrue(updated);

        BillDTO updatedBill = billService.getBillById(testBillId);
        assertEquals("PENDING", updatedBill.getStatus());
//        assertEquals(5, updatedBill.getItems().getFirst().getQuantity());
        assertEquals(400.0, updatedBill.getTotalAmount());
    }

    @Test
    void testListBills() {
        List<BillDTO> bills = billService.getAllBills();
        assertNotNull(bills);
        assertFalse(bills.isEmpty());
    }

    @AfterAll
    void cleanUp() {
        // Delete the test bill after all tests
        boolean deleted = billService.deleteBill(testBillId);
        assertTrue(deleted);
        BillDTO deletedBill = billService.getBillById(testBillId);
        assertNull(deletedBill);
    }
}
