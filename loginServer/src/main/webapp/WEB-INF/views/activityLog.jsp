<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>활동 기록</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<style>

	body {

	font-family: Arial, sans-serif;

	line-height: 1.6;

	margin: 0;

	padding: 20px;

	background-color: #f4f4f4;

	}

	h1 {

	color: #333;

	text-align: center;

	}

	table {

	width: 100%;

	border-collapse: collapse;

	margin-bottom: 20px;

	background-color: #fff;

	box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);

	}

	th, td {

	padding: 12px 15px;

	text-align: left;

	border-bottom: 1px solid #ddd;

	}

	th {

	background-color: #f8f8f8;

	font-weight: bold;

	color: #333;

	text-transform: uppercase;

	}

	tr:hover {

	background-color: #f5f5f5;

	}

	.back-link {

	display: inline-block;

	padding: 10px 15px;

	background-color: #333;

	color: #fff;

	text-decoration: none;

	border-radius: 5px;

	transition: background-color 0.3s;

	}

	.back-link:hover {

	background-color: #555;

	}

	.container {

	max-width: 1200px;

	margin: 0 auto;

	padding: 20px;

	}

	.activity-date {

	font-weight: bold;

	color: #4a4a4a;

	}

	.activity-status {

	font-weight: bold;

	}

	.activity-status.completed {

	color: #28a745;

	}

	.activity-status.ongoing {

	color: #ffc107;

	}

	.delete-btn {

	background-color: #dc3545;

	color: white;

	border: none;

	padding: 5px 10px;

	border-radius: 3px;

	cursor: pointer;

	}

	.delete-btn:hover {

	background-color: #c82333;

	}

	.sort-btn {

	background-color: #007bff;

	color: white;

	border: none;

	padding: 5px 10px;

	border-radius: 3px;

	cursor: pointer;

	margin-bottom: 10px;

	}

	.sort-btn:hover {

	background-color: #0056b3;

	}

	</style>
</head>
<body>
<div class="container">
    <h1>활동 기록</h1>
    <form action="/activityLog" method="get">
        <button type="submit" name="sort" value="asc" class="sort-btn">오래된 순으로 정렬</button>
        <button type="submit" name="sort" value="desc" class="sort-btn">최신 순으로 정렬</button>
    </form>
    <table>
        <thead>
            <tr>
                <th>사용자 ID</th>
                <th>작업 시작 시간</th>
                <th>작업 종료 시간</th>
                <th>인원</th>
                <th>사다리</th>
                <th>헬멧</th>
                <th>상태</th>
                <th>작업</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${activities}" var="activity">
                <tr>
                    <td><c:out value="${activity.userId}"/></td>
                    <td class="activity-date">
                        <c:out value="${activity.formattedStartTime}"/>
                    </td>
                    <td class="activity-date">
                        <c:out value="${activity.formattedEndTime}"/>
                    </td>
                    <td><c:out value="${activity.personnel}"/></td>
                    <td><c:out value="${activity.ladderDisplay}"/></td>
                    <td><c:out value="${activity.helmetDisplay}"/></td>
                    <td class="activity-status ${empty activity.endTime ? 'ongoing' : 'completed'}">
                        <c:out value="${empty activity.endTime ? '진행중' : '완료'}"/>
                    </td>
                    <td>
                        <form action="/deleteActivity" method="post">
                            <input type="hidden" name="id" value="${activity.id}">
                            <button type="submit" class="delete-btn">삭제</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <a href="/" class="back-link">메인으로 돌아가기</a>
</div>
</body>
</html>