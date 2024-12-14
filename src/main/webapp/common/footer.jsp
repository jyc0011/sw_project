<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <style>
        .footer {
            background-color: #4B544E;
            color: #ffffff;
            padding-top: 60px;
            height: 350px;
        }

        .footer .footer-first-area,
        .footer .footer-second-area {
            width: 1200px;
            margin: 0 auto;
            display: flex;
        }

        .footer .footer-title {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 30px;
        }

        .footer .footer-content ul {
            list-style: none;
            padding: 0;
        }

        .footer .footer-content a {
            color: #ffffff;
            text-decoration: none;
        }

        .footer .footer-content a:hover {
            text-decoration: underline;
        }

        .footer-second-right {
            display: flex;
        }

        .footer-second-right a {
            font-size: 14px;
            margin-left: 30px;
            text-decoration: none;
            color: #ffffff;
        }
    </style>
</head>
<body>
<div class="footer">
    <div class="footer-first-area" style="margin-bottom: 80px; justify-content: space-between;">
        <div class="footer-first-first" style="margin: 0 20px;">
            <div class="footer-title">WORMARS</div>
            <div class="footer-content">MADE BY WORMARS<br/>2024 항공대학교<br/>창업경진대회회 시제품</div>
            <div class="footer-social-section">
                <a class="footer__social" href="https://www.facebook.com/" target="_blank">
                    <i class="ri-facebook-box-fill"></i>
                </a>
                <a class="footer__social" href="https://twitter.com/" target="_blank">
                    <i class="ri-twitter-fill"></i>
                </a>
                <a class="footer__social" href="https://www.instagram.com/" target="_blank">
                    <i class="ri-instagram-fill"></i>
                </a>
                <a class="footer__social" href="https://www.youtube.com/" target="_blank">
                    <i class="ri-youtube-fill"></i>
                </a>
            </div>
        </div>
        <div class="footer-first-second" style="margin: 0 20px;">
            <div class="footer-title">About WORMARS</div>
            <div class="footer-content">
                <ul>
                    <li><a class="something" href="/">HOME</a></li>
                    <li><a class="something" href="/contact">CONTACT</a></li>
                    <li><a class="something" href="/check">CHECK UP</a></li>
                </ul>
            </div>
        </div>
        <div class="footer-first-third" style="margin: 0 20px;">
            <div class="footer-title">ABOUT</div>
            <div class="footer-content">
                <ul>
                    <li><a class="something" href="/about">WHY WORMARS?</a></li>
                    <li><a class="something" href="/member">MEMBER</a></li>
                    <li><a class="something" href="https://github.com/jyc0011/warmars">GITHUB</a></li>
                </ul>
            </div>
        </div>
        <div class="footer-first-4th" style="margin: 0 20px;">
            <div class="footer-title">Support</div>
            <div class="footer-content">
                <ul>
                    <li><a class="something" href="https://www.naver.com">자주 묻는 질문</a></li>
                    <li><a class="something" href="https://www.daum.net">지원 센터</a></li>
                    <li><a class="something" href="https://www.nate.com">문의하기</a></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="footer-second-area" style="justify-content: space-between;">
        <div class="footer-second-left">
            © 2024 KAU Startup Idea Contest Team WORMARS. All rights reserved.
        </div>
        <div class="footer-second-right" style="display: flex">
            <div class="footer-TermsNAgreements"><a
                    class="something" href="https://youtu.be/9PfIi4nXJ6E?si=VoHRlilst2YOdQiP"
                    style="font-size: 14px;">Terms & Agreements</a></div>
            <div class="footer-PrivacyPolicy" style="margin-left: 30px"><a
                    class="something" href="https://youtu.be/Eb-JAjWSxkI?si=g6xiT8-0tVViOcT2"
                    style="font-size: 14px;">Privacy Policy</a></div>
        </div>
    </div>
</div>
</body>
</html>