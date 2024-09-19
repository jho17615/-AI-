package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class ActivityLogService {
    @Autowired
    private LivecameRepository livecameRepository;

    public void logActivityStart(String userId, String personnel, String ladder, String helmet) {
        Livecamdb log = Livecamdb.builder()
                .userId(userId)
                .personnel(personnel)
                .ladder(ladder)
                .helmet(helmet)
                .startTime(LocalDateTime.now())
                .build();
        livecameRepository.save(log);
    }

    public void logActivityEnd(String userId) {
        Livecamdb latestActivity = livecameRepository.findTopByUserIdOrderByIdDesc(userId);
        if (latestActivity != null && latestActivity.getEndTime() == null) {
            latestActivity.setEndTime(LocalDateTime.now());
            livecameRepository.save(latestActivity);
        }
    }

    public List<Livecamdb> getUserActivities(String userId) {
        return livecameRepository.findByUserIdOrderByStartTimeDesc(userId);
    }

    public List<Livecamdb> getAllActivitiesOrderByStartTimeDesc() {
        return livecameRepository.findAllByOrderByStartTimeDesc();
    }

    public List<Livecamdb> getAllActivitiesOrderByStartTimeAsc() {
        return livecameRepository.findAllByOrderByStartTimeAsc();
    }

    public void deleteActivity(Long id) {
        livecameRepository.deleteById(id);
    }
}