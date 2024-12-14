<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>]

<%@ page import="sw_project.service.UserService" %>
<%@ page import="sw_project.model.User" %>
<%@ include file="/fragment/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SW term project TEAM C : login</title>
</head>
<body>
<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserService userService = new UserService();
        User user = userService.login(username, password);

        if (user != null) {
            session.setAttribute("loginUser", user);
            response.sendRedirect(request.getContextPath() + "/main.jsp");
            return;
        } else {
            out.println("<p style='color:red;'>아이디 또는 비밀번호가 올바르지 않습니다.</p>");
        }
    }
%>

<form method="post" action="login.jsp">
    <label for="username">아이디</label><br>
    <input type="text" name="username" id="username" required><br><br>

    <label for="password">비밀번호</label><br>
    <input type="password" name="password" id="password" required><br><br>

    <input type="submit" value="로그인">
</form>

<p>
    아직 회원이 아니신가요? <a href="<%= request.getContextPath() %>/login/register.jsp">회원가입</a>
</p>

<%@ include file="/fragment/footer.jsp" %>
</body>
</html>
