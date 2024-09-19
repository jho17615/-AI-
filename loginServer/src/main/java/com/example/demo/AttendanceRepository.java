package com.example.demo;

import org.springframework.data.jpa.repository.JpaRepository;
import java.time.LocalDateTime;
import java.util.List;

public interface AttendanceRepository extends JpaRepository<AttendanceRecord, Long> {
	 List<AttendanceRecord> findByUser(Memo user);
    List<AttendanceRecord> findByUserAndCheckInTimeBetween(Memo user, LocalDateTime start, LocalDateTime end);
    AttendanceRecord findTopByUserOrderByCheckInTimeDesc(Memo user);
    List<AttendanceRecord> findByUserAndCheckInTimeBetweenOrderByCheckInTimeAsc(Memo user, LocalDateTime start, LocalDateTime end);
    
    
}