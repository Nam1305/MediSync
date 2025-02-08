/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

/**
 *
 * @author DIEN MAY XANH
 */
public class Validation {

    public boolean validatePassword(String str) {
        //check length of string
        if (str.length() < 6) {
            return false;
        }

        boolean hasUpperCase = false;
        boolean hasLowerCase = false;
        boolean hasDigit = false;
        boolean hasSpecialChar = false;

        // Iterate through each character in the string
        for (char c : str.toCharArray()) {
            if (Character.isUpperCase(c)) {
                hasUpperCase = true;
            } else if (Character.isLowerCase(c)) {
                hasLowerCase = true;
            } else if (Character.isDigit(c)) {
                hasDigit = true;
            } else {
                hasSpecialChar = true;
            }
        }

        return hasUpperCase && hasLowerCase && hasDigit && hasSpecialChar;
    }

    public String normalizeFullName(String fullName) {
        fullName = fullName.trim();

        String[] nameParts = fullName.split("\\s+");

        StringBuilder normalizedName = new StringBuilder();

        for (int i = 0; i < nameParts.length; i++) {
            String part = nameParts[i].substring(0, 1).toUpperCase() + nameParts[i].substring(1).toLowerCase();

            if (i < nameParts.length - 1) {
                part += " ";
            }

            normalizedName.append(part);
        }

        return normalizedName.toString();
    }
}
