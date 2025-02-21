/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.doctor;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.google.gson.JsonObject;
import jakarta.servlet.http.Part;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

/**
 *
 * @author DIEN MAY XANH
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)
public class TinyMCEUploadImage extends HttpServlet {

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String uploadFolder = request.getServletContext().getRealPath("/uploads");
        Path uploadPath = Paths.get(uploadFolder);

        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }

        Part imagePart = request.getPart("file");

        if (imagePart == null || imagePart.getSize() == 0) {
            sendJsonResponse(response, false, "Không có tệp nào được chọn.");
            return;
        }

        if (imagePart.getSize() > 10 * 1024 * 1024) {
            sendJsonResponse(response, false, "Dung lượng ảnh không được phép vượt quá 10MB.");
            return;
        }

        String imageFilename = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
        String fileExtension = "";
        int dotIndex = imageFilename.lastIndexOf('.');

        if (dotIndex > 0 && dotIndex < imageFilename.length() - 1) {
            fileExtension = imageFilename.substring(dotIndex + 1).toLowerCase();
        }

        if (!fileExtension.toLowerCase().matches("jpg|jpeg|png|dcm")) {
            sendJsonResponse(response, false, "Định dạng tệp không hợp lệ. Chỉ cho phép: .jpg, .jpeg, .png, .dcm");
            return;
        }

        imageFilename = System.currentTimeMillis() + "_" + imageFilename;
        Path filePath = uploadPath.resolve(imageFilename);
        imagePart.write(filePath.toString());

        String imageUrl = request.getContextPath() + "/uploads/" + imageFilename;
        sendJsonResponse(response, true, imageUrl);
    }

    private void sendJsonResponse(HttpServletResponse response, boolean success, String message) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        JsonObject json = new JsonObject();
        json.addProperty("success", success);
        json.addProperty(success ? "location" : "message", message);
        response.getWriter().write(json.toString());
    }

}
