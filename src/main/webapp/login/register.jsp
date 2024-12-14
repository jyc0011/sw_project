<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="sw_project.model.User" %>
<%@ page import="sw_project.service.UserService" %>
<%@ include file="/fragment/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <script>
        function validateForm() {
            var form = document.registrationForm;

            if (form.username.value.trim() === "") {
                alert("아이디(사용자명)를 입력해주세요.");
                form.username.focus();
                return false;
            }
            if (form.password.value.trim() === "") {
                alert("비밀번호를 입력해주세요.");
                form.password.focus();
                return false;
            }
            if (form.email.value.trim() === "") {
                alert("이메일 주소를 입력해주세요.");
                form.email.focus();
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(password);
        newUser.setEmail(email);

        // 비즈니스 로직 호출
        UserService userService = new UserService();
        boolean result = userService.registerUser(newUser);

        if (result) {
            out.println("<p style='color:blue;'>회원가입이 완료되었습니다!</p>");
            response.sendRedirect("login.jsp");
            return;
        } else {
            out.println("<p style='color:red;'>회원가입에 실패했습니다. 아이디(Username)가 중복이거나 DB 오류가 발생했습니다.</p>");
        }
    }
%>

<h1>회원가입</h1>
<form name="registrationForm" method="post" action="register.jsp" onsubmit="return validateForm()">
    <p>
        <label for="username">아이디(사용자명): </label><br>
        <input type="text" name="username" id="username">
    </p>
    <p>
        <label for="password">비밀번호: </label><br>
        <input type="password" name="password" id="password">
    </p>
    <p>
        <label for="email">이메일 주소: </label><br>
        <input type="email" name="email" id="email">
    </p>
    <button type="submit">등록하기</button>
</form>

<%@ include file="/fragment/footer.jsp" %>
</body>
</html>