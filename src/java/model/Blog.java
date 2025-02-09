// Blog.java
package model;

import java.sql.Date;

public class Blog {
    private int blogId;
    private String blogName;
    private String content;
    private String image;
    private String author;
    private Date date;
    private int typeId;
    private int selectedBanner;

    // Default constructor
    public Blog() {
    }

    public Blog(int blogId, String blogName, String content, String image, String author, Date date, int typeId, int selectedBanner) {
        this.blogId = blogId;
        this.blogName = blogName;
        this.content = content;
        this.image = image;
        this.author = author;
        this.date = date;
        this.typeId = typeId;
        this.selectedBanner = selectedBanner;
    }

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

    public int getTypeId() {
        return typeId;
    }

    public void setTypeId(int typeId) {
        this.typeId = typeId;
    }

    public int getSelectedBanner() {
        return selectedBanner;
    }

    public void setSelectedBanner(int selectedBanner) {
        this.selectedBanner = selectedBanner;
    }

    @Override
    public String toString() {
        return "Blog{" + "blogId=" + blogId + ", blogName=" + blogName + ", content=" + content + ", image=" + image + ", author=" + author + ", date=" + date + ", typeId=" + typeId + ", selectedBanner=" + selectedBanner + '}';
    }

    
}