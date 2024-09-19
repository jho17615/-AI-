<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사용자 목록</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .status-online {
            color: green;
        }
        .status-offline {
            color: red;
        }
    </style>
</head>
<body>
    <h1>사용자 목록</h1>
    <c:choose>
        <c:when test="${not empty ls}">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>User ID</th>
                        <th>상태</th>
                        <th>작업</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${ls}">
                        <tr>
                            <td>${user.id}</td>
                            <td>${user.userId}</td>
                            <td class="${user.value == 1 ? 'status-online' : 'status-offline'}">
                                ${user.value == 1 ? '접속중' : '미접속'}
                            </td>
                            <td>
                                <c:if test="${user.value == 1}">
                                    <button onclick="forceLogout('${user.userId}')">강제 로그아웃</button>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <p>접속 중인 사용자가 없습니다.</p>
        </c:otherwise>
    </c:choose>
    
    <script>
    function forceLogout(userId) {
        if (confirm("정말로 사용자 " + userId + "를 강제 로그아웃하시겠습니까?")) {
            fetch('/forceLogout', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: new URLSearchParams({userId: userId})
            })
            .then(response => response.text())
            .then(data => alert(data))
            .catch(error => console.error('Error:', error));
        }
    }
    </script>
</body>
</html>
