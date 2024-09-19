<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>새 글 작성</title>
   <link rel="stylesheet" href="${path}/resources/css/board-write.css" />
</head>
<body>
    <div class="container">
        <h1>새 글 작성</h1>
        <form action="/board/post" method="post">
            <input type="text" name="title" placeholder="제목" required>
            <textarea name="content" placeholder="내용" required></textarea>
            <input type="submit" value="작성" class="btn">
        </form>
    </div>
</body>
</html>