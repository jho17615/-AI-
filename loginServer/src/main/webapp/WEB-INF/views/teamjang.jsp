<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>팀장 목록</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            line-height: 1.6;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 1000px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }
        .search-form {
            display: flex;
            margin-bottom: 20px;
        }
        .search-form input[type="text"] {
            flex: 1;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 4px 0 0 4px;
        }
        .search-form input[type="submit"] {
            padding: 10px 20px;
            background-color: #007bff;
            border: none;
            color: #fff;
            cursor: pointer;
            font-size: 16px;
            border-radius: 0 4px 4px 0;
            transition: background-color 0.3s;
        }
        .search-form input[type="submit"]:hover {
            background-color: #0056b3;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table th, table td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }
        table th {
            background-color: #f8f9fa;
            font-weight: bold;
            color: #333;
        }
        table tr:hover {
            background-color: #f5f5f5;
        }
        .actions {
            display: flex;
            justify-content: center;
            gap: 10px;
        }
        .actions form {
            margin: 0;
        }
        .actions input[type="submit"] {
            padding: 8px 12px;
            background-color: #dc3545;
            border: none;
            color: #fff;
            cursor: pointer;
            font-size: 14px;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        .actions input[type="submit"]:hover {
            background-color: #c82333;
        }
        .home-button {
            display: block;
            width: 200px;
            margin: 20px auto 0;
            padding: 10px;
            background-color: #28a745;
            color: #fff;
            text-align: center;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        .home-button:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>팀장 목록</h1>
        <form class="search-form" action="/searchTeamjang">
            <input type="text" name="searchText" placeholder="팀장 이름 검색">
            <input type="submit" value="검색">
        </form>
        <table>
            <thead>
                <tr>
                    <th>팀</th>
                    <th>팀장 이름</th>
                    <th>팀원 수</th>
                    <th>동작</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${teamjangList}" var="item">
                    <tr>
                        <td>${item.id}</td>
                        <td>${item.userid}</td>
                        <td>${item.teamMemberCount}</td>
                        <td class="actions">
							<form name="change2" method="GET" action="/modify">
							    <input type="hidden" name="userid" value="${item.userid}">
							    <input type="submit" value="수정">
							</form>
                            <form action="/deletemember">
                                <input type="hidden" name="userid" value="${item.userid}">
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