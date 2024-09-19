package com.example.demo;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import jakarta.transaction.Transactional;

@Repository
public interface MemoRepository extends JpaRepository<Memo, Long>{
	Long countByUseridAndPassword(String userid, String password);
	@Transactional
	Long deleteByUserid(String userid);
	Optional<Memo> findByUserid(String userId);
	List<Memo> findByAddr(String addr);
	  @Query(value = "SELECT COALESCE(MIN(t1.id + 1), 1) FROM tbl_memo t1 WHERE NOT EXISTS (SELECT 1 FROM tbl_memo t2 WHERE t2.id = t1.id + 1)", nativeQuery = true)
	    Long findNextAvailableId();
	  List<Memo> findByUseridContainingAndAddr(String userid, String addr);
}
