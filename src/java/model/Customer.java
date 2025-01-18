/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.sql.*;
/**
 *
 * @author DIEN MAY XANH
 */
public class Customer {
    private int customerId;
    private String name, email, password, phone, address, bloodtype, gender;
    private Date dateOfBirth;
    private String status;

    public Customer() {
    }

    public Customer(int customerId, String name, String email, String password, String phone, String address, String bloodtype, String gender, Date dateOfBirth, String status) {
        this.customerId = customerId;
        this.name = name;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.address = address;
        this.bloodtype = bloodtype;
        this.gender = gender;
        this.dateOfBirth = dateOfBirth;
        this.status = status;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getBloodtype() {
        return bloodtype;
    }

    public void setBloodtype(String bloodtype) {
        this.bloodtype = bloodtype;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Customer{" + "customerId=" + customerId + ", name=" + name + ", email=" + email + ", password=" + password + ", phone=" + phone + ", address=" + address + ", bloodtype=" + bloodtype + ", gender=" + gender + ", dateOfBirth=" + dateOfBirth + ", status=" + status + '}';
    }
    
    

}
