package com.uni.service;

import com.uni.dao.ItemDAO;
import com.uni.dto.ItemDTO;
import com.uni.model.Item;

import java.util.ArrayList;
import java.util.List;

public class ItemService {

    private final ItemDAO itemDAO = new ItemDAO();

    public boolean addItem(ItemDTO dto) {
        Item item = new Item();
        item.setCode(dto.getCode());
        item.setName(dto.getName());
        item.setCategory(dto.getCategory());
        item.setUnitPrice(dto.getUnitPrice());
        item.setStockQty(dto.getStockQty());
        return itemDAO.addItem(item);
    }

    public List<ItemDTO> getAllItems() {
        List<Item> items = itemDAO.getAllItems();
        List<ItemDTO> dtoList = new ArrayList<>();
        for (Item item : items) {
            dtoList.add(mapToDTO(item));
        }
        return dtoList;
    }

    public ItemDTO getItemById(int id) {
        Item item = itemDAO.getItemById(id);
        return item != null ? mapToDTO(item) : null;
    }

    public boolean updateItem(ItemDTO dto) {
        Item item = new Item();
        item.setId(dto.getId());
        item.setName(dto.getName());
        item.setCategory(dto.getCategory());
        item.setUnitPrice(dto.getUnitPrice());
        item.setStockQty(dto.getStockQty());
        return itemDAO.updateItem(item);
    }

    public boolean deleteItem(int id) {
        return itemDAO.deleteItem(id);
    }

    private ItemDTO mapToDTO(Item item) {
        ItemDTO dto = new ItemDTO();
        dto.setId(item.getId());
        dto.setCode(item.getCode());
        dto.setName(item.getName());
        dto.setCategory(item.getCategory());
        dto.setUnitPrice(item.getUnitPrice());
        dto.setStockQty(item.getStockQty());
        return dto;
    }
}
