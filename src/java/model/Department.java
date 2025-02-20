/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author DIEN MAY XANH
 */

public class Department {
    private int departmentId;
    private String departmentName;
    private String status;
    public Department() {
    }

    public Department(int departmentId, String departmentName, String status) {
        this.departmentId = departmentId;
        this.departmentName = departmentName;
        this.status = status;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    

    public int getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(int departmentId) {
        this.departmentId = departmentId;
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }

    @Override
    public String toString() {
        return "Department{" + "departmentId=" + departmentId + ", departmentName=" + departmentName + ", status=" + status + '}';
    }
    
}
