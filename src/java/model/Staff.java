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
public class Staff {

     private int staffId;
    private String name;
    private String email;
    private String avatar;
    private String phone;
    private String password;
    private Date dateOfBirth;
    private String position;
    private String gender;
    private String status;
    private String description;
    private Department department;
    private Role role;
    private String certificate;
    
    public Staff() {
    }

    public Staff(int staffId, String name, String email, String avatar, String phone, String password, Date dateOfBirth, String position, String gender, String status, String description, Department department, Role role) {
        this.staffId = staffId;
        this.name = name;
        this.email = email;
        this.avatar = avatar;
        this.phone = phone;
        this.password = password;
        this.dateOfBirth = dateOfBirth;
        this.position = position;
        this.gender = gender;
        this.status = status;
        this.description = description;
        this.department = department;
        this.role = role;
    }
    
    public Staff(int staffId, String name, String email, String avatar, String phone, String password, Date dateOfBirth, String position, String gender, String status, String description, Department department, Role role, String certificate) {
        this.staffId = staffId;
        this.name = name;
        this.email = email;
        this.avatar = avatar;
        this.phone = phone;
        this.password = password;
        this.dateOfBirth = dateOfBirth;
        this.position = position;
        this.gender = gender;
        this.status = status;
        this.description = description;
        this.department = department;
        this.role = role;
        this.certificate = certificate;
    }

    public String getCertificate() {
        return certificate;
    }

    public void setCertificate(String certificate) {
        this.certificate = certificate;
    }

    

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
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

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    @Override
    public String toString() {
        return "Staff{" + "staffId=" + staffId + ", name=" + name + ", email=" + email + ", avatar=" + avatar + ", phone=" + phone + ", password=" + password + ", dateOfBirth=" + dateOfBirth + ", position=" + position + ", gender=" + gender + ", status=" + status + ", description=" + description + ", department=" + department + ", role=" + role + '}';
    }
    
    

}
