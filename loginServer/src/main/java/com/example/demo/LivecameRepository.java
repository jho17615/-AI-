package com.example.demo;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import jakarta.transaction.Transactional;

@Repository
public interface LivecameRepository extends JpaRepository<Livecamdb, Long> {
	@Query("SELECT l FROM Livecamdb l WHERE l.userId = :userId AND l.endTime IS NULL ORDER BY l.id DESC")
	Livecamdb findLatestActiveByUserId(@Param("userId") String userId);
	Livecamdb findTopByUserIdOrderByIdDesc(String userId);
    List<Livecamdb> findByUserIdOrderByStartTimeDesc(String userId);
    List<Livecamdb> findAllByOrderByStartTimeDesc();
    List<Livecamdb> findAllByOrderByStartTimeAsc();
}
