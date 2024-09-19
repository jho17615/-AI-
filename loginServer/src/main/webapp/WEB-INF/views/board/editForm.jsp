<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>글 수정</title>
<link rel="stylesheet" href="${path}/resources/css/board-edit.css" />
</head>
<body>
    <div class="container">
        <h1>글 수정</h1>
        <form action="/board/${post.id}/edit" method="post">
            <input type="text" name="title" value="${post.title}" required>
            <textarea name="content" required>${post.content}</textarea>
            <input type="submit" value="수정" class="btn">
        </form>
    </div>
</body>
</html>