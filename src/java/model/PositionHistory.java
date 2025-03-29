/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDate;
import java.util.Date;
/**
 *
 * @author Admin
 */

public class PositionHistory {
    private int positionId;
    private int staffId;
    private String position;
    private Date date;

    // Constructors
    public PositionHistory() {}

    public PositionHistory(int positionId, int staffId, String position, Date date) {
        this.positionId = positionId;
        this.staffId = staffId;
        this.position = position;
        this.date = date;
    }

    // Getters and Setters
    public int getPositionId() {
        return positionId;
    }

    public void setPositionId(int positionId) {
        this.positionId = positionId;
    }

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    @Override
    public String toString() {
        return "PositionHistory{" +
                "positionId=" + positionId +
                ", staffId=" + staffId +
                ", position='" + position + '\'' +
                ", date=" + date +
                '}';
    }
}
