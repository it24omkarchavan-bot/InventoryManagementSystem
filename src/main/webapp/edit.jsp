<%@ page import="com.myapp.InventoryItem" %>
<% InventoryItem item=(InventoryItem)request.getAttribute("item"); boolean edit=item!=null; %>
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"><title><%=edit?"Edit":"Add"%> Product | StockFlow</title><link rel="stylesheet" href="css/style.css"></head>
<body>
<div class="app-shell">
<aside class="sidebar">
<div class="brand"><div class="brand-icon">SF</div><div><strong>StockFlow</strong><span>Inventory Suite</span></div></div>
<nav><a href="dashboard"><span>▦</span> Dashboard</a><a href="inventory"><span>▤</span> Inventory</a><a class="active" href="inventory?action=new"><span>＋</span> Add Product</a></nav>
<div class="side-footer"><span class="dot"></span> System Online</div>
</aside>
<main class="main">
<header class="topbar"><div><div class="eyebrow">PRODUCT MANAGEMENT</div><h1><%=edit?"Edit Product":"Add Product"%></h1></div><a class="secondary-btn" href="inventory">← Back to Inventory</a></header>
<section class="form-layout">
<div class="panel form-panel">
<div class="panel-head"><div><h3><%=edit?"Update product details":"Create a new product"%></h3><p>Enter accurate stock information below.</p></div></div>
<form method="post" action="inventory" class="product-form">
<input type="hidden" name="action" value="<%=edit?"update":"add"%>">
<%if(edit){%><input type="hidden" name="id" value="<%=item.getId()%>"><%}%>
<label>Product Name<input required name="name" value="<%=edit?item.getName():""%>" placeholder="e.g. Wireless Keyboard"></label>
<label>SKU<input required name="sku" value="<%=edit?item.getSku():""%>" placeholder="e.g. KB-1001"></label>
<label>Category<select required name="category"><%String[] cats={"Electronics","Accessories","Office","Furniture","Software","Other"};for(String c:cats){%><option <%=edit&&c.equals(item.getCategory())?"selected":""%>><%=c%></option><%}%></select></label>
<div class="two-col"><label>Quantity<input required type="number" min="0" name="quantity" value="<%=edit?item.getQuantity():0%>"></label><label>Reorder Level<input required type="number" min="0" name="reorderLevel" value="<%=edit?item.getReorderLevel():10%>"></label></div>
<div class="two-col"><label>Unit Price (₹)<input required type="number" min="0" step="0.01" name="price" value="<%=edit?item.getPrice():""%>" placeholder="0.00"></label><label>Supplier<input required name="supplier" value="<%=edit?item.getSupplier():""%>" placeholder="Supplier name"></label></div>
<div class="form-actions"><a class="secondary-btn" href="inventory">Cancel</a><button class="primary-btn" type="submit"><%=edit?"Save Changes":"Add Product"%></button></div>
</form>
</div>
<div class="panel tips"><h3>Inventory tips</h3><div class="tip"><b>SKU</b><span>Use a unique product code for quick identification.</span></div><div class="tip"><b>Reorder level</b><span>Set the minimum quantity that should trigger a restock.</span></div><div class="tip"><b>Price</b><span>Enter the current unit value in Indian Rupees.</span></div></div>
</section>
<footer>StockFlow Inventory Management System · Java + JSP + Servlet + MySQL</footer>
</main></div>
</body></html>
