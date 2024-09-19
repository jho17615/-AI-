<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title><c:out value="${post.title}" /></title>
    <link rel="stylesheet" href="${path}/resources/css/board-view.css" />
</head>
<body>
    <div class="container">
        <div class="post-header">
            <h1 class="post-title"><c:out value="${post.title}" /></h1>
            <div class="post-info">
                <span class="author">작성자: <c:out value="${post.author.userid}" /></span>
                <span class="date">작성일: <c:out value="${post.createdAt}" /></span>
            </div>
        </div>
        <div class="post-content"><pre><c:out value="${post.content}" /></pre></div>
        <div class="post-actions">
            <a href="/board/${post.id}/edit" class="btn btn-edit">수정</a>
            <form action="/board/${post.id}/delete" method="post" style="display:inline;">
                <input type="submit" value="삭제" class="btn btn-delete" onclick="return confirm('정말 삭제하시겠습니까?');">
            </form>
            <a href="/board" class="btn btn-list">목록으로</a>
        </div>
    </div>
</body>
</html>