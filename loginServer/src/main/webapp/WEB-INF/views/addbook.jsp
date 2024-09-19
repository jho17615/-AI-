<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/resources/css/addbook.css"/>
<script>
var loginok = '<%=(String)session.getAttribute("loginok")%>';
if(loginok == "" || loginok == "null") {
    alert("로그인이 되어 있지 않습니다.");
    location.replace("/");
}

function validateForm() {
    var name = document.forms["calc"]["name"].value;
    var isbn = document.forms["calc"]["isbn"].value;
    var author = document.forms["calc"]["author"].value;
    var date = document.forms["calc"]["date"].value;
    var info = document.forms["calc"]["info"].value;

    if (name == "" || isbn == "" || author == "" || date == "" || info == "") {
        alert("모든 필드를 입력해주세요.");
        return false;
    }

    // 날짜 형식 검증 (YYYY-MM-DD)
    var dateRegex = /^\d{4}-\d{2}-\d{2}$/;
    if (!dateRegex.test(date)) {
        alert("올바른 날짜 형식을 입력해주세요 (YYYY-MM-DD).");
        return false;
    }

    return true;
}
</script>
</head>
<body>
<h2>팀 추가하기</h2>
<form name="calc" method="GET" action="/insertbook" onsubmit="return validateForm()">
    팀 : <input type="text" name="name" required><br>
    팀장이름 : <input type="text" name="isbn" required><br>
    이름 : <input type="text" name="author" required><br>
    입사일 : <input type="date" name="date" required><br>
    담당업무 : <textarea name="info" required></textarea><br>
    <input type="submit" value="팀원 추가하기">
</form>
</body>
</html>