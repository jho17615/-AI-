<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>게시판</title>
    <link rel="stylesheet" href="${path}/resources/css/board-list.css" />
    <script>
        function goToPost(id) {
            window.location.href = '/board/' + id;
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>게시판</h1>
        <a href="/board/post" class="btn">새 글 작성</a>
        <table>
            <tr>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
            </tr>
            <c:forEach items="${posts}" var="post">
                <tr onclick="goToPost(${post.id})" class="clickable-row">
                    <td>${post.title}</td>
                    <td>${post.author.userid}</td>
                    <td>
                        <fmt:parseDate value="${post.createdAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime" type="both" />
                        <fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${parsedDateTime}" />
                    </td>
                </tr>
            </c:forEach>
        </table>

        <!-- 페이징 (이전과 동일) -->
        <div class="pagination">
            <!-- 페이징 코드 -->
        </div>
    </div>
</body>
</html>