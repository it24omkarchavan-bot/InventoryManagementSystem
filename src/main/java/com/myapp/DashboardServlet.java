package com.myapp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private final InventoryDAO dao = new InventoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            req.setAttribute("productCount", dao.countProducts());
            req.setAttribute("totalUnits", dao.totalUnits());
            req.setAttribute("lowStock", dao.lowStockCount());
            req.setAttribute("outOfStock", dao.outOfStockCount());
            req.setAttribute("stockValue", dao.totalStockValue());
            req.setAttribute("items", dao.findAll("", ""));
            req.getRequestDispatcher("/dashboard.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException("Unable to load dashboard.", e);
        }
    }
}
