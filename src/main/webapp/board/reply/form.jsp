<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>댓글 작성</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f9f9f9;
        }
        .form-container {
            width: 400px;
            padding: 20px;
            background: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            border-radius: 5px;
        }
        .form-container h2 {
            margin-bottom: 15px;
            font-size: 20px;
            text-align: center;
        }
        textarea {
            width: 100%;
            height: 100px;
            margin-bottom: 15px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        button {
            width: 100%;
            padding: 10px;
            border: none;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
<!-- 댓글 작성 폼 -->
<div id="replyForm" class="reply-form">
    <form action="addReply.do" method="post">
        <textarea name="content" placeholder="댓글을 입력하세요" required></textarea>
        <input type="hidden" name="author" value="${user}">
        <button type="submit">댓글 등록</button>
    </form>
</div>
</body>
</html>
