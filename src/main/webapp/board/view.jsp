<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시글 보기</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .view-container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .view-container h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .view-group {
            margin-bottom: 15px;
        }
        .view-group label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }
        .view-group p {
            padding: 10px;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .view-buttons {
            text-align: center;
            margin-top: 20px;
        }
        .view-buttons button {
            margin: 0 10px;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            background-color: #007bff;
            color: white;
            cursor: pointer;
        }
        .view-buttons button:hover {
            background-color: #0056b3;
        }
        .view-buttons .delete-button {
            background-color: #dc3545;
        }
        .view-buttons .delete-button:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
<div class="view-container">
    <h2>게시글 상세 정보</h2>
    <!-- 제목 -->
    <div class="view-group">
        <label for="title">제목</label>
        <p id="title"><%= (request.getParameter("title") != null) ? request.getParameter("title") : "제목 없음" %></p>
    </div>
    <!-- 작성자 -->
    <div class="view-group">
        <label for="author">작성자</label>
        <p id="author"><%= (request.getParameter("author") != null) ? request.getParameter("author") : "작성자 없음" %></p>
    </div>
    <!-- 작성일 -->
    <div class="view-group">
        <label for="date">작성일</label>
        <p id="date"><%= (request.getParameter("date") != null) ? request.getParameter("date") : "날짜 없음" %></p>
    </div>
    <!-- 내용 -->
    <div class="view-group">
        <label for="content">내용</label>
        <p id="content"><%= (request.getParameter("content") != null) ? request.getParameter("content").replaceAll("\n", "<br>") : "내용 없음" %></p>
    </div>
    <!-- 버튼 -->
    <div class="view-buttons">
        <button onclick="window.location.href='edit.jsp?id=<%= request.getParameter("id") != null ? request.getParameter("id") : "" %>'">수정</button>
        <button class="delete-button" onclick="confirmDelete('<%= request.getParameter("id") != null ? request.getParameter("id") : "" %>')">삭제</button>
        <button onclick="window.location.href='MainPage.jsp'">목록으로</button>
    </div>
</div>

<script>
    function confirmDelete(id) {
        if (confirm("정말로 이 게시글을 삭제하시겠습니까?")) {
            window.location.href = "deletePost.jsp?id=" + id;
        }
    }
</script>
</body>
</html>
