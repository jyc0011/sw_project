<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Titillium+Web&display=swap');
        body {
            font-family: 'Titillium Web', sans-serif;
            line-height: 1.6;
            color: #333;
            padding-top: 20px;
            padding: 0;
            margin: 0;
        }

        .header {
            width: 1200px;
            margin: 50px auto;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .header ul {
            list-style-type: none;
            display: flex;
            padding: 0;
        }

        .header a {
            text-decoration: none;
            font-weight: bold;
            color: #000000;
        }

        .header a:hover {
            text-decoration: none;
        }
    </style>
</head>
<body>
<div class="header" style="width: 100%; margin: 50px auto;">
    <h1 class="text-muted text-center logo" style="text-decoration: none;">WORMARS</h1>
    <div style="display: flex; width: 100%; justify-content: space-between; margin-top: 30px; background-color: #eaf5ee; ">
        <ul class="nav nav-pills general-menu" style="margin: 0 150px; padding: 15px 0;">
            <li style="margin-right: 30px;"><a href="/about">About WORMARS</a></li>
            <li style="margin-right: 30px;"><a href="/member">WORMARS Member</a></li>
            <li style="margin-right: 30px;"><a href="/contact">Contact</a></li>
        </ul>
    </div>
</div>
</body>
</html>