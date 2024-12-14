<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>댓글 보기</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .reply-container {
            max-width: 600px;
            margin: 0 auto;
        }
        .reply-list {
            margin: 20px 0;
        }
        .reply-item {
            border-bottom: 1px solid #ddd;
            padding: 10px 0;
        }
        .reply-form {
            display: none; /* 기본적으로 폼은 숨겨짐 */
            margin-top: 20px;
        }
        textarea {
            width: 100%;
            height: 100px;
            margin-bottom: 10px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        button {
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
        }
    </style>
    <script>
        function toggleReplyForm() {
            const form = document.getElementById('replyForm');
            form.style.display = form.style.display === 'none' ? 'block' : 'none';
        }
    </script>
</head>
<body>
<div class="reply-container">
    <h1>댓글</h1>
    <!-- 댓글 목록 -->
    <div class="reply-list">
        <c:forEach var="reply" items="${replyList}">
            <div class="reply-item">
                <p><strong>${reply.author}</strong></p>
                <p>${reply.content}</p>
                <small>${reply.date}</small>
            </div>
        </c:forEach>
        <c:if test="${empty replyList}">
            <p>댓글이 없습니다.</p>
        </c:if>
    </div>
</div>
</body>
</html>
