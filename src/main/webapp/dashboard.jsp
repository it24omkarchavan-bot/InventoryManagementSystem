<%@ page import="java.util.List" %>
<%@ page import="com.myapp.InventoryItem" %>
<%
    int productCount = (Integer) request.getAttribute("productCount");
    int totalUnits = (Integer) request.getAttribute("totalUnits");
    int lowStock = (Integer) request.getAttribute("lowStock");
    int outOfStock = (Integer) request.getAttribute("outOfStock");
    double stockValue = (Double) request.getAttribute("stockValue");
    List<InventoryItem> items = (List<InventoryItem>) request.getAttribute("items");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dashboard | StockFlow</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="app-shell">
<aside class="sidebar">
    <div class="brand"><div class="brand-icon">SF</div><div><strong>StockFlow</strong><span>Inventory Suite</span></div></div>
    <nav>
        <a class="active" href="dashboard"><span>▦</span> Dashboard</a>
        <a href="inventory"><span>▤</span> Inventory</a>
        <a href="inventory?action=new"><span>＋</span> Add Product</a>
    </nav>
    <div class="side-footer"><span class="dot"></span> System Online</div>
</aside>

<main class="main">
<header class="topbar">
    <div><div class="eyebrow">INVENTORY MANAGEMENT</div><h1>Dashboard</h1></div>
    <a class="primary-btn" href="inventory?action=new">＋ Add Product</a>
</header>

<section class="welcome">
    <div><div class="eyebrow light">STOCK OVERVIEW</div><h2>Stay in control of your inventory.</h2><p>Monitor products, stock levels and inventory value from one place.</p></div>
    <div class="hero-badge">LIVE<br><strong>DATA</strong></div>
</section>

<section class="stats">
    <div class="stat-card"><div class="stat-label">TOTAL PRODUCTS</div><div class="stat-value"><%=productCount%></div><div class="stat-note">Unique products</div></div>
    <div class="stat-card"><div class="stat-label">TOTAL UNITS</div><div class="stat-value"><%=totalUnits%></div><div class="stat-note">Units in inventory</div></div>
    <div class="stat-card warning"><div class="stat-label">LOW STOCK</div><div class="stat-value"><%=lowStock%></div><div class="stat-note">Needs attention</div></div>
    <div class="stat-card danger"><div class="stat-label">OUT OF STOCK</div><div class="stat-value"><%=outOfStock%></div><div class="stat-note">Immediate action</div></div>
</section>

<section class="content-grid">
<div class="panel">
    <div class="panel-head"><div><h3>Inventory Value</h3><p>Current value of all available stock</p></div><strong class="money">₹ <%=String.format("%,.2f", stockValue)%></strong></div>
    <div class="value-bar"><span style="width: 72%"></span></div>
    <div class="mini-row"><span>Stock valuation</span><span>Based on quantity × unit price</span></div>
</div>
<div class="panel quick">
    <h3>Quick actions</h3>
    <a href="inventory?action=new">＋ Add new product</a>
    <a href="inventory">→ View all inventory</a>
    <a href="inventory?category=All">⌕ Search inventory</a>
</div>
</section>

<section class="panel">
<div class="panel-head"><div><h3>Recent Inventory</h3><p>Latest products in your catalog</p></div><a class="text-btn" href="inventory">View all →</a></div>
<div class="table-wrap">
<table>
<thead><tr><th>PRODUCT</th><th>SKU</th><th>CATEGORY</th><th>QTY</th><th>PRICE</th><th>STATUS</th></tr></thead>
<tbody>
<% int shown=0; for(InventoryItem item: items){ if(shown++>=6) break; %>
<tr><td><strong><%=item.getName()%></strong><small><%=item.getSupplier()%></small></td><td><%=item.getSku()%></td><td><%=item.getCategory()%></td><td><%=item.getQuantity()%></td><td>₹ <%=String.format("%,.2f",item.getPrice())%></td><td><span class="badge <%=item.getStatus().toLowerCase().replace(" ","-")%>"><%=item.getStatus()%></span></td></tr>
<% } %>
</tbody>
</table>
</div>
</section>
<footer>StockFlow Inventory Management System · Java + JSP + Servlet + MySQL</footer>
</main>
</div>
</body>
</html>
