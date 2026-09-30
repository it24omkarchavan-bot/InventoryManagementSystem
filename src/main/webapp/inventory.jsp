<%@ page import="java.util.List" %>
<%@ page import="com.myapp.InventoryItem" %>
<%
List<InventoryItem> items=(List<InventoryItem>)request.getAttribute("items");
List<String> categories=(List<String>)request.getAttribute("categories");
String search=request.getParameter("search")==null?"":request.getParameter("search");
String selected=request.getParameter("category")==null?"All":request.getParameter("category");
String message=request.getParameter("message");
%>
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"><title>Inventory | StockFlow</title><link rel="stylesheet" href="css/style.css"></head>
<body>
<div class="app-shell">
<aside class="sidebar">
<div class="brand"><div class="brand-icon">SF</div><div><strong>StockFlow</strong><span>Inventory Suite</span></div></div>
<nav><a href="dashboard"><span>▦</span> Dashboard</a><a class="active" href="inventory"><span>▤</span> Inventory</a><a href="inventory?action=new"><span>＋</span> Add Product</a></nav>
<div class="side-footer"><span class="dot"></span> System Online</div>
</aside>
<main class="main">
<header class="topbar"><div><div class="eyebrow">PRODUCT CATALOG</div><h1>Inventory</h1></div><a class="primary-btn" href="inventory?action=new">＋ Add Product</a></header>
<% if(message!=null){ %><div class="alert">✓ <%=message%></div><% } %>
<section class="panel filter-panel">
<form method="get" action="inventory" class="filter-form">
<div class="search-box"><span>⌕</span><input name="search" value="<%=search%>" placeholder="Search product, SKU or supplier..."></div>
<select name="category"><option>All</option><%for(String c:categories){%><option <%=c.equals(selected)?"selected":""%>><%=c%></option><%}%></select>
<button class="primary-btn" type="submit">Filter</button>
<a class="secondary-btn" href="inventory">Reset</a>
</form>
</section>
<section class="panel">
<div class="panel-head"><div><h3>All Products</h3><p><%=items.size()%> product(s) found</p></div></div>
<div class="table-wrap">
<table>
<thead><tr><th>PRODUCT</th><th>SKU</th><th>CATEGORY</th><th>QTY</th><th>REORDER</th><th>PRICE</th><th>SUPPLIER</th><th>STATUS</th><th>ACTIONS</th></tr></thead>
<tbody>
<%for(InventoryItem item:items){%>
<tr>
<td><strong><%=item.getName()%></strong></td><td><%=item.getSku()%></td><td><%=item.getCategory()%></td><td><strong><%=item.getQuantity()%></strong></td><td><%=item.getReorderLevel()%></td><td>₹ <%=String.format("%,.2f",item.getPrice())%></td><td><%=item.getSupplier()%></td>
<td><span class="badge <%=item.getStatus().toLowerCase().replace(" ","-")%>"><%=item.getStatus()%></span></td>
<td class="actions"><a href="inventory?action=edit&id=<%=item.getId()%>">Edit</a><form method="post" action="inventory" onsubmit="return confirm('Delete this product?')"><input type="hidden" name="action" value="delete"><input type="hidden" name="id" value="<%=item.getId()%>"><button class="link-danger" type="submit">Delete</button></form></td>
</tr>
<%}%>
</tbody></table>
</div></section>
<footer>StockFlow Inventory Management System · Java + JSP + Servlet + MySQL</footer>
</main></div>
</body></html>
