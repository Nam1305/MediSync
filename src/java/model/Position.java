/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author Acer
 */
public class Position {
    private int positionId;
    private String position;
    private Date date;

    public Position() {
    }

    public Position(int positionId, String position, Date date) {
        this.positionId = positionId;
        this.position = position;
        this.date = date;
    }

    public int getPositionId() {
        return positionId;
    }

    public void setPositionId(int positionId) {
        this.positionId = positionId;
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
        return "Position{" + "positionId=" + positionId + ", position=" + position + ", date=" + date + '}';
    }
    
    
}
