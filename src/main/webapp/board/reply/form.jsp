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
<div class="form-container">
    <h3>댓글 작성</h3>
    <form action="addComment.do" method="post" name="commentForm" onsubmit="return validateCommentForm()">
        <!-- 댓글 내용 입력 -->
        <div class="form-group">
            <textarea name="content" placeholder="댓글을 입력하세요" required></textarea>
        </div>
        <!-- 작성자 표시 (로그인 사용자) -->
        <div class="form-group">
            <label for="author">작성자</label>
            <input type="text" id="author" name="author" value="<%= session.getAttribute("loginUser") != null ? ((sw_project.model.User) session.getAttribute("loginUser")).getUsername() : "익명" %>" readonly>
        </div>
        <!-- 게시글 ID (숨겨진 필드) -->
        <input type="hidden" name="boardId" value="<%= board != null ? board.getId() : 0 %>">
        <!-- 부모 댓글 ID (대댓글용, 기본값은 0) -->
        <input type="hidden" name="pid" value="0">
        <!-- 버튼 -->
        <div class="form-buttons">
            <button type="submit">댓글 등록</button>
            <button type="button" class="cancel-button" onclick="window.location.href='view.jsp?id=<%= board != null ? board.getId() : 0 %>'">취소</button>
        </div>
    </form>
</div>

<script>
    function validateCommentForm() {
        var form = document.commentForm;

        // 댓글 내용 확인
        if (form.content.value.trim() === "") {
            alert("댓글 내용을 입력해주세요.");
            form.content.focus();
            return false;
        }

        return true;
    }
</script>
</body>
</html>
