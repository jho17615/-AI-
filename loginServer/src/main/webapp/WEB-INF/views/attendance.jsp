<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>근태 기록</title>
<style>
body {
    font-family: Arial, sans-serif;
    line-height: 1.6;
    margin: 0;
    padding: 20px;
    background-color: #f4f4f4;
}
.container {
    max-width: 800px;
    margin: 0 auto;
    background-color: #fff;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0 0 10px rgba(0,0,0,0.1);
}
h1 {
    color: #333;
    text-align: center;
}
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}
th, td {
    padding: 12px;
    text-align: left;
    border-bottom: 1px solid #ddd;
}
th {
    background-color: #f2f2f2;
    font-weight: bold;
}
.btn {
    display: inline-block;
    padding: 10px 15px;
    background-color: #007bff;
    color: #fff;
    text-decoration: none;
    border-radius: 5px;
    transition: background-color 0.3s;
    border: none;
    cursor: pointer;
    font-size: 16px;
    margin-right: 10px;
}
.btn:hover {
    background-color: #0056b3;
}
.btn-group, .sort-form {
    margin-bottom: 20px;
}
select, input[type="button"] {
    padding: 10px;
    font-size: 16px;
    border-radius: 5px;
    border: 1px solid #ddd;
}
select {
    margin-right: 10px;
}
</style>
</head>
<body>
<div class="container">
    <h1>근태 기록</h1>

    <div class="btn-group">
        <form action="/checkIn" method="post" style="display:inline;">
            <input type="submit" value="출근 체크" class="btn">
        </form>
        <form action="/checkOut" method="post" style="display:inline;">
            <input type="submit" value="퇴근 체크" class="btn">
        </form>
    </div>

    <div class="sort-form">
        <select id="sortBy">
            <option value="0">날짜</option>
            <option value="1">출근 시간</option>
            <option value="2">퇴근 시간</option>
        </select>
        <select id="sortOrder">
            <option value="asc">오름차순</option>
            <option value="desc">내림차순</option>
        </select>
        <input type="button" value="정렬" class="btn" onclick="sortTable()">
    </div>

    <table id="attendanceTable">
        <thead>
            <tr>
                <th>날짜</th>
                <th>출근 시간</th>
                <th>퇴근 시간</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${attendanceRecords}" var="record">
            <tr>
                <td>${record.checkInTime.toLocalDate()}</td>
                <td>${record.checkInTime.toLocalTime()}</td>
                <td>${record.checkOutTime != null ? record.checkOutTime.toLocalTime() : '-'}</td>
            </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<script>
function sortTable() {
    var table, rows, switching, i, x, y, shouldSwitch;
    table = document.getElementById("attendanceTable");
    var sortBy = document.getElementById("sortBy").value;
    var sortOrder = document.getElementById("sortOrder").value;
    switching = true;

    while (switching) {
        switching = false;
        rows = table.rows;

        for (i = 1; i < (rows.length - 1); i++) {
            shouldSwitch = false;
            x = rows[i].getElementsByTagName("TD")[sortBy];
            y = rows[i + 1].getElementsByTagName("TD")[sortBy];

            if (sortOrder == "asc") {
                if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                    shouldSwitch = true;
                    break;
                }
            } else if (sortOrder == "desc") {
                if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                    shouldSwitch = true;
                    break;
                }
            }
        }

        if (shouldSwitch) {
            rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
            switching = true;
        }
    }
}
</script>
</body>
</html>