<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/fragment/header.jsp" %> <!-- 헤더 포함 -->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>글쓰기</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .form-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .form-container h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .form-group textarea {
            resize: vertical;
            height: 150px;
        }
        .form-buttons {
            text-align: center;
        }
        .form-buttons button {
            margin: 0 10px;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            background-color: #007bff;
            color: white;
            cursor: pointer;
        }
        .form-buttons button:hover {
            background-color: #0056b3;
        }
        .form-buttons .cancel-button {
            background-color: #6c757d;
        }
        .form-buttons .cancel-button:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>
<div class="form-container">
    <h2>새 글 작성</h2>
    <form>
        <!-- 제목 입력 -->
        <div class="form-group">
            <label for="title">제목</label>
            <input type="text" id="title" name="title" required placeholder="제목을 입력하세요.">
        </div>
        <!-- 작성자 입력 -->
        <div class="form-group">
            <label for="author">작성자</label>
            <input type="text" id="author" name="author" required placeholder="작성자를 입력하세요.">
        </div>
        <!-- 내용 입력 -->
        <div class="form-group">
            <label for="content">내용</label>
            <textarea id="content" name="content" required placeholder="내용을 입력하세요."></textarea>
        </div>
        <!-- 버튼 -->
        <div class="form-buttons">
            <button type="submit">저장</button>
            <button type="button" class="cancel-button" onclick="window.location.href='MainPage.jsp'">취소</button>
        </div>
    </form>
</div>
</body>
</html>
<%@ include file="/fragment/footer.jsp" %> <!-- 푸터 포함 -->
