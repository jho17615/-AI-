package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Configuration
@Component
public class HttpSessionEventPublisher implements HttpSessionListener {

    @Autowired
    private LsRepository lsDao;

    private Map<String, HttpSession> sessionMap = new ConcurrentHashMap<>();
    private Map<String, String> activeSessions = new ConcurrentHashMap<>();

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        HttpSession session = se.getSession();
        System.out.println("새 세션 생성: " + session.getId());
        sessionMap.put(session.getId(), session);
        activeSessions.put(session.getId(), "Unknown");
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        HttpSession session = se.getSession();
        String sessionId = session.getId();
        String userId = (String) session.getAttribute("loginok");
        System.out.println("Session destroyed for ID: " + sessionId + ", User: " + userId);

        if (userId != null) {
            Ls ls = lsDao.findByUserIdEquals(userId);
            if (ls != null) {
                ls.setValue(0);
                lsDao.save(ls);
                System.out.println("User status updated to offline in DB: " + userId);
            }
        }
        sessionMap.remove(sessionId);
        activeSessions.remove(sessionId);
    }

    // 세션 ID로 HttpSession을 반환하는 메서드
    private HttpSession getSessionById(String sessionId) {
        return sessionMap.get(sessionId);
    }

    // 주기적으로 모든 활성 세션 갱신
    @Scheduled(fixedRate = 10000)  // 20분 (1200000밀리초)마다 실행
    public void refreshSessions() {
        System.out.println("Refreshing all active sessions...");
        for (Map.Entry<String, HttpSession> entry : sessionMap.entrySet()) {
            HttpSession session = entry.getValue();
            session.setAttribute("refresh", System.currentTimeMillis());  // 세션 갱신을 위해 임의 속성 업데이트
            System.out.println("Session refreshed for session ID: " + session.getId());
        }
    }

    public void invalidateSessionForUser(String userId) {
        String sessionId = findSessionIdByUserId(userId);
        if (sessionId != null) {
            HttpSession session = getSessionById(sessionId);
            if (session != null) {
                session.invalidate();
                System.out.println("Session invalidated for user: " + userId);
            }
        } 
    }

    private String findSessionIdByUserId(String userId) {
        for (Map.Entry<String, String> entry : activeSessions.entrySet()) {
            if (entry.getValue().equals(userId)) {
                return entry.getKey();
            }
        }
        return null;
    }

    public void associateSessionWithUser(String sessionId, String userId) {
        activeSessions.put(sessionId, userId);
        System.out.println("Associated session ID: " + sessionId + " with user: " + userId);
    }
}
