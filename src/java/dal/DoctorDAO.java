/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Staff;

/**
 *
 * @author Acer
 */
public class DoctorDAO extends DBContext {

    DepartmentDAO departDao = new DepartmentDAO();
    RoleDAO roleDao = new RoleDAO();

    public List<Staff> getAllDoctor() {
        List<Staff> listDoctor = new ArrayList<>();
        String sql = "select * from Staff \n"
                + "where roleId = 2";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Staff doctor = new Staff();
                doctor.setStaffId(rs.getInt(1));
                doctor.setName(rs.getString(2));
                doctor.setEmail(rs.getString(3));
                doctor.setPhone(rs.getString(4));
                doctor.setPassword(rs.getString(5));
                doctor.setDateOfBirth(rs.getDate(6));
                doctor.setPosition(rs.getString(7));
                doctor.setGender(rs.getString(8));
                doctor.setStatus(rs.getString(9));
                doctor.setDepartment(departDao.getDepartmentById(rs.getInt(10)));
                doctor.setRole(roleDao.getRoleById(rs.getInt(11)));
                listDoctor.add(doctor);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listDoctor;
    }

//    public static void main(String[] args) {
//        DoctorDAO doctor = new DoctorDAO();
//        System.out.println(doctor.getAllDoctor());
//        
//    }
}
