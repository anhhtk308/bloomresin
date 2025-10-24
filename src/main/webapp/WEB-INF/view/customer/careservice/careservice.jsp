<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dịch vụ hỏi đáp</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="/client/css/bootstrap.min.css" rel="stylesheet">
    <link href="/client/css/style.css" rel="stylesheet">
    <style>
        body {
            background-color: #FFF1D2 !important;
            color: #6B1700;
            font-family: 'Open Sans', sans-serif;
        }

        .message {
            padding: 10px;
            margin: 5px;
            border-radius: 10px;
            max-width: 70%;
            word-wrap: break-word;
        }

        .user {
            background-color: #6B1700;
            color: #FFF1D2;
            align-self: flex-end;
            text-align: right;
            margin-left: auto;
        }

        .bot {
            background-color: #CEAF95;
            color: #6B1700;
            align-self: flex-start;
            text-align: left;
            margin-right: auto;
        }

        #chat-box {
            display: flex;
            flex-direction: column;
        }

        .chat-container {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 800px;
            height: 500px;
            background: #FFF1D2;
            padding: 20px;
            border-radius: 10px;
            border: 2px solid #CEAF95;
            box-shadow: 0 0 15px rgba(0,0,0,0.2);
        }

        #chat-box-container {
            height: 400px;
            overflow-y: auto;
            border: 1px solid #CEAF95;
            padding: 10px;
            background: #ffffff;
        }

        .btn-primary {
            background-color: #6B1700;
            border-color: #6B1700;
            color: #FFF1D2;
        }

        .btn-primary:hover {
            background-color: #CEAF95;
            color: #6B1700;
        }
    </style>
</head>
<body>
<jsp:include page="../layout/header.jsp" />

<div class="chat-container">
    <div id="chat-box-container">
        <div id="chat-box"></div>
    </div>
    <div style="display: flex; margin-top: 10px;">
        <input type="text" id="user-input" class="form-control" placeholder="Nhập tin nhắn..." onkeypress="handleKeyPress(event)" style="flex: 1; margin-right: 10px;">
        <button class="btn btn-primary" onclick="sendMessage()">Gửi</button>
    </div>
</div>

<script>
    const API_KEY = "AIzaSyDv6sL4HSQ6uvlPHq8bfoESihK2g0kzJYo";
    const API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=" + API_KEY;

    function sendMessage() {
        let inputField = document.getElementById("user-input");
        let message = inputField.value.trim();
        if (message === "") return;

        addMessage(message, "user");
        inputField.value = "";

        let chatBox = document.getElementById("chat-box");
        let typingIndicator = document.createElement("div");
        typingIndicator.classList.add("message", "bot");
        typingIndicator.textContent = "...";
        chatBox.appendChild(typingIndicator);
        chatBox.scrollTop = chatBox.scrollHeight;

        fetch(API_URL, {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                "contents": [{ "parts": [{ "text": message }] }]
            })
        })
            .then(response => response.json())
            .then(data => {
                let botReply = data.candidates[0].content.parts[0].text;
                setTimeout(() => {
                    chatBox.removeChild(typingIndicator);
                    addMessage(botReply, "bot");
                }, 1000);
            })
            .catch(error => {
                chatBox.removeChild(typingIndicator);
                addMessage("Xin lỗi, có lỗi xảy ra!", "bot");
            });
    }

    function handleKeyPress(event) {
        if (event.key === "Enter") {
            sendMessage();
        }
    }

    function addMessage(text, sender) {
        let chatBox = document.getElementById("chat-box");
        let messageDiv = document.createElement("div");
        messageDiv.classList.add("message", sender);
        messageDiv.innerHTML = convertMarkdownToHTML(text);
        chatBox.appendChild(messageDiv);
        chatBox.scrollTop = chatBox.scrollHeight;
    }

    function convertMarkdownToHTML(text) {
        text = text.replace(/^(\d+)\.\s/gm, '<br><b>$1.</b> ');
        text = text.replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>');
        text = text.replace(/\*(.*?)\*/g, '<em>$1</em>');
        text = text.replace(/\n/g, "<br>");
        return text;
    }
</script>
</body>
</html>
