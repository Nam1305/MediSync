/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDateTime;

/**
 *
 * @author DIEN MAY XANH
 */
public class VerifyCode {

    private String authCode;
    private LocalDateTime expiredTime;

    public VerifyCode(String authCode) {
        this.authCode = authCode;
        this.expiredTime = LocalDateTime.now().plusMinutes(5); // Mã hết hạn sau 5 phút
    }

    public String getAuthCode() {
        return authCode;
    }

    public boolean isExpired() {
        return LocalDateTime.now().isAfter(expiredTime);
    }
}
