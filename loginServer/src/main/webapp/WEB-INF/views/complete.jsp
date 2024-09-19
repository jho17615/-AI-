<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 완료</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            text-align: center;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            width: 400px;
            background-color: #fff;
            padding: 80px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #2196F3;
            margin-bottom: 20px;
        }
        input[type="button"] {
            padding: 10px 20px;
            background-color:  rgb(0, 0, 160);;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            font-size: 16px;
        }
        input[type="button"]:hover {
            background-color:  rgb(0, 128, 255);
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>회원가입 완료!!</h2>
        <input type="button" value="로그인 하러 가기" onclick="javascript:location.replace('/')">
    </div>
</body>
</html>
