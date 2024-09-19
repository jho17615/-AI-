<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>팀 목록</title>
	<link rel="stylesheet" href="${path}/resources/css/team-list.css">
</head>
<body>
    <div class="container">
        <h1>팀원 리스트</h1>
        <form class="search-form" action="/search">
            <input type="text" name="searchText" placeholder="팀 검색">
            <input type="submit" value="검색">
        </form>
        <a href="/sortByName" class="sort-button">팀 이름으로 정렬</a>
        <table>
            <thead>
                <tr>
                    <th>팀</th>
                    <th>팀장이름</th>
                    <th>입사일</th>
                    <th>이름</th>
                    <th>담당업무</th>
                    <th>동작</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${bookList}" var="item">
                    <tr>
                        <td>${item.name}</td>
                        <td>${item.author}</td>
                        <td>
                            <c:if test="${not empty item.publishDate}">
                                <fmt:parseDate value="${item.publishDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                                <fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd" />
                            </c:if>
                        </td>
                        <td>${item.isbn}</td>
                        <td>${item.info}</td>
                        <td class="actions">
                            <form name="change2" method="GET" action="/change">
                                <input type="hidden" name="id" value="${item.id}">
                                <input type="submit" value="수정">
                            </form>
                            <form action="/deleteBook">
                                <input type="hidden" name="id" value="${item.id}">
                                <input type="submit" value="삭제">
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <a href="/" class="home-button">홈으로</a>
    </div>
</body>
</html>