package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class AttendanceService {
    @Autowired
    private AttendanceRepository attendanceRepository;

    @Autowired
    private MemoRepository memoRepository;

    public void checkIn(String userId) {
        Memo user = memoRepository.findByUserid(userId).orElseThrow(() -> new RuntimeException("User not found"));
        AttendanceRecord record = new AttendanceRecord();
        record.setUser(user);
        record.setCheckInTime(LocalDateTime.now());
        attendanceRepository.save(record);
    }

    public void checkOut(String userId) {
        Memo user = memoRepository.findByUserid(userId).orElseThrow(() -> new RuntimeException("User not found"));
        AttendanceRecord record = attendanceRepository.findTopByUserOrderByCheckInTimeDesc(user);
        if (record != null && record.getCheckOutTime() == null) {
            record.setCheckOutTime(LocalDateTime.now());
            attendanceRepository.save(record);
        }
    }

    public List<AttendanceRecord> getMonthlyAttendance(String userId, int year, int month) {
        Memo user = memoRepository.findByUserid(userId).orElseThrow(() -> new RuntimeException("User not found"));
        LocalDateTime start = LocalDateTime.of(year, month, 1, 0, 0);
        LocalDateTime end = start.plusMonths(1);
        return attendanceRepository.findByUserAndCheckInTimeBetweenOrderByCheckInTimeAsc(user, start, end);
    }
}