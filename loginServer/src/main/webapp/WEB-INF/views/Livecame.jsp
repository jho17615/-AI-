<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/Livecame.css"/>
<script>
// 로그인 상태 체크
var loginok = '${sessionScope.loginok}';
if (!loginok || loginok === "null") {
    alert("로그인이 되어 있지 않습니다.");
    location.replace("${pageContext.request.contextPath}/");
}

// 성공 또는 오류 메시지 알림
<c:if test="${not empty alertMessage}">
    alert('${alertMessage}');
</c:if>
</script>
</head>
<body>
<div class="container">
    <h1>작업준비사항</h1>

    <form name="camedb" method="GET" action="${pageContext.request.contextPath}/addLive">
        작업인원 : <input type="text" name="personnel" value="${param.personnel}"><br>

        헬멧 사용여부 :
        <select name="helmet">
            <option value="1" <c:if test="${param.helmet == '1'}">selected</c:if>>사용</option>
            <option value="0" <c:if test="${param.helmet == '0'}">selected</c:if>>사용안함</option>
        </select><br>

        사다리 사용여부 :
        <select name="ladder">
            <option value="1" <c:if test="${param.ladder == '1'}">selected</c:if>>사용</option>
            <option value="0" <c:if test="${param.ladder == '0'}">selected</c:if>>사용안함</option>
        </select><br>

        <div class="button-container">
            <input type="submit" value="작업준비">
            <input type="submit" value="작업시작" name="action">
        </div>
    </form>
</div>
</body>
</html>