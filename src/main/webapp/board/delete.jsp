<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="sw_project.service.BoardService" %>
<%@ page import="sw_project.model.User" %>
<%@ include file="/fragment/header.jsp" %> <!-- 헤더 포함 -->

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 삭제</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .message-container {
            background-color: white;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            text-align: center;
            max-width: 500px;
            width: 100%;
        }
        .message-container p {
            font-size: 18px;
            margin-bottom: 20px;
        }
        .message-container a {
            display: inline-block;
            margin-top: 10px;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .message-container a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<%
    // 세션에서 로그인된 사용자 정보 가져오기
    User loginUser = (User) session.getAttribute("loginUser");

    // 게시글 ID 파라미터 가져오기
    String idParam = request.getParameter("id");
    int boardId = 0;
    boolean deleteResult = false;

    if (loginUser == null) {
        // 로그인되지 않은 경우, 로그인 페이지로 리다이렉트
        response.sendRedirect("login.jsp");
        return;
    }

    if (idParam != null && !idParam.isEmpty()) {
        try {
            boardId = Integer.parseInt(idParam);

            // BoardService를 사용하여 게시글 삭제
            BoardService boardService = new BoardService();
            deleteResult = boardService.deleteBoard(boardId, loginUser.getId());

        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }
%>

<div class="message-container">
    <%
        if (idParam == null || idParam.isEmpty()) {
    %>
    <p style="color:red;">게시글 ID가 전달되지 않았습니다.</p>
    <%
    } else if (deleteResult) {
    %>
    <p style="color:green;">게시글이 성공적으로 삭제되었습니다.</p>
    <%
    } else {
    %>
    <p style="color:red;">게시글 삭제에 실패했습니다. 삭제 권한이 있는지 확인해주세요.</p>
    <%
        }
    %>
    <a href="board.jsp">목록으로 돌아가기</a>
</div>

</body>
</html>
<%@ include file="/fragment/footer.jsp" %> <!-- 푸터 포함 -->
