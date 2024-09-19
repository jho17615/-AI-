<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LIVE CAM</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f0f0;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .top-text {
            text-align: center;
            margin-bottom: 20px;
        }
        .name {
            font-size: 2em;
            font-weight: bold;
            color: #333;
        }
        .bottom-text {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 20px;
        }
        .btn a {
            display: inline-block;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        #video-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 10px;
            max-width: 800px;
            margin: 0 auto;
        }
        .video-container {
            background-color: #000;
            aspect-ratio: 16 / 9;
            overflow: hidden;
            cursor: pointer;
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .video-stream {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .stream-error, .buffering-indicator {
            position: absolute;
            color: white;
            font-size: 18px;
            text-align: center;
            background-color: rgba(0, 0, 0, 0.7);
            padding: 10px;
            border-radius: 5px;
            display: none;
        }
        #fullscreen-container {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.9);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }
        #fullscreen-video {
            max-width: 90%;
            max-height: 90%;
            object-fit: contain;
        }
        .user-id-display {
            position: absolute;
            top: 10px;
            left: 10px;
            background-color: rgba(0, 0, 0, 0.5);
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 14px;
        }
        #detection-log {
            margin-top: 20px;
            padding: 10px;
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 5px;
        }
        #detection-container {
            height: 300px;
            overflow-y: auto;
            background-color: #fff;
            border: 1px solid #ced4da;
            padding: 10px;
            font-family: monospace;
        }
        .detection-entry {
            margin-bottom: 5px;
        }
        .detection-timestamp {
            color: #6c757d;
            margin-right: 10px;
        }
        .error {
            color: #dc3545;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="top-text">
            <div class="name">LIVE CAM</div>
            <p>운영중인 CAM</p>
        </div>
        <div id="video-grid">
            <div class="video-container" onclick="showFullscreen(this)">
                <img class="video-stream" src="http://localhost:9999/video_feed?user_id=tkdydwk" alt="Live Video Stream 1" id="stream1" data-user-id="tkdydwk">
                <div class="user-id-display">User ID: tkdydwk</div>
                <div class="stream-error" id="error1">연결되지 않음</div>
                <div class="buffering-indicator" id="buffer1">버퍼링 중...</div>
            </div>
            <div class="video-container" onclick="showFullscreen(this)">
                <img class="video-stream" src="http://localhost:9999/video_feed?user_id=tkdydwk2" alt="Live Video Stream 2" id="stream2" data-user-id="tkdydwk2">
                <div class="user-id-display">User ID: tkdydwk2</div>
                <div class="stream-error" id="error2">연결되지 않음</div>
                <div class="buffering-indicator" id="buffer2">버퍼링 중...</div>
            </div>
            <div class="video-container" onclick="showFullscreen(this)">
                <img class="video-stream" src="http://localhost:9999/video_feed?user_id=tkdydwk3" alt="Live Video Stream 3" id="stream3" data-user-id="tkdydwk3">
                <div class="user-id-display">User ID: tkdydwk3</div>
                <div class="stream-error" id="error3">연결되지 않음</div>
                <div class="buffering-indicator" id="buffer3">버퍼링 중...</div>
            </div>
        </div>
        <div class="bottom-text">
            <div class="text">사용중인 라이브 카메라 현황</div>
            <div class="btn">
                <a href="/hjlivecctv">새로고침</a>
            </div>
        </div>
        <div id="detection-log">
            <h3>객체 탐지 로그</h3>
            <div id="detection-container"></div>
        </div>
    </div>
    <div id="fullscreen-container" onclick="hideFullscreen()">
        <img id="fullscreen-video" src="" alt="Fullscreen Video">
        <div class="user-id-display" id="fullscreen-user-id"></div>
    </div>
    <script>
		function updateDetectionInfo(info) {
		    var container = document.getElementById('detection-container');
		    
		    // 작업인원 위반, 헬멧 미착용, 또는 사다리 작업 위반 시에만 기록을 표시
		    if (info.personnel_violation || info.helmet_violation || info.ladder_violation || info.wrists_outside_ladder) {
		        var entry = document.createElement('div');
		        entry.className = 'detection-entry';
		        
		        var timestamp = new Date(info.timestamp * 1000).toLocaleTimeString();
		        var detectionText = info.user_id + ' - Person: ' + (info.detected_objects && info.detected_objects.Person ? info.detected_objects.Person : '0') + 
		                            ', Helmet: ' + (info.detected_objects && info.detected_objects.Helmet ? info.detected_objects.Helmet : '0') + 
		                            ', Ladder: ' + (info.detected_objects && info.detected_objects.Ladder ? info.detected_objects.Ladder : '0');
		        
		        if (info.personnel_violation) {
		            detectionText += ' - <strong class="error">작업인원 위반 (제한: ' + info.personnel_limit + ')</strong>';
		        }
		        
		        if (info.helmet_violation) {
		            detectionText += ' - <strong class="error">헬멧 미착용</strong>';
		        }
		        
		        if (info.ladder_violation || info.wrists_outside_ladder) {
		            detectionText += ' - <strong class="error">사다리 2인1조 작업 위반</strong>';
		        }
		        
		        var rawInfo = 'Raw: ' + JSON.stringify(info.detected_objects || {});
		        
		        entry.innerHTML = '<span class="detection-timestamp">[' + timestamp + ']</span> ' + detectionText + '<br>' + rawInfo;
		        
		        container.insertBefore(entry, container.firstChild);

		        while (container.children.length > 100) {
		            container.removeChild(container.lastChild);
		        }
		    }
		}

        function fetchDetectionInfo(userId) {
            fetch('http://localhost:9999/detection_info?user_id=' + userId)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok: ' + response.status);
                    }
                    return response.json();
                })
                .then(data => {
                    console.log("Received detection info:", JSON.stringify(data, null, 2));
                    if (data.error) {
                        console.error("Error in detection info:", data.error);
                    } else {
                        updateDetectionInfo(data);
                    }
                })
                .catch(error => {
                    console.error('Error fetching detection info:', error);
                    var container = document.getElementById('detection-container');
                    var errorEntry = document.createElement('div');
                    errorEntry.className = 'detection-entry error';
                    errorEntry.textContent = 'Error: ' + error.message;
                    container.insertBefore(errorEntry, container.firstChild);
                });
        }

        function setupStreamHandlers(streamId, userId) {
            var stream = document.getElementById(streamId);
            var buffer = document.getElementById('buffer' + streamId.charAt(streamId.length - 1));

            stream.src = 'http://localhost:9999/video_feed?user_id=' + userId;
            stream.onerror = function() {
                handleStreamError(streamId);
            };
            stream.onload = function() {
                stream.style.display = 'block';
                buffer.style.display = 'none';
            };

            setInterval(() => fetchDetectionInfo(userId), 1000);
        }

        function showFullscreen(container) {
            var fullscreenContainer = document.getElementById('fullscreen-container');
            var fullscreenVideo = document.getElementById('fullscreen-video');
            var fullscreenUserId = document.getElementById('fullscreen-user-id');
            fullscreenVideo.src = container.querySelector('.video-stream').src;
            fullscreenUserId.textContent = container.querySelector('.user-id-display').textContent;
            fullscreenContainer.style.display = 'flex';
        }

        function hideFullscreen() {
            document.getElementById('fullscreen-container').style.display = 'none';
        }

        function handleStreamError(streamId) {
            var stream = document.getElementById(streamId);
            var error = document.getElementById('error' + streamId.charAt(streamId.length - 1));
            var buffer = document.getElementById('buffer' + streamId.charAt(streamId.length - 1));
            stream.style.display = 'none';
            error.style.display = 'block';
            buffer.style.display = 'none';
            
            setTimeout(function() {
                refreshStream(streamId, stream.dataset.userId);
            }, 5000);
        }

        function refreshStream(streamId, userId) {
            var stream = document.getElementById(streamId);
            var buffer = document.getElementById('buffer' + streamId.charAt(streamId.length - 1));
            var error = document.getElementById('error' + streamId.charAt(streamId.length - 1));
            
            buffer.style.display = 'block';
            stream.style.display = 'none';
            error.style.display = 'none';
            
            stream.src = "http://localhost:9999/video_feed?user_id=" + userId + "&t=" + new Date().getTime();
        }

        window.onload = function() {
            setupStreamHandlers('stream1', 'tkdydwk');
            setupStreamHandlers('stream2', 'tkdydwk2');
            setupStreamHandlers('stream3', 'tkdydwk3');
        };

        setInterval(function() {
            ['stream1', 'stream2', 'stream3'].forEach(function(streamId) {
                var stream = document.getElementById(streamId);
                if (stream.naturalWidth === 0 || stream.naturalHeight === 0) {
                    handleStreamError(streamId);
                }
            });
        }, 10000);

        window.addEventListener('online', function() {
            console.log("Network is back online. Refreshing streams...");
            refreshStream('stream1', 'tkdydwk');
            refreshStream('stream2', 'tkdydwk2');
            refreshStream('stream3', 'tkdydwk3');
        });

        window.addEventListener('offline', function() {
            console.warn("Network is offline. Streams may be interrupted.");
        });
    </script>
</body>
</html>