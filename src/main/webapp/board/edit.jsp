<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="sw_project.model.Board" %>
<%@ page import="sw_project.service.BoardService" %>
<%@ include file="/fragment/header.jsp" %> <!-- 헤더 포함 -->

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시글 수정</title>
    <style>
        /* 기존 스타일 유지 */
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
            background-color: #28a745;
            color: white;
            cursor: pointer;
        }
        .form-buttons button:hover {
            background-color: #218838;
        }
        .form-buttons .cancel-button {
            background-color: #6c757d;
        }
        .form-buttons .cancel-button:hover {
            background-color: #5a6268;
        }
    </style>
    <script>
        function validateForm() {
            var form = document.editForm;

            // 필수 입력 확인
            if (form.title.value.trim() === "") {
                alert("제목을 입력해주세요.");
                form.title.focus();
                return false;
            }
            if (form.content.value.trim() === "") {
                alert("내용을 입력해주세요.");
                form.content.focus();
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
<%
    // 게시글 ID 파라미터 가져오기
    String idParam = request.getParameter("id");
    int boardId = 0;
    BoardService boardService = new BoardService();
    Board board = null;

    if (idParam != null && !idParam.isEmpty()) {
        try {
            boardId = Integer.parseInt(idParam);
            board = boardService.getBoardById(boardId);
        } catch (NumberFormatException e) {
            out.println("<p style='color:red;'>잘못된 게시글 ID입니다.</p>");
        }
    } else {
        out.println("<p style='color:red;'>게시글 ID가 전달되지 않았습니다.</p>");
    }

    // 게시글 수정 처리
    if ("POST".equalsIgnoreCase(request.getMethod()) && board != null) {
        try {
            // 한글 인코딩 처리
            request.setCharacterEncoding("UTF-8");

            // 파라미터 받기
            String title = request.getParameter("title");
            String content = request.getParameter("content");

            // 게시글 수정 데이터 설정
            board.setTitle(title);
            board.setContent(content);

            // 게시글 수정 서비스 호출
            boolean updateResult = boardService.updateBoard(board);

            if (updateResult) {
                // 수정 성공 시 게시판 목록으로 리다이렉트
                response.sendRedirect("view.jsp?id=" + boardId);
                return; // JSP 진행 중단
            } else {
                out.println("<p style='color:red;'>게시글 수정에 실패했습니다. 다시 시도해주세요.</p>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p style='color:red;'>예기치 않은 오류가 발생했습니다.</p>");
        }
    }
%>

<%
    if (board != null) {
%>
<div class="form-container">
    <h2>게시글 수정</h2>
    <form action="edit.jsp?id=<%= board.getId() %>" method="post" name="editForm" onsubmit="return validateForm()">
        <!-- 제목 입력 -->
        <div class="form-group">
            <label for="title">제목</label>
            <input type="text" id="title" name="title" required value="<%= board.getTitle() %>">
        </div>
        <!-- 작성자 표시 (수정 불가) -->
        <div class="form-group">
            <label for="author">작성자</label>
            <input type="text" id="author" name="author" value="<%= board.getUsername() %>" readonly>
        </div>
        <!-- 내용 입력 -->
        <div class="form-group">
            <label for="content">내용</label>
            <textarea id="content" name="content" required><%= board.getContent() %></textarea>
        </div>
        <!-- 버튼 -->
        <div class="form-buttons">
            <button type="submit">수정</button>
            <button type="button" class="cancel-button" onclick="window.location.href='view.jsp?id=<%= board.getId() %>'">취소</button>
        </div>
    </form>
</div>
<%
    }
%>
</body>
</html>
<%@ include file="/fragment/footer.jsp" %> <!-- 푸터 포함 -->
