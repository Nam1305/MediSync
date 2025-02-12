/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author Admin
 */
public class Comment {
    private int commentId;
    private String content;
    private Date date;
    private int blogId;
    private int customerId;
    private String name;
    private String avatar;
    
    
    public Comment() {
    }

    public Comment(int commentId, String content, Date date, int blogId, int customerId, String name, String avatar) {
        this.commentId = commentId;
        this.content = content;
        this.date = date;
        this.blogId = blogId;
        this.customerId = customerId;
        this.name = name;
        this.avatar = avatar;
    }

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
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

    public int getBlogId() {
        return blogId;
    }

    public void setBlogId(int blogId) {
        this.blogId = blogId;
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
    
    
    @Override
    public String toString() {
        return "Comment{" + "commentId=" + commentId + ", content='" + content + '\'' + ", date=" + date + ", blogId=" + blogId + ", customerId=" + customerId +", name=" + name +", avatar=" +avatar +'}';
    }
    
}
