import logging
from fastapi import FastAPI, Query, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import StreamingResponse, JSONResponse
import cv2
import time
import json
import yoloph
import pymysql
from pymysql.cursors import DictCursor

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - [%(name)s] - %(message)s')
logger = logging.getLogger(__name__)

app = FastAPI()

# CORS 설정
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# 데이터베이스 연결 설정
DB_CONFIG = {
    'host': '192.168.0.10',
    'user': 'root',
    'password': 'root',
    'db': 'madang',
    'charset': 'utf8mb4'
}

# 사용자별 카메라 URL 매핑
CAMERA_URLS = {
    "tkdydwk": "http://192.168.0.2:8080/video",
    "tkdydwk2": "http://192.168.0.16:8080/video",
    "tkdydwk3": "http://192.168.0.5:8080/video"
}

latest_detection_info = {}

def get_db_connection():
    try:
        conn = pymysql.connect(**DB_CONFIG, cursorclass=DictCursor)
        logger.info("Database connection successful")
        return conn
    except Exception as e:
        logger.error(f"Database connection failed: {str(e)}")
        return None

def check_user_status(user_id):
    conn = get_db_connection()
    if not conn:
        logger.error(f"Unable to connect to database, assuming user {user_id} is inactive")
        return False
    try:
        with conn.cursor() as cursor:
            sql = "SELECT value, play FROM ls WHERE user_id = %s"
            cursor.execute(sql, (user_id,))
            result = cursor.fetchone()
            if result:
                status = result['value'] == 1 and result['play'] == 1
                logger.info(f"Status for {user_id}: value={result['value']}, play={result['play']}, active={status}")
                return status
            logger.warning(f"No status found for user {user_id}")
            return False
    except Exception as e:
        logger.error(f"Error checking status for user {user_id}: {str(e)}")
        return False
    finally:
        conn.close()

def get_personnel_limit(user_id):
    conn = get_db_connection()
    if not conn:
        logger.error(f"Unable to connect to database, cannot get personnel limit for {user_id}")
        return None
    try:
        with conn.cursor() as cursor:
            sql = "SELECT personnel FROM tbl_livecam WHERE user_id = %s ORDER BY id DESC LIMIT 1"
            cursor.execute(sql, (user_id,))
            result = cursor.fetchone()
            if result and result['personnel'] is not None:
                return int(result['personnel'])
            logger.warning(f"No valid personnel limit found for user {user_id}")
            return None
    except Exception as e:
        logger.error(f"Error getting personnel limit for user {user_id}: {str(e)}")
        return None
    finally:
        conn.close()

def get_helmet_requirement(user_id):
    conn = get_db_connection()
    if not conn:
        logger.error(f"Unable to connect to database, cannot get helmet requirement for {user_id}")
        return None
    try:
        with conn.cursor() as cursor:
            sql = "SELECT helmet FROM tbl_livecam WHERE user_id = %s ORDER BY id DESC LIMIT 1"
            cursor.execute(sql, (user_id,))
            result = cursor.fetchone()
            if result and result['helmet'] is not None:
                return int(result['helmet'])
            logger.warning(f"No valid helmet requirement found for user {user_id}")
            return None
    except Exception as e:
        logger.error(f"Error getting helmet requirement for user {user_id}: {str(e)}")
        return None
    finally:
        conn.close()

def get_ladder_requirement(user_id):
    conn = get_db_connection()
    if not conn:
        logger.error(f"Unable to connect to database, cannot get ladder requirement for {user_id}")
        return None
    try:
        with conn.cursor() as cursor:
            sql = "SELECT ladder FROM tbl_livecam WHERE user_id = %s ORDER BY id DESC LIMIT 1"
            cursor.execute(sql, (user_id,))
            result = cursor.fetchone()
            if result and result['ladder'] is not None:
                return int(result['ladder'])
            logger.warning(f"No valid ladder requirement found for user {user_id}")
            return None
    except Exception as e:
        logger.error(f"Error getting ladder requirement for user {user_id}: {str(e)}")
        return None
    finally:
        conn.close()

