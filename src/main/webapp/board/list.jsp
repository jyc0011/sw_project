<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/fragment/header.jsp" %> <!-- 헤더 포함 -->
<!DOCTYPE html>
<html>
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
        }
        .pagination a.active {
            background-color: #007bff;
            color: white;
            border: none;
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
            // 예제 데이터
            String[][] boardData = {
                    {"1", "첫 번째 글", "홍길동", "2024-01-01", "15"},
                    {"2", "두 번째 글", "김철수", "2024-01-02", "10"},
                    {"3", "세 번째 글", "이영희", "2024-01-03", "7"}
            };
            for (int i = 0; i < boardData.length; i++) {
        %>
        <tr>
            <td><%= boardData[i][0] %></td>
            <td><a href="view.jsp?id=<%= boardData[i][0] %>"><%= boardData[i][1] %></a></td>
            <td><%= boardData[i][2] %></td>
            <td><%= boardData[i][3] %></td>
            <td><%= boardData[i][4] %></td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>

    <!-- 페이지네이션 -->
    <div class="pagination">
        <a href="?page=1" class="active">1</a>
        <a href="?page=2">2</a>
        <a href="?page=3">3</a>
        <a href="?page=4">4</a>
    </div>

    <!-- 글쓰기 버튼 -->
    <a href="write.jsp" class="button">글쓰기</a>
</div>
</body>
</html>
<%@ include file="/fragment/footer.jsp" %> <!-- 푸터 포함 -->
