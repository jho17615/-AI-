<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>팀원 수정하기</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            text-align: center;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            margin-top: 10px;
            font-weight: bold;
        }
        input[type="text"], input[type="date"], textarea {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        textarea {
            height: 100px;
            resize: vertical;
        }
        input[type="submit"] {
            background-color:  rgb(0, 128, 255);
            color: white;
            border: none;
            padding: 10px 20px;
            margin-top: 20px;
            cursor: pointer;
            border-radius: 4px;
        }
        input[type="submit"]:hover {
            background-color: rgb(0, 0, 160);
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>팀원 수정하기</h1>
        <form name="changeBook" method="GET" action="/change3">
            <input type="hidden" name="id" value="${id}">
            
            <label for="name">팀</label>
            <input type="text" id="name" name="name" value="${name}" required>
            
			<label for="author">팀장 이름:</label>
			<input type="text" id="author" name="author" value="${author}" required>
			
            <label for="publishDate">입사일:</label>
            <input type="date" id="publishDate" name="publishDate" value="${publishDate}" required>
            
			<label for="isbn">이름</label>
			<input type="text" id="isbn" name="isbn" value="${isbn}" required>
            
            <label for="info">담당 업무:</label>
            <textarea id="info" name="info" required>${info}</textarea>
            
            <input type="submit" value="수정하기">
        </form>
    </div>
</body>
</html>