def generate_frames(user_id: str):
    global latest_detection_info
    video_source = CAMERA_URLS.get(user_id)
    if not video_source:
        logger.error(f"No video source found for user {user_id}")
        return

    last_check_time = 0
    personnel_limit = get_personnel_limit(user_id)
    helmet_requirement = get_helmet_requirement(user_id)
    ladder_requirement = get_ladder_requirement(user_id)
    if personnel_limit is None or helmet_requirement is None or ladder_requirement is None:
        logger.error(f"Unable to get valid limits for user {user_id}")
        return

    logger.info(f"Initial limits for user {user_id}: personnel={personnel_limit}, helmet={helmet_requirement}, ladder={ladder_requirement}")

    retry_count = 0
    while retry_count < 3:
        cap = cv2.VideoCapture(video_source)
        if not cap.isOpened():
            logger.warning(f"Unable to open video source for user {user_id}, attempt {retry_count + 1}")
            retry_count += 1
            time.sleep(2)
            continue
        
        logger.info(f"Successfully connected to video source for user {user_id}")
        break
    else:
        logger.error(f"Failed to connect to video source for user {user_id} after 3 attempts")
        return

    while True:
        current_time = time.time()
        
        if current_time - last_check_time >= 30:
            if not check_user_status(user_id):
                logger.info(f"Stream inactive for user {user_id}, waiting...")
                time.sleep(10)
                last_check_time = current_time
                continue
            
            new_personnel_limit = get_personnel_limit(user_id)
            new_helmet_requirement = get_helmet_requirement(user_id)
            new_ladder_requirement = get_ladder_requirement(user_id)
            if new_personnel_limit is not None and new_helmet_requirement is not None and new_ladder_requirement is not None:
                personnel_limit = new_personnel_limit
                helmet_requirement = new_helmet_requirement
                ladder_requirement = new_ladder_requirement
                logger.info(f"Updated limits for user {user_id}: personnel={personnel_limit}, helmet={helmet_requirement}, ladder={ladder_requirement}")
            last_check_time = current_time

        success, frame = cap.read()
        if not success:
            logger.warning(f"Unable to read frame for user {user_id}")
            time.sleep(1)
            continue

        try:
            frame, detected_objects, wrists_outside_ladder = yoloph.process_frame(frame, user_id, ladder_requirement)
            
            detection_info = {
                "user_id": user_id,
                "detected_objects": {
                    "Person": 0,
                    "Helmet": 0,
                    "Ladder": 0
                },
                "timestamp": time.time(),
                "raw_info": str(detected_objects),
                "personnel_limit": personnel_limit,
                "helmet_requirement": helmet_requirement,
                "ladder_requirement": ladder_requirement,
                "personnel_violation": False,
                "helmet_violation": False,
                "ladder_violation": False,
                "wrists_outside_ladder": wrists_outside_ladder
            }
            
            for obj in detected_objects:
                class_name = obj[4]
                if class_name in detection_info["detected_objects"]:
                    detection_info["detected_objects"][class_name] += 1
            
            if detection_info["detected_objects"]["Person"] > personnel_limit:
                detection_info["personnel_violation"] = True
                logger.warning(f"Personnel violation detected for user {user_id}: {detection_info['detected_objects']['Person']} people detected, limit is {personnel_limit}")
            
            if helmet_requirement == 1 and detection_info["detected_objects"]["Person"] > detection_info["detected_objects"]["Helmet"]:
                detection_info["helmet_violation"] = True
                logger.warning(f"Helmet violation detected for user {user_id}: {detection_info['detected_objects']['Person']} people, but only {detection_info['detected_objects']['Helmet']} helmets")
            
            if ladder_requirement == 1 and wrists_outside_ladder:
                detection_info["ladder_violation"] = True
                logger.warning(f"Ladder violation detected for user {user_id}: Wrists outside ladder")
            
            latest_detection_info[user_id] = detection_info
            
            logger.info(f"Detection for {user_id}: {detection_info}")

            cv2.putText(frame, f"User: {user_id}", (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 1, (255, 255, 255), 2)
            ret, buffer = cv2.imencode('.jpg', frame)
            if not ret:
                logger.warning(f"Unable to encode frame for user {user_id}")
                continue
            frame = buffer.tobytes()
            
            yield (b'--frame\r\n'
                   b'Content-Type: image/jpeg\r\n\r\n' + frame + b'\r\n')

        except TypeError as e:
            logger.error(f"Type error processing frame for user {user_id}: {str(e)}")
            logger.error(f"Current values - Person: {detection_info['detected_objects']['Person']}, Limit: {personnel_limit}")
            time.sleep(1)
        except Exception as e:
            logger.error(f"Error processing frame for user {user_id}: {str(e)}")
            time.sleep(1)

    cap.release()

@app.get("/video_feed")
async def video_feed(user_id: str = Query(default="tkdydwk")):
    if user_id not in CAMERA_URLS:
        raise HTTPException(status_code=400, detail="Invalid user ID")
    return StreamingResponse(generate_frames(user_id), media_type="multipart/x-mixed-replace; boundary=frame")

@app.get("/detection_info")
async def get_detection_info(user_id: str = Query(default="tkdydwk")):
    if user_id not in CAMERA_URLS:
        raise HTTPException(status_code=400, detail="Invalid user ID")
    info = latest_detection_info.get(user_id, {"error": "No detection info available"})
    logger.info(f"Sending detection info for {user_id}: {json.dumps(info)}")
    return JSONResponse(content=info)

if __name__ == '__main__':
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=9999)