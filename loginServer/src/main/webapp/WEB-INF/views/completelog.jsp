<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>수정 완료</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins:400,500,600,700&display=swap">
    <link rel="stylesheet" href="${path}/resources/css/complete_book.css"/>
</head>
<body>
    <div class="container">
        <h2>수정이 완료되었습니다.</h2>
        <button onclick="goHome()">홈으로 가기</button>
    </div>

    <script>
        function goHome() {
            window.location.href = '/';
        }
    </script>
</body>
</html>