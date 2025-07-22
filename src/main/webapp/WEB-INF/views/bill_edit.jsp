<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.uni.dto.BillDTO" %>
<%@ page import="com.uni.dto.BillItemDTO" %>
<%@ page import="com.uni.dto.ItemDTO" %>
<%@ page import="java.util.List" %>
<html>
<head>
  <title>Edit Bill - Pahan Edu</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css" />
  <script>
    <%
      // This script block is used to generate the item options dynamically
      List<ItemDTO> items = (List<ItemDTO>) request.getAttribute("items");
      %>
    const itemOptionsHTML = `
    <% for (ItemDTO i : items) { %>
      <option value="<%= i.getId() %>"><%= i.getName() %></option>
    <% } %>
  `.trim();

    function calculateTotal() {
      const table = document.getElementById("itemsTable");
      const rows = table.querySelectorAll("tr:not(:first-child)");
      let grandTotal = 0;

      rows.forEach(row => {
        const qtyInput = row.querySelector("input[name='quantities[]']");
        const priceInput = row.querySelector("input[name='unitPrices[]']");
        const lineTotalInput = row.querySelector("input[name='lineTotals[]']");

        const quantity = parseFloat(qtyInput.value) || 0;
        const unitPrice = parseFloat(priceInput.value) || 0;
        const lineTotal = quantity * unitPrice;

        lineTotalInput.value = lineTotal.toFixed(2);
        grandTotal += lineTotal;
      });

      document.getElementById("totalAmount").innerText = grandTotal.toFixed(2);
      document.getElementById("totalPrice").value = grandTotal.toFixed(2);
    }

    function addRow() {
      const table = document.getElementById("itemsTable");
      const row = table.insertRow();

      // 1. Create item <select>
      const select = document.createElement("select");
      select.name = "itemIds[]";
      select.onchange = calculateTotal;

      // Copy options from hidden template
      const template = document.getElementById("itemOptions");
      select.innerHTML = template.innerHTML;

      // 2. Create quantity <input>
      const quantity = document.createElement("input");
      quantity.type = "number";
      quantity.name = "quantities[]";
      quantity.min = 1;
      quantity.value = 1;
      quantity.required = true;
      quantity.oninput = calculateTotal;
      quantity.onchange = calculateTotal;

      // 3. Create unit price <input>
      const unitPrice = document.createElement("input");
      unitPrice.type = "number";
      unitPrice.name = "unitPrices[]";
      unitPrice.step = "0.01";
      unitPrice.value = "0.00";
      unitPrice.required = true;
      unitPrice.oninput = calculateTotal;
      unitPrice.onchange = calculateTotal;

      // 4. Create line total <input> (readonly)
      const lineTotal = document.createElement("input");
      lineTotal.type = "number";
      lineTotal.name = "lineTotals[]";
      lineTotal.step = "0.01";
      lineTotal.value = "0.00";
      lineTotal.readOnly = true;

      // 5. Create remove button
      const removeBtn = document.createElement("button");
      removeBtn.type = "button";
      removeBtn.innerText = "Remove";
      removeBtn.onclick = function () {
        table.deleteRow(row.rowIndex);
        calculateTotal();
      };

      // 6. Append all to row
      row.insertCell().appendChild(select);
      row.insertCell().appendChild(quantity);
      row.insertCell().appendChild(unitPrice);
      row.insertCell().appendChild(lineTotal);
      row.insertCell().appendChild(removeBtn);

      calculateTotal();
    }

    function removeRow(button) {
      const row = button.parentNode.parentNode;
      row.parentNode.removeChild(row);
      calculateTotal(); // recalculate after removing
    }

    window.onload = function () {
      calculateTotal(); // recalculate on page load
    };
  </script>
</head>
<body>
<%
  String error = (String) request.getAttribute("error");
  if (error != null && !error.isEmpty()) {
%>
<div class="error"><%= error %></div>
<%
  }

  BillDTO bill = (BillDTO) request.getAttribute("bill");
  List<ItemDTO> billItems = (List<ItemDTO>) request.getAttribute("billItems");

  if (bill == null || billItems == null) {
%>
<div class="error">No bill data found.</div>
<%
} else {
%>

<h1>Edit Bill</h1>

<form action="<%= request.getContextPath() %>/bills" method="post" onchange="calculateTotal()">
  <input type="hidden" name="action" value="update" />
  <input type="hidden" name="id" value="<%= bill.getId() %>" />

  <label>Customer ID:
    <input type="number" name="customerId" value="<%= bill.getCustomerId() %>" required />
  </label><br />

  <label>Billing Date:
    <input type="date" name="billingDate" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(bill.getBillingDate()) %>" required />
  </label><br />

  <label>Status:
    <input type="text" name="status" value="<%= bill.getStatus() %>" required />
  </label><br />

  <h3>Items</h3>
  <table border="1" id="itemsTable">
    <tr>
      <th>Item</th>
      <th>Quantity</th>
      <th>Unit Price</th>
      <th>Line Total</th>
      <th>Action</th>
    </tr>

    <%
      for (BillItemDTO item : bill.getItems()) {
    %>
    <tr>
      <td>
        <select name="itemIds[]">
          <%
            for (ItemDTO i : items) {
              String selected = (i.getId() == item.getItemId()) ? "selected" : "";
          %>
          <option value="<%= i.getId() %>" <%= selected %>><%= i.getName() %></option>
          <%
            }
          %>
        </select>
      </td>
      <td><input type="number" name="quantities[]" value="<%= item.getQuantity() %>" min="1" required /></td>
      <td><input type="number" name="unitPrices[]" value="<%= item.getUnitPrice() %>" step="0.01" required /></td>
      <td><input type="number" name="lineTotals[]" value="<%= item.getLineTotal() %>" step="0.01" readonly /></td>
      <td><button type="button" onclick="removeRow(this)">Remove</button></td>
    </tr>
    <%
      }
    %>
  </table>

  <br><br>
  <strong>Total: Rs. <span id="totalAmount"><%= bill.getTotalAmount()%></span></strong>
  <br><br>
  <input type="hidden" name="totalAmount" id="totalPrice" value="<%= bill.getTotalAmount() %>" />

  <button type="button" onclick="addRow()">Add Item</button><br /><br />
  <button type="submit">Update Bill</button>
</form>

<div id="itemOptions" style="display:none">
  <%
    for (ItemDTO i : items) {
  %>
  <option value="<%= i.getId() %>"><%= i.getName() %></option>
  <%
    }
  %>
</div>

<%
  }
%>

<br />
<a href="<%= request.getContextPath() %>/bills">← Back to Bill List</a>
</body>
</html>
