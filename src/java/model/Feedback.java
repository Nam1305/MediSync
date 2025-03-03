/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author DIEN MAY XANH
 */
public class Feedback {

    private int feedbackId;
    private int ratings;
    private String content;
    private Date date;
    private Staff staff;
    private Customer customer;

    public Feedback() {
    }

    public Feedback(int feedbackId, int ratings, String content, Date date, Staff staff, Customer customer) {
        this.feedbackId = feedbackId;
        this.ratings = ratings;
        this.content = content;
        this.date = date;
        this.staff = staff;
        this.customer = customer;
    }

    public int getFeedbackId() {
        return feedbackId;
    }

    public void setFeedbackId(int feedbackId) {
        this.feedbackId = feedbackId;
    }

    public int getRatings() {
        return ratings;
    }

    public void setRatings(int ratings) {
        this.ratings = ratings;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Staff getStaff() {
        return staff;
    }

    public void setStaff(Staff staff) {
        this.staff = staff;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    @Override
    public String toString() {
        return "Feedback{" + "feedbackId=" + feedbackId + ", ratings=" + ratings + ", content=" + content + ", date=" + date + ", staff=" + staff + ", customer=" + customer + '}';
    }
    
    
    

}
