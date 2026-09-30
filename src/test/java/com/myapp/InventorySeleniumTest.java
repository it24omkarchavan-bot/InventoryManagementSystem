package com.myapp;

import org.junit.jupiter.api.*;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

import static org.junit.jupiter.api.Assertions.assertTrue;

public class InventorySeleniumTest {
    private WebDriver driver;

    @BeforeEach
    void setUp() {
        driver = new ChromeDriver();
    }

    @Test
    void dashboardLoads() {
        driver.get("http://localhost:8081/InventoryManagementSystem/dashboard");
        assertTrue(driver.getTitle().contains("Dashboard"));
        assertTrue(driver.getPageSource().contains("StockFlow"));
    }

    @Test
    void inventoryPageLoads() {
        driver.get("http://localhost:8081/InventoryManagementSystem/inventory");
        assertTrue(driver.getTitle().contains("Inventory"));
        assertTrue(driver.findElement(By.cssSelector("table")).isDisplayed());
    }

    @AfterEach
    void tearDown() {
        if (driver != null) driver.quit();
    }
}
