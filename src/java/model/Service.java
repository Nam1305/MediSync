package model;

import dal.AppointmentDAO;
import java.sql.*;

public class Service {

    private int serviceId;
    private String content;
    private double price;
    private String name;

    AppointmentDAO appDao = new AppointmentDAO();

    public Service() {
    }

    public Service(int serviceId, String name) {
        this.serviceId = serviceId;
        this.name = name;
    }

    public Service(int serviceId, String content, double price, String name) {
        this.serviceId = serviceId;
        this.content = content;
        this.price = price;
        this.name = name;
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

    @Override
    public String toString() {
        return "Service{id=" + serviceId + ", name='" + name + "'}";
    }

}
