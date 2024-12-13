<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="sw_project.model.Board" %>
<%@ page import="sw_project.model.User" %>
<%@ page import="sw_project.service.BoardService" %>
<%@ page import="sw_project.service.UserService" %>
<%@ include file="/fragment/header.jsp" %> <!-- 헤더 포함 -->

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>글쓰기</title>
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
    <script>
        function validateForm() {
            var form = document.registrationForm;

            // 필수 입력 확인
            if (form.title.value.trim() === "") {
                alert("제목을 입력해주세요.");
                form.title.focus();
                return false;
            }
            if (form.author.value.trim() === "") {
                alert("작성자를 입력해주세요.");
                form.author.focus();
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
    // POST 방식으로 폼이 제출되었는지 확인
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            // 한글 인코딩 처리
            request.setCharacterEncoding("UTF-8");

            // 파라미터 받기
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            String content = request.getParameter("content");

            // 사용자명으로 사용자 정보 조회
            UserService userService = new UserService();
            User user = userService.findUserByUsername(author);

            if (user == null) {
                // 사용자명에 해당하는 사용자가 없는 경우
                out.println("<p style='color:red;'>작성자 이름을 찾을 수 없습니다. 회원가입을 먼저 해주세요.</p>");
            } else {
                // Board 객체 생성 및 데이터 설정
                Board newBoard = new Board();
                newBoard.setTitle(title);
                newBoard.setContent(content);
                newBoard.setUserId(user.getId());
                // createdDate는 DB에서 자동으로 설정되므로 설정할 필요 없음
                // viewCount는 기본값 0으로 설정됨

                // 게시글 작성 서비스 호출
                BoardService boardService = new BoardService();
                boolean result = boardService.createBoard(newBoard);

                if (result) {
                    // 게시글 작성 성공 시 게시판 목록으로 리다이렉트
                    response.sendRedirect("board.jsp");
                    return; // JSP 진행 중단
                } else {
                    // 게시글 작성 실패 시 메시지
                    out.println("<p style='color:red;'>게시글 작성에 실패했습니다. 다시 시도해주세요.</p>");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p style='color:red;'>예기치 않은 오류가 발생했습니다.</p>");
        }
    }
%>

<div class="form-container">
    <h2>새 글 작성</h2>
    <form action="write.jsp" method="post" name="registrationForm" onsubmit="return validateForm()">
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
            <button type="button" class="cancel-button" onclick="window.location.href='board.jsp'">취소</button>
        </div>
    </form>
</div>
</body>
</html>
<%@ include file="/fragment/footer.jsp" %> <!-- 푸터 포함 -->
