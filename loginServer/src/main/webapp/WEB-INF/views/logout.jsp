<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins:400,500,600,700&display=swap">
    <link rel="stylesheet" href="${path}/resources/css/complete_book.css"/>
    <title>로그아웃</title>
</head>
<body>
    <div class="logout-container">
        <h2>로그아웃 되었습니다.</h2>
        <button onclick="goHome()">홈으로 가기</button>
    </div>

    <script>
        function goHome() {
            location.replace('/');
        }
    </script>
</body>
</html>