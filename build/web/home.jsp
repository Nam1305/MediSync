<%-- 
    Document   : home
    Created on : Jan 10, 2025, 11:15:54 PM
    Author     : DIEN MAY XANH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>MediSyns System</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                background-color: #f4f4f4;
            }
            .logout-button {
                padding: 10px 20px;
                background-color: #d9534f;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
                transition: background-color 0.3s ease;
            }
            .logout-button:hover {
                background-color: #c9302c;
            }
            .logout-button:active {
                background-color: #ac2925;
            }
        </style>       

    </head>

    <body>
        <!-- Loader -->
        <h1> Home </h1>
        <!-- Loader -->

        <form action="logout" method="get" style="display: inline;">
            <button type="submit" class="logout-button">Logout</button>
        </form>
    </body>
</html>
