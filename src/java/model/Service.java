<<<<<<< HEAD
package model;

import dal.AppointmentDAO;
import java.sql.*;

public class Service {

=======
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Acer
 */
public class Service {
>>>>>>> eb436c0f8b6bd5d32bbcaea78df325500939b8d3
    private int serviceId;
    private String content;
    private double price;
    private String name;
<<<<<<< HEAD

    AppointmentDAO appDao = new AppointmentDAO();
=======
    private String status;
>>>>>>> eb436c0f8b6bd5d32bbcaea78df325500939b8d3

    public Service() {
    }

<<<<<<< HEAD
    public Service(int serviceId, String name) {
        this.serviceId = serviceId;
        this.name = name;
    }

    public Service(int serviceId, String content, double price, String name) {
=======
    public Service(int serviceId, String content, double price, String name, String status) {
>>>>>>> eb436c0f8b6bd5d32bbcaea78df325500939b8d3
        this.serviceId = serviceId;
        this.content = content;
        this.price = price;
        this.name = name;
<<<<<<< HEAD
=======
        this.status = status;
>>>>>>> eb436c0f8b6bd5d32bbcaea78df325500939b8d3
    }

    public int getServiceId() {
        return serviceId;
    }

    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

<<<<<<< HEAD
    @Override
    public String toString() {
        return "Service{id=" + serviceId + ", name='" + name + "'}";
    }

=======
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
>>>>>>> eb436c0f8b6bd5d32bbcaea78df325500939b8d3
}
