/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author ADK_Altmile
 */
//Them boi Nguyen Dinh Chinh  1-2-25 

public class Blog {

    private int blogId;
    private String blogName;
    private String content;
    private String image;
    private String author;
    private Date date;

    // Constructor không tham số
    public Blog() {
    }

    // Constructor đầy đủ tham số
    public Blog(int blogId, String blogName, String content, String image, String author, Date date) {
        this.blogId = blogId;
        this.blogName = blogName;
        this.content = content;
        this.image = image;
        this.author = author;
        this.date = date;
    }

    // Getter và Setter
    public int getBlogId() {
        return blogId;
    }

    public void setBlogId(int blogId) {
        this.blogId = blogId;
    }

    public String getBlogName() {
        return blogName;
    }

    public void setBlogName(String blogName) {
        this.blogName = blogName;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    // toString để debug nhanh
    @Override
    public String toString() {
        return "Blog{"
                + "blogId=" + blogId
                + ", blogName='" + blogName + '\''
                + ", content='" + content + '\''
                + ", image='" + image + '\''
                + ", author='" + author + '\''
                + ", date=" + date
                + '}';
    }
}
