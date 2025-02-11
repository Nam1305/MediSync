<%-- 
    Document   : staffDetail
    Created on : Feb 10, 2025, 10:11:21 PM
    Author     : Acer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Staff Detail</title>
        <style>
            body {
                background-color: #e8f5e9;
                font-family: Arial, sans-serif;
            }
            .container {
                max-width: 800px;
                margin: 50px auto;
                background: #ffffff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0px 0px 10px rgba(0, 128, 0, 0.3);
                text-align: center;
            }
            .profile-img {
                width: 120px;
                height: 120px;
                border-radius: 50%;
                object-fit: cover;
                border: 3px solid #2e7d32;
                margin-bottom: 15px;
            }
            h2 {
                color: #2e7d32;
                margin-bottom: 20px;
            }
            .table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                text-align: left;
            }
            .table th, .table td {
                border: 1px solid #2e7d32;
                padding: 12px;
            }
            .table th {
                background-color: #a5d6a7;
                color: #1b5e20;
            }
            .btn-primary {
                display: inline-block;
                margin-top: 20px;
                padding: 10px 20px;
                background-color: #388e3c;
                color: white;
                border-radius: 5px;
                text-decoration: none;
                font-weight: bold;
            }
            .btn-primary:hover {
                background-color: #1b5e20;
            }
            .alert-danger {
                color: white;
                background-color: #d32f2f;
                padding: 10px;
                text-align: center;
                border-radius: 5px;
                margin-top: 20px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Staff Detail</h2>


         
            <c:if test="${not empty staff}">
                <table class="table table-bordered">
                    <img src="${staff.avatar}" alt="Staff Avatar" class="profile-img">
                    <tr>
                        <th>ID</th>
                        <td>${staff.staffId}</td>
                    </tr>
                    <tr>
                        <th>Name</th>
                        <td>${staff.name}</td>
                    </tr>
                    <tr>
                        <th>Gender</th>
                        <td>${staff.gender}</td>
                    </tr>
                    <tr>
                        <th>Position</th>
                        <td>${staff.position}</td>
                    </tr>
                    <tr>
                        <th>Department</th>
                        <td>${staff.department.departmentName}</td>
                    </tr>
                    <tr>
                        <th>Phone</th>
                        <td>${staff.phone}</td>
                    </tr>
                    <tr>
                        <th>Date of Birth</th>
                        <td>${staff.dateOfBirth}</td>
                    </tr>
                    <tr>
                        <th>Email</th>
                        <td>${staff.email}</td>
                    </tr>
                    <tr>
                        <th>Description</th>
                        <td>${staff.description}</td>
                    </tr>
                </table>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>
                <a href="ListDoctor" class="btn btn-primary">Back to Staff List</a>
            </c:if>
        </div>
    </body>
</html>
