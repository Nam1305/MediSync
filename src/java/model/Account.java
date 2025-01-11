/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author Admin
 */
public class Account {
    private int accountID;
    private String email;
    private String passWord;
    private int status;
    private int role;

    public Account() {
    }

    public Account(int accountID, String email, String passWord, int status, int role) {
        this.accountID = accountID;
        this.email = email;
        this.passWord = passWord;
        this.status = status;
        this.role = role;
    }
    
    

    public int getAccountID() {
        return accountID;
    }
    
    

    public void setAccountID(int accountID) {
        this.accountID = accountID;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassWord() {
        return passWord;
    }

    public void setPassWord(String passWord) {
        this.passWord = passWord;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

    @Override
    public String toString() {
        return "Account{" + "accountID=" + accountID + ", email=" + email + ", passWord=" + passWord + ", status=" + status + ", role=" + role + '}';
    }
    
    
    
    
}
