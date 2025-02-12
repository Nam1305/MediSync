package util;

import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class GeneratePassword {

    private static final String PASSWORD_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()-_+=<>?";

    private static final String UPPERCASE = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    private static final String LOWERCASE = "abcdefghijklmnopqrstuvwxyz";
    private static final String DIGITS = "0123456789";
    private static final String SPECIAL_CHARACTERS = "!@#$%^&*()-_+=<>?";
    private static final String ALL_CHARACTERS = UPPERCASE + LOWERCASE + DIGITS + SPECIAL_CHARACTERS;

    public String generateRandomPassword(int length) {
        if (length < 8) {
            throw new IllegalArgumentException("Độ dài mật khẩu phải lớn hơn hoặc bằng 3");
        }

        SecureRandom random = new SecureRandom();
        List<Character> password = new ArrayList<>();
        //Đảm bảo password có ít nhất 1 số, 1 chữ hoa, 1 chữ thường, 1 số, 1 kí tự đặc biệt

        //chữ hoa
        password.add(UPPERCASE.charAt(random.nextInt(UPPERCASE.length())));

        //chữ thường
        password.add(LOWERCASE.charAt(random.nextInt(LOWERCASE.length())));

        //số
        password.add(DIGITS.charAt(random.nextInt(DIGITS.length())));

        //kí tự đặc biệt
        password.add(SPECIAL_CHARACTERS.charAt(random.nextInt(SPECIAL_CHARACTERS.length())));

        //thêm các kí tự còn lại ngẫu nhiên
        for (int i = 4; i < length; i++) {
            password.add(ALL_CHARACTERS.charAt(random.nextInt(ALL_CHARACTERS.length())));
        }

        // Xáo trộn mật khẩu để không bị đoán được vị trí ký tự đảm bảo
        Collections.shuffle(password, random);

        // Chuyển danh sách thành chuỗi
        StringBuilder passwordStr = new StringBuilder();
        for (char c : password) {
            passwordStr.append(c);
        }
        
        return passwordStr.toString();

    }

    public static void main(String[] args) {
        GeneratePassword genPass = new GeneratePassword();
        String pass = genPass.generateRandomPassword(8);
        System.out.println(pass);
    }
}
