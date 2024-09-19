<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins:400,500,600,700&display=swap">
    <link rel="stylesheet" href="${path}/resources/css/complete_book.css"/>

</head>
<body>
    <div class="logout-container">
        <h2>완료</h2>
       
        <input type="button" value="홈으로 가기" onclick="goHome()">
    </div>

    <script>
        function goHome() {
            location.replace('/');
        }
    </script>
</body>
</html>
