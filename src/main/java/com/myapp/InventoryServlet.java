package com.myapp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/inventory")
public class InventoryServlet extends HttpServlet {
    private final InventoryDAO dao = new InventoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String action = req.getParameter("action");
            if ("edit".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("item", dao.findById(id));
                req.getRequestDispatcher("/edit.jsp").forward(req, resp);
                return;
            }
            req.setAttribute("items", dao.findAll(req.getParameter("search"), req.getParameter("category")));
            req.setAttribute("categories", dao.getCategories());
            req.getRequestDispatcher("/inventory.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException("Unable to load inventory.", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        try {
            if ("add".equals(action)) {
                dao.insert(readItem(req));
                resp.sendRedirect("inventory?message=Product+added+successfully");
            } else if ("update".equals(action)) {
                InventoryItem item = readItem(req);
                item.setId(Integer.parseInt(req.getParameter("id")));
                dao.update(item);
                resp.sendRedirect("inventory?message=Product+updated+successfully");
            } else if ("delete".equals(action)) {
                dao.delete(Integer.parseInt(req.getParameter("id")));
                resp.sendRedirect("inventory?message=Product+deleted");
            } else {
                resp.sendRedirect("inventory");
            }
        } catch (Exception e) {
            throw new ServletException("Inventory operation failed.", e);
        }
    }

    private InventoryItem readItem(HttpServletRequest req) {
        InventoryItem p = new InventoryItem();
        p.setName(req.getParameter("name"));
        p.setSku(req.getParameter("sku"));
        p.setCategory(req.getParameter("category"));
        p.setQuantity(Integer.parseInt(req.getParameter("quantity")));
        p.setReorderLevel(Integer.parseInt(req.getParameter("reorderLevel")));
        p.setPrice(Double.parseDouble(req.getParameter("price")));
        p.setSupplier(req.getParameter("supplier"));
        return p;
    }
}
