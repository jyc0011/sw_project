<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="sw_project.service.BoardService" %>
<%@ page import="sw_project.model.Board" %>
<%@ include file="/fragment/header.jsp" %> <!-- 헤더 포함 -->
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시판</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        table th, table td {
            border: 1px solid #ddd;
            text-align: center;
            padding: 8px;
        }
        table th {
            background-color: #f4f4f4;
        }
        .button {
            display: inline-block;
            margin: 10px 5px;
            padding: 10px 20px;
            color: white;
            background-color: #007bff;
            text-decoration: none;
            border-radius: 5px;
            text-align: center;
        }
        .button:hover {
            background-color: #0056b3;
        }
        .pagination {
            margin: 20px 0;
            text-align: center;
        }
        .pagination a {
            margin: 0 5px;
            text-decoration: none;
            padding: 5px 10px;
            border: 1px solid #ddd;
            color: #007bff;
        }
        .pagination a.active {
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 3px;
        }
        .pagination span {
            margin: 0 5px;
            padding: 5px 10px;
            color: #ccc;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>게시판</h2>

    <!-- 게시판 테이블 -->
    <table>
        <thead>
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
            <th>조회수</th>
        </tr>
        </thead>
        <tbody>
        <%
            // 현재 페이지 번호 가져오기, 기본값은 1
            String pageParam = request.getParameter("page");
            int currentPage = 1;
            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    currentPage = Integer.parseInt(pageParam);
                } catch (NumberFormatException e) {
                    currentPage = 1;
                }
            }
            int pageSize = 10; // 한 페이지에 표시할 게시글 수

            // BoardService 인스턴스 생성
            BoardService boardService = new BoardService();
            List<Board> boardList = boardService.getBoardList(currentPage, pageSize);
            int totalBoardCount = boardService.getTotalBoardCount();
            int totalPages = (int) Math.ceil((double) totalBoardCount / pageSize);

            // 게시글이 존재하는지 확인
            if (boardList != null && !boardList.isEmpty()) {
                for (Board board : boardList) {
        %>
        <tr>
            <td><%= board.getId() %></td>
            <td><a href="view.jsp?id=<%= board.getId() %>"><%= board.getTitle() %></a></td>
            <td><%= board.getUsername() %></td>
            <td><%= board.getCreatedDate() %></td>
            <td><%= board.getViewCount() %></td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="5">게시글이 존재하지 않습니다.</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>

    <!-- 페이지네이션: << 1 >> 형태로 단순화 -->
    <div class="pagination">
        <%
            // 이전 페이지 링크
            if (currentPage > 1) {
        %>
        <a href="list.jsp?page=<%= currentPage - 1 %>">&lt;&lt;</a>
        <%
        } else {
        %>
        <span>&lt;&lt;</span>
        <%
            }

            // 현재 페이지 번호만 표시
        %>
        <a href="list.jsp?page=<%= currentPage %>" class="active"><%= currentPage %></a>
        <%

            // 다음 페이지 링크
            if (currentPage < totalPages) {
        %>
        <a href="list.jsp?page=<%= currentPage + 1 %>">&gt;&gt;</a>
        <%
        } else {
        %>
        <span>&gt;&gt;</span>
        <%
            }
        %>
    </div>

    <!-- 글쓰기 버튼 -->
    <a href="write.jsp" class="button">글쓰기</a>
</div>
</body>
</html>
<%@ include file="/fragment/footer.jsp" %> <!-- 푸터 포함 -->