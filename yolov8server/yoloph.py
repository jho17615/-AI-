import cv2
import torch
import numpy as np
from ultralytics import YOLO
import mediapipe as mp

# 전역 변수로 모델 로드 (한 번만 로드하도록)
model_path = 'bestend.pt'
model = YOLO(model_path)

# GPU 사용 가능 여부 확인
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
model.to(device)

# MediaPipe 초기화
mp_pose = mp.solutions.pose
pose = mp_pose.Pose(static_image_mode=True, min_detection_confidence=0.5, min_tracking_confidence=0.5)

# 프레임 카운터 초기화
frame_count = 0

def process_frame(frame, user_id, ladder_requirement):
    global frame_count
    frame_count += 1

    # 3프레임마다 처리 (프레임 스킵)
    if frame_count % 1 != 0:
        return frame, [], False

    # 이미지 크기 축소
    scale_percent = 50  # 원본 크기의 50%로 축소
    width = int(frame.shape[1] * scale_percent / 100)
    height = int(frame.shape[0] * scale_percent / 100)
    dim = (width, height)
    resized_frame = cv2.resize(frame, dim, interpolation=cv2.INTER_AREA)

    # YOLO 모델 추론
    results = model(resized_frame, device=device)
    
    # 결과 처리
    detected = []
    ladder_boxes = []
    person_boxes = []
    wrists_outside_ladder = False
    person_detected = False
    ladder_detected = False

    for r in results:
        boxes = r.boxes
        for box in boxes:
            x1, y1, x2, y2 = box.xyxy[0]
            x1, y1, x2, y2 = int(x1), int(y1), int(x2), int(y2)
            conf = float(box.conf)
            cls = int(box.cls)
            
            # 신뢰도 임계값 설정 (여기서는 0.5 이상인 경우에만 탐지)
            if conf > 0.4:
                if cls in [0, 1, 2]:  # 0: ladder, 1: person, 2: helmet
                    class_name = "Ladder" if cls == 0 else "Person" if cls == 1 else "Helmet"
                    detected.append((x1, y1, x2, y2, class_name, conf))
                    if class_name == "Ladder":
                        ladder_boxes.append((x1, y1, x2, y2))
                        ladder_detected = True
                    elif class_name == "Person":
                        person_boxes.append((x1, y1, x2, y2))
                        person_detected = True

    # 각 Person에 대해 개별적으로 포즈 추정 수행
    if ladder_requirement == 1 and person_detected and ladder_detected:
        all_wrists_outside = True
        for person_box in person_boxes:
            x1, y1, x2, y2 = person_box
            person_image = resized_frame[y1:y2, x1:x2]
            
            # MediaPipe 처리
            rgb_person = cv2.cvtColor(person_image, cv2.COLOR_BGR2RGB)
            pose_results = pose.process(rgb_person)

            if pose_results.pose_landmarks:
                person_wrists_outside = True
                for i, landmark in enumerate(pose_results.pose_landmarks.landmark):
                    if i in [mp_pose.PoseLandmark.LEFT_WRIST.value, mp_pose.PoseLandmark.RIGHT_WRIST.value]:
                        if landmark.visibility > 0.5:
                            wrist_x = int(x1 + landmark.x * (x2 - x1))
                            wrist_y = int(y1 + landmark.y * (y2 - y1))
                            
                            wrist_inside_ladder = False
                            for ladder_box in ladder_boxes:
                                if (ladder_box[0] <= wrist_x <= ladder_box[2] and 
                                    ladder_box[1] <= wrist_y <= ladder_box[3]):
                                    wrist_inside_ladder = True
                                    person_wrists_outside = False
                                    break
                            
                            # 원본 크기로 좌표 변환 및 시각화
                            scale = 100 / scale_percent
                            wrist_x, wrist_y = int(wrist_x * scale), int(wrist_y * scale)
                            color = (0, 255, 0) if wrist_inside_ladder else (0, 0, 255)  # 초록색(안전) 또는 빨간색(위험)
                            cv2.circle(frame, (wrist_x, wrist_y), 5, color, -1)
                            cv2.putText(frame, "Wrist", (wrist_x, wrist_y - 10),
                                        cv2.FONT_HERSHEY_SIMPLEX, 0.5, color, 2)

                all_wrists_outside = all_wrists_outside and person_wrists_outside

        wrists_outside_ladder = all_wrists_outside

    # 결과 시각화
    scale = 100 / scale_percent
    for x1, y1, x2, y2, class_name, conf in detected:
        x1, y1, x2, y2 = int(x1*scale), int(y1*scale), int(x2*scale), int(y2*scale)
        if class_name == "Person":
            color = (0, 255, 0)  # 초록색
        elif class_name == "Ladder":
            color = (255, 0, 0)  # 빨간색
        elif class_name == "Helmet":
            color = (0, 0, 255)  # 파란색

        cv2.rectangle(frame, (x1, y1), (x2, y2), color, 2)
        label = f'{class_name} {conf:.2f}'
        cv2.putText(frame, label, (x1, y1 - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.5, color, 2)

    return frame, detected, wrists_outside_ladder