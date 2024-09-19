package com.example.demo;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import jakarta.transaction.Transactional;

import java.util.List;

@Repository
public interface BookInfoRepository extends JpaRepository<BookInfo, Long> {
    @Transactional
    void deleteById(Long id);
    
    List<BookInfo> findByNameContaining(String isbn);
    
    @Query("SELECT COUNT(b) FROM BookInfo b WHERE b.name = :memoId")
    long countByMemoId(@Param("memoId") String memoId);
}