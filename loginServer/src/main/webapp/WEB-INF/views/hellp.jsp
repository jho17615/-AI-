<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>119 긴급전화</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        body {
            font-family: 'Noto Sans KR', sans-serif;
            line-height: 1.6;
            color: #333;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }
        .container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            padding: 40px;
            text-align: center;
            max-width: 500px;
            width: 100%;
        }
        h1 {
            color: #e74c3c;
            margin-bottom: 20px;
            font-size: 28px;
        }
        p {
            margin-bottom: 30px;
            font-size: 16px;
        }
        .emergency-button {
            background-color: #e74c3c;
            color: white;
            padding: 15px 30px;
            font-size: 20px;
            border: none;
            border-radius: 4px;  /* 사각형 모서리로 변경 */
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
            display: inline-block;
            text-decoration: none;
            font-weight: bold;
            text-transform: uppercase;  /* 대문자로 변경 */
            letter-spacing: 1px;  /* 글자 간격 추가 */
        }
        .emergency-button:hover {
            background-color: #c0392b;
            transform: translateY(-2px);  /* 호버 시 약간 위로 이동 */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);  /* 그림자 효과 추가 */
        }
        .warning {
            margin-top: 20px;
            font-size: 14px;
            color: #7f8c8d;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>긴급 상황 발생</h1>
        <p>생명이 위급하거나 화재 발생 시 즉시 119로 연락하세요.</p>
        <a href="tel:119" class="emergency-button">119 긴급전화 연결</a>
        <p class="warning">주의: 실제 긴급 상황에만 사용하세요.</p>
    </div>
</body>
</html>