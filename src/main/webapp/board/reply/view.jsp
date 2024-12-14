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
    <h3>댓글 목록</h3>
    <div class="reply-list">
        <c:forEach var="comment" items="${commentList}">
            <div class="reply-item">
                <p><strong>${comment.author}</strong></p>
                <p>${comment.content}</p>
                <small>${comment.createdDate}</small>
                <br>
                <!-- 댓글 삭제 버튼 (작성자만 삭제 가능) -->
                <c:if test="${sessionScope.loginUser != null && sessionScope.loginUser.id == comment.userId}">
                    <form action="deleteComment.do" method="post" onsubmit="return confirm('댓글을 삭제하시겠습니까?');">
                        <input type="hidden" name="commentId" value="${comment.id}">
                        <input type="hidden" name="boardId" value="${comment.boardId}">
                        <button type="submit" class="delete-button">삭제</button>
                    </form>
                </c:if>
            </div>
        </c:forEach>
        <c:if test="${empty commentList}">
            <p>댓글이 없습니다.</p>
        </c:if>
    </div>
</div>
</body>
</html>
