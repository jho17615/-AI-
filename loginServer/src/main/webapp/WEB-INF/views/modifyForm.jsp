<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>팀장 정보 수정</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
        }
        .container {
            width: 300px;
            margin: auto;
            background: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            margin-top: 10px;
        }
        input[type="text"], input[type="password"] {
            padding: 8px;
            margin-top: 5px;
        }
        input[type="submit"] {
            margin-top: 20px;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>팀장 정보 수정</h2>
        <form action="/modify" method="GET">
            <input type="hidden" name="userid" value="${memo.userid}">
            
            <label for="userid">사용자 ID:</label>
            <input type="text" id="userid" value="${memo.userid}" disabled>
            
            <label for="password">비밀번호:</label>
            <input type="password" id="password" name="password" value="${memo.password}" required>
            
            <label for="addr">ID:</label>
            <input type="text" id="addr" name="addr" value="${memo.addr}" required>
            
            <input type="submit" value="수정">
        </form>
    </div>
</body>
</html>