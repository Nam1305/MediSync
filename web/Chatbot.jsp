<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
    <head>
        <title>Chatbot Gemini</title>
        <meta charset="UTF-8">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f9;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }
            .chat-container {
                width: 400px;
                background: white;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                overflow: hidden;
            }
            .chat-header {
                background: #007bff;
                color: white;
                padding: 15px;
                text-align: center;
                font-size: 18px;
                font-weight: bold;
            }
            .chat-box {
                height: 300px;
                padding: 15px;
                overflow-y: auto;
                border-bottom: 1px solid #ccc;
                background: #fafafa;
            }
            .message {
                padding: 8px;
                border-radius: 5px;
                margin-bottom: 10px;
                max-width: 80%;
                word-wrap: break-word;
            }
            .user-message {
                background: #007bff;
                color: white;
                align-self: flex-end;
            }
            .bot-message {
                background: #e9ecef;
                color: black;
                align-self: flex-start;
            }
            .chat-input {
                display: flex;
                padding: 10px;
                background: white;
            }
            .chat-input input {
                flex: 1;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 16px;
            }
            .chat-input button {
                margin-left: 10px;
                padding: 10px 15px;
                border: none;
                background: #007bff;
                color: white;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
            }
            .chat-input button:hover {
                background: #0056b3;
            }
        </style>
        <script>
            function sendMessage() {
                var message = document.getElementById("message").value;
                if (message.trim() === "") return;

                var chatBox = document.getElementById("chatBox");
                var userMessage = document.createElement("div");
                userMessage.className = "message user-message";
                userMessage.textContent = "Bạn: " + message;
                chatBox.appendChild(userMessage);
                chatBox.scrollTop = chatBox.scrollHeight;

                fetch("ChatBot", {
                    method: "POST",
                    headers: {"Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"},
                    body: "message=" + encodeURIComponent(message)
                })
                .then(response => response.json())
                .then(data => {
                    var botMessage = document.createElement("div");
                    botMessage.className = "message bot-message";
                    if (data.error) {
                        botMessage.textContent = "Bot: Lỗi: " + data.error;
                    } else if (data && data.candidates && data.candidates.length > 0) {
                        botMessage.textContent = "Bot: " + data.candidates[0].content.parts[0].text;
                    } else {
                        botMessage.textContent = "Bot: Không có phản hồi từ AI!";
                    }
                    chatBox.appendChild(botMessage);
                    chatBox.scrollTop = chatBox.scrollHeight;
                })
                .catch(error => {
                    var errorMessage = document.createElement("div");
                    errorMessage.className = "message bot-message";
                    errorMessage.textContent = "Bot: Lỗi kết nối!";
                    chatBox.appendChild(errorMessage);
                    chatBox.scrollTop = chatBox.scrollHeight;
                });
                
                document.getElementById("message").value = "";
            }
        </script>
    </head>
    <body>
        <div class="chat-container">
            <div class="chat-header">Chatbot Gemini</div>
            <div id="chatBox" class="chat-box"></div>
            <div class="chat-input">
                <input type="text" id="message" placeholder="Nhập tin nhắn..." />
                <button onclick="sendMessage()">Gửi</button>
            </div>
        </div>
    </body>
</html>
