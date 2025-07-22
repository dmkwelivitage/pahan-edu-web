<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, com.uni.dto.ItemDTO" %>
<%@ page import="com.uni.service.ItemService" %>
<html>
<head>
    <title>Create Bill - Pahan Edu</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css" />
    <script>
        function addItemRow() {
            var itemRow = document.getElementById("itemRowTemplate").cloneNode(true);
            itemRow.removeAttribute("id");
            itemRow.style.display = "";
            document.getElementById("itemsContainer").appendChild(itemRow);
        }

        function removeRow(btn) {
            btn.parentNode.parentNode.remove();
            calculateTotal();
        }

        function calculateTotal() {
            var rows = document.querySelectorAll("#itemsContainer .itemRow");
            let total = 0;
            rows.forEach(function(row) {
                const qty = parseFloat(row.querySelector("[name='quantities[]']").value) || 0;
                const price = parseFloat(row.querySelector("[name='unitPrices[]']").value) || 0;
                total += qty * price;
            });
            document.getElementById("totalAmount").innerText = total.toFixed(2);
            document.getElementById("totalPrice").value = total.toFixed(2);
        }
    </script>
</head>
<body>
<h1>Create New Bill</h1>

<%
    ItemService itemService = new ItemService();
    List<ItemDTO> itemList = itemService.getAllItems();
%>

<form action="<%= request.getContextPath() %>/bills" method="post" oninput="calculateTotal()">
    <input type="hidden" name="action" value="create" />

    <label>Customer ID:</label>
    <input type="text" name="customerId" required /><br><br>

    <label>Date:</label>
    <input type="date" name="billingDate" required /><br><br>

    <label>Status:</label>
    <select name="status">
        <option value="Pending">Pending</option>
        <option value="Paid">Paid</option>
    </select><br><br>

    <h3>Items</h3>
    <div id="itemsContainer">
        <!-- First Item Row -->
<%--        <div class="itemRow">--%>
<%--            <select name="itemIds[]">--%>
<%--                <% for (ItemDTO item : itemList) { %>--%>
<%--                <option value="<%= item.getId() %>"><%= item.getName() %></option>--%>
<%--                <% } %>--%>
<%--            </select>--%>
<%--            Quantity: <input type="number" name="quantities[]" step="1" value="1" />--%>
<%--            Unit Price: <input type="number" name="unitPrices[]" step="0.01" value="0.00" />--%>
<%--            <button type="button" onclick="removeRow(this)">Remove</button>--%>
<%--        </div>--%>
    </div>

    <br>
    <button type="button" onclick="addItemRow()">+ Add Item</button>

    <!-- Hidden Template Row -->
    <div id="itemRowTemplate" style="display:none;" class="itemRow">
        <select name="itemIds[]">
            <% for (ItemDTO item : itemList) { %>
            <option value="<%= item.getId() %>"><%= item.getName() %></option>
            <% } %>
        </select>
        Quantity: <input type="number" name="quantities[]" step="1" value="1" />
        Unit Price: <input type="number" name="unitPrices[]" step="0.01" value="0.00" />
        <button type="button" onclick="removeRow(this)">Remove</button>
    </div>

    <br><br>
    <strong>Total: Rs. <span id="totalAmount">0.00</span></strong>
    <br><br>
    <input type="hidden" name="totalAmount" id="totalPrice" value="0.00" />

    <input type="submit" value="Create Bill" />
</form>

<br>
<a href="<%= request.getContextPath() %>/bills">← Back to Bill List</a>
</body>
<%--<script>--%>
<%--    window.onload = function () {--%>
<%--        addItemRow(); // Add one item row by default--%>
<%--    };--%>
<%--</script>--%>
</html>
