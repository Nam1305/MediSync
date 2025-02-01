
package model;
import java.sql.*;

public class Customer {
    private int customerId;
    private String name;
    private String avatar;
    private String email;
    private String password;
    private String address;
    private Date dateOfBirth;
    private String bloodType;
    private String gender;
    private String status;
    private String phone;

    public Customer() {
    }
    
      public Customer(int id) {
          this.customerId = id;
    }

    public Customer(int customerId, String name, String avatar, String email, String password, String address, Date dateOfBirth, String bloodType, String gender, String status, String phone) {
        this.customerId = customerId;
        this.name = name;
        this.avatar = avatar;
        this.email = email;
        this.password = password;
        this.address = address;
        this.dateOfBirth = dateOfBirth;
        this.bloodType = bloodType;
        this.gender = gender;
        this.status = status;
        this.phone = phone;
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

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getBloodType() {
        return bloodType;
    }

    public void setBloodType(String bloodType) {
        this.bloodType = bloodType;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPhoneNumber() {
        return phone;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phone = phoneNumber;
    }

    @Override
    public String toString() {
        return "Customer{" + "customerId=" + customerId + ", name=" + name + ", avatar=" + avatar + ", email=" + email + ", password=" + password + ", address=" + address + ", dateOfBirth=" + dateOfBirth + ", bloodType=" + bloodType + ", gender=" + gender + ", status=" + status + ", phone=" + phone + '}';
    }


}
