<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>팀원 추가 완료</title>
    <link rel="stylesheet" href="${path}/resources/css/complete_book.css"/>
    <style>
     
    </style>
</head>
<body>
    <div class="container">
        <h1>팀원 추가 완료!</h1>
        <p>새로운 팀원이 성공적으로 추가되었습니다.</p>
        <button class="btn" onclick="goHome()">홈으로 돌아가기</button>
    </div>

    <script>
        function goHome() {
            window.location.href = '/';
        }
    </script>
</body>
</html>