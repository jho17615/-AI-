<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IP Webcam 제어</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f0f0f0;
            text-align: center;
        }
        .button {
            padding: 15px 30px;
            font-size: 18px;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin: 10px;
        }
        #launchButton {
            background-color:  #007bff;
        }
        #endButton {
            background-color: #f44336;
        }
        #status {
            margin-top: 20px;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <button id="launchButton" class="button" onclick="launchIPWebcam()">카메라 어플 실행</button>
    <a href="/endLive" id="endButton" class="button">작업 종료</a>
    <div id="status">${message}</div>

    <script>
        function launchIPWebcam() {
            var appPackageName = "com.pas.webcam"; // IP Webcam 앱의 실제 패키지 이름으로 변경 필요
            var intentUrl = "intent:#Intent;action=android.intent.action.MAIN;category=android.intent.category.LAUNCHER;package=" + appPackageName + ";end";
            
            var statusElement = document.getElementById('status');
            statusElement.textContent = "앱 실행 시도 중...";

            try {
                window.location.href = intentUrl;
            } catch (e) {
                console.error("앱 실행 실패:", e);
                statusElement.textContent = "앱 실행에 실패했습니다. 앱이 설치되어 있는지 확인해 주세요.";
                return;
            }

            setTimeout(function() {
                statusElement.textContent = "작업을 마치면 '작업 종료' 버튼을 눌러주세요.";
            }, 1000);
        }
    </script>
</body>
</html>