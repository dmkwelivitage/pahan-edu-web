<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.uni.dto.ItemDTO" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>Items - Pahan Edu</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css" />
</head>
<body>

<div class="item-container">
    <h2>Item List</h2>

    <table class="item-table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Code</th>
            <th>Name</th>
            <th>Category</th>
            <th>Unit Price</th>
            <th>Stock Qty</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<ItemDTO> items = (List<ItemDTO>) request.getAttribute("items");
            if (items != null) {
                for (ItemDTO item : items) {
        %>
        <tr>
            <td><%= item.getId() %></td>
            <td><%= item.getCode() %></td>
            <td><%= item.getName() %></td>
            <td><%= item.getCategory() %></td>
            <td><%= item.getUnitPrice() %></td>
            <td><%= item.getStockQty() %></td>
            <td>
                <div class="action-buttons">
                    <a class="edit-button" style="display: inline; text-decoration: none" href="<%= request.getContextPath() %>/items?id=<%= item.getId() %>">Edit</a>
                    <form action="<%= request.getContextPath() %>/items" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="delete"/>
                        <input type="hidden" name="id" value="<%= item.getId() %>"/>
                        <button class="delete-button" type="submit" onclick="return confirm('Delete this item?');">Delete</button>
                    </form>
                </div>
            </td>
        </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>

    <h2 class="center">Add New Item</h2>
    <form class="item-form" action="<%= request.getContextPath() %>/items" method="post">
        <input type="hidden" name="action" value="add"/>
        <label>Code:
            <input type="text" name="code" required/>
        </label>
        <label>Name:
            <input type="text" name="name" required/>
        </label>
        <label>Category:
            <input type="text" name="category"/>
        </label>
        <label>Unit Price:
            <input type="number" name="unitPrice" step="0.01" min="0" required/>
        </label>
        <label>Stock Qty:
            <input type="number" name="stockQty" min="0" required/>
        </label>
        <button type="submit">Add Item</button>
    </form>
</div>

</body>
</html>
