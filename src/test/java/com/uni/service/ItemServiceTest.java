package com.uni.service;

import com.uni.dao.ItemDAO;
import com.uni.dto.ItemDTO;
import com.uni.model.Item;
import org.junit.jupiter.api.*;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class ItemServiceTest {

    private ItemService itemService;
    private ItemDAO itemDAO;
    private Item testItem;

    @BeforeEach
    void setUp() {
        itemService = new ItemService();
        itemDAO = new ItemDAO();

        testItem = new Item();
        testItem.setCode("DTO-CODE");
        testItem.setName("DTO Name");
        testItem.setCategory("DTO Category");
        testItem.setUnitPrice(25.5);
        testItem.setStockQty(30);
        itemDAO.addItem(testItem);
    }

    @AfterEach
    void tearDown() {
        Item toDelete = itemDAO.getItemByCode("DTO-CODE");
        if (toDelete != null) {
            itemDAO.deleteItem(toDelete.getId());
        }
    }

    @Test
    void testGetAllItemDTOs() {
        List<ItemDTO> itemDTOs = itemService.getAllItems();
        assertFalse(itemDTOs.isEmpty());
        assertTrue(itemDTOs.stream().anyMatch(dto -> "DTO-CODE".equals(dto.getCode())));
    }

    @Test
    void testGetItemDTOById() {
        Item saved = itemDAO.getItemByCode("DTO-CODE");
        ItemDTO dto = itemService.getItemById(saved.getId());
        assertNotNull(dto);
        assertEquals("DTO-CODE", dto.getCode());
    }
}
